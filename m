Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB514B965
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430052; cv=none; b=oSUy/y52fm7crjtswuLLuiW4lxB7u/kcL4gDyUwBjgfDSMEqMXD4duDTQz8DHlB/GK+0yFTHn9jnHQslV3AkE5x5ysq9WMSQ8GiSqv5uwTvV912AdIj9n5QWliy7+mAmED/aKkipa54ngId/G7OTdygq4xSfLAO8+k7X/0vQIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430052; c=relaxed/simple;
	bh=65IGrO/SFag4pw5MZ/Wk2GyyG0vMN2YksR3dPQLBQhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1rf3eBRlCZ1rNEhzXxQriiC/5juhOLQRmGRAOZ+bDKJgdx50LaN/L3rusc1hX+MCi6HGkLbeP39tCNa6MEekHcB4zrZbAPnlYIX3hh3Rq7i1sruHMi1NvPEk+uuiYXUSiIsNVp1xZ6umNtxitWMoemBRS+NB44L82b0EzBKPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/MQ1Kg8; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/MQ1Kg8"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e72a786b1b8so3185835276.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 00:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746430050; x=1747034850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WYAoIFr0FT7tTW9i4YTQQ8UwTOzit5ePJNKxRcWv+zU=;
        b=m/MQ1Kg8MqwNdp4B0jTRqnlwxCMcDkjpPx6hYKaZJGmB1hUGeaeO+Np/o1MUm5m6Zv
         J3O6/0YHNaPw3F45Bml/slQ6+1ViVIb8YXoznD/YUMxpS31QYlWxpiS/9qtATcD57K9o
         iv/6/P2w5GNFJjuSWU4w/fBOGLm9AcKOk2ZH7FVtQAKpjzFy4rxpvTkqE/vA2HQylj6w
         rraGjZsXSdxnW9wHREuFktA8cysOd9fo0hQS5jx1BMdF79bikgGe0dSa/4CeM03BNsqN
         iZOSC8gP+inDKi24WKWoaUZSMNIEFEg34XTewN1QYeYrPpdBZuediwRQ/loU1a56sMip
         hRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746430050; x=1747034850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYAoIFr0FT7tTW9i4YTQQ8UwTOzit5ePJNKxRcWv+zU=;
        b=ifhWEd3zfkgKcVNx+EJ0wHCQHhFvQ2r7zoK5PMgqzxamixc+/MCl6WnxSTMBST6dN9
         ppMft5x6eT0ZDXBpCHGLruHE+yigUrAfTDwzMBZb9bb+DAhqwUFGBuq2sLjJR7Nk65UT
         FWAfcJPOemmljx+Fosp7Sp9fVWYQ/vfsXj3COSQAXXGv3+Vu9SXCb5fpLdxT3RjprgzB
         OZKDknChj/q7XBYhqwSAU09keZL+0Fjb30lDen4VUouHqbb34fUDqFlS3/ABNKYC+pjW
         j1jh+G3QsvalzCF/Ox/oQfVeSMWJZSS7KJyV+gTxFAa7mPadCzyhYizkGNDRPhWEXfRL
         JZjg==
X-Gm-Message-State: AOJu0YxhfUs9NYh348vwHBSZiy9WjhVF8J7OaG/WbOz4nxje8P/Z7xMw
	X08UdOCiWtl4xl/GI0P1ANAk1NkAMTV4a+rInwPKgZtO6a/gELTCKZbI2WSWDqsqGGSv+KB3MHx
	a1JPsYoOThhLTKU2nanfNz9loodbqnJMuwXROfw==
X-Gm-Gg: ASbGncshJ3Bek4om9Prer4aW7+KIgwDMHFt5dpAx5GgeKru74dCujMU7+ebe+Q77Pjl
	/tMUZHwn3+PNujtM0iD3FD+EAfujkn91HtN0HiCnolrwHZ4ZPiJoMFVy817HBMwQfsggfHALqC2
	TEM6qS72zxmIqimHaisLX39zA=
X-Google-Smtp-Source: AGHT+IFclb+btv41BxxhVgUszBcSpFz7qDnFBJIAnGVS6KGvwgCqGLI2Sk23pv5QZCe13gaL8d/Ki7iNVfGY39qlMC0=
X-Received: by 2002:a05:6902:a09:b0:e73:312e:7809 with SMTP id
 3f1490d57ef6-e7564a52e60mr15944497276.14.1746430049826; Mon, 05 May 2025
 00:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429175302.23724-1-kuforiji98@gmail.com> <20250429175302.23724-11-kuforiji98@gmail.com>
 <aBSXJcT8REHWrsrx@pks.im>
