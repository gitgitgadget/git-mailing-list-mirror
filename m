Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC17C54EED
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 11:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjA3LIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 06:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjA3LIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 06:08:49 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D4E2D5D
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 03:08:48 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u21so10562045edv.3
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPkZS3e3mFj6Dw2tbc1yStfuGkpMhynftGnEETMy3PQ=;
        b=e74lq3myrwI7AzdPVRmEMEH4U2TGpFbNT96jg0Two5eOglnn1CzcLgmcrfg6SLD8j1
         rixWkPCrQlYTZgjfOcT1eAH4fgUCsRCAcp4Ezg7WovIpMQcq4LgK8zQ5Sv5SbV9+INZ/
         PjXcSIW1/MGEFYiCn4RlBHJURDvcCm+ouCVxCe6PGdgNAPmU2WeBqT3a4Xbh9AN0L2Wm
         /wpMZp2BHNSNwT7WaHBNMxQJInKyWE/KLd7GYbF81VrgWsf4Bh06x3pVbQ8p9LHdPSwM
         vzLB2a7BT+Ip+oY0kB+m38+OZ+Fd8d+IwchPRmxRgUwobzM0RC/J2bsXnSYLBC5mNUfa
         jHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPkZS3e3mFj6Dw2tbc1yStfuGkpMhynftGnEETMy3PQ=;
        b=ZnaBcKjXjxcJxagPLAe3ilVgP0RpCZEzBa+utFfxhu0ZDJTLdxCRPxX4/s5MKGUcv2
         Eb+f6fkS9xjgl3P55Lyed70zglrY4MF3QNkQv5BgXo9idPfPH+4zpGrCnWTIM6goKEbc
         QbEUSSIU4t1WnLmo4KP+I25nKX/+aD3dKAyrnwZ8swU7Ya8c5+AcjNIVT6WcH8IPcsBs
         hI708oWFSjsAxfv7LR3U54To1Wy43WqQUR+hO+sSSg7EzGqxcO9SM8cmrNuNouvD9Vl6
         vVv6Oxk8YLXbyl9J16q1qOCYOnUd7+F0pU3bG8jsqQNUNSJuAjGcEFCm1amodaXf8BpZ
         46Uw==
X-Gm-Message-State: AO0yUKXpbehtYySMIdlSZ85KyJ1sdLcLPtvvW4rhycN7NAHfaSGeu+oS
        fi7USAh/VKxIIv5ftVBE9jKLJQ==
X-Google-Smtp-Source: AK7set/I2l3s1EeX1HaA7Q8LqrdqORU4HB+/e1bqiXVpEza8Q6tjm8WpYGhNQwglkTDFkRhhqFBvHg==
X-Received: by 2002:a05:6402:540a:b0:4a2:20ba:71e5 with SMTP id ev10-20020a056402540a00b004a220ba71e5mr10016079edb.26.1675076926632;
        Mon, 30 Jan 2023 03:08:46 -0800 (PST)
Received: from ?IPV6:2003:f6:af05:8d00:5f06:9802:2fa1:311a? (p200300f6af058d005f0698022fa1311a.dip0.t-ipconnect.de. [2003:f6:af05:8d00:5f06:9802:2fa1:311a])
        by smtp.gmail.com with ESMTPSA id m5-20020aa7c485000000b0049e19136c22sm6591557edq.95.2023.01.30.03.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:08:46 -0800 (PST)
Message-ID: <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
Date:   Mon, 30 Jan 2023 12:08:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
Content-Language: en-US, de-DE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <20230127154952.485913-1-minipli@grsecurity.net> <xmqqbkmk9bsn.fsf@gitster.g>
 <xmqq1qnfancf.fsf@gitster.g>
 <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
 <xmqqk0156z55.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqqk0156z55.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.01.23 18:15, Junio C Hamano wrote:
> Mathias Krause <minipli@grsecurity.net> writes:
> 
>> ... While we might be able to compile the pattern and run it in
>> interpreter mode, it'll likely have a *much* higher runtime.
>> ...
>> So this grep run eat up ~9.5 *hours* of CPU time. Do we really want to
>> fall back to something like this for the pathological cases? ...Yeah, I
>> don't think so either.
> 
> You may not, but I do not agree with you at all.  The code should
> not outsmart the user in such a case.

It doesn't. My rhetoric question was just missing "automatically" to
state that I would dislike an *automatic* fallback to the interpreter
for *pathological cases.* But I'm fine with (and that's what this patch
is all about!) a fallback to the interpreter for patterns that simply
fail the JIT because it's broken. Sorry for the confusion.

> Even if the pattern the user came up with is impossible to grok for
> a working JIT compiler, and it might be hard to grok for the
> interpreter, what is the next step you recommend the user if you
> refuse to fall back on the interprete?  "Rewrite it to please the
> JIT compiler"?

Not at all. A user is still free to disable the JIT and enforce using
the interpreter by using the "(*NO_JIT)" prefix. My patch doesn't
disable this behavior. My patch only tries to avoid having to specify it
for "regular" patterns when the JIT is broken anyways.

The key here is that this would be a manual step (in contrast to an
automatic fallback), i.e. we require explicit user consent to accept the
worse runtime performance. And, IMHO, that should be acceptable from a
usability point of view as this would only be required for the
pathological cases an otherwise functional JIT simply cannot handle.

> If that is the best pattern the user can produce to solve the
> problem at hand, being able to give the user an answer in 9 hours is
> much better than not being able to give anything at all.

Sure, fully agree.

> Maybe after waiting for 5 minutes, the user gets bored and ^C, or
> without killing it, open another terminal and try a different
> patern, and in 9 hours, perhaps comes up with an equivalent (or
> different but close enough) pattern that happens to run much faster,
> at which time the user may kill the original one.  In any of these
> cases, by refusing to run, the code is not doing any service to the
> user.

My patch doesn't make it worse than what 'git grep' would currently be
doing. On the contrary, actually. It allows me to use PaX's MPROTECT and
have a functional 'git grep' as well.

Maybe the missing piece here is simply something like below to make
users more aware of the possibility to disable the JIT for the more
complex cases?:

diff --git a/grep.c b/grep.c
index 59afc3f07fc9..1422f168b087 100644
--- a/grep.c
+++ b/grep.c
@@ -357,7 +357,8 @@ static void compile_pcre2_pattern(struct grep_pat
*p, const struct grep_opt *opt
                        p->pcre2_jit_on = 0;
                        return;
                } else if (jitret) {
-                       die("Couldn't JIT the PCRE2 pattern '%s', got
'%d'\n", p->pattern, jitret);
+                       die("Couldn't JIT the PCRE2 pattern '%s', got
'%d'%s\n", p->pattern, jitret,
+                           pcre2_jit_functional() ? "\nYou might retry
by prefixing the pattern with '(*NO_JIT)'" : "");
                }

                /*

(Sorry about the wrapped lines, my mailer is just broken. I'll make it a
proper patch, if such functionality is indeed wanted.)

Thanks,
Mathias
