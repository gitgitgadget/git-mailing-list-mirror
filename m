Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE236D
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088269; cv=none; b=bzU2xEbP0i8XFUmKI7XddBc6KjqgldaAv9XswBarpnSyRwe7TGETblkmtYoPitfSBLQt44yyUj7BVR4QHlc1FAI/2zYitwlaeTp62rJORit1WBDlwervSBpG17s5XVWCsI3Ai4h/cxVo18r9kRAS682APKC54VSE6lYdrHpvhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088269; c=relaxed/simple;
	bh=ud5j8obEgxhXCttnvpl8l7MXQ04eMWsFu3+lZ+CMT+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRtLlB5OeX1Ab7nfjJlbcncArdEXN+dT80QYQsGQBoJecr1aHXz5onFpm7+1LSG3YVU5RWOF0n5rG1RAYgKoV3Q+OeaKmSmX5y1smr8Wz1+wOTEdE3X+mis39zczyR2paRnRQT0ir7tRD02nqy3k7wiKjgTmrxubwKtJerADgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW+c9S69; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW+c9S69"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so80831866b.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718088266; x=1718693066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhr/IkXl/arxjFeFmcBFzB3+1lwjyAZa7JP3vDF7TAY=;
        b=RW+c9S69eIyAuOQmTHt6lemLgvKnvRz6kbHX1Rddgnzzwh22r3icjbFLVYi6vHlsAz
         uy+2zZJP0di9+u2+wfTIMmp+BXW7csqNQfNMyJX0GQIAyJZ487UMoTynVk8P02Q3dlW6
         Y21Iw4m8nA3xIdZYBTHfnDTwcUoWCiDGaGXpMkHTgByg4uac8AU5t+czuIKS2vu9pARU
         Ho+Gl0Pr9+FAVqiIepblQaqOKPmHFCePQ6k5vr2J4qU/TWS+/r9TuSglNEOPffeDobVZ
         F01rKf4qzX2rKpnU2EfQbchLEazHoDYYYF623cG8rzg1EeoTG/EKjrYN8LIYVyMj/Mct
         xWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088266; x=1718693066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xhr/IkXl/arxjFeFmcBFzB3+1lwjyAZa7JP3vDF7TAY=;
        b=YucZ4Bqv1e4lhBjtxBAYX5SGol8JmXGmU1ANdF6+zsK0Qf3g6fhijXqpNShUP6vylF
         QGxm896kQuzJZKvNph1VFqQ1pwgDEtIdHgg0r9YHh/hCiKPBCAIstdkEf8ExLaoR1MSF
         Swktq3Ef9hYqM51+GFyM+lwRsiZoNaOBqtABnvilm1MvljlOpffXXcHEqQeCig+9sFBW
         1wSjwgZvYkXvFMPJoVx1USPYzjP1UDGB0RLfXrmZgvW/y9yTf4jKcPcw4HZffbTP51ZJ
         sR81kWdqFwTMiccKINHBpmnEBdGzSno/EJgLH90QhUq6jXoNYcnSdmktEEMi4/ph0udV
         0vqg==
X-Gm-Message-State: AOJu0YykUr7MlqZ0WU3g3DcM8++gZs/05SZ0MkLgTwNlqUx4oT2Sac7V
	qaTOB2s80mwUA9kI7UkuJz8TUik9NbcATzxhI0mKqyQs8/uj15+X9UhPDcR4CIEiuP4waGRP6bW
	tPqC6pgFFS9Uv1CFlVbHWVbKYfPZkkg==
X-Google-Smtp-Source: AGHT+IEQ2iCiufM9H2e9pyRHs0yvDNMV9kHKk3yJ/ZSChLODDSsEivtHp8e3GOJadpIOj11Bc6/CsrpTmTuV2DvfoOo=
X-Received: by 2002:a17:906:3819:b0:a6f:fed:4330 with SMTP id
 a640c23a62f3a-a6f0fed43dcmr400291166b.13.1718088265502; Mon, 10 Jun 2024
 23:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
 <20240610131017.8321-4-chandrapratap3519@gmail.com> <ZmcEaFxZhpyrFd-b@tanuki>
In-Reply-To: <ZmcEaFxZhpyrFd-b@tanuki>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 11 Jun 2024 12:14:14 +0530
Message-ID: <CA+J6zkS8zkyienEDm9m1Z6bEBzbPzC_Lo5gvy03vFfzTHhLFjQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] t-reftable-tree: split test_tree() into two sub-test functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 19:19, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Jun 10, 2024 at 06:31:30PM +0530, Chandra Pratap wrote:
> > @@ -44,13 +44,29 @@ static void test_tree(void)
> >               check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
> >       }
> >
> > -     infix_walk(root, check_increasing, &c);
> > +     tree_free(root);
> > +}
> > +
> > +static void test_infix_walk(void)
> > +{
> > +     struct tree_node *root = NULL;
> > +     void *values[13] = { 0 };
>
> Is there a reason why we have 13 values here while we had 11 values in
> the test this was split out from?

I did that to introduce some variety between the test cases, but now that you
mention it, this change doesn't go well with the objective of this patch.

> > +     struct curry c = { 0 };
> > +     size_t i = 1;
> > +
> > +     do {
> > +             tree_search(values + i, &root, &test_compare, 1);
> > +             i = (i * 5) % 13;
> > +     } while (i != 1);
>
> It's completely non-obvious that `tree_search()` ends up _inserting_
> nodes into the tree when the entry we're searching for wasn't found (and
> if the last parameter is `1`. I feel like this interface could really
> use a complete makeover and split up its concerns. In any case, that
> does not need to happen as part of this patch seriesr

I don't really mind it because all tree operations are only used in
reftable/writer.c and only in a couple of places, so it would make sense
for the original authors to focus their efforts on other parts of the codebase.
Still, I do agree that the readability takes a hit 'cause of that.

> What I think would help though is if the commit message itself mentioned
> this unorthodox way of inserting values into the tree.

Sure thing.

> > +     infix_walk(root, &check_increasing, &c);
>
> Not a fault of this commit, but this test certainly isn't great. It
> would succeed even if `infix_walk()` didn't do anything as we do not
> verify at all whether all nodes have been traversed (and traversed once,
> exactly).

I'll try to modify the test to check for these properties of an infix
walk as well.
