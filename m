Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F028EB
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731854942; cv=none; b=N9GLub+xlaXAjW/evIwbGEWYDXC53OA4zRDUgX83Wxz0Y5enxsPI8HU9psP/fKGP5TIm6COja1AIQmgKNtv7tJcgy+FfAGEU/qyzqO/cQ/u5Jp395vFXqWYRQH6bEmxMrwvsyQ4oC25v0qoHD/Gl14/lWFcAPdVRz1oxWE+IaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731854942; c=relaxed/simple;
	bh=u8+nO49FTNoqKmGzOcF6HPgc4i3QwES94o//VoHjxaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOTWlJKLnVyJ7yokTd/HjPsaMCRhqQVhXMiJTcvTT+wlsz5CBHnnlE6FpQng19Lc//mrTUxhk8v76jD0cjdLHQGl0KnFw4u+O3nnvnBIv70ltrBvmu2Gzyaz4PR5eMjcFagxB+wrTYPEA/4Xhy02Mw6LGyd25Xcbi+9nBoj6hsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4XrsvH6g9Fz5v00
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 15:04:27 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Xrsv2625RzRnmP;
	Sun, 17 Nov 2024 15:04:13 +0100 (CET)
Message-ID: <7f24a030-bae2-4712-8593-61a9d4089cfb@kdbg.org>
Date: Sun, 17 Nov 2024 15:04:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] doc: git-diff: apply new documentation guidelines
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Cc: Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
 <6841bd5825be8e7b17c2f9c3a997de29ffa3a540.1731785769.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <6841bd5825be8e7b17c2f9c3a997de29ffa3a540.1731785769.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 16.11.24 um 20:36 schrieb Jean-Noël Avila via GitGitGadget:
> --1 --base::
> --2 --ours::
> --3 --theirs::
> +`-1`::
> +`--base`::
> +
> +or `-2`::
> +`--ours`::
> +
> +or `-3`::
> +`--theirs`::
>  	Compare the working tree with the "base" version (stage #1),
>  	"our branch" (stage #2) or "their branch" (stage #3).  The
>  	index contains these stages only for unmerged entries i.e.
>  	while resolving conflicts.  See linkgit:git-read-tree[1]
>  	section "3-Way Merge" for detailed information.

Having seen this new proposal (which I am not a fan of), I reconsidered
my take on how this could be formatted.

First, I wonder why the pre-image is not

-1::
--base::
-2::
--ours::
-3::
--theirs::

like we write in other cases where multiple options are described by the
same paragraph (e.g.: -p -u --patch; -W --function-context; --textconv
--no-textconv).

Next, since with such a scheme all options are treated equally, we have
to ask whether the description in the body text makes sufficiently clear
that they not all do the same thing (it does), that there are actually 3
distinct groups (it does), and which options mean the same thing. The
latter is rather meh, but it is the fault of the text and can be
remedied easily.

Finally, with all this considered, I think it is not so bad at all that
all options are lumped together in a single line (or remain on six
separate header lines, depending on the processor). So, I would no
longer mind seeing this transformed into

`-1`::
`--base`::
`-2`::
`--ours`::
`-3`::
`--theirs`::

for consistency, or

`-1`, `--base`::
`-2`, `--ours`::
`-3`, `--theirs`::

for brevity.

-- Hannes

