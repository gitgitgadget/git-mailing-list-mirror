Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F90C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbiEXVun (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiEXVul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:50:41 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E687CB7C
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:50:40 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e93bbb54f9so23871818fac.12
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t586IcHRVrBfa5ngFxtxBpIiLBZaEB52sBVcWfoYVXo=;
        b=VUej0Yyqv4kpS/zmP1S+8AnHKIpu7pXkQJK9CSJcrwDu1zONFzBCObl8sRj4phMUi1
         yXws9mZyO3xK5g+yf8FN/YN/VpWXmZTbqROyWhfHZpSteE51ZTRxNsujXdPRwpzwZNM0
         u3/vQVXl9RO9FJbtveRTDvmX33CcGThwJrBlsMn2+CnlF1kHdaw5F+/D7+I8wZ6n7D9y
         SX2VFxrNyV7f1cze2LDkkxruB+MVyyEaAJLh1BsH2N8+tC4Ak/F+y6YXZ2tW0jONS92q
         xo4pHPvjWVRTm4nqgiFfkUg9NsgijFtgtMxWSgIF/5U3YMrfee7jICWfx6h3Vf0Ugoql
         M02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t586IcHRVrBfa5ngFxtxBpIiLBZaEB52sBVcWfoYVXo=;
        b=imWU7Q2RcJjHNoXz0qeM9b1O6FCePZrlUoOCO9oxqUkKjtV0LOauqEi25QxdGoDndc
         Ayd6e2oqgFbVfChr9ljPCov8/10x7UV7ESz/AnMRGRZYOdS3+79HRbeMiy4tKaTXk7Td
         V++diaN+gJ4EtdoX+c8v+bQ/W0ubQLe5b+2dwlFox73DwyldFPWjFzi6mDnN7j+OPgBJ
         GULGOGQSYEicSqkQ7aN3RjAwwugtzUhE5yJAX19brTX23iamt7TiQWrRe9jkJMeClNDJ
         3EzD42nvVhS3Xi/1B4/ca76zlx7QmcdBT6UiB9gMadCDJdrzuzBsBTiahd2xnc4Rr377
         jqgg==
X-Gm-Message-State: AOAM531nauORihkaBOYwBXKUJDbeellMxsWK7qIL3EDf/3V57+nLmklY
        2mJWX783RveWJ35FjlIeJ/2OTTYeSt9jQg==
X-Google-Smtp-Source: ABdhPJxpSyZJHzk4i1EYj8gRjJF8k5NgkAdMmkIH7mcOYLh7SAA4z1l8zcAnjQRKRDNgiuFqYORfnQ==
X-Received: by 2002:a05:6870:51cc:b0:e1:e6ee:448f with SMTP id b12-20020a05687051cc00b000e1e6ee448fmr3746752oaj.136.1653429028774;
        Tue, 24 May 2022 14:50:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w184-20020aca62c1000000b0032b99637366sm158192oib.25.2022.05.24.14.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:50:27 -0700 (PDT)
Date:   Tue, 24 May 2022 17:50:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 00/17] cruft packs
Message-ID: <Yo1TIQqvlxhvLZ58@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <220521.868rqv15tj.gmgdl@evledraar.gmail.com>
 <Yo00X0NEu8N0MnZV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yo00X0NEu8N0MnZV@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 12:39:11PM -0700, Jonathan Nieder wrote:
> Ævar Arnfjörð Bjarmason wrote:
> > On Fri, May 20 2022, Taylor Blau wrote:
> > 	On Mon, Nov 29 2021, Taylor Blau wrote:
>
> > 	> +static void write_mtimes_header(struct hashfile *f)
> > 	> +{
> > 	> +	hashwrite_be32(f, MTIMES_SIGNATURE);
> > 	> +	hashwrite_be32(f, MTIMES_VERSION);
> > 	> +	hashwrite_be32(f, oid_version(the_hash_algo));
> > 	> +}
> [...]
> > 	But since this is a new format I think it's worth considering not using
> > 	the 1 or 2 you get from oid_version(), but the "format_id",
> > 	i.e. GIT_SHA1_FORMAT_ID or GIT_SHA256_FORMAT_ID.
> >
> > 	You'll use the same space in the format for it, but we'll end up with
> > 	something more obvious (as the integer encodes the sha1 or sha256 name).
>
> Agreed.

I know we recommend using the format_id for on-disk formats, but I think
there is enough existing uses of "1" or "2" that either are acceptable
in practice.

E.g., grepping around for "hashwrite.*oid_version", there are three
existing formats that use "1" or "2" instead of the format_id. They are:

  - the commit-graph format
  - the midx format
  - the .rev format

Moreover, I can't seem to find any formats that _don't_ use that
convention. So I have a vague preference towards using the values "1"
and "2" as we currently do in these patches. (TBH, I don't find "sha1"
significantly more interpretable than just "1", so I would be just as
happy leaving it as-is).

> [...]
> > Other than that the only question I have (I think) on this series is if
> > Jonathan Nieder is happy with it. I looked back in my logs and there was
> > an extensive on-IRC discussion about it at the end of March, which ended
> > in you sending: https://lore.kernel.org/git/YkICkpttOujOKeT3@nand.local/
> >
> > But it seems Jonathan didn't chime in since then, and he had some major
> > issues with the approach here. I think those should have been addressed
> > by that discussion, but it would be nice to get a confirmation.
>
> I would still prefer if this used a repository format extension, but
> that preference is not strong enough that I'd say "this must not go in
> without one".  What I think would help would be some information in
> the user-facing documentation for commands that create and work with
> cruft packs.  In other words, if our take on people sharing
> repositories between implementations that understand and don't
> understand cruft packs and get objects moving back and forth between
> packed and loose objects is "you should have known you were doing
> something strange", the least we can do is to warn them.

I think that's a good suggestion. We already have some documentation in
Documentation/technical/cruft-packs.txt, but I think it could be helpful
to add user-facing documentation, too.

Would you be opposed to doing that outside of this series? ISTM that the
technical discussion has mostly settled, so I'd rather wordsmith the
user-facing documentation separately.

> I don't see a config to enable PACK_CRUFT by default yet in this
> series.  I'd like one, so that people can turn it on and get the good
> new behavior. :)

`git gc` has support for this (c.f., "gc.cruftPacks"). `git repack`
requires you to pass `--cruft`; IIRC I originally had a similar
configuration in `git repack` which would change the behavior of `-A` /
`-a` when set, but I found it too confusing and scrapped it.

Thanks,
Taylor
