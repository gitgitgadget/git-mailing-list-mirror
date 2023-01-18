Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEA5C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 17:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjARRDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 12:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjARRDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 12:03:04 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633E4F36E
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 09:03:03 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-15f97c478a8so710364fac.13
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 09:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaBjNZJU6VVlfSObhemIU7tcYW9gfJo6tv44CumCx/g=;
        b=E/jBmDlgyX+XcXet+KHOUFZxXu15q00SPAW9XDB0NXflv0vOVf0YQ8h3l5mrruD2aJ
         ol7PFAlsA7Bl3ltFTg1GlvpLoR63w8Y7MFEYSpdGMNMvQ0jdqXA8jFoAwrqmpdYiQitc
         m173Y4Hs5M4ZhZrpjIxkucqqlN+F++JpYAmLNPJasDWJK8wODtD1CsnES7DMKa2n5nGQ
         uIo7B7BCUSmF7RN2aNj6vlGIBFFGx/R2Ql9ZRnPIxwGPQVpKHcIZn8xOAAm8T5NGRqmk
         9Fsg9fSm8CTjKGfkXmWbIiqumvaIq0m5gOHlIirQ6tT/mtfR0jJoT5lFG5JLf6q/Q9gk
         JDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaBjNZJU6VVlfSObhemIU7tcYW9gfJo6tv44CumCx/g=;
        b=P6eZ0iMS7NyDW43Y16mlk3vjW84zq38aLdTDsSV366AgcPECl1kdMwSxgmOawUeoIp
         +NIPlg+/QV/tjy+S4dAD/1ku6kdnblQSt3ugiD31g/Gp2qtu49fWFqHsdaUSlBW3Q9A7
         U8rBsz9wR2DTV0wW1a3j1VZBRe9PiWLVLjp7loKoRYcj/MM/0d/mqKD0vkORI9/7TGH1
         /m3hQh1hyjh8SkKvpXJUEbXPYBca7BGpSP80Cwo//0zSxwZWYmoTBUsPu7qP80gfh1J7
         dXrtr8Qsw1dXe6mapCa6EtHtupSLV2aYbYDvuA3wmLRTnSIhPfkUtvhDMh1A2RAHiUeo
         4q5w==
X-Gm-Message-State: AFqh2kpBdu8MTQnlyUpA0wCqmleM+NT3Wpd8N5Ep5y+NrISIUEPRdbKO
        Sb58+bNbPQ/WCmxfa68Jy4rk
X-Google-Smtp-Source: AMrXdXsKVtWV10Sr6qF52dZ2KjxgIdXoqUuOTwMrFDUd1DO4Rt7dgdXz8zye/wB6zg4QiSYZr+G1Xg==
X-Received: by 2002:a05:6870:7d15:b0:15e:df01:69f3 with SMTP id os21-20020a0568707d1500b0015edf0169f3mr4259772oab.24.1674061382362;
        Wed, 18 Jan 2023 09:03:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1543:36d:dc9e:b94? ([2600:1700:e72:80a0:1543:36d:dc9e:b94])
        by smtp.gmail.com with ESMTPSA id x6-20020a05620a448600b0070736988c10sm501221qkp.110.2023.01.18.09.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:03:01 -0800 (PST)
Message-ID: <58a70c93-22ed-901c-44f2-3224734c27c3@github.com>
Date:   Wed, 18 Jan 2023 12:03:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [BUG?] 'git rebase --update-refs --whitespace=fix' incompatible,
 but not enforced
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <b322c536-5a75-bb0c-8eac-1a99d3ba3230@gmail.com>
 <9445830b-d172-c3b6-ef60-ae4931cab84b@github.com>
 <CABPp-BGLVMoGiCeBMvyRhQmUSDEv8U7_U8=4B=Fh94=p_=QJVQ@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BGLVMoGiCeBMvyRhQmUSDEv8U7_U8=4B=Fh94=p_=QJVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/2023 11:24 AM, Elijah Newren wrote:
> On Wed, Jan 18, 2023 at 7:51 AM Derrick Stolee <derrickstolee@github.com> wrote:

>> +       /* Check for arguments that imply --apply before checking --apply itself. */
>> +       if (options.update_refs) {
>> +               const char *incompatible = NULL;
>> +               if (options.git_am_opts.nr)
>> +                       incompatible = options.git_am_opts.v[0];
>> +               else if (options.type == REBASE_APPLY)
>> +                       incompatible = "--apply";
> 
> git_am_opts can include "-q" which is not incompatible since it's also
> supported under the merge backend.

True, but I don't think that happens at this point in time. Right now,
the only things in there should be those placed by the opts parsing.
Things like '-q' get translated later. However, it would be good to be
sure.
 
>> +
>> +               if (incompatible) {
>> +                       int from_config = 0;
>> +                       if (!git_config_get_bool("rebase.updaterefs", &from_config) &&
>> +                           from_config) {
>> +                               warning(_("you have 'rebase.updateRefs' enabled in your config, "
>> +                                         "but it is incompatible with one or more options;"));
>> +                               warning(_("run again with '--no-update-refs' to resolve the issue"));
>> +                       }
>> +                       die(_("options '%s' and '%s' cannot be used together"),
>> +                           "--upate-refs", incompatible);
>> +               }
>> +       }
> 
> We already have imply_merge() to catch the range of incompatibilities;
> can we just use it?

That would be great! I didn't realize that.

>> +
>>         if (trace2_is_enabled()) {
>>                 if (is_merge(&options))
>>                         trace2_cmd_mode("interactive");
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 462cefd25df..8681c8a07f8 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -2123,6 +2123,18 @@ test_expect_success '--update-refs: check failed ref update' '
>>         test_cmp expect err.trimmed
>>  '
>>
>> +test_expect_success '--apply options are incompatible with --update-refs' '
>> +       for opt in "--whitespace=fix" "-C1" "--apply"
>> +       do
>> +               test_must_fail git rebase "$opt" --update-refs HEAD~1 2>err &&
>> +               grep "options '\''--upate-refs'\'' and '\''$opt'\'' cannot be used together" err &&
>> +
>> +               test_must_fail git -c rebase.updateRefs=true rebase "$opt" HEAD~1 2>err &&
>> +               grep "options '\''--upate-refs'\'' and '\''$opt'\'' cannot be used together" err &&
>> +               grep "you have '\''rebase.updateRefs'\'' enabled" err || return 1
>> +       done
>> +'
>> +
> 
> t3422 exists specifically for checking for incompatibilities of such
> options; the test should go over there.
> 
> I have both changes over at
> https://github.com/gitgitgadget/git/pull/1466; it doesn't include the
> "--no-update-refs" hint, but maybe that's good enough?  If so, I can
> submit it.  If not, do you want to alter or adopt some parts of my
> patch and submit a v2?

It sounds like you have a better handle on this and should take it
from here. I look forward to your patch.

Thanks,
-Stolee
