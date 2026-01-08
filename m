Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B491309F13
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896174; cv=none; b=RjDGTr2CBYLoLn1/gWmZ+9AKsBAhx6XutT55LYJ35zJZJnWh2vRm2VnvMSCIpkm8YzGw7RqNym7tkrvETW+TORQ4c5oPFsU/slGuFUeKRt9XCa6EMqZUIour6WF6gHwgLDK6ALtc1m66NCPlfLLTTw3/biWSBhYO/Kh98wsrZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896174; c=relaxed/simple;
	bh=FMCmFdO+0vHZnmin6CDtbzrMyi/bvQ8Vdfygm2upxgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+KuChkgOV9r+ak0dA8u9lf6PlvTGtdUbGcah9KnlkmuHH0uIL1WfP5yS1mdgxNNUtExJAzMkU6aRRgnyTlGD2WdQHPts0qTfgCAAz6fGyLjuvQSSHBCgz/3yK35vKSXbDmsX9+3VikKbsWomAeWF9Qqy3qPhzI84l/PCOGNo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKwlJ96P; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKwlJ96P"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-790ac42fd00so29639757b3.3
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767896171; x=1768500971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYe7fEW71o50qOn1jk2s7wpcp7Y+7/ibBlRtqWL9XW8=;
        b=YKwlJ96PJZl/20FO5LjDOh1zSf5iwSUMyxvfXEOCTjylGgovpuCRozOYtAu4HRA9aU
         hdJK9NxL19LhgqQXuhD38kPxKBfEd3gbTZZ5qWaX2fLIcPSJxcAJbu0b0L/IR+2UOlGj
         GrGHjZfHlIDyBkE990MuUbyMfAL6L12eloHcU8EM4AUvlq6xXXVlNAT1AWek/8t0qYNI
         LeOwRNt7juAjNQQd+iKi7Y18JgKY/5dbmDb7pWRj1eITohuSsBjY/rfzLgSIidpq71Z7
         e5T2gFMnDXgx4WNK2aLoV84oOmvbOwPK1JQldQT1U4yBARmtSvw3KMTUDrUO/lBZNwq6
         U0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896171; x=1768500971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XYe7fEW71o50qOn1jk2s7wpcp7Y+7/ibBlRtqWL9XW8=;
        b=HMxZSuNZGoNHOL31uf0CK7vb6+5Rk2RA47GUpvIkW8R56sZMTgNrS9kALtxh7cxDxD
         9vRm3DV5g5nXNw3xWXMjiQKFsuWEPDv9ncdOC3jIgMd4NHSKJ+uCNFN8c70q9XXkZId/
         QiXLWH5z6zTrAUvUXkDjscOt5DDXPDYiJzGSx7NigArZErWyP53i2KAV2cfFvpOxd5aR
         qYaUolLlc3zeUrKPP72CvtNzXoOd1hGfsWPOw4rtYhA6YYQGbaMZyPpYkL+LP6DsFks/
         lWu7bkUpnX0Ff+KOIMwX7KDAVy1v1cmREmQGsAsqWRjWnarYt3AMh681tMLcygSQUxGx
         0PYA==
X-Gm-Message-State: AOJu0YxOmPmu0atY2T+VwLnv8XOy5lAvgJ6OHotHw9I3tcYBy7zQ8PZc
	SGeuGjhCh+SAP7JKdTGsSwjYxGpMOHFUc26/wzjhfMM3whGMVlgJfh11/vRL42V44K0Bwt1a6Pa
	CaAkhitZdcw1/huIvt0HoZudx3tvaTUAX3mOcrS4=
X-Gm-Gg: AY/fxX7wnCWV4xCcy6DlhqZ1DOaIkK0M8k3pWFI9sKmAxI20wVyV38W+8SEslPzwjvq
	xDevqUtaCOXaCbSfEI6cVOisfxLfVLSQLGHw+CzfwhXMFvJM2c+fa0VSJdcme3dfTWEynP7+asu
	wwRT5ZUtBygzWLpRzem6/3vmMdnLB4P3LcOcaDIqQLucFCfpbOwdVdJROgCJUBTwp2cmLOpS1F/
	oxew7vKRpIl2J3XhLtPEi8pPjS5zBckkQeP1pN9sDBFdilCL8e5KB+kjEV4Pg6hX5DlNRc=
X-Google-Smtp-Source: AGHT+IFXGzdwmjcOUeHjO4yXPPJoemddOlJF1tn6/lNQ+3WQMET9/NPPQsJ0etyF800Hypr220zyD3ltNIxhcqGrTZo=
X-Received: by 2002:a05:690c:38b:b0:783:6f8d:e7a6 with SMTP id
 00721157ae682-790b5828d2amr137810717b3.51.1767896170446; Thu, 08 Jan 2026
 10:16:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_doc_patch-id_3.1ab@msgid.xyz> <--verbatim_and_--stable.1b1@msgid.xyz>
In-Reply-To: <--verbatim_and_--stable.1b1@msgid.xyz>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Thu, 8 Jan 2026 23:45:59 +0530
X-Gm-Features: AQt7F2pQBGiFyX0RUTUTmBuhoxmR5qIW9a8g8VBGUwB1Y9T2V57Bt-fBq7Sg0f0
Message-ID: <CALE2CrSu-JW___Lav0SnLPfwxB8QCRYMKQgsfbXCHrAQSEyDoA@mail.gmail.com>
Subject: Re: [PATCH 6/6] doc: patch-id: --verbatim locks in --stable
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

I read through the entire series and all six changes look correct to me.

Each patch is small and focused, and together they improve the clarity,
consistency, and accuracy of the git-patch-id documentation without
changing meaning. In particular, spelling out the `git diff-tree --patch`
form and documenting the `--verbatim` / `--stable` relationship help align
the docs more closely with the actual behavior and existing code.

I didn=E2=80=99t notice any issues with the changes.

Thanks for working on this,
Pushkar

On Thu, Jan 8, 2026 at 12:02=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The default `--unstable` is a legacy format that predates `--stable`.
> That=E2=80=99s why 2871f4d4 (builtin: patch-id: add --verbatim as a comma=
nd mode,
> 2022-10-24) made `--verbatim` lock in[1] `--stable`:
>
>     Users of --unstable mainly care about compatibility with old git
>     versions, which unstripping the whitespace would break. Thus there
>     isn't a usecase for the combination of --verbatim and --unstable,
>     and we don't expose this so as to not add maintainence burden.
>
> =E2=80=A0 1: imply `--stable`, disallow `--unstable
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-patch-id.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id=
.adoc
> index 61498def317..013e1a61906 100644
> --- a/Documentation/git-patch-id.adoc
> +++ b/Documentation/git-patch-id.adoc
> @@ -32,7 +32,7 @@ OPTIONS
>
>  `--verbatim`::
>         Calculate the patch ID of the input as it is given, do not strip
> -       any whitespace.
> +       any whitespace. Implies `--stable` and forbids `--unstable`.
>  +
>  This is the default if `patchid.verbatim` is `true`.
>
> --
> 2.52.0.421.gc32ead4fc78
>
>
