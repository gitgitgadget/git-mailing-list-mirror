Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BC73B2AE
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YqE8cwbq"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6F6118
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:52:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CB461C1276;
	Wed, 18 Oct 2023 14:52:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yFefI2f46T/X
	3q3JajKDIS/6Igj3td2B0Bm/TG6Srrw=; b=YqE8cwbq89cCcPqs3SLHLn+kjtMh
	VO794pz7RQhfeuUXfesnIxr6RlvKyAgynr0yok1Q43kcy8T3m9wr61gv581Z6M+l
	zU65sDci/UsZ8TAbj1xmotVXqVhU5++xtnQc+XQNkQzcNhwmKOklSOLTbi8jBYT7
	DxLHlW+I9imfYKE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 036361C1275;
	Wed, 18 Oct 2023 14:52:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33ABF1C1274;
	Wed, 18 Oct 2023 14:52:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Pratyush Yadav <me@yadavpratyush.com>,  Matthias
 =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH] git-gui: add support for filenames starting with tilde
In-Reply-To: <pull.1599.git.1697619043944.gitgitgadget@gmail.com> ("Matthias
	=?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Wed, 18 Oct 2023
 08:50:43
	+0000")
References: <pull.1599.git.1697619043944.gitgitgadget@gmail.com>
Date: Wed, 18 Oct 2023 11:52:27 -0700
Message-ID: <xmqqpm1bsqz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7C1DD104-6DE7-11EE-8C13-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Matthias A=C3=9Fhauer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>
> When git-gui encounters a file name starting with a tilde character (~)=
,
> TCL "helpfully" expands that tilde into a (probably non-existing) users
> home directory. But in git-gui we're often not dealing with user suppli=
ed
> paths, where such an expansion might be expected, but actual names of f=
iles.
>
> Prevent TCL from doing tilde expansion on these literal filenames.

I do not have stake in git-gui (or gitk) and take the changes the
subsystem owners have decided to take from them, but I have to
wonder if this is merely robbing Peter to pay Paul?

If the above description were not "we're often not" but "the only
paths we use are repository relative, and a path that begin with a
tilde NEVER refers to somebody's home directory", then I would buy
into the change (but again, I am not even a user of git-gui, so take
this with a moderate grains of salt).

Thanks.
