Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2578C7A
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290995; cv=none; b=rOcl6QP7ruopNaoNO/Z88J+dRIQVIwN9tQoPRlT+fpv6vWZLdAhIelNmRO0tsF9WvnzcgWbkmRDcIcu5ITpuMnHOs2qul1vSVyeGTJB5XXIEvYa7C75ARNhqxFqlMlqa0JQacLH4Ey6yDJxjNF3xkO9x5xv86XhMdjWeOx7h+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290995; c=relaxed/simple;
	bh=u0EyM+te2vmusrdzZL9Rp/kM0+ZtZYwLciKXgBsSKkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGa9cE6EeKxyJiWMEZP5pOmMqczoqAnjW8ugXB8k3Oe6WvTgoxEwShFw9kDQ/ZsHMYG59aRRQDuAysGyklzXPE+mPnIgYMHT3HIPP9m2mdYHCLl4tbninUNdl2CAyQlPjqVg0BUN5wONqmQcJmI8kKDLFLBVEbsk6Mqft2w4qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtTsU3q5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtTsU3q5"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77e85cb9b4so60147166b.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290992; x=1721895792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ydUI3z1L54+qc8+QcfDkgg59Qi9lmbdL8Z7vVrIq9Pw=;
        b=BtTsU3q5LqzEUqSo2d1+cT650Y73FkGISQNl5BdYJrr0S7JSpvHpvyU5KF/KEDQPD0
         FGATaEdrox7yIPquGgSrV6HX9ZOSan+LpdO2dLDQGkdIkIvDpLea0s9WXgBHz1KgrOGH
         eMeSf3ATIAxZUqye/dlk36SZAn4TzX7Ohm/ZVbGynPUO5VoTdqWQNnNbJROCJKA+4Cui
         BFdYb7W79hN96wGu9QVWlXSqZ8eBFi+t6w7dGe1s6ZACqq//s0hfPBpN+ySid5uIMMPi
         Tibf/k6/IweqpmeH1eQ6GqxvRbL1jkA+VcRDMpsuPB1+IiV5m2KRBUr/TIWXGzfu+NtF
         oLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290992; x=1721895792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydUI3z1L54+qc8+QcfDkgg59Qi9lmbdL8Z7vVrIq9Pw=;
        b=TmnsPWAgQm20qO/fK84rzIPjcIDhZ6n/jBGc3MkBSRFf+l3tIlsgIYGew7hsY8S4Xl
         yLW1Yw1yRendV6ORMJBMVMHL4q+5GZ4GZ7d/ol749ZQ3JW0biTOmdpZLyBBPX/y6xbHK
         7RxDHxCZ/iAaWiJeAwydLE57q+tKwpptHIfvWQK9HszEJOQ0kTz93yUb6S4gFp3VLykd
         Oi/7JlR+keaqNN12axhm7sBVkXrOJc1AqtVqed8Sh/5z6Yx4rUyGzdRyLXX8bhDcExFx
         j0xALAhixxUuJSb7qGZNWJ2A/Y4ZQpjnLFTQBy2Mj+8F3X8X9LOAmUHbiSZi/H9nOtIl
         +vPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwrmf5k2A/d6YXuhx14lQx6GNMlN9p3xJApwuYlOPIITExp+ZTAd5Gi9O/mBdL/M+aOQAenQyjv/NWMRlrGTuBbTWL
X-Gm-Message-State: AOJu0Yw46xw8d8g03spoaH5FM1CU2OE8yVBSvk6xEg88bfzBHHwShg57
	BGJOZe1ks3CRSjwUasCud37rzNtPfq5DpZKm1HyykENMJehmJnW3G/kU9GrmCQLIHL+j/cXg1rw
	DNz66bPq3OmcIsXQyTbpO5Oi+X71VAQZfpOc=
X-Google-Smtp-Source: AGHT+IHelyWtR0TFXXzAZk1aBaHqvXYwM4gpXKMYLVgdpwrgKpyfoUCVHY/EEfqL3KUgH9YtcYM8Zisd04a9yj+wReM=
X-Received: by 2002:a17:907:d301:b0:a77:cd51:3b32 with SMTP id
 a640c23a62f3a-a7a01353715mr321872566b.62.1721290991807; Thu, 18 Jul 2024
 01:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com> <20240716075641.4264-3-chandrapratap3519@gmail.com>
 <CAOLa=ZQxDXDDWXQrt9kpykuMr6nxSA8uf2U2nu0ChTf3yuH8sQ@mail.gmail.com>
 <CA+J6zkQLXsDdSa5xjizr82bPUCng0-XZJRNQ1CAV7ttDbE03xA@mail.gmail.com>
 <irlg4rgsbfedphbxemj6pns35aceuwqrth6gyj6hi56fmr25n6@yvp4od2ydc26>
 <CA+J6zkRWzq_XNf-E7Nx4_D7rOOjN4Bwi4g3zgzV6YCiVoCe8rA@mail.gmail.com> <CAOLa=ZRGV1-3cDxgJd9zENTCEPqz04AFwWmkQnYwj5Cbg=EmfA@mail.gmail.com>
In-Reply-To: <CAOLa=ZRGV1-3cDxgJd9zENTCEPqz04AFwWmkQnYwj5Cbg=EmfA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Thu, 18 Jul 2024 13:53:01 +0530
Message-ID: <CA+J6zkSBap2OehD+fbK3cMtVBJgU4kb5C9-4Jk4kafqTgum14Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing framework
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, karthik188@gmail.com, 
	chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 13:40, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > On Thu, 18 Jul 2024 at 03:45, Justin Tobler <jltobler@gmail.com> wrote:
