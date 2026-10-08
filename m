Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565354F5E0
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466971; cv=none; b=SKJcpfcRI9pEbFg7pzAOV5v85hSLZhoPKKnaPJhjkOcypVaNkabsZWpE6hT6Azn65KdbIQeVKl5Ydie7YJ4KkivSiBBN8cv3aCOwJV+C+Qhd6UJEQB4KK/SLm4fG0z1U3Dh4FQGk3F7wwESeJZo6pNdKtE4n3D06ipVOnS9X1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466971; c=relaxed/simple;
	bh=572jgkbevtpZFk2WaxLzgn3O1+XeHYVAgcLrZNVMT3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oMfl5ZPwREeXrmPnx+16qqMbXKE6n3CYnhSrBG647aJ5Lsks0JeTjg4NaAyH1phxfh6pGDfWPdtjd592Q73yRCQF6yaCFh1CLAe924ejsIqbp0aObKmvLsRYYHZToH/TW2NXpBBgquTfJLQcFMhkJiSpIGu3ZC8XD5q5qfGKl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snlD9fAy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snlD9fAy"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2732457f8f.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791466968; x=1792071768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rV1wLyMj/BR1t6R64g19km74dhVAyFPysaUdzMvCy40=;
        b=snlD9fAyxj5wQ+DotTdmF3Y7b78W8sOFWO+Jx6t8Sl7PSFpWCsDA2l3Y+FaNXsyORV
         sNsAg9fq1t0PWvLtIjDlkFY8T54TI06cu3pZnzndLJ1BgM5EEhxRpOAQxrQqaoQbj5e2
         H4AA7UF9yy9OtiYAKZUcCUkGA0Ygw+wQ0lmQvuGK6Fw8E3Q52j5dMsMsMU7vONboWaaB
         Vp+DJtrFDNE7L76R2harjgmbf1fGHrMd8wS5akj+3eMiZsnBXnvg/5L37WljJYXTBtz7
         nQL2zDbxKUGSc72DxJksg3RGA/s5Y837dux7/74GoIy2PMexH4ayBkSp7FF0CKZYUP3d
         /FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466968; x=1792071768;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rV1wLyMj/BR1t6R64g19km74dhVAyFPysaUdzMvCy40=;
        b=JPIrRdLh2gL46cpg45Z5fSUQXJ0WIipVfCSrN61ZPTE/PhiAYPdMRn8oFnbGT70vt+
         vqVsYXFNl2QG0DgRwTUrr+GBPXCIdQcg3uQs3BTPT/g1dx0xklm6s2dBvwIxYR43iHTS
         N5Or5rU2YtwkHisENrZAb+L2Ycl2dI3eAmbZG/kcoGa+YRrpjYOSTwPIckeSAmCY9xKW
         RsjuivCkWemkZ9VggxrabRgLJyNzY4hZXa7rtPkhms0GjltwvGdpHX37VKrhSEzyHIDR
         XB20SHg73eCm5QspT3sp8hieQjoO/78oBi2ccUsPhsAeokO9ocM0+S4Jkd3+RCc9kSib
         fBnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzguiCRtKc/DiJkFhcgzsWCQDOtGcEiQp6qtJGyhc/2bo1LQkL0R0pRc8eUgQqjVU66jtg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLremat04wx+XFP3/x0GmK4PWm+89hIivf0OlR2gHORw++5fvUw
	nXiLphrK9kSD55P4UliqzqohSQbJgfapmB+I8MljTL2o7rj+ciEHPhrv937Z4No9
X-Gm-Gg: AYBFou0YxEdGkqctZqLlY+HFn3ZjkN1RGNtlwXdhJFnWL8E+xpEAqdYxurLG5svD9B8
	60bnIt3oar/ghAPcXDvCe3HZmwBdFKktvll+I2QMj32/1RSHhX8Ti94SkrTdv4tQrgU5g14RBWr
	TFBeKlK0PGEnXsOCaesQtzADo+gMw9OkoOMACcLOHCDDXi1pkPKobK83emQl7vB1F51h3/x3fld
	uatS4RQHWEloXh4ax6pClZo7qM39T0qlR8R1jDo4ioMCjPF7SzP3Wc1FtszKqh+ukIoEMFrx1EY
	VzirKFiziTJKCr/VjjQc2/HNoZ56vJU3f72M1AgdJkSAAe4zLFxuL+Wa48Dzks1RrTWfDaHUidd
	eFIROnoDsYr4Se0dMM3XmU7Fw97lARFMNlTVPO0NvvAEio+a6bh7CvsoJzYw9NL5goi+03bsUcf
	nmt+RJ42FyvLc49PjO8XmD9fbuwz6v5L4r4nDELifRN+zD4L4ja2dXyshRFgJ60s0J4X1sYeazu
	XY109IZBG6+5+JzORKZ+vhLmPXzoiM/J28K2jSuNpfiLIknI2Jh
X-Received: by 2002:a05:6000:3cd:b0:488:8568:bb02 with SMTP id ffacd0b85a97d-48c7278837emr9450973f8f.23.1791466968366;
        Thu, 08 Oct 2026 06:42:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71c0b7f4sm12105389f8f.17.2026.10.08.06.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 06:42:47 -0700 (PDT)
