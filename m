Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E07C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350949AbiHSS7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350943AbiHSS7i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:59:38 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EED104459
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:59:37 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 10so3987893iou.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=A8D6LF13S4HbeGbQdNjsVEaYRWfHqxjfdmOkl5EgdgE=;
        b=E+NU87+XBgMlyr+aDnjmvOBcZ3fwssZgU6mQzSq1g5TQj4Vxsv3wk/fMZHJaD8sPUh
         X2tNA7sAemR+TPikYyKl6xhRvJd3nIAAcdddG4QLS/oFmhAScYlUwCiE0wEu0VbHiq2G
         N4Y2uBH9TWBCEFOebulzkYl9usedRESS6RxdET4QD94tB8q/NJt18jKX6zAYIES0oLcp
         /frQn6Qkk/EnQVbNwdnTUkeCVTCS/lqBB27YEha99iXnN6Hma6aIpvbpPGIiiWs8T79+
         e1dVGvaTZLJYp1lJFxAblYF49eEdKEpAHkDJiGkZrb039MtUBwntDxc6OlP5i2MqM0CG
         v1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=A8D6LF13S4HbeGbQdNjsVEaYRWfHqxjfdmOkl5EgdgE=;
        b=FpeGo6fDod9eCwKQ1NhdX8J093HoE6A9MYwf8Sckv5SY1C1/jmZVK6HRjXrhcCA12a
         swyVGuD01wooknAVotzVQGv9HmGnCdf3bRyesHHLlwzA1P2XUouzBpNe/uMtT90JbZ6V
         WoKTQcbi079GIEVsz9oEXjf7wqAQp2wT/ToeQN4JyaeUtmUulDlC/g+ZOG8HolqmSPAr
         MNY/aH7RiXas4cVFXBNlDt0ovLvFjiH+dBmk6iMrZ/rQgcv3v+A7YZgpDuMevwplg8A3
         uLvDCpTQ8ZlN+6/o/EeL9/0qnj7BqS69zw0dWbB9nL7MvINgszCIn6fApH0CEca1liKb
         W7Mw==
X-Gm-Message-State: ACgBeo0sGzlVZaJdIlkrXREHNYouNKqcsWNxb6BJnbxyvD73FjJ89MuK
        1rRLw6a340gXMGMZ7HR/zkJE
X-Google-Smtp-Source: AA6agR5HMaI4NCCstHebHCzs7wjXduX62fE+cG9b2dA0NC+52wWf7thmqgpCGtEEU5eCXttXBUS80g==
X-Received: by 2002:a02:cccd:0:b0:346:e38b:1c5e with SMTP id k13-20020a02cccd000000b00346e38b1c5emr3763811jaq.47.1660935576573;
        Fri, 19 Aug 2022 11:59:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55ca:650:1968:6180? ([2600:1700:e72:80a0:55ca:650:1968:6180])
        by smtp.gmail.com with ESMTPSA id cq13-20020a056638478d00b003428115672fsm2050452jab.30.2022.08.19.11.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 11:59:36 -0700 (PDT)
Message-ID: <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com>
Date:   Fri, 19 Aug 2022 14:59:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/11] annotating unused function parameters
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
 <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2022 9:58 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Aug 19 2022, Jeff King wrote:
> 
>> I've been carrying a bunch of patches (for almost 4 years now!) that get
>> the code base compiling cleanly with -Wunused-parameter. This is a
>> useful warning in my opinion; it found real bugs[1] when applied to the
>> whole code base. So it would be nice to be able to turn it on all the
>> time and get the same protection going forward.
>> [...]
>> And of course the most important question is: do we like this direction
>> overall. This mass-annotation is a one-time pain. Going forward, the
>> only work would be requiring people to annotate new functions they add
>> (which again, is mostly going to be callbacks). IMHO it's worth it. In
>> addition to possibly finding errors, I think the annotations serve as an
>> extra clue for people reading the code about what the author intended.
> 
> I've known you've had this out-of-tree for a while, and really like that
> it's on the path to getting integrated.
> 
> But I have a hang-up about it, which is that I though __attribute__
> (unused) didn't work like *that*.
> 
> What it means (and maybe only I find this counter-intuitive) is "trust
> me, this is unused, but don't check!", furthermore it causes the
> compiler to completely ignore the variable for the purposes of *all*
> warnings, not just the unused one.

That's not the reason for the attribute at all. It's supposed to say "I
know this is unused, but I still need it to be in the parameter list for
other reasons. Don't create a warning for this case."

Interpreting it the way you are means "don't do the analysis. Just throw a
warning." which doesn't make any sense.

> I may still be missing something, but I wonder if this squashed in
> wouldn't be much better:
> 	
> 	diff --git a/git-compat-util.h b/git-compat-util.h
> 	index a9690126bb0..e02e2fc3f6d 100644
> 	--- a/git-compat-util.h
> 	+++ b/git-compat-util.h
> 	@@ -190,9 +190,9 @@ struct strbuf;
> 	 #define _SGI_SOURCE 1
> 	 
> 	 #if defined(__GNUC__)
> 	-#define UNUSED(var) UNUSED_##var __attribute__((unused))
> 	+#define UNUSED(var) var __attribute__((deprecated ("not 'deprecated', but expected not to be used!")))
> 	 #else
> 	-#define UNUSED(var) UNUSED_##var
> 	+#define UNUSED(var) var
> 	 #endif

Does the deprecated attribute imply unused? Or at the very least, does it
avoid the -Wunused-parameter warnings?

It might be helpful to _also_ have a deprecated annotation so we know to
remove the UNUSED macro if a parameter starts being used again. The
existing macro changes the variable name so we would get compiler errors
if we started using it, but we could have a better message indicating
exactly why things are not working.

So in that sense, you are onto something. Should we use both attributes?

At the very least, the warning message you recommend in the 'deprecated'
attribute could be more direct about what we expect.
	 
	 #if defined(__GNUC__)
	-#define UNUSED(var) UNUSED_##var __attribute__((unused))
	+#define UNUSED(var) var __attribute__((unused)) \
				 __attribute__((deprecated ("remove UNUSED macro before using")))
	 #else
	-#define UNUSED(var) UNUSED_##var
	+#define UNUSED(var) var
	 #endif
	 
	 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */

Thanks,
-Stolee
