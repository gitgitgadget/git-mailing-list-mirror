Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B5C1FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 20:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756934AbcLAUB6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:01:58 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33821 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756240AbcLAUB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:01:57 -0500
Received: by mail-pf0-f174.google.com with SMTP id c4so47778911pfb.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zS5VN6R4bmlu5BKd/PCygvlbPEq3PXO6Ts7uVfvxK4Q=;
        b=RUAIXLWwUPwO8SkOh7KjqzHWZ0iNX69V3Zz73mIMCXpLpi7UWKYj68nouTQ3aNTv7r
         tvikDzJ7/jA6XNbUWfg9VVIYEF2MueMZitmeVUi6llpYx3vEuA035Wap7eQIixqfZzCm
         N8QbIp8HSQ9P9a7KNRAuqX29hKyRjZMK0WsN5szzvyGJhg/+UJigpb/oIn0OCNc5Oevz
         fn5jgWL4LyVIsypVsZ2oIonlQHo8jSSp6xTKQmsUHerTt2zP7I7uPuH8crFcd2gXAlMS
         WyIGpu08na5AHT1LdkX2nsGeW0zzNhaWC6iGCcPmaLZdGI/fOFaDO+HeJTPwJm3vBVdP
         yNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zS5VN6R4bmlu5BKd/PCygvlbPEq3PXO6Ts7uVfvxK4Q=;
        b=FGHFHcxYZDPjgezgtfE70Xw/oOyHg+u6TrQsEfGKA6StOK+qZ2LGQFWtvvLUO7o4Km
         Y4/wWUz1R5sz8nhly4UU6WKr6ebzf4u7B39DcrJZYZhkWoXEGC2zRkbh34P07KIo+RDw
         ij6FBWnlEYZt08xauyX55I5X4UlmK6PEdTHfT7+CbWz4IVTpJ/+NYMb8MN5KdVYB1OkO
         taQiKWLmVgIVdKy51PVEAo40l15m8lqnN2Azq5oJrya3w8ecZP3t+FFOc57t90PtXRJU
         jocpu7D++js3TmDfe0bmqmemK4za789a+c6gEBc0KguP1BGcR2U6e00N2/XOD5ySaXRG
         XYvg==
X-Gm-Message-State: AKaTC00GEBF90MvAGsk79GgZSpqnSg9xdTnIGU0HFI+tgDh7dJFL0RWVDe8ynTvID8iU3/fw
X-Received: by 10.84.194.37 with SMTP id g34mr87997327pld.36.1480622516962;
        Thu, 01 Dec 2016 12:01:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id y134sm1996714pfg.81.2016.12.01.12.01.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:01:56 -0800 (PST)
Date:   Thu, 1 Dec 2016 12:01:54 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v6 4/4] transport: check if protocol can be used on a
 redirect
Message-ID: <20161201200154.GF54082@google.com>
References: <1478555462-132573-1-git-send-email-bmwill@google.com>
 <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480621447-52399-5-git-send-email-bmwill@google.com>
 <20161201195031.fd4uwmvkyhk4so7i@sigill.intra.peff.net>
 <xmqqbmwva0im.fsf@gitster.mtv.corp.google.com>
 <20161201195902.td4zfolqpc3uwfgq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201195902.td4zfolqpc3uwfgq@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Jeff King wrote:
> On Thu, Dec 01, 2016 at 11:54:09AM -0800, Junio C Hamano wrote:
> 
> > > I'm not sure if we should call this "redirect" here. That's how it's
> > > used by the curl code, but I think from the perspective of the transport
> > > whitelist, it is really "are you overriding the from_user environment".
> > >
> > > Calling it "from_user" may be confusing though, as the default value
> > > would become "1", even though it means only "as far as I know this is
> > > from the user, but maybe the environment says otherwise". So bizarrely,
> > > I think calling it "not_from_user" is the clearest value.
> > 
> > Bikeshedding: perhaps call it "unsafe" (in the sense that it is "not
> > known to be safe")?
> 
> That is definitely what we are going for, but it is vague about how it
> is unsafe. :)
> 
> I think I may have converted Brandon in the other thread to my way of

Yep, I've been converted :D

If we agree on that then I can make the change and resend the patch.

> thinking of it as a tristate[1]. That lets us call it "from_user", and
> just do:
> 
>   case PROTOCOL_ALLOW_FROM_USER:
> 	if (from_user < 0)
> 		from_user = git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> 	return from_user;
> 
> which is pretty clear. Nobody would ever pass "1" as from_user to the
> function, but it does the sensible thing if they do.
> 
> -Peff
> 
> [1] The original I posted calling it "redirect" was totally bogus
>     because the logic between the two names is inverted.

-- 
Brandon Williams
