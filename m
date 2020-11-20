Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334BAC2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CD12242B
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cguW0sdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgKTSvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgKTSvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 13:51:19 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC0C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 10:51:19 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id v20so5167724qvx.4
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 10:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BoSpIt+0NUhDCeWZ5SYe7GiusMBB9RzFIJxR9t+hxno=;
        b=cguW0sdpEycenW/xBGH6EczafTYTtqe8GYsj+9DTYEsv2iBXxKCpBMIOBkvZXpXfth
         fMCeTu4JzAQWmP1wRkuUB4pBhKaSw3MDY6ZPZAT1TzbWX1o3ADasW1+JVh9Sn/dyPjpM
         KxrFW6V2inxvAOM48n21aPlCpeajoLu+Ke+Az3t58V29yItQ+a6tDkH65whsM2B0tAgY
         efKkBK/ZUn8I/OZNTy1nHKwPwZlpwEjZax6fhmDEXwrnZMGwfJRDsnEmzJcu3w7RRUOX
         D6whqCgyLzA5KUN5Y1JVdG5JzBRD6fOF8XTv7WMGC3y+oON3DBWQt62paJCSsYYCzx7r
         GtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BoSpIt+0NUhDCeWZ5SYe7GiusMBB9RzFIJxR9t+hxno=;
        b=Y25H947aVFejg0+cT7fsaBN0kcjNjf5q/GjMYImQDGrN1utnAlvU3BLxnk2lmYr70g
         BKUc3mWvVLqck8hT/ofc0tAJd8Dz3FcmNe/FitrGTDS1v12dfBPGh6E3b/MzNHe9J4Aj
         70rVnPja7jh+d5Fy2qB22/HsJyTrAsnY10Wlw8+s6HfbhOn+jGTEfZRu2o98cOwH6FNO
         sxWSOYI1uAqA8Y60VadHkVgTixo1FUH7H4X1mDUxk09Azoi8FEeF6yZZNotSN4nA83lo
         gevTHwTBWQlVkuSiIs6JD9x1LJUG+H9WP6P6Q0W4WhspTOkDpmgMLTxtiaGF5mGQkra3
         RlLQ==
X-Gm-Message-State: AOAM530ebewWZghTxwuY4LDQq5zIal+m8DvaUNPypVmLOfjQD4sbpbaL
        +FfiWxiuMBn9C8Vbka017xE=
X-Google-Smtp-Source: ABdhPJwvepz411SUiXlrXaLolXztREw0inlzBS/AisacNsUaDqeeuIQMEDzsPlGYa53aCV/c3PlX9w==
X-Received: by 2002:ad4:4743:: with SMTP id c3mr17655014qvx.62.1605898278344;
        Fri, 20 Nov 2020 10:51:18 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id s7sm2503570qkm.124.2020.11.20.10.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:51:17 -0800 (PST)
Subject: Re: [PATCH 0/7] config: add --literal-value option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <87k0ugp3mg.fsf@evledraar.gmail.com>
 <e7973fe1-eb64-2f5a-ecb3-fadf2ba9764d@gmail.com>
 <xmqqk0ufubha.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3a347d16-8549-5244-c7db-82b97d7311de@gmail.com>
Date:   Fri, 20 Nov 2020 13:51:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0ufubha.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2020 1:30 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 11/20/2020 8:19 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Thu, Nov 19 2020, Derrick Stolee via GitGitGadget wrote:
>>>
>>>> As reported [1], 'git maintenance unregister' fails when a repository is
>>>> located in a directory with regex glob characters.
>>>
>>> Just as bikeshedding on the name: Did you consider something
>>> thematically similar to the corresponding git-grep option,
>>> i.e. --fixed-string[s]. I see -F is also free in git-config(1).
>>
>> I definitely wanted to be specific about "value" in the name,
>> since some options include regexes on the key as well. I'm open
>> to new ideas, and combining your idea with mine would introduce
>> "--fixed-value". Thoughts?
> 
> I very much appreciate "value" is in the name, with the current
> semantics that this only controls how the pattern matching is done
> on the value side and not on the key side.  When making an obvious
> addition of a separate option to control how the pattern matching is
> done on keys in the future, we would regret if we called this option
> "--fixed-strings" today.  And no, I do not think it is an acceptable
> option to introduce "--fixed-strings" that only affects value side
> and then later change its behaviour to affect also on the key side.
> 
> 	Side note.  It _is_ possible to ship such a "--fixed-strings"
> 	option that does not work on the key side and document it as
> 	a known bug, later to be fixed.  I am not sure if I like it.
> 
> But stepping back a bit, is the extra flexibility that allows us to
> control the matching on keys and values separately with such a
> scheme really worth the complexity (at the end-user facing interface
> level, not the implementation level)?
>
> So an alternative may be to use a single option, whose name would
> probably be one of "--(literal|fixed)-(match|strings)", but extend
> the implementation in this series to make the single option affect
> both the value and key matching the same way.
> 
> That would however be more work in the shorter term.  Offhand, I am
> not sure if I like it (i.e. spending time and effort that is more
> than the absolute minimum necessary to fix a breakage.  And the end
> result of doing so is less powerful/flexible, even though it may be
> easier to explain to users simply because the feature is less
> powerful than it could be).  It would be easier, if I can convince
> myself that the extra flexibility is not worth it, to just declare
> that simpler is better here, but I am not quite ready to do so yet.
I had not thought about making this option be related to the key
names at all. In particular, we already have the --get-regexp option:

--get-regexp::
	Like --get-all, but interprets the name as a regular expression and
	writes out the key names.  Regular expression matching is currently
	case-sensitive and done against a canonicalized version of the key
	in which section and variable names are lowercased, but subsection
	names are not.

I suppose that there could be reason to create a similar --unset-regexp
that is the same equivalent of --unset-all. Perhaps the --replace-all
mode could benefit, too? These are also more dangerous to use with regex
matches since they also _change_ the config, not just query it.

Since there is already asymmetry between the key and value (only one
mode, --get-regexp, has a "name_regex"), I would prefer to treat the
value_regex in isolation here.

Thanks,
-Stolee
