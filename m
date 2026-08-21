Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAE73769EC
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294100; cv=none; b=ROHEs244W9utI73xx9OdopkwUQYKbARWHpD22tQKatnUs92S27Jj3cQYI8uKqGpF4pMM5gUkEQCtPdHxhCnMmd4yhLZn0qbYzoHZPV8clXEnT9QQbWO0dgTGnMID47PdKNrjHJKMlPPwFxTrPonHtrczSAVEolZPCOcM6s9d3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294100; c=relaxed/simple;
	bh=YuCuys2ZeoVl0eDMwnJKLxQAzLmfR3s1m4BJWvABfdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4Odk3mDCa089508W+ixShoTPN0qIRzhxHZfJb16vsj49ny/vOfqwG0v2HOluh0wZxVZuPkH8LrX1ypnXxz8kS71Umxnw8a/L0fHVoHwijTg+tWIFiiVGTgOqw/DaIYndDJThTmPPcfIzennvoXlPJ0k/DcS+FhZwIgnKj0JptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=of2rJjHU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GXDo7YUr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="of2rJjHU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GXDo7YUr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EAA9EC0283;
	Fri, 21 Aug 2026 02:34:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Aug 2026 02:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787294098;
	 x=1787380498; bh=xg8VhxXJXdECjkkO9qQT79noAqfuPmZuXjF4myuAucU=; b=
	of2rJjHUXI1nT1j7Y4opKJdde0ak6C3xI9MLEOmtveDoEfE/tteoTWM7y7WLDWdK
	PBNy2Mw3UYXypf5fkquCZyuXmBhBX6O0QOgDQWN+wOWKM0s4SQqsiowUvjL3Nh1z
	Rz40ylkRvAPw2mSE+W2hQLPIuYbxQJApUEUeUujO/OCvyPfpFoEQQYqohOQps0tw
	XH1NMUkNEtJETd4edGBywxb1ioyPiqGGWGM1ZDNBF+J8dV+uKaCrcMBjHUonIQ1L
	847BmgJsfz3yUBEJOVQxM2g8IDc9vs1phAEkNd5cSgLoEoNilTTDj8UVd9mx63Ld
	5ObWyQIxI8Rfta+peEmbQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787294098; x=
	1787380498; bh=xg8VhxXJXdECjkkO9qQT79noAqfuPmZuXjF4myuAucU=; b=G
	XDo7YUr31ztw74z1fK3aNR+mr4VeJCLb8I4lnVzNx+eP3iWPylqEhddl2cciDaxz
	YVUKX14k757Ea7lommuHJ9dRSSG+PnlacmuuH6vYw7igI5lhdX5AWYY6KwsYCrfJ
	tqCL2ynM7Lt1lkqIX7K8wULGtTYvellwboZ7IcdII1Lkauhc8kT1AQiIBMrX7Y9y
	+OYTJEJ0y+/ptJi2+N25UerzdqV82GWeZjXD9PtrL2ErnWESztcXtnXuQD6pdFU6
	IlTlr8Ts42X952JCpUsuzF4Comr/nM4PbvbJTN1RybBqhvZz9Ct/md7JPeaWiqvO
	OIV/ues6eJf+rmmJ916sg==
X-ME-Sender: <xms:kvGHajBnLmoB05iTLCQ6urTBjUqA5oKaYNJ2O5mRoBSZGVyxvv2Ycg>
    <xme:kvGHag8HiVhKrDxGbHob1Qbzw9NZuZ7oZIBpTcTBy9_mJCjVsNFYt85HCOVeJ-Mxw
    RaLh7Dte9QNEvrFkqxLFMSSXuWoofA8vWs3RkndzukV3RXtTgWfkw0>
X-ME-Received: <xmr:kvGHar-DAYd9zYryXSx7G6PIYzVQyZNSaMCC2JgmeF-VpJvVhq5KdJqFfhsMQW8yKwHWARUN-nAAkx8xka1vVZBQwTOvue9pcHINqNm_Oyg9>
X-ME-Proxy-Cause: dmFkZTGUfDu3ZiAIa2b9++Vj0B1fCIExJiEus+Q6q7vqzQPizizWN5PGg1cX4xrcB/iM/Z
    xk/XaDNjcsTe+0YD5rBlKxV4npUJbIemp7ffW3u2T7v9NK4AxMIQ1X9kLsbCoKlIqLyU5y
    p5bYuXGLQkevMDPuf77HGSxLirfwPdvNecF8LpgNr6xyeMOOI82K7EZZ/EQXZze6K1oL+c
    ADuNlbQa6g+QY75xhnM0Ydqd2Va6Ca+Lw/vHK4io6KBNMUrMXqST9cLqBLXaxLq7FESY4d
    47QwfKWHds1bfvWTqxwYI9ZB2aETTMix+MtCE82c3TjOCGPmts+jb/x/BrfJR1UZUwoJg7
    PcbxtMnS5BeSyqfv3+KejcpCIQt1JefGpvkHBIt6KIr0Iil1qv7pheptx8bKecgeD/tLcW
    gRzO6IekW5hCOcbMOxqirOuWgLwI0ZGAfqj0zTJ8HmukcXZVEAMMYGr/IdsEoMM+gxpxdh
    lOkTq3KbRxvl2zRgbaLG0SZcp/1LDg1lR+sgCJEkipb6uDRnBbhInYFQWi+QJQBKO22aB0
    eYVm7KIyCc3Cf1kYXNvP7Z+GwPKvUYOEPhHvEvOK+GH9CowIZyQq5lnMQJUjhMuZPjb+kq
    A6Z47dY3EVDBYunR6OuVxLWszDyfOVTQFPwFUrSulkBhBMwBwfsszA3kKpNA
