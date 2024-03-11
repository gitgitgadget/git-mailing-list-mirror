Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B858537E3
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180832; cv=none; b=AgYRkHCpZDb9qEKtJStbklLfnky2XQGZ0dj1YQAIdfrTfBTf0wiKGYC83DeNBMrngFLV0lWLiR7FK6mNAONXalcqJz095+HVAzOiyQZ+dvmqYFNUHilXkH8MzOTPm9p4EO3k8cSVqo+Mu5vdv+radpx8KxEc0Hc8v4gdwGgg+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180832; c=relaxed/simple;
	bh=9/s4Fuuwad4qP0UmCV7no0SDkkEQbvnzxtRHeJQ8NbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EzOzHr9EMUz37oxcE+QgdZHjqg/QuBcVI65AHaCqs9XjTkwpCyuZDMxgdbfI7OZ1sYgVRLelSGYweXpy+PB/947eeWQffsfqQay89MdSHGJ5UapZT+BkOGgm97bWihI8RPNqchup2a1jAJiFokwJWSOb9Y+odGaghOY8CttMQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f9sbz1me; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f9sbz1me"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B87DB1EE4BB;
	Mon, 11 Mar 2024 14:13:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9/s4Fuuwad4qP0UmCV7no0SDkkEQbvnzxtRHeJ
	Q8NbQ=; b=f9sbz1me3kLE+GquOi5/J1Abssbu0fJwUM4osOYIdeQHU4O3Qx+vNd
	hm9WQRkXPiRKy2wqMdzy0O04C7kv0y8gNctpYBQjPajO5pBCcAQKiHTouUy1Son4
	4ccsQE+SuctHBvZ2ERiiUcdwzoVXj4UxUYWnbiTaNI0+IJ8crnJWg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B097E1EE4BA;
	Mon, 11 Mar 2024 14:13:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16F431EE4B9;
	Mon, 11 Mar 2024 14:13:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philemon GIRAUD <philemon.giraud@metrologic.group>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git bug report CDPATH completion
In-Reply-To: <AM6PR10MB28087CFD43779194563F558492242@AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM>
	(Philemon GIRAUD's message of "Mon, 11 Mar 2024 14:24:24 +0000")
References: <AM6PR10MB28087CFD43779194563F558492242@AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM>
Date: Mon, 11 Mar 2024 11:13:47 -0700
Message-ID: <xmqq8r2or604.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1BB665AC-DFD3-11EE-8FE4-25B3960A682E-77302942!pb-smtp2.pobox.com

Philemon GIRAUD <philemon.giraud@metrologic.group> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> This bug is about the "git bash" that comes with git for windows
> I added "export CDPATH=.:/c/some/path" to my .bashrc

FYI, https://news.ycombinator.com/item?id=19886334 is the first hit
when I asked "exporting CDPATH" to my search engine.  It makes an
interesting and educational read.  In short, setting CDPATH in your
interactive environment, i.e.  your .bashrc having CDPATH=..., is a
fine convenience measure, exporting it to environment is not.

In addition to what people wrote there, it would break many
third-party shell scripts that expect their "cd" to work without
getting affected.  We even explicitly unset CDPATH in our
(remaining) shell scripted Porcelain commands to avoid the insanity
of it the first thing.
