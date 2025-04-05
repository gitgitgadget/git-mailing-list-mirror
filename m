Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D122E62CA
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743850690; cv=none; b=VnU9zJujyqfuBUXe8wi1zpRY1yf+/a8QyezqMeix0ExzUaGnLTuFAf+iI7tbaudqCk48tS74AfemrPfif0f2qX3UIAkn/8KppTZOrVaeiQzmfCAJ5/+KKsURkTp7Cv2zHANFkz3dDxLHN+0LvHhM3eUd2Hkywe9UR5+SAiGmY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743850690; c=relaxed/simple;
	bh=icJmE6uWHPernNL9I+gfO3tPpq/dBJ13ViCv9wVOFBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiRXXrM0H/3iGcHPpVAa5MABltkEOP1OBn0YZd450OtDwDHfBUmYuWb+df2sq7Pm73H2bZVUzFBPJTkWDiB3AXU5jzLtXaNGeyEMMr336uO8tk7jfZSvh8CQCt41gNA2VcZ3mRFOrn2ZR9dvIWSBpCQArm/RqVUsNSKNY4I+KSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqx9LcdE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqx9LcdE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c266c1389so2010864f8f.1
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743850687; x=1744455487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdChL+24A50iwJbAF2RlywKbI82rTbWDxPOcjd3ZXt4=;
        b=jqx9LcdEE+VV5wvS+kOtUPn0Xr3zpGa2pwrM0W1/pADsWnWfDG/+f0uFCps8M0kZ5a
         hImT+IOkjv9ijDEKZcSzLN7yEdHg3GvOyzehe2Jt3QOEeKQOycvU93+0UElzgPGLWsUZ
         P+AN3s1DKslognWnb4MErgYwYnXHOFPhr1SmA2Bmu30p1OshGLecsIfbn2g4W3izmcGz
         jDbiPNer5rUdrTgHTPDVsbjWOXFQQreGOo6hWQBwtouU3lsCaN8I4+mwXKTJrDzcSN4b
         Ic5e2O4OgpWtBRQ3vCjJK7I3mBXgV6F9Kcd50QdEZYDD2JbkULTMaGnyGbPCh7cWyAIU
         4mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743850687; x=1744455487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdChL+24A50iwJbAF2RlywKbI82rTbWDxPOcjd3ZXt4=;
        b=KlKNFOxSIt4uCsu2rzyOJZAKZh/0qPrjUQRvKtwF9xd7PPNEmJE0qPHCfoOK44M0Pa
         wDVbMv9pBOc4na/yS06MTdKM/TpbkZ20h9eGBp9Y9pkvARDFQ5z3OGlLqn/mVyyojV9D
         MRO89P0B9oHg2+4wOyb3vbHAkrWO/GVNp9ydo9YBZWDXiV2hVzpfhAcM4xJPnXLwk1fN
         wyAk6R3gpxsI1cDDRnMrZpnAjNGNxXqqlB7a4jOulCZvO0wIbpJDmDiwskgJ5YlPi8BO
         lILnqf7DIetoPjHb1yVw0Q21ttyeF3e5WbeG1vTWcfjPzldeKhys2vp9v+o3InKokrMP
         1LGg==
X-Gm-Message-State: AOJu0Yx6DUfGjQtCxufu4pVEQb4V+sHYX5pz5aV0vPpqpg6ACXN1J1nN
	KqB0mG32E5m/k4fPOyhasA7yzp2mT2CITFhcVr4vdJHVtWghSrf0Pz4cjaj+NBdLVK075gMbkQv
	Q6FDuiVPgsgpQX3sURoxjxTBob74=
X-Gm-Gg: ASbGncu2nbNRCcDiA3ywh16/A+7up2RbU9vim0zQykG5YSzMGP35zSmKNx15SZWHZZe
	FyIcXQBm7v13CNvJOWA4sMP0ROHG2Mbn6ttCbRdfzvtop4azSKZwwmF31jXaJutHHKhRufwpJtX
	uawtTgtM7vvdFlWGPopMPsRRNvnVM=
X-Google-Smtp-Source: AGHT+IGr3Z9i6lRmERHL1dab4wrPwdIRQtwpSLuZIRV9+M0DtFzIkY6LUClP8Ik4fbC7+kmftB1mmZr7H/0tg8ml2bc=
X-Received: by 2002:a05:6000:1849:b0:391:ba6:c066 with SMTP id
 ffacd0b85a97d-39d0de3e88dmr5272290f8f.35.1743850687065; Sat, 05 Apr 2025
 03:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com> <9f7cd02cc1ef76bfe92cbb8152f34460c67b2eda.1743354964.git.gitgitgadget@gmail.com>
In-Reply-To: <9f7cd02cc1ef76bfe92cbb8152f34460c67b2eda.1743354964.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Sat, 5 Apr 2025 12:57:54 +0200
X-Gm-Features: ATxdqUEOxrW58LfC3xHragmAjcOhP0SCmChf6_7Zu96OhdjDhMIzU4WAM3rhaR4
Message-ID: <CAN0heSodC8_Uwg_Lw31rtkdLfOEDyGg=iE0gb1TRrUWQEynT+w@mail.gmail.com>
Subject: Re: [PATCH 4/5] doc: move synopsis git-mv commands in the synopsis section
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Mar 2025 at 19:16, Jean-No=C3=ABl Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:

>  [verse]
> -'git mv' [<options>] <source>... <destination>
> +'git mv' [-v] [-f] [-n] [-k] <source> <destination>
> +'git mv' [-v] [-f] [-n] [-k] <source> ... <destination-directory>

Shouldn't "..." be tucked with the preceding "<source>", i.e.,
"<source>..." as it was in the original?

>  DESCRIPTION
>  -----------
>  Move or rename a file, directory, or symlink.
>
> - git mv [-v] [-f] [-n] [-k] <source> <destination>
> - git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>
> -

This is where "<source> ..." comes from. You moved these lines up. Good.
But I do think we want "<source>..."?

Martin
