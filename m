Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B226FE35
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711495666; cv=none; b=dMeYKyAsqgwkpc0vdRhXTgJm1e1K95UFdLws5GMRi80ZvHMzojMqlOmJuul56okrTktmOgaEDPiUr0wfzStwHfemgdA7fjMbteCcukCvUG/biNgJTvFhtJ/w7viQzpfn+Wb1Om0dL8xJnY7D8N6euoxDhxTIJV3mBaFpifshn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711495666; c=relaxed/simple;
	bh=RV7B/m70QIJ4Fzh4i/+jva6MvZ2k8RBmOJIzSJr/QSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ga4WmMXWyPnsTQJsV1jq8sxMlzuAmtpOCTizAtghJBXqLUzc5ltkwhwoRsLQWoH3MhbkadybRv7aEfXF2lJi0ek8Vq00ZQgvEL+XoA0Q2mP33EGepz249qNMg6Noa/U4L6XdIk8YYWFivCC/cTCR2/d1DklI04ly9OQYHuwcGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=m0/hnN/D; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m0/hnN/D"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F12651DB1A7;
	Tue, 26 Mar 2024 19:27:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RV7B/m70QIJ4Fzh4i/+jva6MvZ2k8RBmOJIzSJ
	r/QSY=; b=m0/hnN/DULcfknImOgeB6LAnx4S23XPZEqr/tPFXHMxiWBU0Iz8xz6
	ZD0RD1RRrxU+FJ+9uEUuqwm9ReMciQjc/oy80sF36e+1O/DtAFkOj3Wa/5eiDdio
	VgGVS8o9mw24/zJNSVKOsKkk0Tn+tZynzdYJADZik+LRhpVWpjmKA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7DD31DB1A6;
	Tue, 26 Mar 2024 19:27:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A22A1DB1A5;
	Tue, 26 Mar 2024 19:27:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ralph Seichter <github@seichter.de>
Cc: rsbecker@nexbridge.com,  Dragan Simic <dsimic@manjaro.org>,  Chris Torek
 <chris.torek@gmail.com>,  git@vger.kernel.org,  Ralph Seichter via
 GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 3/1] config: allow tweaking whitespace between value and
 comment
In-Reply-To: <874jcsvccq.fsf@ra.horus-it.com> (Ralph Seichter's message of
	"Tue, 26 Mar 2024 23:48:21 +0100")
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
	<xmqq8r2jp2eq.fsf@gitster.g> <xmqq4jd7p1wf.fsf_-_@gitster.g>
	<xmqqcyrg7imy.fsf@gitster.g> <874jcsvccq.fsf@ra.horus-it.com>
Date: Tue, 26 Mar 2024 16:27:42 -0700
Message-ID: <xmqq4jcs7evl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 72035DBA-EBC8-11EE-8E40-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ralph Seichter <github@seichter.de> writes:

>> Can you unblock [this topic] to let us move forward?
>
> I don't see any obvious way to alter the pull request's state, or where
> a response of mine might be inserted to move things along.

The easiest would have been for you to say "Yup, the two additional
patches queued on top of mine seem to make it better. Let me review
them in detail", followed by "Yeah, they looked good to me", and
after that we can just merge the topic with three patches down to
'next' and later to 'master'.

Of course, if you do not agree with the two follow-up patches, you
can point out issues in them and argue why they are bad idea.  That
would take more cycles, of course.
