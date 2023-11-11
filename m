Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655E63AE
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR1hc8yK"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8922591
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 20:05:03 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a98517f3so3493704e87.0
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 20:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699675502; x=1700280302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owj3sI3q8dAZk3QfQqDs/JMz+VDlYLjH2oy9YzE5Prs=;
        b=VR1hc8yKzrl7x6f/IXoTJMqUVK6+Gq562IWQ/SyhfJoG7j6Lyhwgg3p9TeygB4+Uhz
         2ksjLL++BJ2EiLM3uPNH+7+MxyTgoF4WvK4inLHFIo7DhvpceQ98mxTebCxUiFFENzyA
         oTtthnV1VTlCM7Pv65cMUtV7RJvK93ilG2Tnw5XWtODcFzfWBRf9cQckV6xBwzlqbHhk
         VYbwLbyKkgqFi2QGv7+TTQ+mCjeK2EIdhplR7Xx5dzc/Y+1lMhY7IiDvHdQb9BYJAr6y
         m2lp+t/VZ+qKqo6RvziHrcMEMOgIm1M3wT1IcNw6heNYK6WMuSBmfd+fwm5e9/dCr6XV
         Pjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699675502; x=1700280302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Owj3sI3q8dAZk3QfQqDs/JMz+VDlYLjH2oy9YzE5Prs=;
        b=u+53UYAYfxVv+MlUoxxqEPJOLsjG/PHpSCC0glHcNl/O4oAgMXCQkaFqO6uU0he06u
         raPMPOyr1qQDC1nHf64Nxj114IXX9599lZhdK4Q/lKPMh6QU3MmDlfnX02DyrDBNFS0q
         SUzj6xz11TXTxX8tX9agkxqS1E3U3R6RJwDmbjdSMOwsElBzkrwNBiBK+NWsoiBA9Vqp
         9RCQ9/gDP+oiosE5j60uC3Z2pzhBqSeff+M3OtyrfkifGh4nYkdu/crIcVh2r+O+BMoa
         ljKEvicwikDr5gB5gtwDXvZlTAAkaSyRTKfDSGdYQfUzC/o/PrZrWJd0jvuVkG3HHdDu
         B8SA==
X-Gm-Message-State: AOJu0YyIsMeHPepY90G517Ves8RBMdMrVV2kKQb62dFr4BqyLmP+KBbj
	1sY6fUKSE8SzuKPGtVJmxa+fRaLGGV9yGYcnHXE=
X-Google-Smtp-Source: AGHT+IFWARxh+TDye7Fx8TWuliNNJQjGs7z8cXXILcs2hph6DE269GtNvpKUZ5O+YqIAaZWLYtQIqzkyBXXhBb1uUfM=
X-Received: by 2002:a19:9103:0:b0:507:9f4c:b72 with SMTP id
 t3-20020a199103000000b005079f4c0b72mr447411lfd.15.1699675501619; Fri, 10 Nov
 2023 20:05:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUpepnSCSxL8i96b@nand.local> <cover.1699381371.git.me@ttaylorr.com>
In-Reply-To: <cover.1699381371.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 10 Nov 2023 20:04:49 -0800
Message-ID: <CABPp-BGy8tkDAfgdhP9+V1dNk8_J3fM6ykb18jO5O4MC0VwTQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] replay: implement support for writing new objects
 to a pack
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 10:22=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> (Based on a combination of Christian's cc/git-replay and my
> tb/merge-tree-write-pack branches).
>
> This RFC demonstrates extending the new `--write-pack` option that
> `merge-tree` recently learned to the `replay` builtin as well.
>
> The approach is as follows:
>
>   - write a pack out after each step in the replay operation, so that
>     subsequent steps may see any new object(s) created during previous
>     steps
>
>   - combine those packs into one before migrating them back into the
>     main object store
>
> This is accomplished with a combination of the bulk-checkin and
> tmp-objdir APIs, with some minor modifications made to when we flush out
> and finalize bulk-checkin transactions.

Just thought I'd note that I finished reading all of this series as
well as the five-commit series it's based on.  Just wanted to note
that any commits I didn't comment on from either series looked good to
me.
