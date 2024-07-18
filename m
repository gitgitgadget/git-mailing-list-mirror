Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F81B86F2
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721278702; cv=none; b=ZVUU1xJjiVNWmtS4us671BRrjsOkjiCqeq6ypxet5vZnZufMjHuWd2YTcQUo8/UjCFDHClVM979NYvdFuy/h5hJKw5oODoTkdF653LMizN/rI35WTx/Dn/4VWFwYizZQwAvgnhmHASN3L4U00blKA1y2l3MQiRIGmALhwb+Jb4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721278702; c=relaxed/simple;
	bh=gnCNHxHX15LNkhi+Udi+nYx4wpXaIgkTNfbyuz5DvoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeSbcw9V1LhnufvzWvAvlqsdUSAZwMn16BMhxtYDXfhe40jDdBRduT5JpT8WCml9826Lqfg/3h0tnLcgwetG+ptbtRw0bOhS+hYQ12x3bns8XbBNZl5cNTXdrlFDGPyY/JSTuo+GypKT17rRXHTkYvtV4r8cjJdMdLrjrlL0flE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZvwQYlo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZvwQYlo"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so294117a12.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721278699; x=1721883499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6/lmhEGtaIegWbi6t7mDfzv6aaf1V9t3bxtaY4fCRI4=;
        b=HZvwQYloLYFsoGPhGh3DYv+Si+XpE76wXuY9Yl6lAtryK7LbtYqTDRqmGOxOApjFTZ
         +4U0Ne3rEHR0Kw1AxNWIuVT0NrjShNodLvKFCRH1g97ni1RFziIhOM1Vez842HJ3kIMF
         L9cjTE+tG0m/+laCXc6qrinwOpcPcMj+XYlAPGuHW0TL2+0p5F+M/k0xL0wRzwXkLJZa
         31avdYy3xYD6hAPehSHJ4G04GzJpDzeWw6ko3MQOsQJ90uF7rV5/hOPoA1Tj7idcBdfH
         66gbriCWMW7LEsQQLcLlFoblGvqDV6JDCl7CIvPwUk3yeTyq5MDmN+yQh5bj+6/wCLVQ
         vUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721278699; x=1721883499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/lmhEGtaIegWbi6t7mDfzv6aaf1V9t3bxtaY4fCRI4=;
        b=Y1kMmGDLtZEHvyU9rPh8+wvXop9Ff6Ta3PJ4DdLEWcTj+gJ8ugzVlyxvnadHwfg2nR
         kKFjNDfDuAoUJIrkKIs/f/WjtB3exQP5aM7KpPAk96du2Lp0F3NI9RztXt4ID4X96Yke
         b2WEveoOv63y9wPo+XwV8XQbND5XScn7msXP2ASSITgREzx6nQCOsY+fh7wCor7hGN9B
         cwkRk410f60scND+0kXkBnMFGvXdBuCzhcNUjHvwF9HUj98FIwr8xoewbgdeHwKfntNx
         SJ12uChKnOPKnzP0WRg+qFVaPubCmzY5Tz1YYpf9drbQ/Sq9IFx02TCCk93ZXtFc1M+g
         qUWg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ISs2NrQi5C8HN8iDgLOiAm2KLL28RfIcLg61b+hoDDmcyemIeBClx1/BFKdXh01DuXQ7QM26aUePZQhL3K+lSXhC
X-Gm-Message-State: AOJu0YwRpMzG3xbMf4fen8v5CvdTeEe4F4N+UN24NUGN7EIogBF1xTeC
	FZCyqOmOVd5juaiOWjcrpXNHXWbPbWTn2zkr6siUMYfbTiUo9a/uW32Em90tJar9wBFrsPQGeT6
	bMDrCMf2jzZBC1flsSvOIIbx+Nqh/AXIq
X-Google-Smtp-Source: AGHT+IHoRzPnSS4xGyR9eDecq7PWW/lHRVCFjMAQfsDhpCZKgN+czuucrCy6EmOCHf4iCwJcSGGfVD7pOZ/zpn89liw=
X-Received: by 2002:a17:906:694:b0:a72:80b8:ba5b with SMTP id
 a640c23a62f3a-a7a0134990amr248633566b.56.1721278698417; Wed, 17 Jul 2024
 21:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com> <20240716075641.4264-3-chandrapratap3519@gmail.com>
 <CAOLa=ZQxDXDDWXQrt9kpykuMr6nxSA8uf2U2nu0ChTf3yuH8sQ@mail.gmail.com>
 <CA+J6zkQLXsDdSa5xjizr82bPUCng0-XZJRNQ1CAV7ttDbE03xA@mail.gmail.com> <irlg4rgsbfedphbxemj6pns35aceuwqrth6gyj6hi56fmr25n6@yvp4od2ydc26>
