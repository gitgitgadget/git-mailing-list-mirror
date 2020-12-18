Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0B0C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E5B23A58
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgLRCIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 21:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgLRCIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 21:08:34 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EADFC0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:07:54 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q22so565351pfk.12
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CX0IdRnKpfKuE/t/ItO/9hQIdbT1Oq65W5B///4ZzSk=;
        b=Zp4eAMUGRTXhfPO4dCib2nSb7985Umju8lS0JNuFGLRjJh5iMfzgjj5vuTebUKrWhL
         wIufEpFyKHhrgQaq2TqFaxUOu9E9OzS7ZP27txcOQwLqOAoHUyQZN7+1bwm/l6vTi1EW
         LVLvBFbjHxGJucMohBAmxnK2I6ZuNkYwF2QDPKZA2s9C7dqyZFD/52nf3x7Mg8xXVRn2
         s36Ro6iMY2NvFMYXFSk1tE6zTdTD9QXrC+YHb7vhJQGqoBKLz0MkmiTbMweD7rugl8vY
         JrEh1l0kAZL+eBc4kd51diyWDSdqDF3hjbZKhr8Xnk/vbWYXT1F6eG7HxcViu4MzBs9y
         h35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CX0IdRnKpfKuE/t/ItO/9hQIdbT1Oq65W5B///4ZzSk=;
        b=EuSMlOeB8qotbr2ZAwdA4VJpGkOPXnYe3Z4t6/JDccbc5XtSMR/vCEPsdDBcPKjLik
         W7DhFjJOvXlPRBshyZ7mZxN9UBYmDCDAQ+4p5b82carNYVLc+JoZ2D3Q+IhwqhO1G+hM
         p5W+kgZGAPme5qBp9r07P0EHHEDnbjH7MrxIDFPatj0/G6BDsExmWw4yIIYQu9R+8jkB
         tCBn9pIj0Zzb22vlqev9Y5tgHRQIw0l8NJRLw8H2g433CqkUOS4HqChpABP8PcRlQt1E
         zf0Rmm62sFtT/0qTX4paVTM1d4UYFDMbIQjPocPqicziGSJfJRICMc9kgtuPQH8IlSx3
         1P9w==
X-Gm-Message-State: AOAM531bdrXlwNVYOA/xSV5dYEw8TSfdOa2yF04rIEaY/TGsz0XovFjF
        gdsGX7BpMhGr1+GeabRFd8D5aw==
X-Google-Smtp-Source: ABdhPJwyK5Gp1w22ztGo1I9BWMt1nzdaOiRYOJ/pwkrXq2oi/6d+Vp5uERt12u6+Lyn1zTrbd9SUnw==
X-Received: by 2002:a05:6a00:1716:b029:19e:11b0:7804 with SMTP id h22-20020a056a001716b029019e11b07804mr1686238pfc.57.1608257273417;
        Thu, 17 Dec 2020 18:07:53 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id k21sm6385953pfu.7.2020.12.17.18.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:07:52 -0800 (PST)
Date:   Thu, 17 Dec 2020 18:07:48 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 00/17] propose config-based hooks (part I)
Message-ID: <20201218020748.GI3783238@google.com>
References: <20201014232447.3050579-1-emilyshaffer@google.com>
 <20201205014607.1464119-1-emilyshaffer@google.com>
 <20201216003408.GR36751@google.com>
 <xmqqlfdy6025.fsf@gitster.c.googlers.com>
 <20201216201625.GF3783238@google.com>
 <xmqqwnxh1g4h.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnxh1g4h.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 03:32:46PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >> By the way, es/config-hooks does not seem to pass 5411 (at least)
> >> even as a standalone topic, and has been kicked out of 'seen' for
> >> some time.  Has anybody took a look into the issue?
> >
> > Yeah, I looked at it today. Looks like an issue with not paying
> > attention to master->main default config, since I added a new test to
> > the 5411 suite (which means it wouldn't have made a conflict for someone
> > to say "ah yes, s/master/main/g"). I am tracking down couple of other CI
> > errors today and will send a reroll today or tomorrow.
> 
> Thanks.

I don't have a reroll today. I have been trying to get to the bottom of
a test which fails when built with clang but passes when built with gcc
(t6030-bisect-porcelain.sh after patch 12 of the part II series) and
have not made progress on that, let alone on the other tasks I wanted to
do before sending the next version.

Next week I will only work one day, so I'd anticipate a reroll sometime
the week following. Sorry for the wait - but I think even if I sent it
with the fix for this t5411 failure, it would still break 'seen' because
of whatever this clang vs. gcc problem is.

Hope you enjoy your holidays.

 - Emily
