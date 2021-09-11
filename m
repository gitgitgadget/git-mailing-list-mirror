Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A3C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 23:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D2461059
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 23:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhILAA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhILAA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:00:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FDC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 16:59:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x7so5334513pfa.8
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wukr+IsUiNsCV6Yl8fLNtIxD8NV/99DUDGNa38gB20w=;
        b=Lvuz2lgg8WZ63Yq397q3o/KRcLTmbZTs3pWj4+V5Xnlu0g5NC8Fzam9kYL9WDhcdNz
         5vRdBuawWP195uR4GTM84nIBW0Xtu4BZT6PmJQVxOTG1rLIE9z/34KbNh6QdrsQgvEcK
         RcILKLRhTdTwB2YRcDmzS55qpYPVZ3hQ+VtJGI8RzwQsnf1K/Shg0GKEQydJ06gj9mmv
         cLj9iS29KZTFdzyepcwPRKaTd3L5F74HtwA4mNo6zBJgNzu+qphuGso7Il5LSsJYa9dX
         /hpRlRy/2mh78dHFl+0d8/BThzApRBJjc02Ty9EEl3H+KMntpBhqHJYgkiKGrnn/kAdz
         VjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wukr+IsUiNsCV6Yl8fLNtIxD8NV/99DUDGNa38gB20w=;
        b=6l8n7OlXstiT6DgoOYa3wolNj1UDl+uEZ5Ct8N55RlVVjGN2Y0dsXWcM5EZ2n52ZYD
         7nmPik+rbRI9WJJ+U1bxBa3NymdXzG51qqKYwzjK/xVJWF/8u3wMPBzEiSf1sUApU5zH
         LCDj1MEI4ZVapPr8IptitbCpseX4zaSqjTNjLTnLGb7vBwdC9vIdCwNog8JUkda0JeHE
         +VCEbFvoU+/cG6hLrvs2Wn38aCztNrSZejG0MKRttS2/TVkt4XqFSLnUz2M3CyoPZwLz
         1vtiLQ29AaF7xI9dTdQZ9wyVZm7RjiybtK1bg5lMEdPvoLpFhMv3KDrk4n/mplPXBuId
         fFvw==
X-Gm-Message-State: AOAM533bK2GbHmQwp9OB9i4TWCbB60fHvD+KTrOCyvOdXo5s8fqL+rkF
        Y/8JAU7Ge6yQ44+ZPQfQ1jU=
X-Google-Smtp-Source: ABdhPJwQcED+VWAeBVffNydbkmf/Dzg6hacntk4cLCxKYdORweEWMtsGZXw8Z53Q3IL5/alu+Wa9eQ==
X-Received: by 2002:a05:6a00:10ca:b0:3fe:3a9b:2100 with SMTP id d10-20020a056a0010ca00b003fe3a9b2100mr4447738pfu.59.1631404782986;
        Sat, 11 Sep 2021 16:59:42 -0700 (PDT)
Received: from Derricks-MacBook-Pro.local ([2600:6c5e:517f:f73e:c13a:5a43:8d62:620f])
        by smtp.gmail.com with ESMTPSA id o2sm3044886pgc.47.2021.09.11.16.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 16:59:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] packfile: use oidset for bad objects
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9cdf54db-132e-d771-e177-6673f7ad02bf@gmail.com>
Date:   Sat, 11 Sep 2021 19:59:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/21 4:31 PM, René Scharfe wrote:
> Replace the custom hash array for remembering corrupt pack entries with
> an oidset.  This shortens and simplifies the code.
> 
> Changes since v1:
> - inline oidset_size()
> - inline nth_midxed_pack_entry() early
> - use oidset_size() to avoid a function call if no bad objects exist
> 
>   oidset: make oidset_size() an inline function
>   midx: inline nth_midxed_pack_entry()
>   packfile: convert mark_bad_packed_object() to object_id
>   packfile: convert has_packed_and_bad() to object_id
>   packfile: use oidset for bad objects

These were easy reads, and I understand the value of them.

I initially hesitated to support the drop of
nth_midxed_pack_entry(), since it was designed with things
like midx bitmaps in mind (specifically, to also support
lex-order-to-stable-order conversions). However, it seems
that the midx bitmap series by Taylor is succeeding without
needing such a translation.

Thanks,
-Stolee
