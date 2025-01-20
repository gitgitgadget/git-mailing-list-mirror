Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856D155A52
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737404358; cv=none; b=Rq/HI+BzBA1tCqDXOWD659PjxyOfywGFZGo+IwesWGtmk6Bx3oQLNI9lx4US1TixaJAr+h34Rjulq/lxcmTL09oVvER9zxyo+uwJRNlTzVUgye0JxqD6xm6642jvYWgbxRcX/DNsEspvubC5zllenjyzirIbGrK+LcR4R50Kmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737404358; c=relaxed/simple;
	bh=CDyLziBXgGYXWdYMwiEqYaNk87E4zdPH8+AiQZ8SjPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeRhmqyXVYgPAulx3FH5C4jZ8I3ddLhzZsTgOQ8PvMTFtLMefmpEYv0WjVrZjrwyE4arNH+8rzgqU3As0UJz2lZXMreAWgsRRI0Drbb8VbBSXBLynNH8pCJdIoh1DIa7JHjLGmzqy+GKrboCVqo9hhvdpOrAgmSweYZ8rAK8FKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8NLadxe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8NLadxe"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf60d85238so824006166b.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 12:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737404352; x=1738009152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDyLziBXgGYXWdYMwiEqYaNk87E4zdPH8+AiQZ8SjPc=;
        b=O8NLadxefzZmRFbQt+IZNz36MBR7DEtIszx9bUdRtvABIC7io+DtDu9ur22LU4EHGH
         3B5vJYgZbIFKjhJle1glHMC6xQgrA0VHDrIoJI4RJxKSEZChKs/XD33ECEJN3elCQVLI
         V2/Ty7nZ3d+J8wsRrVzc0QywIYljCs08SFcfQxbgjeJHooShk/OSbNllKGxnOjur/suK
         0Kg1nU5c9EOBncJiD7P2KLa6zLDzmzA+EaPdfK6DfprZ8BlBwCbRlF/o+jUIQ2VgWRQH
         5hIHxB1cbjT7IsUjbaAhY3ImXPIh6MvESNoPrOahJLDmccY3VmKOZ9zXboN3nbpvGe5l
         Opbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737404352; x=1738009152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDyLziBXgGYXWdYMwiEqYaNk87E4zdPH8+AiQZ8SjPc=;
        b=tvZ/R/ScUDGBcNV3vqfXqwLatf7vyO9G01f0pYdvvRMK+pBrWyMxoorZ5tSNi9AThU
         V3YnoYJEZPWo6qTVDL4y/qKAKArp/UXPikxKUOgwKn+Sxp/NPH18NTWr4Qoz7REXpm3u
         NsD5K8pKjIf4hOJ431wpQiAudcoclY1HCJ5m8sdtPiRFrB/F86gTtktm0okOPFRRp2Jk
         1RMwgs15YmUhPpdDAUtn23DSuvVwswdCYSvZeVEXjQGrEcak/p3DxB9gyAfErsdi061R
         inEwH09wGSetjBYcdvxR5GL+4yKLT0ww6CxMfSW7HrpmgYdgXhkCcrg95fTHZmJVRYUb
         Vl7g==
X-Gm-Message-State: AOJu0Yxop3sN8959xBQ/VdS/lITsW7aZzTI30ZEJFkG3BZnF25WoVvX4
	m57IDHZM8ehKEdOzkvRtUi6SCfOoebTYp8WuBSFbdA4G1fNqJoMX4Wzu1pmGHkRo6JQDbCsLUK2
	DClxzD+fxQJXEvUICdonAS7Z+F54=
X-Gm-Gg: ASbGnct6deqYgxzA85P+XHBkJcOsr90CDFsFAKzxTVLH6Pf6TN42fVpRgnE7XIpkMrv
	YxxC2iJsqjzCe9pOHtVbBFGS83JTDYHGNnNakTtm0bASqt7jxCAzrQMSQUFWU/wy9aEr3fSZjEP
	42LoeIuDY=
X-Google-Smtp-Source: AGHT+IEfIUwTrig49rkEEtSEyJzeFdABuSsvXNV5HSxGUZQ8Ed1Alu4ExQQG0EGz5fvjhmR+sHxLLDFnNxWkprOkFv8=
X-Received: by 2002:a17:906:d54d:b0:aae:bac6:6659 with SMTP id
 a640c23a62f3a-ab38b190d52mr1324385866b.7.1737404352450; Mon, 20 Jan 2025
 12:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
In-Reply-To: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 20 Jan 2025 15:19:01 -0500
X-Gm-Features: AbW1kvZPEj0PSt2nDfMRjLsMcT4RwOo1MqrhIKG2aX-MXEdJvMtbuih8_MshUb0
Message-ID: <CALnO6CCzHU1bD4yVuJKBf+uFVFe-AenQ2sGP+fgEkdADzqgqNQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Convert AsciiDoc files to .adoc extension
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 8:56=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> [snip]
>
> I found that using `git log -p --word-diff --word-diff-regex=3D.` produce=
d
> the nicest rendering of the large patch, so I would recommend that to
> reviewers.
>

[off topic] It's a small thing, but I've started including a
"Best-viewed-with: <git diff options>" trailer in commits where I
think it's relevant. Now I wonder about including a configuration
option to automatically apply such options (though safety + alerting
someone to this change in how the diff is presented would be an
interesting UI factor).

--=20
D. Ben Knoble
