Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92149374F6
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254534; cv=none; b=ridwV1Ir1u0cq6+aEkxG44iGN9gZXDLx+YOgEfzLOQ0yBJLSVUQFkmTtalOiX4zKcWz2614A+m9ezcGWdT4QNDCyO2TDkd6DdJO2R0EhcAkgNImkk7aEdvbRxvZlym5SdZCCXdKGd7BkYQxX71gzyhjhTB3VRvQI9OlrRD3Mt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254534; c=relaxed/simple;
	bh=44hR+xHGnets9tLDO3Vt9svRHixYBHR+gr93b6xopjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5cYFSQGZ2ByZRXE0Yjz0nlXLUqXIDFOKN0sutRjhHQlLSaJ0UxJjsYTRi+pTi4jyuNsPcrR5hj4EInBp+aSvBNVBhJqPr4nIJAuxtNl8OfnqXOUiwNmB9SkD2foOGle1hnD+e8Co37cSMj9XmgMVb8N4hZ4eJ6C+yhjDqtBUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EehuJLKc; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EehuJLKc"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-708cf5138b6so152369a34.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721254528; x=1721859328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxCgbMItx6a0TcVFZ1Webm5sOQzocUgleYAZDb4bnB4=;
        b=EehuJLKcGtDt26EUv4lbkgmAFk1qGq5ou2CfMd2zD+fKmSLRIsS3R2E56ZABhnW30o
         acNLEfN0JgR7TioMacnDMMM4plNtd1nJlnt3eXZ80xGaLsvF4z8zLgtFeX5LYiw+qlZA
         wygKYlGaEoSqkl5J7BK/La0+bvfUR6i8sQ+h1fPX4ergi5EF4JVdLk33kfxqO/T0wxi6
         o01YXq1Kscjs0kEbCBLPsMEqTi6AjzbSldmn0OiZn2Ca5oUKM1uscmdyuoXV0DzqA1g5
         cGomlsWCyhKMSY//w2HGgsca1kDjJWAdwjUMc1ltDpjHMGryQu5lSO54SEgeSNUPYY8l
         phEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721254528; x=1721859328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxCgbMItx6a0TcVFZ1Webm5sOQzocUgleYAZDb4bnB4=;
        b=JssWZqWA7qGTylKnRyeX4nSI9gjaWWxPQK9aPdb9xk84uigP4dAw2vSTQKums7RETs
         lqMQrkxBvwzcSmuEB6EqYgDjHdGhSb4FIPrVKnnOuYkJ6/o61YGA9OnTAhSClDImj3zH
         C/OGZCToGOVmBlJuNetoczD69IwL4nOa+xBAceMmjl6goeC73GgF8+5KnDMRIcLz+Wm7
         oh4gVnyE+omX/k5X6PDnRmlImrk88ue2g7mPtngpHmFM2QfKXH2M3e8somWkYRYhCnkW
         eCaP2KQYicAf6CKICe1b7FX6Dl2N4LroZv2fZQeytjJ8jpntRnyOGkHIuaumCUxWVbJG
         wOug==
X-Forwarded-Encrypted: i=1; AJvYcCXbkGZ/b7QEueVzs8W2zQ/jV9JnKdgNgmvJUdTnkIQYqqRWD+qWHGbj+usccpjDEpj8EqXk4KyifMWU+qhWdE2FtzZx
X-Gm-Message-State: AOJu0YxrrWqeWQLrimjUCAdyLEMyndAWVy9Ata1U467sHlGF1/7MnoCk
	73v46ok4PlB/bPGCjvQXG0ciYu9FhRTN64bcR8G7+c43FDqpH7btoOywL477
X-Google-Smtp-Source: AGHT+IGSLBuylRStBe6ebp5e+gDUIdN9juSgggz5o+bbgP5+CGucmpuxVIhXwR8NI8p0JpmugdORsg==
X-Received: by 2002:a05:6870:4590:b0:25e:2208:6c8a with SMTP id 586e51a60fabf-260d8feb64amr2316587fac.4.1721254528582;
        Wed, 17 Jul 2024 15:15:28 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-260ee0eda55sm114827fac.0.2024.07.17.15.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:15:28 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:14:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, 
	karthik188@gmail.com, chriscool@tuxfamily.org
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing
 framework
Message-ID: <irlg4rgsbfedphbxemj6pns35aceuwqrth6gyj6hi56fmr25n6@yvp4od2ydc26>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-3-chandrapratap3519@gmail.com>
 <CAOLa=ZQxDXDDWXQrt9kpykuMr6nxSA8uf2U2nu0ChTf3yuH8sQ@mail.gmail.com>
 <CA+J6zkQLXsDdSa5xjizr82bPUCng0-XZJRNQ1CAV7ttDbE03xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+J6zkQLXsDdSa5xjizr82bPUCng0-XZJRNQ1CAV7ttDbE03xA@mail.gmail.com>

On 24/07/17 08:00PM, Chandra Pratap wrote:
> On Wed, 17 Jul 2024 at 18:09, Karthik Nayak <karthik.188@gmail.com> wrote:
> >
> > Chandra Pratap <chandrapratap3519@gmail.com> writes:
> >
> > > +struct curry {
> > > +     void *last;
> > > +};
> > > +
> > > +static void check_increasing(void *arg, void *key)
> > > +{
> > > +     struct curry *c = arg;
> > > +     if (c->last)
> > > +             check_int(t_compare(c->last, key), <, 0);
> > > +     c->last = key;
> > > +}
> > > +
> > > +static void t_tree(void)
> > > +{
> > > +     struct tree_node *root = NULL;
> > > +     void *values[11] = { 0 };
> >
> > Although we were comparing 'char' above, here we have a 'void *' array.
> > Why?
> 
> The array is passed as a parameter to the 'tree_search()' function which
> requires a void * parameter (i.e. a generic pointer). In the comparison
> function (also passed as a parameter), we cast it to our expected type
> (a character pointer) and then perform the required comparison.

The point of `values` is to provide a set of values of type `void **` to
be inserted in the tree. As far as I can tell, there is no reason for
`values` to be initialized to begin with and is a bit misleading. Might
be reasonable to remove its initialization here.

> > > +     struct tree_node *nodes[11] = { 0 };
> > > +     size_t i = 1;
> > > +     struct curry c = { 0 };
> > > +
> > > +     do {
> > > +             nodes[i] = tree_search(values + i, &root, &t_compare, 1);
> > > +             i = (i * 7) % 11;
> >
> > It gets weirder, we calculate 'i' as {7, 5, 2, 3, 10, 4, 6, 9, 8, 1}. We
> > use that to index 'values', but values is '0' initialized, so we always
> > send '0' to tree_search? Doesn't that make this whole thing a moot? Or
> > did I miss something?
> 
> We don't use 'i' to index 'values[]', we use it to calculate the next pointer
> address to be passed to the 'tree_search()' function (the pointer that is 'i'
> ahead of the pointer 'values'), which isn't 0.

The `i = (i * 7) % 11;` is used to deterministically generate numbers
1-10 in a psuedo-random fashion. These numbers are used as memory
offsets to be inserted into the tree. I suspect the psuedo-randomness is
useful keys should be ordered when inserted into the tree and that is
later validated as part of the in-order traversal that is performed.

While rather compact, I find the test setup here to rather difficult to
parse. It might be a good idea to either provide comments explaining
this test setup or consider refactoring it. Honestly, I'd personally
perfer the tree setup be done more explicitly as I think it would make
understanding the test much easier.

-Justin