In-Reply-To: <irlg4rgsbfedphbxemj6pns35aceuwqrth6gyj6hi56fmr25n6@yvp4od2ydc26>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Thu, 18 Jul 2024 10:28:07 +0530
Message-ID: <CA+J6zkRWzq_XNf-E7Nx4_D7rOOjN4Bwi4g3zgzV6YCiVoCe8rA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing framework
To: Justin Tobler <jltobler@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, karthik188@gmail.com, 
	chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 03:45, Justin Tobler <jltobler@gmail.com> wrote:
>
> On 24/07/17 08:00PM, Chandra Pratap wrote:
> > On Wed, 17 Jul 2024 at 18:09, Karthik Nayak <karthik.188@gmail.com> wrote:
> > >
> > > Chandra Pratap <chandrapratap3519@gmail.com> writes:
> > >
> > > > +struct curry {
> > > > +     void *last;
> > > > +};
> > > > +
> > > > +static void check_increasing(void *arg, void *key)
> > > > +{
> > > > +     struct curry *c = arg;
> > > > +     if (c->last)
> > > > +             check_int(t_compare(c->last, key), <, 0);
> > > > +     c->last = key;
> > > > +}
> > > > +
> > > > +static void t_tree(void)
> > > > +{
> > > > +     struct tree_node *root = NULL;
> > > > +     void *values[11] = { 0 };
> > >
> > > Although we were comparing 'char' above, here we have a 'void *' array.
> > > Why?
> >
> > The array is passed as a parameter to the 'tree_search()' function which
> > requires a void * parameter (i.e. a generic pointer). In the comparison
> > function (also passed as a parameter), we cast it to our expected type
> > (a character pointer) and then perform the required comparison.
>
> The point of `values` is to provide a set of values of type `void **` to
> be inserted in the tree. As far as I can tell, there is no reason for
> `values` to be initialized to begin with and is a bit misleading. Might
> be reasonable to remove its initialization here.

The thing is, the values[] array being 0-initialized makes debugging
a lot easier in the case of a test failure, so I'm not very sure about
getting rid of the initialization here.

> > > > +     struct tree_node *nodes[11] = { 0 };
> > > > +     size_t i = 1;
> > > > +     struct curry c = { 0 };
> > > > +
> > > > +     do {
> > > > +             nodes[i] = tree_search(values + i, &root, &t_compare, 1);
> > > > +             i = (i * 7) % 11;
> > >
> > > It gets weirder, we calculate 'i' as {7, 5, 2, 3, 10, 4, 6, 9, 8, 1}. We
> > > use that to index 'values', but values is '0' initialized, so we always
> > > send '0' to tree_search? Doesn't that make this whole thing a moot? Or
> > > did I miss something?
> >
> > We don't use 'i' to index 'values[]', we use it to calculate the next pointer
> > address to be passed to the 'tree_search()' function (the pointer that is 'i'
> > ahead of the pointer 'values'), which isn't 0.
>
> The `i = (i * 7) % 11;` is used to deterministically generate numbers
> 1-10 in a psuedo-random fashion. These numbers are used as memory
> offsets to be inserted into the tree. I suspect the psuedo-randomness is
> useful keys should be ordered when inserted into the tree and that is
> later validated as part of the in-order traversal that is performed.

That's right, the randomness of the insertion order is helpful in validating
that the tree-functions 'tree_search()' and 'infix_walk()' work according
to their defined behaviour.

> While rather compact, I find the test setup here to rather difficult to
> parse. It might be a good idea to either provide comments explaining
> this test setup or consider refactoring it. Honestly, I'd personally
> perfer the tree setup be done more explicitly as I think it would make
> understanding the test much easier.

This probably ties in with the comments by Patrick on the previous iteration
of this patch, that using 'tree_search()' to insert tree nodes leads to
confusion. Solving that would require efforts outside the scope of this
patch series though, so I'm more inclined towards providing comments
and other ways of simplifying this subroutine.
