Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BACEEAA
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751166673; cv=none; b=i0ncVkPJw0Zr1AR655jm7WxR0RBLFvfI2xSh/zP5Iz+2bkxSl6A9TuZuCxJ1eaKodfemVchbBwfhMKv3oQsQb43G6FMYuXYouz0/I1skppqLQGyXh+H715ePyHmXhfP35jWz+PV6cd3LYrjKkJrubxb8SMVHAxSxJF4BJMQrB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751166673; c=relaxed/simple;
	bh=JVtOT+WqrGIuZI8yOeJobeA49OYjn0vFDyaCf3h6BQ4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=knjdY5rWm4VVOkuxikQSuW6kyJrjEU2Hql7DdHVO1v1IshKH7Lm+enJJt7TYLPY12GSHNNyEc81NsQywgAeXkzdsYVG4jpGSuYNWvW+t93mKf8hR913P1ZF5b7uiMOSxFPHwPrn2DicR9/YbuOjO5sRYZO206ZQfEG7Y6p0Como=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE+rs4Mr; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE+rs4Mr"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3176785a12.3
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 20:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751166671; x=1751771471; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcC/61x3tXkFj1/+Xr1C+QO926eYlm050+rDmcQb71I=;
        b=VE+rs4MrE5IVnpx0a1hp44ftyb7qnlQAQwVkz3ng8yAYdRqRn5CrrdSmzNsdB48Cfw
         cakkhU/jLB+ke+XZBd2XqiJLdJv/l+RQzn08V2HH/OK4sYfGLtmac8zsgFuUpw46rXWV
         mZT0SSwzSA0+3sQU//WmoDHxEwRV2AJJMXrl/BzlrT42Nf5BIQXMluqvUzPTJk9YaoTQ
         5o7S+5l4RRXdcv4+OZZX95DvBGcipcG2cICHozyE5O45rIBErpDQlKLkJNlLSlwsAmwP
         zn9edktsoz13cKYBbGKY2/fQymupOx8eCP52RAV61F13EVzg4+FcDny/ilyITDvfYRRy
         6SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751166671; x=1751771471;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcC/61x3tXkFj1/+Xr1C+QO926eYlm050+rDmcQb71I=;
        b=nl1IfTuBKXnx2IzVqPLDgutCvgghYo32uN/eyQz0uFVoPXWQy0N1Oy4IkkKWGVj3Rl
         KiSqNlX2sdG4q6JbMgqopNvbKqY0CEDZdODNDnQnRs9g2nLd/aeDwRT6vVXTbPhw9lw0
         5lb6FYMBXsB3hLgYxSDAb7jrjthilsA3CbanE9hWLDPg0VdoZcVELrk/FzLS+qkDIFIC
         8ZEVBAYfA8eG+87YvQ7f6AIORYG1kBHdfpvP2yZGi1SP07w3/1U3JGnAL5a5ngY+vR6t
         /Io04ujYKvNqD6BGtBqtAc9nEfn154DbARnp9dIgArU/LUuXM8nuhnjCSUr3P12R4B5j
         9/Xw==
X-Gm-Message-State: AOJu0Yw3zf1ik/mle276QnQa7hivALb8QPnKey4cUUEIcV8PM3E5Berz
	JTHo9RA6QEDtzqNqgvcgWCKXvSjQOC2pMUS90a4e08M2Ep3A6j0HmFYs1ipO4V/OvrcXEw==
X-Gm-Gg: ASbGncuq2OkW3WWFXeXaNhAkKNulef6AAdnsWJLpe5NgPEqmz579IeN+68ZU8whD/wo
	RJ7mXjdzXGJxiogmu0z+NXvElYj+5iRB2zHOAHuAeDZo6hZRk8flzVgNDy9nlh5cHUIp22FmaUH
	dT6xrodhJWcbsUr3jajxYGWdvcGPVkvmto03dT+T00Js6PRav+k7RsDMcimR1XY+Lkb/clDJ7Yy
	bU5ImZ5vBEsFbGjGrPDxm7DINO3Qu8AMrmQguC14WccxJ4fDXR1GnK+VxY1vZIuYRvzxQ5OjTt4
	pIyR+igqr0SrmUzKFH93GqY9fH5xxSmhJJwCHNjLxUyyhD5uQzZ//1IL5wGtUIBqcULa5uFUTxO
	GJuNuOT1Zr4Br3edAPRphJJoPy62wC9LRNyVGBhYicV4YhwSmGCWyXdim+QO1bRw=
X-Google-Smtp-Source: AGHT+IGgGrO4RNvp/3GLMDyOg7fx9JI36IYES11GMnjNqjM0q4oW7JMlmI6L60mBgTVTcjSAAajceQ==
X-Received: by 2002:a05:6a21:8dc5:b0:21f:74b5:e8cf with SMTP id adf61e73a8af0-220a16a12f4mr13016263637.25.1751166671419;
        Sat, 28 Jun 2025 20:11:11 -0700 (PDT)
Received: from smtpclient.apple (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da944sm4830144a12.60.2025.06.28.20.11.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jun 2025 20:11:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 0/5] fix apply --intent-to-add
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <20250628225819.1294068-2-ray@ameretat.dev>
Date: Sun, 29 Jun 2025 11:10:57 +0800
Cc: git@vger.kernel.org,
 aclopte@gmail.com,
 gitster@pobox.com,
 jason11choca@proton.me,
 kristofferhaugsbakk@fastmail.com,
 rhodges@cisco.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <16943C7D-C331-482E-BFDD-236E8E79552A@gmail.com>
References: <20250628225819.1294068-2-ray@ameretat.dev>
To: "Raymond E. Pasco" <ray@ameretat.dev>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Raymond E. Pasco <ray@ameretat.dev> writes:
> The --intent-to-add (-N) flag to apply has not worked properly since =
its
> introduction in Git 2.19; in particular, it creates an empty index
> except for any new files in the patch, making it largely useless =
except
> on blank repositories.

I find the problem is that when we use 'git apply =E2=80=94intent-to-add=E2=
=80=99, git doesn=E2=80=99t
read index file then update the intent-to-add cache entry, git forgot to =
read
the index file and only update one intent-to-add cache entry in index =
file.=20

> This patch series fixes it to work as expected and updates the tests
> and documentation for this flag.

I think [PATCH 2/5] actually solve the problem. [PATCH 3/5] makes 'git =
apply'
consistent with 'git add', which means
  git add =E2=80=94intent-to-add exist-in-index-file.c
and
  git apply =E2=80=94intent-to-add patch-contains-exist-in-index-file

will ignore intent-to-add and do nothing.=
