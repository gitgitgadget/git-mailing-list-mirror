Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1EE47F44
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956771; cv=none; b=Mqoq9mJZuHTxTyMAd5IfxBgkRU7oqwpjSgTufKm2MtqU1KheAY/nMYuJ2xkjUAp0giXZp7S6BXd6Yhx+fYX0R5qrfJyL+HxRtNpI+akJxITCBhOCRgdEMBG4zpT/5viIHqRmF2rjZUlWwoFg6EbOC7w+AjKTeL6BHHQ6z4Gh6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956771; c=relaxed/simple;
	bh=av7XYR26Gvg5oAj6Gy4YN7B1wwbLkhKri3lCbsVz2xQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1SOjgAbxpEaf98+fRlDbkvJJTBjfCjig67IuypP4L5GjGudlsmU0l6syTEzy/ZmtKSlxSvBOIXnTMh67HtEImmpUZESngGYxh/mJpE2pZkngM9I/P/paxjCm+0mNEZVRcG7P8OL3sgKKDXPgzoi4rq+O1zKYgxEYnd86dNnvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nUmLkS3h; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nUmLkS3h"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 529071D2F77;
	Mon, 22 Jan 2024 15:52:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=av7XYR26Gvg5
	oAj6Gy4YN7B1wwbLkhKri3lCbsVz2xQ=; b=nUmLkS3hM2okMiBnX+lOd3aSZsiT
	IXy3uX/K0JOjB9LLcti5qbsUvaYMFKE/Ar8Z+H6BXNessKIvu+JHC27M3JDenIGQ
	fOpOUdLJkSflA1/+PaTyA10byigGVGzRTAApTOo6mWWMcV/q+ct4OdA2rd3l3DfA
	HbKgFXQe0r8lDRw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A9E31D2F76;
	Mon, 22 Jan 2024 15:52:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B36521D2F75;
	Mon, 22 Jan 2024 15:52:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas Coronado <raulnac@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Fwd: Unexpected behavior of ls-files command when using
 --others --exclude-from, and a .gitignore file which resides in a
 subdirectory
In-Reply-To: <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
	(=?utf-8?B?IlJhw7psIE7DusOxZXo=?= de Arenas Coronado"'s message of "Mon, 22
 Jan 2024
	21:45:46 +0100")
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
	<CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
Date: Mon, 22 Jan 2024 12:52:46 -0800
Message-ID: <xmqqfryprsyp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 32F185DA-B968-11EE-956C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ra=C3=BAl N=C3=BA=C3=B1ez de Arenas Coronado <raulnac@gmail.com> writes:

> In short: using 'git ls-files --others
> --exclude-from=3Dsubdir/.gitignore' results in an empty listing if
> subdir/.gitignore contains '*". IMHO that pattern should be applied to
> the subdir contents ...

I do not think so.

Imagine what would happen then if you did

    $ cp subdir/.gitignore /var/tmp/1
    $ git ls-files --others --exclude-from=3D/var/tmp/1

in such a repository?  The "--exclude-from" option is used to name
the contents (set of patterns) that should be used and the path of
the file that happens to contain the contents does not matter.  So
you should get the same output as the ls-files command that was told
to use "--exclude-from=3Dsubdir/.gitignore".
