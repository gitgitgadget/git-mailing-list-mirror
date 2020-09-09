Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E1DC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 12:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76052074B
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 12:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYwqQ6WD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgIIMmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbgIIMkk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 08:40:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D69C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 05:40:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g3so1713600qtq.10
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sxlNHeoL/UUQtAVp/y5RqhwiQ4sZ90H2jcHq1WzxOTg=;
        b=DYwqQ6WDFl0SNr57YYCEBzBmmv41wkKV2QkP5TO7tJniu8yFO7W2dHjz101eqXAsom
         eQllJ+z7uRZa8JyNBKdeROX7ALHaVDx1eX6QA0gamJzRz7RwXG8SYKzhjI2Go5AyLc8v
         Hkac8DNVUz+VzyosaoeVcAIUBucI7I0hHoOvHQs59PvbtOpaqZ90sI/LcDqKtnLb6Rdp
         iBV98RF3kqv13Z1QIqaRYrX2l5DsF6eG1as5pUBNPDyBFI8rjVjCOv6P1Um6iipHbhGD
         /TjNatjFKJKbuVtEbvsx54wwqAKCbbQev1eoC3vEVn8guQGi9OMIztkYPRjICQcBRpxQ
         90BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sxlNHeoL/UUQtAVp/y5RqhwiQ4sZ90H2jcHq1WzxOTg=;
        b=WTTxu7YHvASjsn56erA+gq6ty2gthFhHyfIyH9aoAOXcstQ1Vrtx/Ip1eOYOHGIsPE
         UpTmu6mciy8Rd8OIXtnE75CaWd6JV4TYRlEzebjAaNUoq3uOOcxDZRoEJ6cZg9gdNyPj
         IPydJ+0Kskjqv1xfmTI9D/cChW/0sR7HjNsPUbu3I5bkBgr8wfrTYrs2y2mCFsInJiBT
         H/kr84nXLJp4ehd3ydlQLBM2DyQCDDV3+Sen4sXb3X4lozoTMm/NaQzLjU7mtuylPal8
         L4VShyk5aO2Y448mGpiMN8NnpPVXblIWz6EueyUugaCPO2knxja8tu7aMvQzq4maPTOc
         7XxA==
X-Gm-Message-State: AOAM533kMtyxrTkSml4l3uk86u7GsYmnw5HdPx4yXbnLxkmUn5UgLw2t
        fHskc/vuq4VYCApVm+WLXbI=
X-Google-Smtp-Source: ABdhPJwxLN4YqEO/VUMNUXG0LFuNALfo2ra5rpK07gWC2wR3jleCkwrqA4gAjk6xJHdhs47wMeU+Mw==
X-Received: by 2002:ac8:12c4:: with SMTP id b4mr3033704qtj.224.1599655197491;
        Wed, 09 Sep 2020 05:39:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:84a2:b0cb:7621:10c7? ([2600:1700:e72:80a0:84a2:b0cb:7621:10c7])
        by smtp.gmail.com with ESMTPSA id 8sm2420310qkc.100.2020.09.09.05.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:39:56 -0700 (PDT)
Subject: Re: [PATCH v2] blame.c: replace instance of !oidcmp for oideq
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        dstolee@microsoft.com, git@vger.kernel.org, peff@peff.net
References: <20200908211053.807194-1-eantoranz@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6b84f112-7e3f-3a78-3766-033fcf494464@gmail.com>
Date:   Wed, 9 Sep 2020 08:39:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200908211053.807194-1-eantoranz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2020 5:10 PM, Edmundo Carmona Antoranz wrote:
> 0906ac2b54b introduced a call to oidcmp() that should be
> replaced by oideq() (the latter introduced in 14438c4).

Short-OIDs on their own are not enough. Please use the
format "abbreviated hash (subject, date)" as mentioned
in my earlier reply:

0906ac2b (blame: use changed-path Bloom filters, 2020-04-16)

14438c4 (introduce hasheq() and oideq(), 2018-08-28)

See Documentation/SubmittingPatches [1] for more information
on this.

[1] https://github.com/git/git/blob/3a238e539bcdfe3f9eb5010fd218640c1b499f7a/Documentation/SubmittingPatches#L144-L165

Thanks,
-Stolee