Message-ID: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
Date: Thu, 8 Oct 2026 14:42:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ssh signing: valid-before is checked at the signer's own date,
 and a missing revocationFile fails open
To: =?UTF-8?Q?Christian_No=C3=A9_Ramos_L=C3=B3pez?=
 <chris@nortesoftware.dev>, git@vger.kernel.org
References: <CAHGSfbZ_Q8Ujt3om0POapkjWZed1pZVUrB-mV-e+UjmPgCNvWQ@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHGSfbZ_Q8Ujt3om0POapkjWZed1pZVUrB-mV-e+UjmPgCNvWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian

Having waded through this here is a human readable summary:

(1) Our documentation implies that we check the expiry date of the key 
(which is recorded in the allowed signers file) against the date the 
commit was signed, but we actually use the committer date which can 
easily be faked.

(2) If the revocation file does not exist we print a warning rather than 
failing the operation like the gpg backend does.

For (1) I'd be happy to see a patch that tightens the wording, but we 
should also note that the timestamp in the gpg signature can also be faked.

For (2) I agree failing seems like the safer option.

Thanks

Phillip

On 08/10/2026 07:56, Christian Noé Ramos López wrote:
> Two things that, together, mean an SSH signing key cannot be reliably
> stopped from being trusted. git 2.47.3, OpenSSH 10.0p2, Debian 13;
> source read at v2.47.3 and at master (c46c1e37724f).
> 
> 1. valid-before is checked at a date the signer writes.
> 
> SSH signatures carry no time of their own, so git passes -Overify-time
> from the committer or tagger line (gpg-interface.c,
> parse_payload_metadata). alice's key is in the allowed signers file
> with valid-before="20260101":
> 
>      ssh-old        %G?=G 2025-06-01 12:00:00 +0000 verify-commit=0 merge=0
>      ssh-backdated  %G?=G 2025-06-01 12:00:00 +0000 verify-commit=0 merge=0
>      ssh-honest     %G?=U 2026-10-08 02:15:15 -0400 verify-commit=1 merge=128
> 
> ssh-backdated was signed today, with only the committer and author
> dates set to 2025-06-01. Nothing distinguishes it from ssh-old except
> when it was made, which only its author knows. ssh-honest, signed and
> dated today, is refused: "key has expired: verify time ... >
> valid-before 2026-01-01T00:00:00".
> 
> The GPG backend refuses both:
> 
>      gpg-old        %G?=Y verify-commit=1 merge=128
>      gpg-backdated  %G?=Y verify-commit=1 merge=128
> 
> The documentation for gpg.ssh.allowedSignersFile says "Git will mark
> signatures as valid if the signing key was valid at the time of the
> signature's creation", which is the intent, but does not say the time
> comes from the commit. So valid-before rotates a key; it does not
> retire one.
> 
> 2. A configured revocation file that does not exist fails open.
> 
> gpg-interface.c:568-574 at v2.47.3 (579-586 at master): if the
> revocation file exists, pass -r; otherwise warn and verify without it.
> The same file, present and listing alice's key, refuses:
> 
>      S2-revoked       %G?=B verify-commit=1 merged=no
>      S3-revfile-gone  %G?=G verify-commit=0 merged=yes
>                       warning: ssh signing revocation file configured
> but not found
> 
> S3 merged under `git merge --ff-only --verify-signatures`. An
> unreadable file and a directory both fail closed:
> 
>      S4-revfile-0000  %G?=B verify-commit=1 merged=no
>      S6-revfile-dir   %G?=B verify-commit=1 merged=no
> 
> ssh-keygen, given the same missing path, refuses: exit 255, "Could not
> verify signature". git avoids that by not passing -r. OpenSSH's
> RevokedKeys says, in sshd_config(5), "Note that if this file is not
> readable, then public key authentication will be refused for all
> users."
> 
> No test in git exercises gpg.ssh.revocationFile; it appears only in
> Documentation/config/gpg.adoc and gpg-interface.c.
> 
> Controls for both runs, fixed beforehand: a good signature gives G and
> merges; an unsigned commit gives N and is refused; the revocation file
> present and listing the key gives B and is refused; a commit with its
> message changed and the signature kept gives B and is refused.
> 
> Together: the two ways to stop trusting an SSH signing key are
> valid-before, which the signer can date around, and revocationFile,
> which does nothing if its path is wrong. Either would be enough on its
> own if it held.
> 
> What I would ask for: refuse when the revocation file is configured and
> missing, as ssh-keygen and sshd do, or say in the documentation that it
> is ignored; and say, under valid-before, where the time compared
> against it comes from.
> 
> On prior art: the ssh signing series (Fabian Stelzer, 2021) carried the
> warning from before v4, and the review raised the config name's case,
> not what a missing file should do. The key-lifetime series (RFC
> 2021-10-15 to v6 2021-12-09) passes the commit date to the check, and
> the replies are about style. The N for an unconfigured allowed signers
> file is already on the list (Grayson Tinker, 2026-06-25) and is not
> part of this.
> 
> Christian Ramos
> Norte Software
> chris@nortesoftware.dev

