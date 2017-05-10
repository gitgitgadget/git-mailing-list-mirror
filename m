Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9828720188
	for <e@80x24.org>; Wed, 10 May 2017 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbdEJSUy (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 14:20:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36828 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbdEJSUw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 14:20:52 -0400
Received: by mail-pg0-f68.google.com with SMTP id 64so386770pgb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xz36BeDkjmT2/jXVtfuUqtrZ8mpBRTMoBiB4fQvaXNc=;
        b=h2YTCzs+zp9E+XAJy/NeXFayXxyPPG9NT8EDyatLz94VqQEF7lV9FI/W4ZAGUWDr3g
         lzIFSR5RmewMl4kMS8Ajny4pYBexlERhftz2rXC1+UyajGzr5RzYllyWivemWIbBo2/7
         sF4mALLHwWmrUE2V/fDbCLiCLLSrQ0xXijMxrzZdvyBdPDazKhpfoRA9zxLMrRwVSDps
         P2GZ0OUE5GPj6JyfWSBawuKaTm09iRiJ1uYiAyr1ByJE+0KhCP+6Z2+HmhjwSUexfOwt
         wr6uJsRDHEvK5trnI3qNM/Mh1wHt0Di8wIsZeCRZO2tfuQLk5dFl2SsBveuX+v885MIY
         IRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xz36BeDkjmT2/jXVtfuUqtrZ8mpBRTMoBiB4fQvaXNc=;
        b=rNddJo1Hjz/cSMrF0z+x9/TmdcqlbPElF3+h3g6K++n/9l99GUv1fIZ4tGNjJTUKNq
         OC8MVHHKIS1utiYyZzDZhWwDG3BS9mnUwBV6C/EyE6WsKp5G6m2b5zuA7dEz0+cSr9/q
         jc5eMXeAZU76VBBUlKnlZWtB0qmBTAhdJk2ZcVFkseEMZIKgWZ360FH4Fbi7gaBMSUKV
         veXpSNL36dTlcg3cMfiZMFmvyOx4gIqChwI7Fzp/7wb9hPMedf4f6Z/JTG8zXa3DZjne
         D+J27CZivTgOkJedFDgiNCFBCVVhidQT3lSxMNWbJhH9aprHbtvLhp5905P26YVIpaw9
         YB0Q==
X-Gm-Message-State: AODbwcCN27UOqNWHu2kLDecX5hl6xVFII0i5OdnLtu4yTIe6djkXw4Yb
        a/9sq9g3uFdCIg==
X-Received: by 10.99.115.11 with SMTP id o11mr7944594pgc.10.1494440451764;
        Wed, 10 May 2017 11:20:51 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:55dd:a079:3f06:9176])
        by smtp.gmail.com with ESMTPSA id 202sm6434623pfy.83.2017.05.10.11.20.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 11:20:51 -0700 (PDT)
Date:   Wed, 10 May 2017 11:20:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>,
        Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170510182049.GZ28740@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
 <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
 <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
 <20170510044626.g4dwcujfr7vhv55d@glandium.org>
 <CACBZZX4AnmP2N_-WLtqQncUDCZDeWS3LFomZrWLYP6iW-hL5KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4AnmP2N_-WLtqQncUDCZDeWS3LFomZrWLYP6iW-hL5KA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Just a side question, what are the people who use this feature using
> it for? The only thing I can think of myself is some out of band ref
> advertisement because you've got squillions of refs as a hack around
> git's limitations in that area.

That's one use case.

Another is when you really care about the exact sha1 (for example
because you are an automated build system and this is the specific
sha1 you have already decided you want to build).

> Are there other use-cases for this? All the commits[1] that touched
> this feature just explain what, not why.

Similar to the build system case I described above is when a human has
a sha1 (from a mailing list, or source browser, or whatever) and wants
to fetch just that revision, with --depth=1.  You could use "git
archive --remote", but (1) github doesn't support that and (2) that
doesn't give you all the usual git-ish goodness.

Thanks and hope that helps,
Jonathan
