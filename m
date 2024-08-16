Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145B14534A
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794137; cv=none; b=M0GJVd+myBT4895JHXQsMCYsGOxcFEio6+zUNCbvf5kGlD+zukFfIyKTYF2TxO1UQ77ITRfVGDC+Shl9CLobL3IYRk9RJLnsqeLWNAcnpFkiBBP0SI/dCZY5lfVWgMlBgDH2eRsA6rxXN6MQQWH+va279v8sBwt1fvafpX0TlGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794137; c=relaxed/simple;
	bh=9SfuZAu4Ma/EnfHr3WDT4zMPi+5jJPm/napUpICSEzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhb7oaHdmkT6NTM0f7CFDR8z4xBxNh+6e7akWotBTtdViGtzAcS89H8/ShAYtGQlyCI/j4aPzHhJSx0jOxdnxts4I38Ens34JnvCV2f9ADVnNcZgMeUCDMAKGgUcxcZMjrrCoL728GjA1uAFmYvZLy1cnvEG6igYdgwXdHLAcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=haxSjx84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oL1mxCMP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="haxSjx84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oL1mxCMP"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C5B001151AB4;
	Fri, 16 Aug 2024 03:42:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 03:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723794134; x=1723880534; bh=qTRqzRU9em
	ZgsxmQc7X5qm0FvM5ovVDAeJoqsDfm2Nw=; b=haxSjx844mNViGRpkciPWb7bNv
	8hP6tvOazf7ajz5DZGiwDCKGHCYXE56szteOt+AmJ4q+6sNvWkDW/QSXofvUGTvu
	3JNh2tCqDP7jiSHHSd8kn2OucULe0N4loZHuqW60XGJXA5xO5MxUtQZkspJ0Cvse
	HHfvTXYtoM4bmFiRMJ8xiRCnUFp90LvuXpHcrB6elnk7CEdYxiflY1VopM5+M8+K
	qDtZ9+GFY+VQMcM4pCjS00cTSLVL25V0D4SBiWXqZfcRqJYgtj/4VTN7psVq/kK7
	xhtOkIil/EYooDKXJUKiiUEt540AZ9vvrLMyCbtAtWygL6pGRKz0Pgb/0CRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723794134; x=1723880534; bh=qTRqzRU9emZgsxmQc7X5qm0FvM5o
	vVDAeJoqsDfm2Nw=; b=oL1mxCMP+bhen93N6NqBmn5LIxPz0Q90vxtodneH9laS
	j+WHq+XsgEg3fHLpO7qc6o/clVU7UMs3kDA1JCUPSUsoEJK/Sx8y0aaJxb65mj0I
	NIS9qc+x1656mBuKGMzqumqHny5Bjqn386TEptpxF+2Z26UhnpkB9R9Rq8ekSwaW
	ng7eWhUVAm0AxOJCTDMBYHh7NkknrTO9yL5ADBEnmz/XfWyL6ypFyyNuzL1k3cwl
	10BXrZsjxom02MeE11urZoPM7Y0wJ//IUp/pwjF0HN2C2jxBboF0vmojn7dV+Gfc
	2TJWMQ1JaSzzICbX4piE+HH9mNxj29gSrkBGu1FdBw==
X-ME-Sender: <xms:1gK_ZkZv_0qdMTxbHWRJ1ONfY2YtCZZy6rgJKQhU59DyKz1ZzU5ytQ>
    <xme:1gK_ZvZgOf2y_3h1mdXvFIaajgJ4NXBtI7fpJFl7N3r5UbKTGTHH1TFYko6DA1XPA
    LvRdhzZFRktJh1xHw>
X-ME-Received: <xmr:1gK_Zu-kswxvR2iPVdJ5hbihhGkFf1P5_ShPJz531zvA9zyHgPPIwGLQeizz4534ZW2eoQjCqrea3UUGz-GTf9ZTThdvWsnqSEoyE4a4lrMpbdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphht
    thhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:1gK_Zupf42GpsKGYvHAvPfJYI_02m8mKSj8i7DywsfbDSpHiO_Zj4g>
    <xmx:1gK_ZvrW94nRGd-awUEgd1M9OfhUbiOK3Hj4JUd2sxQW0sdpNY5qRA>
    <xmx:1gK_ZsTACeXpTFxu3NfSsTeo9N4xjKZw39oACF7-3Vb7izIO00Z8rQ>
    <xmx:1gK_Zvq8pGeGWffuyjFF5zDw1Y1uhPNk7eGbPHvKYwWyTdaHeZgs5Q>
    <xmx:1gK_ZuX69xLiQguhxj5UgdVUhO1EtfzUyxddjieuWpM33jzoX3B_9muf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:42:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0b54918 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:41:49 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:42:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 08/10] t-reftable-block: add tests for log blocks