> >>
> >> On 24/07/17 08:00PM, Chandra Pratap wrote:
> >> > On Wed, 17 Jul 2024 at 18:09, Karthik Nayak <karthik.188@gmail.com> wrote:
> >> > >
> >> > > Chandra Pratap <chandrapratap3519@gmail.com> writes:
> >> > >
> >> > > > +struct curry {
> >> > > > +     void *last;
> >> > > > +};
> >> > > > +
> >> > > > +static void check_increasing(void *arg, void *key)
> >> > > > +{
> >> > > > +     struct curry *c = arg;
> >> > > > +     if (c->last)
> >> > > > +             check_int(t_compare(c->last, key), <, 0);
> >> > > > +     c->last = key;
> >> > > > +}
> >> > > > +
> >> > > > +static void t_tree(void)
> >> > > > +{
> >> > > > +     struct tree_node *root = NULL;
> >> > > > +     void *values[11] = { 0 };
> >> > >
> >> > > Although we were comparing 'char' above, here we have a 'void *' array.
> >> > > Why?
> >> >
> >> > The array is passed as a parameter to the 'tree_search()' function which
> >> > requires a void * parameter (i.e. a generic pointer). In the comparison
> >> > function (also passed as a parameter), we cast it to our expected type
> >> > (a character pointer) and then perform the required comparison.
> >>
> >> The point of `values` is to provide a set of values of type `void **` to
> >> be inserted in the tree. As far as I can tell, there is no reason for
> >> `values` to be initialized to begin with and is a bit misleading. Might
> >> be reasonable to remove its initialization here.
> >
> > The thing is, the values[] array being 0-initialized makes debugging
> > a lot easier in the case of a test failure, so I'm not very sure about
> > getting rid of the initialization here.
> >
> >> > > > +     struct tree_node *nodes[11] = { 0 };
> >> > > > +     size_t i = 1;
> >> > > > +     struct curry c = { 0 };
> >> > > > +
> >> > > > +     do {
> >> > > > +             nodes[i] = tree_search(values + i, &root, &t_compare, 1);
> >> > > > +             i = (i * 7) % 11;
> >> > >
> >> > > It gets weirder, we calculate 'i' as {7, 5, 2, 3, 10, 4, 6, 9, 8, 1}. We
> >> > > use that to index 'values', but values is '0' initialized, so we always
> >> > > send '0' to tree_search? Doesn't that make this whole thing a moot? Or
> >> > > did I miss something?
> >> >
> >> > We don't use 'i' to index 'values[]', we use it to calculate the next pointer
> >> > address to be passed to the 'tree_search()' function (the pointer that is 'i'
> >> > ahead of the pointer 'values'), which isn't 0.
> >>
> >> The `i = (i * 7) % 11;` is used to deterministically generate numbers
> >> 1-10 in a psuedo-random fashion. These numbers are used as memory
> >> offsets to be inserted into the tree. I suspect the psuedo-randomness is
> >> useful keys should be ordered when inserted into the tree and that is
> >> later validated as part of the in-order traversal that is performed.
> >
> > That's right, the randomness of the insertion order is helpful in validating
> > that the tree-functions 'tree_search()' and 'infix_walk()' work according
> > to their defined behaviour.
> >
> >> While rather compact, I find the test setup here to rather difficult to
> >> parse. It might be a good idea to either provide comments explaining
> >> this test setup or consider refactoring it. Honestly, I'd personally
> >> perfer the tree setup be done more explicitly as I think it would make
> >> understanding the test much easier.
> >
> > This probably ties in with the comments by Patrick on the previous iteration
> > of this patch, that using 'tree_search()' to insert tree nodes leads to
> > confusion. Solving that would require efforts outside the scope of this
> > patch series though, so I'm more inclined towards providing comments
> > and other ways of simplifying this subroutine.
>
> Agreed that refactoring `tree_search()` probably is out of scope here.
> But rewriting the test is definitely something we can do.
>
> Perhaps:
>
> static void t_tree(void)
> {
>         struct tree_node *root = NULL;
>         int values[11] = {7, 5, 2, 3, 10, 4, 6, 9, 8, 1};
>         struct tree_node *nodes[11] = { 0 };
>         size_t i = 1;
>         struct curry c = { 0 };
>
>     // Insert values to the tree by passing '1' as the last argument.
>     for (i = 1; i < ARRAY_SIZE(values); i++) {
>                 nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
>     }
>
>         for (i = 1; i < ARRAY_SIZE(nodes); i++) {
>                 check_pointer_eq(values[i], nodes[i]->key);
>                 check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
>         }
>
>         infix_walk(root, check_increasing, &c);
>         tree_free(root);
> }
>
> Wouldn't this have the same effect while making it much easier to read?

I agree that the change 'values + i -> &values[i]' is a net positive, I had this
change in mind as well. This comment on the other hand,
>     // Insert values to the tree by passing '1' as the last argument.
has already been stated in the commit message of the 3rd patch
as was suggested by Patrick earlier:

'Note that the last parameter in the tree_search() function is
'int insert' which when set, inserts the key if it is not found
in the tree. Otherwise, the function returns NULL for such cases.'

So I was thinking of adding something along the lines of:
'// pseudo-randomly insert pointers to elements between values[1]
and values[10] in the tree'
