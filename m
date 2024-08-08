Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AE148310
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127165; cv=none; b=hhtDtokhGKsqSaiKCNUMj9tZgeWa0WTDW5vWHx0iYPplUvSL5ogMRyxFDPw3m8DE/qS/KOs5cRKNwUc/f+FxcMPnJiHBlNOVcReYKZ36KnTCtP2JphEZe9FTAxTNKgdaL0pYl/5dgz9kcvfeW/URPzfcU5ImpSrccp1kuWrUaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127165; c=relaxed/simple;
	bh=XFCdSy1OKkE6qMaICMV96D6PI+KDTZJYaXuy3XwzjAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0ekOjnLulggodygHRc9Nkq96qPjx01XANXcnnsTUQBZb0bRRu/ppY2iTZrjHcEBaBNc42ARH1yKbtwiZpmDJLbJln0J9Ut+J+ONOb8WZgzAQDHA0aG5mLhgtqlImA7rJCGAIZm6VloWJOFwQT7b1cQOtUk8fVsQNGGx0iWpeBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7rLImkT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7rLImkT"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f16d2f2b68so14209671fa.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723127162; x=1723731962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HqQBAd02uCJ3LOE1JueGR9/tIr3SPdspxUK4Rof3vcU=;
        b=Y7rLImkTiOfiLMeri+rn8fse7g40KNCAH22PwZeYfvKY396PML+jY68keR65lZ3Q9q
         TzdhwJDKHdxIZyumhD63MzB18qcrAVNOi7eDb5H/ruqL5hK+BwKzxdRIWBk6uo7hvoLN
         IRaY0UOJM+ELUfU6Hfu7iWSRx+27A/L5JvK2k/y+cZEtWlc6K1jAr7nFmysadK9V4iNo
         Q/dXAdndxYkOy0PL1iT4Npkz3HiZXLYkB33023dCRNM47W7d5yfY1Mn1t2C9uKaAEozc
         0c4A8iZe2PLUs9qTT2N1hC1gg96gkRMXpLW2YjuDgl70Bv0z3zoGYLyM1BKnMP80eRgE
         7wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723127162; x=1723731962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqQBAd02uCJ3LOE1JueGR9/tIr3SPdspxUK4Rof3vcU=;
        b=eXqj8rp4M/IkEJJTGS3G5R2El6lXS2E6OjtZIrQtk77zSlLbwXjTxZjq2MQwruVisW
         7n8ZZ4X+0oLA8pt5dkVXl3G/F7luraCGPSg8RoImpNgHs0eNsd3V5hLC86JnvKbHRVMs
         VxKEtqaD4IJVEWwBKKUIJeNdhvkixkSv5KK5jG0c8NoggylKykq/JUos7mfkK6kSvuvr
         wYgC6Qh/BYP/ozNwPe/cl743pt0yNOUqcHLIiQ4Z7wY4m2/jGpsLfdgl19iIAgZHKCs1
         rt4tqEBLW+yVwehMvK4+CB9bMrdYV7xTZ8Oa2JmE+DwksRRlrpAcvElNEG0/kb+f1dXR
         FuPg==
X-Gm-Message-State: AOJu0Yw9CqbPMF2e8siTtDAY/vjt+dpU1yCcdi4huC7SkefVMeembxun
	K9L/AZNqUof1Nc8y3bAGF/FsAd31r/XQLZppJyrFjjtKctq2Hp9yrhXlUZiNOtPD/9cgJqtZNE+
	ZkzOJ/x2NsXujKtIrplNa9Pa8Sx4=
X-Google-Smtp-Source: AGHT+IFb0PcOSHxa9ETcy5U+O8Kv/sPZ0rdx703C6afKbFXJxYP+Jz+FfET4KWos5jVA7CM3Z2X2kBXb4P5DsVwH5iQ=
X-Received: by 2002:a05:651c:1549:b0:2ef:20ae:d117 with SMTP id
 38308e7fff4ca-2f19de1afacmr19008881fa.10.1723127161183; Thu, 08 Aug 2024
 07:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
 <20240807141608.4524-6-chandrapratap3519@gmail.com> <ZrR91dR3G06L9dy7@tanuki> <ZrSzbdNkCS2LOXaL@tanuki>
