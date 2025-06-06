Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CF2882C0
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749209482; cv=none; b=FS80iopqmtHpxIB049JGNcR0cuOMc7BGVFZ2mAPcs49X31K8am3lyFvbQ+s5jLc2fjGO4U6KhSUTug/pC0I5s41US0G+1tEMRM9Exb+9IpCpnj7vu6tp4x0OmbRlgTtFVKJ4vk7b1ibmJTUH/8iIdSjipIrJvfkLgY6M2LTdRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749209482; c=relaxed/simple;
	bh=FRLOnmdTIRwOK5ycJ/uGGSq51XsYY6BNL+YjF+UGtOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HalrWWa/6cgkezuMvBsxKtpnrJUhPTcGR4DTAIaCwayBclT039XdshuO0kWthxHaxkAY8q68QM6bvIA4ig37PCCzFUodWy6e4Eb6adH7tcMdUW/Znjs3DDh/NA0Co2S5Wg3btqqlCNBgARiTWUukvBiboXfVbPg8HYuv79Skl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC/V4F65; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC/V4F65"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso13704525e9.2
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 04:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749209475; x=1749814275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uczaYvUAZDs2KhlwgdaeRJ5gZUXGFVmfu/vEeKQ5KKs=;
        b=bC/V4F650cfW8i76bmroWh/TYc90/iuV91rEzzVEWnZL6fjYtuloXYd9riMTGb1e73
         pK9/ZvjfS/XE79yJ/VfOP8ovFFIJhHhDtJ4WrBUFICWLoUXDlGY3D4ww/5R8Mf/oIVhs
         FBUa4IfugvkGsUWpaWkhon8J0ebi5dRFlQK2DjyaDDjRpLbNRfjW4oCGlX/oTvF0YV7F
         x8Mclb/dl/zR2JLkvO3UyeI7ivZKW0Ql6KvBVk/g9iFOJw8mZC6EMJwD4YFNCDzBK7iA
         kK6Xs4o1wehiw+a2QV3bmzHjouvsycnk+AF+ewvIiFXIa38TcMEagElQKqeD89RbB4Md
         kufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749209475; x=1749814275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uczaYvUAZDs2KhlwgdaeRJ5gZUXGFVmfu/vEeKQ5KKs=;
        b=HsnwDLGAEUKxnnWnc3fC1G2ZyhGj8FIbjT2f9fbeFiXnEMX5GtgeTBK8oc7BAHzcOx
         4pIE11KHx6CYFUPTxkgg/Uu0zG1mzRUQxPDqJNd1uN94FkfTTmneRBZir+L1zD7XB8tY
         jZOx/oHdmn69oHbNLA+yOV7/cOCb2K+1BhGLAmQOZTBBD67U4W9voa7g1PVmDQmha9sd
         EsxV4b6ujB+QWcg6xgqrYmnqdMhMxNUlaGWD5xIfM7Fe7z9GXo3mfHnOD7dVjwv3s9m+
         UEMNqzQnSPKttxS8C6FDpP8SVgx9bdFMUkLSBldTXiFGV5uapbUj4NyNuLzonQtizWAn
         wG1w==
X-Gm-Message-State: AOJu0YxdTjDUf+nvd8mEHkpzQv5jFLLHx8Wprh5rfE4Wk5p9i70/Aq+u
	CgNYLzusoXOuCL47v7Ot56mgYhc1sogOIeOmt4upHbL1YO+YKllizMyjVVPexYvPls3Bl4iOxLN
	K9a4eLH8xJQZWp5cDFELAIu0CFiUBfiA=
X-Gm-Gg: ASbGncsMlb4Gv7YRv7yb9Ln4ttSPKh1g4/yDZHi7V8y+AAi7JstznQUCThBfcbPegsu
	VI/eGxWB88ulcR43bcA8Dtx2uUEfQP8o9BB0/ff1V4f82qhFfqfwviKeTN3rN6A9oHoEPB9k2iD
	7nfim7ULSuZmIPRr3AFkh5VwtQYKnAJSmJjg==
X-Google-Smtp-Source: AGHT+IHnTySyGOpvonRyBRbZW/0fnckeMHF4NdRDsOzV2VJO4LRgPubri/obFb8Vquv7DJgrhLAUpz49vAakcHOWcbw=
X-Received: by 2002:a05:600c:1d04:b0:450:d37d:3584 with SMTP id
 5b1f17b1804b1-45201437a9dmr34477795e9.13.1749209475044; Fri, 06 Jun 2025
 04:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
 <cover.1747733203.git.phillip.wood@dunelm.org.uk> <2cd67f5cd85af03ae99a2760a76e9df5a7edfd95.1747733203.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <2cd67f5cd85af03ae99a2760a76e9df5a7edfd95.1747733203.git.phillip.wood@dunelm.org.uk>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Fri, 6 Jun 2025 13:31:03 +0200
X-Gm-Features: AX0GCFsKSHunf0rLJ1EbS0QlvvpLHimPhfFvqVTAh0EBDuh06qT8sS0KdxlMZ6Q
Message-ID: <CAN0heSpGtLW8B-wtoMgW7gunMMeVTL1jhk8xN1LBbeeG4f1Fxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] stash: allow "git stash -p <pathspec>" to assume
 push again
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 11:27, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Fix this by regression by checking argv[1] instead of argv[0] and add a
> couple of tests to prevent future regressions.

>         if (argc) {
> -               force_assume = !strcmp(argv[0], "-p");
> +               force_assume = argc > 1 && !strcmp(argv[1], "-p");
>                 argc = parse_options(argc, argv, prefix, options,
>                                      push_assumed ? git_stash_usage :
>                                      git_stash_push_usage,

After reading up on 8c3713cede (stash: eliminate crude option parsing,
2020-02-17), I share your analysis. This fix looks correct to me.

> +test_expect_success 'stash -p <pathspec> stash and restores the file' '
> +       cat file >expect-file &&
> +       echo changed-file >file &&
> +       echo changed-other-file >other-file &&
> +       echo a | git stash -p file &&
> +       test_cmp expect-file file &&
> +       echo changed-other-file >expect &&
> +       test_cmp expect other-file &&
> +       git stash pop &&
> +       test_cmp expect other-file &&
> +       echo changed-file >expect &&
> +       test_cmp expect file
> +'

This only exercises the patch machinery fairly trivially: all hunks are
added. The implementation under test could miss `-p` completely and
behave as `git stash push -- file` or some variant of it, and this test
would continue to pass. (Confirmed by editing the test to not use `-p`
and seeing it run successfully.)

It might be worthwhile to set up some more elaborate scenario where you
pick only some hunks, e.g., this (whitespace-damaged) diff:

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index d24559a328..3b28504126 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1178,16 +1178,19 @@ test_expect_success 'stash -- <pathspec>
stashes and restores the file' '
 '

test_expect_success 'stash -p <pathspec> stash and restores the file' '
-       cat file >expect-file &&
-       echo changed-file >file &&
+       test_write_lines b c >file &&
+       git commit -m "a few lines" -- file &&
+       test_write_lines a b c d >file &&
+       test_write_lines b c d >expect-file &&
       echo changed-other-file >other-file &&
-       echo a | git stash -p file &&
+       test_write_lines s y n | git stash -p file &&
       test_cmp expect-file file &&
       echo changed-other-file >expect &&
       test_cmp expect other-file &&
+       test_write_lines b c >file &&
       git stash pop &&
       test_cmp expect other-file &&
-       echo changed-file >expect &&
+       test_write_lines a b c >expect &&
       test_cmp expect file
 '


Martin
