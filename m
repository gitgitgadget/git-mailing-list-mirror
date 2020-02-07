Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20533C04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CD8217BA
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 13:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGqd4eYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGNzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:55:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35695 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGNzY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 08:55:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id n17so1884282qtv.2
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 05:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cmmAi20BaW1CJWx8eqlP+NxpGGx9IES97kmSoX6SKnw=;
        b=HGqd4eYau5g8LqDplqUR3m6C0znF1cNnW4y7yBA/K93D2zjOAuLFsZcVYhkIYVdT+U
         RIzVIVhkOetXHIDsMJDg+v8kRCvdXXyyRIgbSnzcUIJEepT4IWaYVq1/jVDTwNKB6pKP
         kZ957vdU8M56zSE3cBtKME6iaB9ugY9H50lXIi76JzqFG1GskxRJCQIKKvddmuDGrI3l
         jongVoP9MMVLS8rgHzUMw61mRl71iir+VC4fw4jfonOFiS/vVtseZncQ6m+0g1pn+DDq
         5Xvuc0cqidn9+M6aJ/BqZAjetv2R+5jwg+Bpg0rMpUKuRk2fOlYAct3JpP6E0CCy1i37
         KQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmmAi20BaW1CJWx8eqlP+NxpGGx9IES97kmSoX6SKnw=;
        b=pj0o8bo8x9iXEpcw8JE7+4o/m9vLKgwkq5nyUMz9Ei1kCESYAfv1zP62me3O0WWYWN
         KiGojK8LTecwyDvlyFz+sxGplFziyya+81pRANFbnpGNo1+boObzVyDaqcaOFQjeIDgi
         n+XK9SK3HcMob95P5DhCQtZOV2XYFkfcwsTdMhnGL6aHtJ8uSYBonY4Tbqj7dY5A3Ez3
         YwH1BbgCR82LdA7OYqelDt/fVltTF7Vh1GzfU7FBasdRH+ujSuaGN5qDI7G022hQBiAW
         zfFqkSict+umo5bSg8E0hwWPJKrBmRkYJUz3Oa25YGgImncoqYjbS/wj+tVG0qylev2u
         8k4A==
X-Gm-Message-State: APjAAAWiEIo6xL8PJbVbBFPjYRHCkx2VMdH5VUlhDNo57/IbPQy+amdG
        uvWXxN39bkcqQDIivT3WSMrLBjHwZBY=
X-Google-Smtp-Source: APXvYqwU02IWMuE6RDfnioS37eiSKNvj5osddMxhJVNcFyTNxyUJr+66quGAf039ig1MELqyPAlp+Q==
X-Received: by 2002:ac8:5298:: with SMTP id s24mr7366339qtn.54.1581083722757;
        Fri, 07 Feb 2020 05:55:22 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:439:e50b:6e3c:1277? ([2001:4898:a800:1012:b56c:e50b:6e3c:1277])
        by smtp.gmail.com with ESMTPSA id g53sm1419857qtk.76.2020.02.07.05.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 05:55:14 -0800 (PST)
Subject: Re: [PATCH] submodule: add newline on invalid submodule error
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200207004833.255965-1-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aacd5724-fdb6-832c-4af9-22c1831baea2@gmail.com>
Date:   Fri, 7 Feb 2020 08:55:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200207004833.255965-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/6/2020 7:48 PM, Emily Shaffer wrote:
> Since 'err' contains output for multiple submodules and is printed all
> at once by fetch_populated_submodules(), errors for each submodule
> should be newline separated for readability. The same strbuf is added to
> with a newline in the other half of the conditional where this error is
> detected, so make the two consistent.

A worthy goal, and thanks for pointing out that this matches the
"Fetching submodule %s%s\n" string in the other block.

> -					    _("Could not access submodule '%s'"),
> +					    _("Could not access submodule '%s'\n"),

My initial thought was that this `\n` should be added in front of the
string, and only if the string has existing data. However, that's not
what happens in the other block, so doing it that way would require
changing both places. This approach is also less error-prone, even if
it may result in an "extra" newline at the end of all the messages.

LGTM.

Thanks,
-Stolee

