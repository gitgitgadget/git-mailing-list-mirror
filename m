Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD04C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 23:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685F860EE7
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 23:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhHIXCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhHIXCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 19:02:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00DC0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 16:01:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso2367327pjy.5
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 16:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+v0V/Tpf4HoYtjAXLm7Mmtw7DyHJmpkOzdsV+qOUFqg=;
        b=fMkcFtG9NVZjykF3OJtLGGtF7uMFugsUKEcg5bZAaQ7o+UxVmiS7dN49ytljJqktqU
         ifLIE69kQHfwSDHTSjlbSp8LwaMI+DthOsgknBWAHk+5oAn7GKYDLrLXpM5puDzTMXOQ
         lWCfLZyDZot2AUG7iKyfceH5++4CVTsWy9gTLoER/xDhTWB6q6VDzVL+2g02xmBrqhee
         lZ005N389sSOc6Wdav2NdRlhrb8Nd1YQS5Mtl1CYnd2mYc1AgsfAgBoNInvH38ViXH0k
         7aON8zDd0IMakNHqcGqA7cUSnPsioBzB3J6ajdCoBzwOAE8nQo7PLCsrCxRUkT3HS6eJ
         Mvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+v0V/Tpf4HoYtjAXLm7Mmtw7DyHJmpkOzdsV+qOUFqg=;
        b=e6xrTxwPo614QWJsDLj+q7L0hgZLY+Q5O8jdXXNe9lxE6xTJrAEeAn3CJxWR9iT+nx
         zY1+yjxKIJ55FdhTt9HRUQIBa+VRPH3O3GDaEgO1P1pAcyeLzoLYoC1DmYhezTMQnowl
         epJcxhl7BhxxtlUyMpuxzs1/8olBAAKgIBUMAoWFCvkvwQsCH5d3pUkUGrxzYq6AIiAV
         STKtNBQPhAdYop9GB2wCBW9EAXcQo8OfrFcXKN3r1ELvgCXWleL126jg97a2eygQGXQn
         ho8iOY/JrpcKmt+XEV71OgnP+GvvvuHVlfpX92/uGbQLhj7SyNYNwNt99gKRvcvpr9sW
         uYaw==
X-Gm-Message-State: AOAM531VclpMBoocgWQ/t/Iqtnxci1Uh7BHlHSs5RE65kkEKheBrlULf
        q1AGxrCmQl2/lwU4ut6XamQ=
X-Google-Smtp-Source: ABdhPJz0q9WeS/3Hxb0q1QjaYCZKq99rOLVvle3SVrVjLiXEb9mIoOS84wRTyWfilbzRxzqmOGtt8g==
X-Received: by 2002:a17:902:e804:b029:12c:af3b:b172 with SMTP id u4-20020a170902e804b029012caf3bb172mr22438437plg.2.1628550103796;
        Mon, 09 Aug 2021 16:01:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4d74:2fd5:acb7:59ca])
        by smtp.gmail.com with ESMTPSA id 31sm24599095pgy.26.2021.08.09.16.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 16:01:43 -0700 (PDT)
Date:   Mon, 9 Aug 2021 16:01:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kim Altintop <kim@eagain.st>, git@vger.kernel.org,
        jonathantanmy@google.com, bwilliams.eng@gmail.com
Subject: Re: [PATCH 1/3] t5730: introduce fetch command helper
Message-ID: <YRGz1bFdBP8X/U29@google.com>
References: <20210730135845.633234-1-kim@eagain.st>
 <20210731203415.618641-1-kim@eagain.st>
 <20210804203829.661565-1-kim@eagain.st>
 <20210804205951.668140-1-kim@eagain.st>
 <20210809175530.75326-1-kim@eagain.st>
 <20210809175530.75326-2-kim@eagain.st>
 <YRGEwFauT5QjMSNO@google.com>
 <CDFBG4S23B1M.141X9FIPP7YHS@schmidt>
 <xmqqpmume0oa.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpmume0oa.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Kim Altintop <kim@eagain.st> writes:

>> Perhaps an alternative would be:
>>
>> 	write_fetch_command () {
>> 		write_command fetch &&
>> 		echo "0001" &&
>> 		echo "no-progress" &&
>> 		cat /dev/stdin &&
>> 		echo "done" &&
>> 		echo "0000"
>>  	}
>>
>>
>> Which would then be called like so:
>>
>> 	write_fetch_command >pkt_cmd <<-EOF &&
>> 	want-ref refs/heads/main
>> 	have $(git rev-parse a)
>> 	EOF
>> 	test-tool pkt-line pack <pkt_cmd >in &&
>> 	test-tool serve-v2 --stateless-rpc >out <in &&
>>
>>
>> I'm not sure how portable that is, though. Maybe using `while read -r` instead
>> of `cat /dev/stdin`?
>
> If you drop /dev/stdin, the result would be emimently portable.
> "cat" without any argument reads from the standard input stream
> and copies it to the standard output stream.

Yep, with that tweak (using "cat" instead of "cat /dev/stdin") this
looks like a pleasant enough helper.

Jonathan
