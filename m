Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CC319855
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613159; cv=none; b=YV7IA7OKnmzirH+3zyya91GPLxKspzpD5VFVy7wv9lbdPgg7pFeoHin4GHHCZRdbyeKM6WLcWHAoweJ3Pg541phO1EtwC1Y4czh65YtoXKFq8jJ+5W4eteyJTGUz22ndboL2xdVlZncM5LQ/F4UO+zWwBkqxR7S3twqMtftd+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613159; c=relaxed/simple;
	bh=FxQY5yz/9VOAH07dwrKYoo1KI4oFZULNndFrEoVy7oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otceO9tpyExhyqg9QQgVpgALAaZiiAmA9bQGCr+Pmo091ldKNDgxFC5mn9hGSK9wc+X3SBKZz3fw2idyund4XHZLN+J44mbtCCLvQPnP2QCNAiC6o9s99rcUdUSfF3h7S5ZtOFQb/s8E/alnfHlBN8PRqGT7h+c3oD3uNsqjHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmNyXAi2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmNyXAi2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0833b5aeeso188208675ad.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 03:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767613158; x=1768217958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ckr2KK6M5R5eySDIyyiWvwh8ff2sO+OBQjCyWMlwwgs=;
        b=KmNyXAi23le8iE8dSW/gdqifNmRW3V22fqjnsVXd7tLdvrrvduMwXrEfOEZRwiN0rH
         NBDDkuTamzACE9Iyxa2+lwclj8j3092sJHzgFaskALWnMR6jXGgvCqgTHzEZRfbLD6rb
         Yyf5gLcLjDn1ANNVvfabruxNxCAGAeJcb/on3y6yiiiN6PT4UGLGP9zz91l9IBejzfdY
         2L9WiumzUtqGfjD4B4OQ3x4ZtMT9spLhFkZgy8whFuCHwO4GJsRJvXzmFE8CNuJL79Wk
         IWWjbsd46Ws/R5jY1Iq4bcIgUyJWSIkI5IeD61OQCiljGrAK8C/SFugvMAZ8Had0LAE+
         epEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767613158; x=1768217958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ckr2KK6M5R5eySDIyyiWvwh8ff2sO+OBQjCyWMlwwgs=;
        b=CRvfPLmGW7ho2SS89VwAA5Nltgepa4C6K3kPzLCVwMMleqdu4tk16LEES/mc4stdUX
         hci9fXseIDiEStZ4NcOxQA+SqqE/5UwCa/dIZfIahs16uLtScau8mU7L1EO6nYQMxfKX
         pn988Oui/oDG14QTyROipsNiqFv+TuMNjJFVPtanKh2FPo1x3qp5lS+0ZtYj4EB+pTTf
         Dk1frlIGNDywZMCSnTlEUEdGTjNILvIokXLT3A2CpzZaKxEwmgfvRaupBySsv9jKk+8v
         km3T8v0rwaIRUtjmBSiAfbyj5hoz7glqburtJ4iZfwcUbG9spI2576y0rF5IxHCeevGM
         Lj4A==
X-Gm-Message-State: AOJu0Yw45Gc4usT/BJiHeMUalPLzD0UjKe0cy0cKdiatk9Et04xMtUd8
	ob+yBQrxIWshVAI+0xdHVTZLj33GrljAA2Kh5Kp5KamxQlUYFG1fvPtQDUmp7Q3OoIBQvv5803E
	tDw/G0FW+41q1hF7MNVL8SaffbTfHLI0=
X-Gm-Gg: AY/fxX4pTnb90+3ZCpp/tVxIjkfyQXYQiLN/9sGGd3XNf3xqJGDkFSPeNFdB823+J5W
	OB7KKTv8PInM29S2tuJnMqOsU/9RCOVAO5IttWLMRKdVTPv8hvdajxOSE7wJzyn/NGxmbVRHLuD
	9rpJdup6hqGdxGFY5zXU2QioNsvylFj8IuzkjNM79HEBHdzL2f6oOmMrCJwSSE2PTIKkQj7xhTf
	Jz4S8FHGgct07FiZXcH49H9XDkQGPJSaoTa1BYD1E7VUfotEbGzbJZ8U2Lwt9ZvWRK9jQaRisTK
	N8mgAEzGkQ==
X-Google-Smtp-Source: AGHT+IHhZkOtk3YANKCas11mjZjq5WjmyXGPg2oUuSM7oJ5P1swekIj49nmgLEIAEycyl7oECwEKBNNwmextPcH8eKo=
X-Received: by 2002:a05:7022:e997:b0:11b:9386:8265 with SMTP id
 a92af1059eb24-121722ecff8mr52766438c88.42.1767613157485; Mon, 05 Jan 2026
 03:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVfzMsN2ouY3UBFG@ubuntu> <CAOLa=ZTOKvEQaMxymi+mRcqyNy4bZ4JbK2HPtq6CeewjHMo_=g@mail.gmail.com>
In-Reply-To: <CAOLa=ZTOKvEQaMxymi+mRcqyNy4bZ4JbK2HPtq6CeewjHMo_=g@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 5 Jan 2026 12:39:19 +0100
X-Gm-Features: AQt7F2qGC5v-k-bJfVwHHRAXdCDNGV7bwbadyM0nA8McOU4qrzlnQha9t_Ei9WQ
Message-ID: <CAD=f0L-ge9FfNh04Nu05eg9Q6t_gtLaPi2=jiT1LXOjF20OO2Q@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into repo-setting
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jan 2026 at 12:09, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
> [snip]
>
> > @@ -927,8 +921,13 @@ static void bootstrap_attr_stack(struct index_state *istate,
> >       }
> >
> >       /* home directory */
> > -     if (git_attr_global_file()) {
> > -             e = read_attr_from_file(git_attr_global_file(), flags);
> > +     if (istate && istate->repo)
> > +             repo = istate->repo;
> > +     else
> > +             repo = the_repository;
> > +     attributes_file_path = repo_settings_get_attributesfile_path(repo);
> > +     if (attributes_file_path) {
> > +             e = read_attr_from_file(attributes_file_path, flags);
> >               push_stack(stack, e, NULL, 0);
> >       }
> >
>
> For my own understanding, when can `istate` be NULL?
>

Thank you for your question Karthik.
So it was stated in a comment in `apply.c:read_old_data():2340` that
`git apply without --index/cached
should never look at the index because the target file may not be in
the index yet
and we may not be in a Git repository.`
So NULL is passed to convert_to_git() in place of `istate`.

So when we do
`git apply patch.file` `istate` is NULL, but when we do
`git apply --cached patch.file`, `istate` is not NULL.

Bello
