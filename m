Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F78720954
	for <e@80x24.org>; Thu, 23 Nov 2017 00:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbdKWAIn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 19:08:43 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:34739 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdKWAIm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 19:08:42 -0500
Received: by mail-io0-f180.google.com with SMTP id q101so24933472ioi.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7EARHQfSbpWeuQYCHCr4KDm6+G+lSjRm1QmCQk0QKhE=;
        b=p7482EpkZiQnQc/IfeaDjXpvowOecjTN3lyKxz6NmFIarIlVpzdv8/aX8jh/bAUOBF
         2c3CjnmxXJyOn3NOq51eiIfKt8ghiLNll9wrWnJePDJ3MwZvat2rspuH26kGKGoJP2PC
         Zg8IS3XHEMGvs2YYwuRRldJjs08eqcosx3+Yfb/YFVS57UwPqPMP5i73xqxFHazW0SLj
         hUtSuAbIQilzm0t9rXOPzlGyJNEaXnPCEfLf3HxsVw5qYOchCg1PM8pGukr/8kQFUyB5
         9sdPVyC0dTIhB0j0OR8bYNxN2JiGz3X149Pes6V3Ji6wK0oYg5clAfWHaGPsph5UOmi+
         2apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EARHQfSbpWeuQYCHCr4KDm6+G+lSjRm1QmCQk0QKhE=;
        b=pteA282Qi/NHMUpUHJWvzSjeqPO/vRhNWcPDgsbLQ5Gup3uAbvz5uj7yeeI/BZuOqN
         lcUPdQkuoS+8VfjZm3Z3o3maaKFjhI8up5pqmmI1P2nsvq4/QDBBVzSpzGIhYGO+dArB
         DoBCvLj5gFbQvY0s1AvMVWLPCp0PqZXnQwORC6ZbF6sYTryQ2s7N7R+6yungq/w834vw
         K4NHmzHwsmAdZ1OwhjCDHEbw060iaShWGNBjDMDnk0aN/1qsICrYgs+b54QaQc+VKkJC
         zYQRK8SZZO3L2eMbsP1anyDg5GKhVwUo529Zve10xVXqnX0ZAIbro7Fi4xUAwWHCx90C
         Ezow==
X-Gm-Message-State: AJaThX6u+TjsBhW9ANE2gkNitr6+VeObEQX8O/hNX9W4KP5TR3ztaent
        VTZ4SaSyyC+PuUdm0cD/8Xbv4ThJ
X-Google-Smtp-Source: AGs4zMZVjRP9ktE8CDK1v6OyHheBdBfeqfistzeEPsvlkEaRalSXa48Y6yT1r+m/BrGOR0ZkmffnEA==
X-Received: by 10.107.129.150 with SMTP id l22mr25883090ioi.158.1511395721650;
        Wed, 22 Nov 2017 16:08:41 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o73sm3831945ito.4.2017.11.22.16.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 16:08:41 -0800 (PST)
Date:   Wed, 22 Nov 2017 16:08:39 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
Message-ID: <20171123000839.GL11671@aiede.mtv.corp.google.com>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122232457.GA8577@sigill>
 <20171122232814.GH11671@aiede.mtv.corp.google.com>
 <20171122233905.GC8577@sigill>
 <20171122234532.GI11671@aiede.mtv.corp.google.com>
 <20171122235851.GE8577@sigill>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122235851.GE8577@sigill>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Nov 22, 2017 at 03:45:32PM -0800, Jonathan Nieder wrote:

>> It lets you build with NDEBUG.
>
> But why do you want to build with NDEBUG if nothing uses assert()? ;)

No idea, but some distros (not Debian) have done it before and I don't
want to be burned again.

> I'm being a little glib, but I think there really is a chicken-and-egg
> question here. Why are people building with NDEBUG if they don't want to
> disable asserts?

It's because they want to disable asserts.

The semantics of assert is that they're allowed to be compiled out.  A
person setting NDEBUG is perfectly within their rights to assume that
the author of a program has followed those semantics.  Of course this
makes assert a terrible API from the point of view of Rusty Russel's
API rating scheme
<http://sweng.the-davies.net/Home/rustys-api-design-manifesto> but
it's what C gives us.

FWIW I think we've done fine at using assert so far.  But if I
understand correctly, the point of this series is to stop having to
worry about it.

[...]
>> It also goes through our own die()
>> handler, which means that e.g. the error message gets propagated over
>> remote transports.
>
> BUG() doesn't go through our die handler. It hits vreportf(), which does
> do some minor munging, but it always goes to stderr. Error message
> propagation over the remote protocol happens either:
>
>   1. From a parent process muxing our stderr onto the sideband.
>
>   2. Via special wrappers like receive-pack's rp_error().
>
> The only program I know that sets a custom die handler to change the
> reporting is git-http-backend (and there it only applies to die("BUG"),
> not BUG(), so with the latter you'd get a hard hangup instead of an
> attempt at an http 500).

Ah, interesting.  That could be worth changing, though I don't think
it's too important.

[...]
> Yes, obviously side effects in an assert() are horrible. But I haven't
> noticed that being a problem in our code base.
>
> For the record, I'm totally fine with banning assert() in favor of a
> custom equivalent. I just don't think we've seen any real problems with
> assert in our codebase so far.

It sounds like we basically agree, then. :)

Jonathan
