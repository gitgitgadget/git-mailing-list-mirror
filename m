Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD3A1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 17:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfIKRwH (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 13:52:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52197 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbfIKRwH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 13:52:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so4523836wme.1
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uBEiDXE8dlJLwtnPT6Z40698FXUSV50jK6BrT51U3ZY=;
        b=BeI3JECT4uHNJvQ//66hqwm4TwqkYmRe3IpAIkpPa7fjj2fsl0sJcLQjxSb/W8t/2x
         fyy+J6FL4052d478ldNVGiHuvEp14hi0tAdKjHdVDqrpW0J7yMQdZoTlP5DgF8hlSMYO
         jsfyt1c1AphTUh/Z2s1pGpLemaAanp7fBg93MY/SiLHGf1GALxvA0IWcrSNfwU0vLp3P
         cYYO0rY4u+MkLMFeQ6Xs9qFf/JFClkKinOsmNaMU31ERyWysKqxMscSSdqRsjgejEy8W
         1N/UBmlei1aI9GxWj8uo+ZYv4KahDLPwYFE50vtRK2anozEEItKGP6uQtIGKePnsXqHe
         QHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uBEiDXE8dlJLwtnPT6Z40698FXUSV50jK6BrT51U3ZY=;
        b=i4Wt7cppJAPmGx49LxsQyh7793LbKtzED4lEH47kzqGfBszegKVUcOpP5E2o3J+HV5
         6nZsbHQB4qK6Nxw3T1EdupPMsne+37brrFINYlCzWULYtAQTC94zYGtQssx+gkliU23h
         DFM0TNJ9BCFQU1aZqc6fQpBTLAmqnor5T+UTZy8/iI58f7VFEofsgMsqpKBolB73feBE
         rCnU9DJinNIVlgQ9pdtP/3pbVj5jqg/nNlQ+AAgcsvqdcz0Uk/jHEC6uTCoGhDP52rXL
         qlcVO4HBAjnLuaTJPUgoTxPzcDJkgUyApPPJDG8i5HsiwfH2uV8T3+QzNzM31OOMGXqk
         9gOA==
X-Gm-Message-State: APjAAAVMRFFeEPgN/2GyiN7Ct/hMwKwqL3KOwrs8inSjrwuojsT0j6he
        iXdulRDN8zNsiBfarbsfqfo=
X-Google-Smtp-Source: APXvYqy4gjHCZBF/PSIT7nJNv/TJ6xrzERI/Rr8g0fRctlhxiIn/9bhC6fYKSeLNjjsZhMWOFLzi+g==
X-Received: by 2002:a1c:6c09:: with SMTP id h9mr4629657wmc.36.1568224324823;
        Wed, 11 Sep 2019 10:52:04 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id d18sm27242266wra.91.2019.09.11.10.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 10:52:02 -0700 (PDT)
Date:   Wed, 11 Sep 2019 18:52:01 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Joel Teichroeb <joel@teichroeb.net>, Jeff King <peff@peff.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 1/3] factor out refresh_and_write_cache function
Message-ID: <20190911175201.GA11444@cat>
References: <20190829182748.43802-1-t.gummerer@gmail.com>
 <20190903191041.10470-1-t.gummerer@gmail.com>
 <20190903191041.10470-2-t.gummerer@gmail.com>
 <xmqqwoemo131.fsf@gitster-ct.c.googlers.com>
 <20190906141812.GA128436@cat>
 <nycvar.QRO.7.76.6.1909111155540.5377@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909111155540.5377@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/11, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Fri, 6 Sep 2019, Thomas Gummerer wrote:
> > Oops, I didn't realize there was another series in flight that also
> > introduces 'repo_refresh_and_write_index'.  Probably should have done
> > a test merge of this with pu.
> 
> Yep, our patches clash. I would not mind placing my patch series on top
> of yours, provided that you can make a few changes that I need ;-)

Sounds good.  Looking ahead further I don't mind these changes at all!

> > Right, and if gentle is set to false, it avoids writing the index,
> > which seems fine from my perspective.
> 
> This also suggests that it would make sense to avoid
> `LOCK_DIE_ON_ERROR`, _in particular_ because this is supposed to be a
> library function, not just a helper function for a one-shot built-in
> (don't you like how this idea "it is okay to use exit() to clean up
> after us, we don't care" comes back to bite us?).

Yup, returning an error for this definitely makes sense, especially
for future proofing.

> > >  - This version allows to pass pathspec, seen and header_msg, while
> > >    the one in builtin-add-i cannot limit the part of the index
> > >    getting refreshed with pathspec.  It wouldn't be a brain surgery
> > >    to use this version and adjust the caller (there only is one) in
> > >    the builtin-add-i topic.
> >
> > 'pathspec', 'seen' and 'header_msg' are not used in my version either,
> > I just implemented it for completeness and compatibility.  So I'd be
> > fine to do without them.
> 
> Oh, why not keep them? I'd rather keep them and adjust the caller in
> `builtin-add-i`.

Great, I'm happy to keep them.

> > There's two more differences between the versions:
> >
> >  - The version in my series allows passing in write_flags to be passed
> >    to write_locked_index, which is required to convert the callers in
> >    builtin/merge.c.
> 
> I can always pass in 0 as `write_flags`.
> 
> >  - Dscho's version also calls 'repo_read_index_preload()', which I
> >    don't do in mine.  Some callers don't need to do that, so I think it
> >    would be nice to keep that outside of the
> >    'repo_refresh_and_write_index()' function.
> 
> Agreed.
> 
> > I can think of a few ways forward here:
> >
> >  - I incorporate features that are needed for the builtin-add-i series
> >    here, and that is rebased on top of this series.
> 
> I'd prefer this way forward. The `builtin-add-i` patch series is
> evolving more slowly than yours.

Great!  I'll send an updated version of my series soon.  Thanks!