In-Reply-To: <ZrSzbdNkCS2LOXaL@tanuki>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Thu, 8 Aug 2024 19:55:35 +0530
Message-ID: <CA+J6zkRszqfPP=_gbzzyDCOoUsLQUd0ke-XbMbFYu30Vhtocng@mail.gmail.com>
Subject: Re: [PATCH 5/5] t-reftable-readwrite: add tests for print functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 17:36, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Thu, Aug 08, 2024 at 10:12:07AM +0200, Patrick Steinhardt wrote:
> > On Wed, Aug 07, 2024 at 07:42:01PM +0530, Chandra Pratap wrote:
> > > +static void t_table_print(void)
> > > +{
> > > +   char name[100];
> > > +   struct reftable_write_options opts = {
> > > +           .block_size = 512,
> > > +           .hash_id = GIT_SHA1_FORMAT_ID,
> > > +   };
> > > +   struct reftable_ref_record ref = { 0 };
> > > +   struct reftable_log_record log = { 0 };
> > > +   struct reftable_writer *w = NULL;
> > > +   struct tempfile *tmp = NULL;
> > > +   size_t i, N = 3;
> > > +   int n, fd;
> > > +
> > > +   xsnprintf(name, sizeof(name), "t-reftable-readwrite-%d-XXXXXX", __LINE__);
> >
> > Is it really required to include the line number in this file? This
> > feels unnecessarily defensive to me as `mks_tempfile_t()` should already
> > make sure that we get a unique filename. So if we drop that, we could
> > skip this call to `xsnprintf()`.
> >
> > > +   tmp = mks_tempfile_t(name);
> > > +   fd = get_tempfile_fd(tmp);
> > > +   w = reftable_new_writer(&fd_write, &fd_flush, &fd, &opts);
> > > +   reftable_writer_set_limits(w, 0, update_index);
> > > +
> > > +   for (i = 0; i < N; i++) {
> > > +           xsnprintf(name, sizeof(name), "refs/heads/branch%02"PRIuMAX, (uintmax_t)i);
> > > +           ref.refname = name;
> > > +           ref.update_index = i;
> > > +           ref.value_type = REFTABLE_REF_VAL1;
> > > +           set_test_hash(ref.value.val1, i);
> > > +
> > > +           n = reftable_writer_add_ref(w, &ref);
> > > +           check_int(n, ==, 0);
> > > +   }
> > > +
> > > +   for (i = 0; i < N; i++) {
> > > +           xsnprintf(name, sizeof(name), "refs/heads/branch%02"PRIuMAX, (uintmax_t)i);
> > > +           log.refname = name;
> > > +           log.update_index = i;
> > > +           log.value_type = REFTABLE_LOG_UPDATE;
> > > +           set_test_hash(log.value.update.new_hash, i);
> > > +           log.value.update.name = (char *) "John Doe";
> > > +           log.value.update.email = (char *) "johndoe@anon.org";
> > > +           log.value.update.time = 0x6673e5b9;
> > > +           log.value.update.message = (char *) "message";
> > > +
> > > +           n = reftable_writer_add_log(w, &log);
> > > +           check_int(n, ==, 0);
> > > +   }
> > > +
> > > +   n = reftable_writer_close(w);
> > > +   check_int(n, ==, 0);
> > > +
> > > +   test_msg("testing printing functionality:");
> >
> > Is it intentionally that this line still exists? If so, I think it
> > really only causes unnecessary noise and should rather be dropped.
> >
> > > +   n = reftable_reader_print_file(tmp->filename.buf);
> > > +   check_int(n, ==, 0);
> >
> > Wait, doesn't this print to stdout? I don't think it is a good idea to
> > exercise the function as-is. For one, it would pollute stdout with data
> > that we shouldn't care about. Second, it doesn't verify that the result
> > is actually what we expect.
> >
> > I can see two options:
> >
> >   1. Refactor these interfaces such that they take a file descriptor as
> >      input that they are writing to. This would allow us to exercise
> >      that the output is correct.
> >
> >   2. Rip out this function. I don't think this functionality should be
> >      part of the library in the first place, and it really only exists
> >      because of "reftable/dump.c".
> >
> > I think the latter is the better option. The functionality exists to
> > drive `cmd__dump_reftable()` in our reftable test helper. We should
> > likely make the whole implementation of this an internal implementation
> > detail and not expose it.
>
> For the record: I've got a bigger patch series in development that drops
> the generic reftable interfaces. As part of this, I'll also rip out the
> functionality provided by "reftabel/dump.c".

Cool, I'll just drop this patch from the series then.