Message-ID: <Zr8C0ir5UHzaHfUq@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-9-chandrapratap3519@gmail.com>
 <Zr3NMOQWYDOufHXg@tanuki>
 <CA+J6zkSOF-RtrBvgunMsTdL4Qd8H10zUHesXYtYG8DW+kJht-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+J6zkSOF-RtrBvgunMsTdL4Qd8H10zUHesXYtYG8DW+kJht-w@mail.gmail.com>

On Fri, Aug 16, 2024 at 12:06:47AM +0530, Chandra Pratap wrote:
> On Thu, 15 Aug 2024 at 15:11, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Aug 14, 2024 at 05:33:16PM +0530, Chandra Pratap wrote:
> > > @@ -101,9 +101,95 @@ static void t_block_read_write(void)
> > >               reftable_record_release(&recs[i]);
> > >  }
> > >
> > > +static void t_log_block_read_write(void)
> > > +{
> > > +     const int header_off = 21;
> > > +     struct reftable_record recs[30];
> > > +     const size_t N = ARRAY_SIZE(recs);
> > > +     const size_t block_size = 2048;
> > > +     struct reftable_block block = { 0 };
> > > +     struct block_writer bw = {
> > > +             .last_key = STRBUF_INIT,
> > > +     };
> > > +     struct reftable_record rec = {
> > > +             .type = BLOCK_TYPE_LOG,
> > > +     };
> > > +     size_t i = 0;
> > > +     int n;
> > > +     struct block_reader br = { 0 };
> > > +     struct block_iter it = BLOCK_ITER_INIT;
> > > +     struct strbuf want = STRBUF_INIT;
> > > +
> > > +     REFTABLE_CALLOC_ARRAY(block.data, block_size);
> > > +     block.len = block_size;
> > > +     block.source = malloc_block_source();
> > > +     block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
> > > +                       header_off, hash_size(GIT_SHA1_FORMAT_ID));
> > > +
> > > +     for (i = 0; i < N; i++) {
> > > +             rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
> > > +             rec.u.log.update_index = i;
> > > +             rec.u.log.value_type = REFTABLE_LOG_UPDATE;
> > > +
> > > +             recs[i] = rec;
> > > +             n = block_writer_add(&bw, &rec);
> > > +             rec.u.log.refname = NULL;
> > > +             rec.u.log.value_type = REFTABLE_LOG_DELETION;
> > > +             check_int(n, ==, 0);
> > > +     }
> > > +
> > > +     n = block_writer_finish(&bw);
> > > +     check_int(n, >, 0);
> >
> > Do we maybe want to rename `n` to `ret`? That's way more customary in
> > our codebase.
> 
> Sure thing, but then I would want to change the existing test (which gets
> renamed as t_ref_block_read_write) and I'm unsure of which patch would
> be the most suitable for that change. Would it be fine to include that
> change as a part of this patch?

The way I'd do it is to first do the minimum required changes to port
the old test to the new testing framework, without any of the cleanups
to align code style. Then I'd put another commit on top that does all
the changes like removing braces, converting types and also adapting
names.

> > > +     block_writer_release(&bw);
> > > +
> > > +     block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
> > > +
> > > +     block_iter_seek_start(&it, &br);
> > > +
> > > +     for (i = 0; ; i++) {
> > > +             int r = block_iter_next(&it, &rec);
> > > +             check_int(r, >=, 0);
> > > +             if (r > 0)
> > > +                     break;
> >
> > We can also reuse `n` (or `ret`) here, right?
> >
> > > +             check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
> > > +     }
> >
> > One thing that this loop doesn't verify is whether we actually got the
> > expected number of log records. It could be that the first iteration
> > already returns `r > 0`, which is not our expectation. So we should
> > likely add a check for `i == N` after the loop.
> 
> What about something like
> if (r > 0) {
>     check_int(i, ==, N);
>     break;
> }
> That should achieve the same results if I'm not wrong.

Yup, looks good to me.

Patrick
