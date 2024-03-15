Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275181799D
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497155; cv=none; b=Bn08lnz/1dpZl7XzA0V3y9KKsiglO78ioHyU8yydm11PJh6MvCapWPj/hmgg7+aYyK/h37pQ4t8bAOMJeG92jBbChSs3kqJCjhy9aG81d63B4Vv/eSXkZQano/SLIG2JjVSp1o9FtVX0LwpbtOqj5KBac+dX1CpczZvZYMwZzTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497155; c=relaxed/simple;
	bh=lDyYFjkHzbKm/zVuwDao4AYz6TcRUEls0UWN4dMEUtI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Weq6w8CNfkskeiLrQYkv5DEE59TPllCsTXhGDUgTl33VBK8Orw01Iw2cSUpYefqumXW+BcJJ1QhV3LMmNJ+WZcL1vUdB5G+q/SW5yG6vYJj0F3BoEz5FLdzmrHCibt5wqkXzFbn6stbNPy4io+po36g9C+lfomRItXpVu3SSKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaqlIjX9; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaqlIjX9"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a057b6601so18879757b3.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 03:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710497153; x=1711101953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lDyYFjkHzbKm/zVuwDao4AYz6TcRUEls0UWN4dMEUtI=;
        b=BaqlIjX9GiDtS5i4XinfnLiZvWIsG4Aptt3MjoxIqoIllA8W4sGmrHk4BavopjrqK9
         Wm3NVQRoehVaEKcuj+hS9GWaAxiDhnkwmObjGYkMA1DNOeyTeJKY2p5JE67YLEsjNOtU
         laejlL7owLhOiiXRJtX0Yxlr1IVSlrETAOujVAyrLO6IJrav30bobewCpfmNKcyRYAHA
         7WNl+p0eyqN0byZH7TXmglTrFMS6lRYY4DCicnCoXImbIWrUOMhhi3M0dKfvDLFyztMd
         go1gFzgHAFVvF/GbwoiGE0emsLwbJXFrFk/+JvrjJZ8ZS4CE+O6TE1ce5Rk3kU6g/DS4
         BM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710497153; x=1711101953;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDyYFjkHzbKm/zVuwDao4AYz6TcRUEls0UWN4dMEUtI=;
        b=fi6M7OyyMYyOm9m2YHRSeN+4xPDv7DDd8TMlyYwVfzUfNjbzIMy8n/TPL10tsXbFCI
         UFk2/S0rsxO2EzEFwQNvw5fZSuaoNOJ2NcIYxY3t6EIVDhW/IsJwgIYhD5H5NNmXQFHN
         v+/1cYRkmn8Ed8m4imsDEyYHjkNZ6j2SlWueui7HhArxcWlKdjTN+skPFjIDiegMzyNy
         Ixw0xFkYn2relW+7Zp/5C20bgrNUsCN+Ra/o6bKSDHtHt4bfnbcGpDV9EDlceJHzcgpG
         +PS/MwPHkFhUCmlGyK70gudf5nCR5XUBMdnC3MutI60uUvl5jf1En6OdXP/QYBKILLtJ
         bNJQ==
X-Gm-Message-State: AOJu0YzTXP/xXExz9KRcwiE9V/+FBwW6D7GtkzuhKRdn1NnSEE3yrNPO
	LC3GrUTzTpr4O3Jnbih/jz2T2airKfPx6bKaKMkTEVDPeViKkpGg4PyLG1ifbSWDXjmYdF8y+s3
	wf9yVULBkITf0nzsd8NcAnP8+we8=
X-Google-Smtp-Source: AGHT+IG5ZTGMi2kZsJHQqgPaJWFOepozKDX0ZzPjUoifqIkds/dJt10iUDWlLL7NXY8xIEXAQcQoS/LFNqN+cwChWTo=
X-Received: by 2002:a25:bfd1:0:b0:dc2:5553:ca12 with SMTP id
 q17-20020a25bfd1000000b00dc25553ca12mr4205850ybm.14.1710497153012; Fri, 15
 Mar 2024 03:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: eugenio gigante <giganteeugenio2@gmail.com>
Date: Fri, 15 Mar 2024 11:05:41 +0100
Message-ID: <CAFJh0PSRrz=WYvuXgFGER6_E5qshVKSWNxBDgVo6GcCGfFDK8A@mail.gmail.com>
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
To: ps@pks.im
Cc: git@vger.kernel.org, gitster@pobox.com, 
	karthik nayak <karthik.188@gmail.com>, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 09:51:52 +0100 Patrick Steinhardt <ps@pks.im> wrote:

> We also have consider that there may be alternate implementations of Git
> that would only know to handle the old layout. Those tools would be
> broken in case we did such a migration, but they would be broken anyway
> if the bisect was started via Git and not via the tool.

The first implementations that come to my mind are Jgit and libgit2.
I took a look at these two and apparently there is no support for git-bisect.
Maybe you are not referring to those.
Also, do we care about several GUIs for git?

Eugenio
