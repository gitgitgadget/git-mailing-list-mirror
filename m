Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6B1B6CEE
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126520; cv=none; b=iiaJNcWXPVmO8385txBnTDBWFKWEcsXUdQI/CiyLNI7PztovQGwW3sPaSLOu5CYIp538JW5USzAt7m7kJIVfHYMl4i+69N5rUr3suLzYO261Bgj+el5tAT1ZLFQckBp6Hk9p7OPF/syhiiPDRQb64QB2j2VobdjBeK9GGnvmAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126520; c=relaxed/simple;
	bh=KxP4ruUq4o+YUNBT6nIe58ItZHyYVqDhgoQd38Wjcz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVvktjk1pOZyVFL51oc3w4ML47bvtDbr1wJnOxlhg+I1GyJ4fxuVhZavFntdRxh4snrTzR6AsQbRPO5HFmKySjhC+E/G1xly8pYVe2x/Db/rTaYv/rK30TGhBnFMg0fWItsg2yUIxUfslhr4Rf3Z5e5YF4j2nACrSvoh6jrCr5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndGn3HRJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndGn3HRJ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa1e87afd31so7571266b.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732126517; x=1732731317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxP4ruUq4o+YUNBT6nIe58ItZHyYVqDhgoQd38Wjcz0=;
        b=ndGn3HRJihNayDHxT+p9RkevsCOr8Ot/MzloFCKVOoLNxBhumrjku+v1rP/wYOPNW6
         zd3GxbEs5H+Wdf7YkxLRpcX/VE2OB3rU3avNAl7ZhSmZa57I+OJXcdYAd6GE/ioSkejF
         whgEqkNp5a02WjlyyzzTMZ0CWQdsMD08y2q/HTKheRyoYGONFmvyogwcZG39z3uQr5t6
         iZ4RDl5DRzZXXnRTFsDaeqlhV9l2UOm0znXYC/3MP2PmEFtyphiMNIE1/H7zETJdz23O
         j0a2w5hXPyHQD7g7nqT4F2QXt3r6ZXvW+vt7A7dJhcdTZRbfrScY7KRBei4cWzEiqmQN
         dQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732126517; x=1732731317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxP4ruUq4o+YUNBT6nIe58ItZHyYVqDhgoQd38Wjcz0=;
        b=l6jXZQSGdv353j8+EcyjF8dLC8jurtyyYbge6TJKvG8N1YTrNrPcsj8+4wj+NPoqtI
         dsUmWgtxvYhvCT00/+o3Kp74eXYM9sL8byTbko8/wCu3xKBdQp6G+hKsJic8M7oaoAdS
         A69NheKBboBvk0scwQtMndnLEdmoAeRmESalEom+UndFdEdkIO9gYKNjwKD6UsJBUEIo
         Q3zyJgKvlwrXyMFwGWLvuK09E1u/wa+bfFrcbqBf0vSX8qrcQZb17XVHDPA91GVU35hJ
         J3V6g0P4fcaeDghBt+1MiVJ+IG4FYWNr1uR9M9tdd1lcJb2wyBIIaZN0bbdHN235Nbtt
         rCVA==
X-Gm-Message-State: AOJu0YwkL/kaXqXK6caBp81qdKpeFq5UgpWyHwWVSxtYBVMapasNSACz
	TueDsyUvAN2dqbxTpV4VdkxDfrqA5BIIfe7R+rTS+rnhDtI9pj3ovntHl06SMQIFUJCf/F9zmEC
	hCBgtN8dia6rOhCBMadUYK9g5XzUmlg==
X-Google-Smtp-Source: AGHT+IFYUNgfuBxVLDln74r7mK/szMVl0GQVmgejN/gL+LmCyMj8FShDN4ORynn+crGIl3F9oJ+DG2N87QCeAuYm9ao=
X-Received: by 2002:a17:906:d54b:b0:a9f:508:6726 with SMTP id
 a640c23a62f3a-aa4dd52d5acmr344569466b.2.1732126517064; Wed, 20 Nov 2024
 10:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-2-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-2-e2f607174efc@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Nov 2024 19:15:04 +0100
Message-ID: <CAP8UFD0RpTXCdeYPA44yiS1E-LsmSHVrGxNKaUFkvUqq+zNTZw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] midx-write: pass down repository to static functions
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 5:36=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> In 'midx-write.c' there are a lot of static functions which use global
> variables `the_repository` or `the_hash_algo`. In a follow up commit,
> the repository variable will be added to `write_midx_context`, which
> some of the functions can use. But for functions which do not have
> access to this struct, pass down the required information from
> non-static functions `write_midx_file` and `write_midx_file_only`.
>
> This ensures that the usage of global variables is limited to these
> non-static functions, which will be cleaned up in a follow up commits.

s/commits/commit/

There are a few places in the patch where hash_to_hex() is replaced
with hash_to_hex_algop(). However hash_to_hex() is not quite a static
function and is not defined in 'midx-write.c'. So you might want to
mention this additional change in the commit message.

Thanks.
