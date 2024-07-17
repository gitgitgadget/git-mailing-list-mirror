Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03211CA1
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226649; cv=none; b=ulZin4NU2/GxKE+Zb0uZGcSchBJwD6MsUkGVj0+fZBAZMqyTRCDNUm5as3k16L5JxJbb7eu8hWHn0FOvQGKdVwJb18Gtr2r8By/4CAUhIUr4GaJbLCHzhkDwurNkVsduu/d+7yvVAlPjcM6I/gnwPB8n4nfQQqSkm+Nz7nKFG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226649; c=relaxed/simple;
	bh=l3qfwbmY/l+60EorZzaaVDIShdr22iBE1uCTYpjD1ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWbH5MrJHwbE3iUer0Nm5KbFzt1KyzpHIr6mKuQgA2K01Lixjo8JAzxH90QLWax1vT3l9JHazHMjUSIQhG3UndB0IkV4uX/8FcKyHpS/jX071TK+ZEzEXLpGMB3hcxkRI+qqAX7GWmG0mWDousg/tH3LQorwTnwLZla/qni7Uq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLP5xD9R; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLP5xD9R"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77d9217e6fso764588666b.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721226646; x=1721831446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9G1deEyEm2ObcIvivngRuMVqXmW0fmZSPGcVaI/E7Wg=;
        b=MLP5xD9RgxeAiTGia1rQgyk5rIPHwy80vNsIOEK6ypsH1hDoSkyjV5gFbDBv0NW/Fl
         PJDZTQoBkyuQxOlXMgD9Z0nvTbCXVQj2P5DwuRxkFb0zCsLQOqgDRyO1OaMHLB4uip5S
         xAXc7Ar1mLnjegorG0F4zZNFVN0nvAel3miTAyh7bWwpojhngC85IoC78kk3MZtzBMoK
         sQMjsVskz3Zy52ExuvnCp5Mxmepa0W6wogPLwAxd25nWMCMa20Pq6pxFhIZPxE3TqkkS
         DqpLMx/ljGZfDWRtZ55ZBCh7VKQvlQFi5HnIVPej3ipFoIGIHskDxkulZ69i/XLN+zia
         fUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721226646; x=1721831446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9G1deEyEm2ObcIvivngRuMVqXmW0fmZSPGcVaI/E7Wg=;
        b=FT5un4D9gjam2ip1ukpiL1LVRmILezz524m9pPEdpzw3Ljz+XYsQEwr1DSQj3Xh4hb
         bRg0fZluBUKUpiYMiuAl7OSrNM+0MmFdL3eG1hUyfgx9w8JMWsjlftf8iwcZPHA99oqY
         hd+IN5iuDpkFqrpZyblj4MLIxyLoROt5TuJ/RXmof1Bn3Olco1h1rv0Ei37QUCWFCiOu
         hesmBX83mEx91WHMyrh+21NX70Xqwq14yeVuBGBiNemf1dPaKqgSacyztsdemszld0Lp
         1LvxhmDxxZa5+eEONx1DhWFuI0plPBRgFGk7z+ivTGAuRsOAyz7kiFUHxIncLSSKIAhI
         VzRw==
X-Gm-Message-State: AOJu0Yxod5CGdoxBvP3h8ox1DjbBlYUL9F1q+1M2Lr0Hs1+boGmwND8s
	RUldHk7NprWyunibQKFnvB7n6IVAeHMUVJqrEL4rafm9EW6OhSoNs9qChcjjYK5IMGDrK6o/qqt
	YYSiZoi/SEYRXvo0cO4N5kgFrQEo=
X-Google-Smtp-Source: AGHT+IGY2GnEMl0mMbG/T37GE+/IJFIXvCiQWncLBjBS/LzBwAaVD1PHpGe7DH5uApgdUekawRjdtI4Iaudt9FmVVRk=
X-Received: by 2002:a17:906:f291:b0:a77:cf9d:f496 with SMTP id
 a640c23a62f3a-a7a011af228mr126465966b.39.1721226645889; Wed, 17 Jul 2024
 07:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com> <20240716075641.4264-3-chandrapratap3519@gmail.com>
 <CAOLa=ZQxDXDDWXQrt9kpykuMr6nxSA8uf2U2nu0ChTf3yuH8sQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZQxDXDDWXQrt9kpykuMr6nxSA8uf2U2nu0ChTf3yuH8sQ@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 17 Jul 2024 20:00:35 +0530