In-Reply-To: <aBSXJcT8REHWrsrx@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 5 May 2025 08:27:16 +0100
X-Gm-Features: ATxdqUEfA-LNASfmZ72GlM-tRiJAlDpe-mcDe6jyQZu85Rfv2LlcnCqijW7uegU
Message-ID: <CAGedMtdRwsBwRK6ENaJfbZ1tba4jD1WMyk3HdFft3sC6H2001w@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] t/unit-tests: adapt lib-reftable{c,h} helper
 functions to clar
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,
On Fri, 2 May 2025 at 10:58, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Apr 29, 2025 at 06:53:02PM +0100, Seyi Kuforiji wrote:
> > Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
> > required for the reftable-related test files to run efficeintly. In the
> > current implementation these functions are designed to conform with our
> > homegrown unit-testing structure. So in other to convert the reftable
> > test files, there is need for a clar specific implementation of these
> > helper functions.
> >
> > type cast `for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++)`
> > Adapt functions in lib-reftable.{c,h} to use clar. These functions
> > conform with the clar testing framework and become available for all
> > reftable-related test files implemented using the clar testing
> > framework, which requires them. This change migrates the helper
> > functions back into `lib-reftable.{c,h}`.
> >
> > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> > ---
> >  Makefile                    |  4 +-
> >  t/meson.build               |  4 +-
> >  t/unit-tests/lib-reftable.c | 26 +++++------
> >  t/unit-tests/lib-reftable.h |  6 +--
> >  t/unit-tests/unit-test.c    | 93 -------------------------------------
> >  t/unit-tests/unit-test.h    | 16 -------
> >  6 files changed, 20 insertions(+), 129 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 0b42893611..7e646e16ee 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1379,12 +1379,12 @@ CLAR_TEST_SUITES += u-urlmatch-normalization
> >  CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
> >  CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
> >  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> > -CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
> >  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
> > +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
> > +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
> >
> >  UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
> >  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
> > -UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
> >
>
> `UNIT_TEST_PROGS` only contains the "unit-test" binary now, right? Does
> this mean that we can simplify build rules in our Makefile now?
>
> > diff --git a/t/meson.build b/t/meson.build
> > index 8fa00fc9ef..7c305a90b5 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -26,8 +26,9 @@ clar_test_suites = [
> >
> >  clar_sources = [
> >    'unit-tests/clar/clar.c',
> > +  'unit-tests/lib-oid.c',
> > +  'unit-tests/lib-reftable.c',
> >    'unit-tests/unit-test.c',
> > -  'unit-tests/lib-oid.c'
> >  ]
> >
> >  clar_decls_h = custom_target(
> > @@ -69,7 +70,6 @@ foreach unit_test_program : unit_test_programs
> >    unit_test = executable(unit_test_name,
> >      sources: [
> >        'unit-tests/test-lib.c',
> > -      'unit-tests/lib-reftable.c',
> >        unit_test_program,
> >      ],
> >      dependencies: [libgit_commonmain],
>
> Can't we remove this completely? `unit_test_programs` is empty now, so
> this loop is a no-op now.
>
> > diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftable.h
> > index e4c360fa7e..2958db5dc0 100644
> > --- a/t/unit-tests/lib-reftable.h
> > +++ b/t/unit-tests/lib-reftable.h
> > @@ -6,12 +6,12 @@
> >
> >  struct reftable_buf;
> >
> > -void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
> > +void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
> >
> > -struct reftable_writer *t_reftable_strbuf_writer(struct reftable_buf *buf,
> > +struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
> >                                                struct reftable_write_options *opts);
> >
> > -void t_reftable_write_to_buf(struct reftable_buf *buf,
> > +void cl_reftable_write_to_buf(struct reftable_buf *buf,
> >                            struct reftable_ref_record *refs,
> >                            size_t nrecords,
> >                            struct reftable_log_record *logs,
>
> It is quite weird that we declare the replacement functions in
> "unit-test.h" in the first commit only to remove them at a later point.
> It would make way more sense if we introduced the functions in
> "t/unit/lib-reftable.{c,h}" right from the start and then only remove
> the unused functions in the last step.
>
> Patrick

If I get it correctly, you're suggesting I have both the original
functions and the clar-based variant in `t/unit/lib-reftable.{c,h}`
right from the first commit, right?

Thanks
Seyi
