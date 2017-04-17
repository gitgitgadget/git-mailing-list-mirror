Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9666520D09
	for <e@80x24.org>; Mon, 17 Apr 2017 01:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932426AbdDQBnV (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 21:43:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34254 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbdDQBnT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 21:43:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id g23so7630398pfj.1
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 18:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7p+86jYnf3DCfZs/U3aZxpyeYkg0yoJFfaEgkPBOfi0=;
        b=JN21H8Lu5eKyuHLhqUa+wCdRranDkcBkqaFsO/LsBEWuODktSLjLbcx/7fd7/JZO2a
         LsvQHHzc8NW59HdxIdMNz1sY9JoQ4fm+3a8Yw5lN39jSTlkER2TtTclaTVGAo657cvyZ
         gpJAHDnNzrciTHzIxkxR+H1MNK+8tMN4kWIiz3D8vc+t00NsYrlDIANiLbe9TB16djOO
         AkSL99h8y7u2+39Yw2eY9QLZRd2kqwkHbathPUxI1uSk8ivvwz2qJRJW84j/lV6ExZUF
         +lCA4F21rQbz72DmLhukkQoBsLpxohoSqLYhNtwWp2VoyQ8EhSTlegFrwQhDX/X6+kwr
         lMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7p+86jYnf3DCfZs/U3aZxpyeYkg0yoJFfaEgkPBOfi0=;
        b=Bt20nQN1Bz19XQjFFUQmerw0KPikj0dQmoKMl7HETC7CCrBpVl5juHSZlx3+7k4X3Y
         97tLQ3N2GvyJWGx0Ye+ek3DWXCaUuXFiHmb/WUjDZtA46Ftczo1TPJoTA1PCfPASrpqT
         /i+ZeQ9xNxsB3X3T9sDBxaBgzBCsuF1Z4p7C2G39Fs9MJFD/LMaEvosV4LAodZWQ7yDy
         TdDcHNuIu9eyDABc1o0RqXB4Wbrvy2LS5uj4GiHis+vzDXk8s/iI7+cSWOLme+NNOZjx
         Q/RleJU9uFDDFGy+4WcyLwF4jNecM8ECc6gTG9JDsD7SN0RhWXHnLk2hpCG4yR1FjZ6S
         BxbQ==
X-Gm-Message-State: AN3rC/7SIfyH2Dlz7MSz7TmJGIozywUOUc42WNp5GRogVAs+iZDjnskN
        rUHXmhEW6ULixA==
X-Received: by 10.99.98.134 with SMTP id w128mr2149874pgb.207.1492393379641;
        Sun, 16 Apr 2017 18:42:59 -0700 (PDT)
Received: from duynguyen.vn.dektech.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id c3sm14243724pfg.46.2017.04.16.18.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 18:42:59 -0700 (PDT)
Date:   Mon, 17 Apr 2017 08:42:55 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        bert.wesarg@googlemail.com
Subject: Re: [PATCH 1/2] config: prepare to pass more info in
 git_config_with_options()
Message-ID: <20170417014255.GA8987@duynguyen.vn.dektech.internal>
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
 <20170416104125.15300-1-pclouds@gmail.com>
 <20170416153127.f227kdbfctgrumh4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170416153127.f227kdbfctgrumh4@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 11:31:28AM -0400, Jeff King wrote:
> On Sun, Apr 16, 2017 at 05:41:24PM +0700, Nguyễn Thái Ngọc Duy wrote:
> 
> > So far we can only pass one flag, respect_includes, to thie function. We
> > need to pass some more (non-flag even), so let's make it accept a struct
> > instead of an integer.
> 
> Yeah, this makes sense. But...
> 
> > diff --git a/builtin/config.c b/builtin/config.c
> > index 4f49a0edb9..5de4a36146 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -26,7 +26,8 @@ static int use_global_config, use_system_config, use_local_config;
> >  static struct git_config_source given_config_source;
> >  static int actions, types;
> >  static int end_null;
> > -static int respect_includes = -1;
> > +static int respect_includes_opt;
> > +static struct config_options config_options;
> 
> It fails all the git-config "include" tests because respect_includes_opt
> is missing the initialization to "-1".

Serves me right for doing last-minute "harmless" refactoring without
rerunning the test suite :(

> 
> -Peff