X-ME-Proxy: <xmx:kvGHavc14dZWhJ5vOZmlN73hOGdmaFcK-DzMUaqFOo5R_yrptlxvzg>
    <xmx:kvGHasFfdTBzU8oEviIyfBBQn_HAcRdnAsQhOe0zx7CFvSwf1Jo-eQ>
    <xmx:kvGHalesfsRn2ZNNsweMsL_s7cqrcD7nw19gSyKwfZfRNYaaKqKr6Q>
    <xmx:kvGHauGUzDiBFk6KhwIkTL9lmOIFYIgmIXxfOGGfaMZLcaac3wafGw>
    <xmx:kvGHag96MZ-b4MynmkA7J29mcHeW12f3VZ3ugrZk1aVntGdQjSPOtM37>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 02:34:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f777e00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 06:34:55 +0000 (UTC)
Date: Fri, 21 Aug 2026 08:34:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] odb: introduce interface to generate packfiles
Message-ID: <aofxjYAYPGkCrtQ7@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
 <20260817-b4-pks-odb-generate-pack-v2-1-4c8a96ccfdb3@pks.im>
 <CABPp-BG3_xvbXtt5BucyOy-dHXqX569d4FBfyZwbLiAb-qRPXA@mail.gmail.com>
 <aoaYL_BinFtgdJ5N@pks.im>
 <CABPp-BHSFW38sF4dZkqZuGaRASVRj2FVG2NN1OTA7-Dd6Pt6rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHSFW38sF4dZkqZuGaRASVRj2FVG2NN1OTA7-Dd6Pt6rw@mail.gmail.com>

On Thu, Aug 20, 2026 at 09:41:03PM -0700, Elijah Newren wrote:
> On Wed, Aug 19, 2026 at 11:01 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Aug 19, 2026 at 09:56:56AM -0700, Elijah Newren wrote:
> > > On Sun, Aug 16, 2026 at 10:40 PM Patrick Steinhardt <ps@pks.im> wrote:
> > > >
> > > > +static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
> > > > +                                         struct odb_pack_generator **out,
> > > > +                                         const struct odb_generate_pack_options *opts)
> > > > +{
> > > > +       struct child_process cp = CHILD_PROCESS_INIT;
> > > > +       struct odb_pack_generator_files *generator;
> > > > +       FILE *in;
> > > [...]
> > > > +       cp.clean_on_exit = 1;
> > > > +
> > > > +       if (start_command(&cp))
> > > > +               return error(_("could not spawn pack-objects"));
> > > [...]
> > > > +       CALLOC_ARRAY(generator, 1);
> > > > +       generator->base.out = opts->pack_fd < 0 ? cp.out : -1;
> > > > +       generator->base.err = opts->progress_fd < 0 ? cp.err : -1;
> > > > +       generator->base.finish = odb_pack_generator_files_finish;
> > > > +       generator->cp = cp;
> > > > +
> > > > +       *out = &generator->base;
> > > > +       return 0;
> > > > +}
> > >
> > > Does this have a use-after-scope bug lurking here, due to the
> > > combination of clean_on_exit = 1 (which makes a copy of &cp for later
> > > use), and the fact that cp is a function-local?  If I'm reading the
> > > code right, start_command() calls mark_child_for_cleanup(), which does
> > >
> > >     p->process = process;  /* where process is &cp */
> > >
> > > and then cleanup_children() accesses various fields under p->process.
> > > You do copy the necessary fields from cp to generator->cp, but
> > > &generator->cp was not passed to start_command(), so p->process points
> > > to the function-local cp.
> >
> > Oh, that's a very good catch indeed. Out of curiosity, how did you end
> > up discovering this? Did you just happen to remember that we store the
> > pointer out of scope or did the copy make you have a deeper look?
> 
> Neither.  Went to review the series, but I was worried I'd be missing
> context from not reviewing earlier odb refactorings.  Used AI to help
> orient me and give me its own findings from reviewing your patches.
> (AI will sometimes spot things I miss in a review, though it'll also
> miss some things I catch.)  And sometimes I iterate with AI to dig
> into various areas.  Anyway, it flagged the potential problem, and I
> dug in to make sure it didn't look like a hallucination before
> cleaning it up and passing it on.  I'm still looking through your
> other patches in this series, but should finish soon.

I agree. For all the pain AI is causing, doing reviews is one of the
things where it's helping me a ton. Both by reviewing my own patch
series before I send them out, and by reviewing others.

Thanks!

Patrick
