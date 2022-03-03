Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089EEC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 23:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiCCXdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 18:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCCXdK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 18:33:10 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219FE15F08B
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 15:32:24 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id h28so5298900ila.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 15:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4DyKxdthbhupjkW3TkUsjJzw47vesI0RDADU5Zn/gwE=;
        b=ltUy8X/nTIPldy/KIOC/Lj8GxiDy/joqvovx47dS8lxMzI6awaKqucZDTg2O7pYctP
         ndS2UYRmJkt186PSil6TnYQN1vScUaZgEilTmBstZawTzr4D5l/m7lh12LX01eyvHjTA
         yVuRpePaJKiUPNpQbk3Vt3vAFpCuNWWl5MjjNmpUtCdybqoWxkmpwnqIb7N7vireJFJO
         9MsnUxXcdEa8dnF9FesbY6VpoapH9kTf181lheL/8yA113Hkyttz5/x1BquQMdSodQuv
         m95f8H6u6qK5Pahp/cP2F4z234s9CmaBQ8mmdOszE++L2NMJcV1I0jZxuFTKT5Ia1q9R
         Gsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4DyKxdthbhupjkW3TkUsjJzw47vesI0RDADU5Zn/gwE=;
        b=t4Y7+Ntee7+dkgLr6DQpDD+XNuoszDochdTD3/hZcHmBy2+55iPN9vwo6QNnhs1R6E
         0IY6sn6V0NU1EBvlSqe9vydnFLsW+mTdRUHzR7/1uVgKueeHPyl4w1ehjDAo08BL6MxL
         2SCoIPZyShQ/L1v8ZhhLOYPez6MRIV19/6WEpdCnl6cjoFuQ9p6sH7h6/OOyO8k7l5He
         zusuGCOLplxT9+HeKlEgLeB8x4uDTBtX8ddgVJrv4qgZdN3RzlvCep5Jb3yWQtCXeXiv
         aYbOmoaca9aQAcqOq8meRkBerLhAcQS0t4JsB3YE5bicrCcRZROkt9defERORrjRvt43
         lMWA==
X-Gm-Message-State: AOAM5302C1ITLjIV8faaUS1trfLzlSWyuLZ6bh+ItwE8zN8zKdxM83h/
        BFlFxMxlKfzyWPu3j1sG0JMbTQ==
X-Google-Smtp-Source: ABdhPJw3jQ3wcTEHBVFA4Wy6eFNagW9bKKykRXRnGAUOZvcjVR5hisuQXwlXlNhmPMxP3/Wb9Gi5Lg==
X-Received: by 2002:a05:6e02:178d:b0:2c4:b692:a8eb with SMTP id y13-20020a056e02178d00b002c4b692a8ebmr10611124ilu.74.1646350343553;
        Thu, 03 Mar 2022 15:32:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f13-20020a056e02168d00b002c4b8023f1dsm3602214ila.43.2022.03.03.15.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:32:23 -0800 (PST)
Date:   Thu, 3 Mar 2022 18:32:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, tytso@mit.edu,
        derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v3 04/17] chunk-format.h: extract oid_version()
Message-ID: <YiFQBobcLT2m/KMx@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <135a07276b0a40b04f2c28d4f48c26b1af76c12c.1646266835.git.me@ttaylorr.com>
 <220303.86ilsv2dke.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220303.86ilsv2dke.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 03, 2022 at 05:30:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Mar 02 2022, Taylor Blau wrote:
>
> > Consolidate these into a single definition in chunk-format.h. It's not
> > clear that this is the best header to define this function in, but it
> > should do for now.
> > [...]
> > +
> > +uint8_t oid_version(const struct git_hash_algo *algop)
> > +{
> > +	switch (hash_algo_by_ptr(algop)) {
> > +	case GIT_HASH_SHA1:
> > +		return 1;
> > +	case GIT_HASH_SHA256:
> > +		return 2;
>
> Not a new issue, but I wonder why these don't return hash_algo_by_ptr
> aka GIT_HASH_WHATEVER here. I.e. this is the same as this more
> straightforward & obvious code that avoids re-hardcoding the magic
> constants:

Hmm. Certainly the value returned by hash_algo_by_ptr() works for SHA-1
and SHA-256, but writes may want to use a different value for future
hashes. Not that this couldn't be changed then, but my feeling is that
the existing code is clearer since it avoids the reader having to jump
to hash_algo_by_ptr()'s implementation to figure out what it returns.

Thanks,
Taylor
