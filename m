Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D1620401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbdFUVbQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:31:16 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33464 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbdFUVbP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:31:15 -0400
Received: by mail-pf0-f172.google.com with SMTP id e7so10940303pfk.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1ybIUwiR3XJxqaEWUtTIyFGCna+4YySOc53cYn8yG8Y=;
        b=gjVP8WUksS5rVg6FxdXHzP5t7YkvO1LveVh5XgPVvub8Wo1g2OvoWryCYI0hNnYtVb
         G+lehVwumXPkGS4cthA41Vmbe8HUsu7QZWLIh3IoVAaO9jEchNTEXe2va55z6qhbRY4Q
         jX466fV0PfA1tJBnDCS0oY7PUq4rY7Vds8ygqL60iOxZfdVYZZkfCLHz+6LF0L8f6YWn
         5GuIMa39mmc1Bgl2utNF6bC0sDNnaz46Bm/RVk/LButyDRn6Z0OcXXQbj5aTY2rHwzrW
         ++UC1HlkxpQAqspH/abbf17yAgG8aa0QOnZ6x9UtNseIpS9wR5XuPkakuhCkldCO8YJS
         /7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1ybIUwiR3XJxqaEWUtTIyFGCna+4YySOc53cYn8yG8Y=;
        b=Az9nC9+bTwC1S6FEhyZqlUo9stUh2Gk+y8JpVT6/JfH+ErKsSGy94jCYqwH4h3KqAI
         601eQaKdnBNgpt6JCHM9/eTHLXEQBFYmZ502rXQtHlbyTE0mZa8dueI+DuI2QYXtLtu9
         7Z+xgimj66vRtUQpTQxdiYftIdNaweOsPvTP9KvoYNaSHHeSUHPDm0WsB5rblxx8eT+o
         zPf5NgYwQ56w1RoKRUxrXHVRtboATu6Jui+v5x/S8SsacEBq8YOx1yhsothMdqj6auv7
         t84ixvyEIjHIm+HauOKqhmeW4Uaj4Ud/F2sL5a48tpTyV6lozxouBQ+/tCba9jX1iMGH
         1xXQ==
X-Gm-Message-State: AKS2vOzFvjwoIulhXexGHSOr8F3zYObZJuFks8K+TwD4+IAWr9EhRig0
        0CJ/YKeIyL6kkCDupsYCwRI85LErfARY
X-Received: by 10.84.232.205 with SMTP id x13mr19590888plm.245.1498080674330;
 Wed, 21 Jun 2017 14:31:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 14:31:13 -0700 (PDT)
In-Reply-To: <20170621212709.GC53348@google.com>
References: <20170608234100.188529-1-bmwill@google.com> <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-5-bmwill@google.com> <CAGZ79kaUiODQm8KsGOAtAoATNW7mci3DRM=RimXXv-6--9NOKw@mail.gmail.com>
 <20170621212709.GC53348@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 14:31:13 -0700
Message-ID: <CAGZ79kY6hAj318ePRQjdbqoZxYPDuqiLrbEEGi4t7xJYE28zQQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/20] repository: introduce the repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> I guess we can still refactor later, it's just one
>> thing to thing about when introducing an API
>> that will likely be used a lot down the road.
>
> I'm not sure what we want right now, hence why I left it a little more
> vague.  At this point in time all the relevant callers I can think of
> (or rather potential callers) don't care about the failure and just want
> to know if it succeeded.  I think it would be ok to do a small refactor
> at a later time if we really needed to provide the reason for the
> failure.  Unless of course someone feels strongly enough that it needs
> to be addressed right now.  If we did address it now then we would need
> a group of #define's or maybe an enum to describe the failure modes.

I do not feel strongly, just wanted to draw your attention to it.
And having thought about it, refactoring down the road is likely quite cheap,
so this was a useless bikeshedding attempt.

>>
>> I applaud the effort towards documenting what each variable is
>> supposed to contain. But some of them read like
>>
>>     /* increments i by one */
>>     i++;
>>
>> which is considered bad comment style (it doesn't add
>> more information, it just wastes a line), so specifically for
>> all the "Path to X" comments:
>> * Are they absolute path, or relative path?
>>   If relative, then relative to what?
>> * Can they be NULL? When?
>>
>> (* Why do we need so many path?
>>     Could one of them be constructed using
>>     another and then hardcoding a string relative to it?
>>     This question may rather be answered in the commit
>>     message)
>
> Thanks for pointing this out.  I'll work a little bit more on the
> comments to be more descriptive.  I do think that all field names should
> probably be commented though.

Thanks!
Stefan