Message-ID: <CA+J6zkQLXsDdSa5xjizr82bPUCng0-XZJRNQ1CAV7ttDbE03xA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing framework
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 18:09, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > reftable/tree_test.c exercises the functions defined in
> > reftable/tree.{c, h}. Migrate reftable/tree_test.c to the unit
> > testing framework. Migration involves refactoring the tests to use
> > the unit testing framework instead of reftable's test framework and
> > renaming the tests to align with unit-tests' standards.
> >
>
> On second thought, it's easier for me to review here for the existing
> state of the code. So let me do that..
>
> [snip]
>
> > diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
> > new file mode 100644
> > index 0000000000..5df814d983
> > --- /dev/null
> > +++ b/t/unit-tests/t-reftable-tree.c
> > @@ -0,0 +1,56 @@
> > +/*
> > +Copyright 2020 Google LLC
> > +
> > +Use of this source code is governed by a BSD-style
> > +license that can be found in the LICENSE file or at
> > +https://developers.google.com/open-source/licenses/bsd
> > +*/
> > +
> > +#include "test-lib.h"
> > +#include "reftable/tree.h"
> > +
> > +static int t_compare(const void *a, const void *b)
> > +{
> > +     return (char *)a - (char *)b;
> > +}
> > +
>
> So this is the comparison code, and we're expecting the values to be a
> character. Okay.

We're actually expecting the values 'a' and 'b' to be of the type (char *),
which is a pointer to a character, and thus we perform the comparison on
the basis of pointer arithmetic.

> > +struct curry {
> > +     void *last;
> > +};
> > +
> > +static void check_increasing(void *arg, void *key)
> > +{
> > +     struct curry *c = arg;
> > +     if (c->last)
> > +             check_int(t_compare(c->last, key), <, 0);
> > +     c->last = key;
> > +}
> > +
> > +static void t_tree(void)
> > +{
> > +     struct tree_node *root = NULL;
> > +     void *values[11] = { 0 };
>
> Although we were comparing 'char' above, here we have a 'void *' array.
> Why?

The array is passed as a parameter to the 'tree_search()' function which
requires a void * parameter (i.e. a generic pointer). In the comparison
function (also passed as a parameter), we cast it to our expected type
(a character pointer) and then perform the required comparison.

> > +     struct tree_node *nodes[11] = { 0 };
> > +     size_t i = 1;
> > +     struct curry c = { 0 };
> > +
> > +     do {
> > +             nodes[i] = tree_search(values + i, &root, &t_compare, 1);
> > +             i = (i * 7) % 11;
>
> It gets weirder, we calculate 'i' as {7, 5, 2, 3, 10, 4, 6, 9, 8, 1}. We
> use that to index 'values', but values is '0' initialized, so we always
> send '0' to tree_search? Doesn't that make this whole thing a moot? Or
> did I miss something?

We don't use 'i' to index 'values[]', we use it to calculate the next pointer
address to be passed to the 'tree_search()' function (the pointer that is 'i'
ahead of the pointer 'values'), which isn't 0.

> > +     } while (i != 1);
> > +
> > +     for (i = 1; i < ARRAY_SIZE(nodes); i++) {
> > +             check_pointer_eq(values + i, nodes[i]->key);
> > +             check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
> > +     }
> > +
> > +     infix_walk(root, check_increasing, &c);
> > +     tree_free(root);
> > +}
> > +
> > +int cmd_main(int argc, const char *argv[])
> > +{
> > +     TEST(t_tree(), "tree_search and infix_walk work");
> > +
> > +     return test_done();
> > +}
> > --
> > 2.45.GIT
