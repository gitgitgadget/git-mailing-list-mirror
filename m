Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22F1E52A
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647369; cv=none; b=iWdMuxtdTYKA6q2CpazV0vR8PmoDDDypkh+c5W9PSp5nRQBT0mXlkTDLgzH9OTRkM18CZ2hIyGH41D3NVFlXzLNtsu4ndF6v1Kp3pAbJxN3QVrhMgkhzETgEkpdfWwnio2uWLskKIJqRpMibklBvi5BiklXCj+pNRwS/tvR5E3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647369; c=relaxed/simple;
	bh=06Den4qOw0+T3WlB/25TD62elBXyO4lEgiHEPAUc4uM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=En+bYeEIOixOt4UGaVetVHIX22F1ASCvQ7a6aczqxjpIk+Qie2Pk8jyLWoBREJjn+K/xw6TKXSdK6z+H2kDUxP4MycLo1SC64FmKFH6bDhzpFqQGglGiqmeDep/39wzkw/oYb9J92ypElHUjeG7ciWMDH6+3/Ld6yUBX5qEdWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ycSSNOrz; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ycSSNOrz"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5960D1E376;
	Thu, 28 Mar 2024 13:35:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=06Den4qOw0+T3WlB/25TD62elBXyO4lEgiHEPA
	Uc4uM=; b=ycSSNOrzZ3h8frtfsvNmnKrU6TIBgYAB/LInsQ8tJECMwbfEMGTOCW
	IF/q2WJq+L6s7BCNUahOgCYmfYJiOzrnqf0K3js1mpuZHwTeKYdhRwAANLUZokbQ
	kix8DSgz9H/R1kwB4NlXQeCXeZ41vvMMYJH0iDZJMNEIa+ooGCvpE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 521181E375;
	Thu, 28 Mar 2024 13:35:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC3811E36B;
	Thu, 28 Mar 2024 13:35:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: zhang kai <kylerzhang11@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Update message_advice_pull_before_push to mention how to push
 after rebasing
In-Reply-To: <CAK_130RadXce-_PwnZTzJ6qmr3m=OXd2M9bCj2gggM49RxL9=g@mail.gmail.com>
	(zhang kai's message of "Fri, 29 Mar 2024 01:19:23 +0800")
References: <CAK_130T8sZUZAuvj4x7sB278kVL7ARaBv3Pg2djQB45O+7xKTg@mail.gmail.com>
	<xmqqo7aywfc5.fsf@gitster.g>
	<CAK_130RadXce-_PwnZTzJ6qmr3m=OXd2M9bCj2gggM49RxL9=g@mail.gmail.com>
Date: Thu, 28 Mar 2024 10:35:53 -0700
Message-ID: <xmqq5xx6uume.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A135A158-ED29-11EE-A945-A19503B9AAD1-77302942!pb-smtp21.pobox.com

zhang kai <kylerzhang11@gmail.com> writes:

> Updates were rejected because the tip of your current branch is behind
> its remote counterpart. If you want to integrate the remote changes,
> use 'git pull' before pushing again. If this is not the case, you may consider
> `git push --force-with-lease`.
> See the 'Note about fast-forwards' in 'git push --help' for details.

True, but isn't that a slipperly slope to cram more and more of the
material from the manual into the "hint" that is supposed to be
short, helpful and not so obnoxious?  Perhaps removing "pull again
before you push", and saying "updates were rejected because X; see
the note about fast-forwards in the manual" and nothing else would
be an improvement?

Thanks.
