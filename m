Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF4395254
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482949; cv=none; b=m7jPTU9MwiMONBKMOg1ZCb8fov00+aI6If1AOz0BXSSMK119Z/rz23+6QIGWgWbgijQgp2x8QO6WGZ6UFVoA3P/OZ4iU0bNoBNyCshr1YQDQzuaDksoG9MkzCNWU46Bb7lUPOkxO+7Krfy2w5OaXY/GqQUQFGS5YhcJkSMy4Vtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482949; c=relaxed/simple;
	bh=sSkGeiWfqxw5oAMNHKGPsCgkBrRboHu/rIaXZGrAOOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdfEW3wdREFPpwk3oOcATFwoHXczAKeZqSwlbh14wi7WOnfHipwOhQfza701ba1/pLNr/a22bT6RbIfXx8wb5Nybw/7zmuYYjJP29dWVMfxXCY0ArAnmsCgYuYSfZMwt3p2QRK5jL2+mHo74yPE9Irw4fLxxGfnkX4Lm9FeDaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llGHublC; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llGHublC"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6446d7a8eadso746154d50.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768482947; x=1769087747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=935VJf0n7EdJTt21LJTC+O1hRXmqDPZ1zQ/cd5U0I48=;
        b=llGHublCVNkn97n2Xr/JRmkVg0ZZKrHWafvjVwCMsxniN4zQufj7zOI8ItnsXpkpNs
         DZpyaH72Pocs4L7fLVpaDqSyP5ggKbgwRqcCU9bBTldyQ7f23hPVeR2NzaQSMeQ5wM/L
         rBD08YWLn39ioj3pKQ6RiWQpF8SpaoP2PpqOqj2PV4twp6iiZ1HMM0vAkmnD7A76c5xP
         UCksaD5F1PrG0ZKj11UkCKUvepB1nwXR4e958zM4ZwCKqH2vFbz+ie02ksPdxnDqm6T/
         L57MEgxb3DFUIUHNL4Hm3rMsuvlr5Xepk+Tjyi/o/s3xFXF/YtpDZijDytX/+f5qUHIz
         7Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768482947; x=1769087747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=935VJf0n7EdJTt21LJTC+O1hRXmqDPZ1zQ/cd5U0I48=;
        b=qXa2I1Y2u0xJTLZMDkDP/Wty3cpO8jqqSRI++awbp1jhWCfr55m4WHcfBFSXJh0B6a
         5utswIpHaH3Jt4QYlsByBGLfE7FfGlomfbbkPAByZT6Guvoh7d5fBJlgbFn2w8WlkbCQ
         A3m4bkXGVQBO1cMk+MbnmECWQnZLMhWKSTRL8DQ47yYHYAivs+PWvWFHSIHdltX7OXjx
         nIC0vvUoFH+siawJ4S0jXlD7LPlQeB8COs/nJno3hxvZZgoxgExqiRLkJBT3TgjfH7ol
         X8OybhhCZBNzNZ2svevgYjv+Rz86I5aJU8eKgUemF+KF2HgKhyUUznF+QWqLv9AAsdZY
         8+Gg==
X-Gm-Message-State: AOJu0YwaYnMlnqzraE49tgbNp2VdcGkaF5wQpClgERmRw7CNKjXCROlE
	9jv4YumsEUY12n4AZ/gMzIJzENpdPdsB+gZFyZtNAS++N7EKxjKDK1Md8WlRpavZ1JLCsP0/wgz
	T6Q+4JTTKEUChVUPpD/hWI0y0Vg4j9HlnJWceIyM=
X-Gm-Gg: AY/fxX4z8YpVkZ7rf0lxgy7e9ouYcfT9zf4g7AN4UZ73yxhHRM/KND7OSuHr+s6PMw3
	JkFO0SmX3biByYzMrs/S5KSbNVC1kL83LY95VvtureZ30lo6LYi8Jro9Bwhfd+AfCVDbmsRzmVi
	AKH4W4FNxIpfQki0tOIcRXCTvyL2AFJCWx9xyrqdqhMod+KzbWZyV2UyL+py9d0BxrVzh9qrqlA
	3f6zRWKly5mVaTXhmn4ptKxAyRoo/gNeZOvkOqfyiSyfN5c6ckP6Tf88xSq6L38fs8xqKuSDNGN
	Aj8hpo6TtnXRjev+uK7b15IBVbA=
X-Received: by 2002:a05:690e:b84:b0:644:71e8:cce9 with SMTP id
 956f58d0204a3-64901aa65f4mr4908742d50.5.1768482946808; Thu, 15 Jan 2026
 05:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114192803.4852-1-amishhhaaaa@gmail.com> <20260115130935.93526-1-amishhhaaaa@gmail.com>
In-Reply-To: <20260115130935.93526-1-amishhhaaaa@gmail.com>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Thu, 15 Jan 2026 18:45:35 +0530
X-Gm-Features: AZwV_QgkP3LfSSsbCOymBT4ehTUoZsCgdS2mxGucQAoqF8CdDy9K8yDGUpbVvRk
Message-ID: <CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com>
Subject: Re: [PATCH v3] sparse-checkout: optimize string_list construction
To: git@vger.kernel.org
Cc: gitster@pobox.com, stolee@gmail.com, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

Made the changes for other 2 places as well!

I was also very curious about the presence of
string_list_remove_duplicates in the original code, from my
understanding string_list_insert already removed duplicates and
string_list_remove_duplicates was still present with it.


On Thu, 15 Jan 2026 at 18:39, amisha <amishhhaaaa@gmail.com> wrote:
>
> Improve O(n^2) complexity to O(n log n) while building a sorted 'string_list'
> by constructing it unsorted and sorting it afterwards.
>
> Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> ---
>  builtin/sparse-checkout.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 15d51e60a8..edabe7cbd9 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -91,7 +91,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
>
>                 hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
>                         /* pe->pattern starts with "/", skip it */
> -                       string_list_insert(&sl, pe->pattern + 1);
> +                       string_list_append(&sl, pe->pattern + 1);
>                 }
>
>                 string_list_sort(&sl);
> @@ -289,11 +289,10 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
>                 if (!hashmap_contains_parent(&pl->recursive_hashmap,
>                                              pe->pattern,
>                                              &parent_pattern))
> -                       string_list_insert(&sl, pe->pattern);
> +                       string_list_append(&sl, pe->pattern);
>         }
>
>         string_list_sort(&sl);
> -       string_list_remove_duplicates(&sl, 0);
>
>         fprintf(fp, "/*\n!/*/\n");
>
> @@ -311,13 +310,12 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
>                 if (!hashmap_contains_parent(&pl->recursive_hashmap,
>                                              pe->pattern,
>                                              &parent_pattern))
> -                       string_list_insert(&sl, pe->pattern);
> +                       string_list_append(&sl, pe->pattern);
>         }
>
>         strbuf_release(&parent_pattern);
>
>         string_list_sort(&sl);
> -       string_list_remove_duplicates(&sl, 0);
>
>         for (i = 0; i < sl.nr; i++) {
>                 char *pattern = escaped_pattern(sl.items[i].string);
> --
> 2.51.0
>
