Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E70520193
	for <e@80x24.org>; Thu,  1 Sep 2016 23:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbcIAXb5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 19:31:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32972 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbcIAXb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 19:31:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id w207so632164wmw.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=q3DsO9wltFA8ofyyiy9earNADPWbVIon1fdUVbd95Yc=;
        b=Yd8/dtLHXG5dXG7LdO2U+2lSPNXhSz+rpicNOrhD8yK5o/g9zvcR1J8qUkpA4VBpHN
         TRFy0Nh0oLGYSuNEFYv8Ree0HfslAA93ol5vARo90u/o9Op+TOuqjuk+SdFe8Xcldc0e
         fLuaELSK3l30V8EP1AhkTEihNxnkK5gSSKl7Rat/u64836c2N5G+mOJf7fuD/QjVMPAB
         oGxyao7NXlJcO3drlOHaJ142jYEz5N2JO6ci1aPJJN+YCFwqNkSfahtZ2IJomM9g0nFB
         yGUg/XrC7JXKinQYZlcXA6WP4G/cky9INXDvX03fP8JER4izu/APFGqrgpgJblN/ijH/
         1MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=q3DsO9wltFA8ofyyiy9earNADPWbVIon1fdUVbd95Yc=;
        b=U98LBl5Y40gnOL7j3skn00Zns2h6iVNcrUSJSuxEzEqpSqaT/W1voQ43CYhp8L9nq2
         ITOCWkxOtS2fLLc5Ol4Zi5URYJwZD+CocAH0yWuv0UeLSODc+mz4zMtX0ucLAe8Qqrbh
         CnqiWshZ5I2rtgdGlHWBdzFv4p1M/moPVyQalKp9XxBCSr2fs8A6hQIb6c6MVPIpbrpr
         4an7pjniDNXtKU2cejLi/cWUGYSM4455Vjqw4hoj3VZvA1vE3MogfduRST8Tw0h9Nydo
         uTVauUUBC2wokWCj9ezmFr3q3h3MP+5F9WjdSEdi3W8IBP7bwFU7ojOJQ+ONhyQTdoi1
         2waA==
X-Gm-Message-State: AE9vXwOpfGFN4sMCIUKvMgm8Mg8O2cWOscTyE5eeagaLn+OsWG9C5+66rJvZIM8VkZiDsw==
X-Received: by 10.28.161.133 with SMTP id k127mr168129wme.103.1472772715215;
        Thu, 01 Sep 2016 16:31:55 -0700 (PDT)
Received: from [192.168.1.26] (abrf30.neoplus.adsl.tpnet.pl. [83.8.99.30])
        by smtp.googlemail.com with ESMTPSA id jd4sm7596671wjb.6.2016.09.01.16.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 16:31:54 -0700 (PDT)
Subject: Re: [PATCH 19/22] sequencer: support cleaning up commit messages
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <eeb3d11d235a0220a9a125a21d1b09a73d2c61dc.1472457609.git.johannes.schindelin@gmx.de>
 <9f2cbc74-3e4d-e7f1-d2dd-e85e0b9168b1@gmail.com>
 <alpine.DEB.2.20.1609011543290.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <80a779a5-70d3-64dc-d206-41c47e1c69f5@gmail.com>
Date:   Fri, 2 Sep 2016 01:31:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609011543290.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 01.09.2016 o 15:56, Johannes Schindelin pisze: 
> On Thu, 1 Sep 2016, Jakub Narębski wrote:

>> It's a pity that emulation of named parameters in C requires
>> relying on designated inits from C99
>>
>>   typedef struct {
>>     double pressure, moles, temp;
>>   } ideal_struct;
>>
>>   #define ideal_pressure(...) ideal_pressure_base((ideal_struct){.pressure=1,   \
>>                                         .moles=1, .temp=273.15, __VA_ARGS__})
>>
>>   double ideal_pressure_base(ideal_struct in)
>>   {
>>     return 8.314 * in.moles*in.temp/in.pressure;
>>   }
>>
>>   ... ideal_pressure(.moles=2, .temp=373.15) ...

Forgot to add citation:

[1] Ben Klemens "21st Century C: C Tips from the New School", 2nd Ed. (2014),
    O'Reilly Media, chapter 10. "Better Structures", subsection
    "Optional and Named Arguments"

> 
> Yeah, that looks unwieldy ;-)
>

Declaration needs some trickery, but use is much, much more readable
(if we cannot use sensibly named variables for passing arguments):

  ideal_pressure()
  ideal_pressure(.temp=373.15)
  ideal_pressure(.moles=2)
  ideal_pressure(.moles=2, .temp=373.15) 

It is even better if there are large amount of parameters:

  res = amortization(.amount=200000, .inflation=3,
                     .show_table=0, .extra_payoff=100)

vs

  double amortize(double amt, double rate, double inflation, int months,
            int selloff_month, double extra_payoff, int verbose,
            double *interest_pv, double *duration, double *monthly_payment);

 
But we can't use it in Git, anyway
-- 
Jakub Narębski

