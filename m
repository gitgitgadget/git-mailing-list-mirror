Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8DBC77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 10:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbjDZKrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 06:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbjDZKqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 06:46:31 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF0759E8
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 03:45:28 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9582901279so10395235276.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682505927; x=1685097927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fum2h4vOCuM0yfrU03CSUyK0uQDnmPhMoeasshxE19A=;
        b=GIQSTjNP69AUHNOVIparradpMfy+Q3UxXJeuBh+iKz2BUvS4oV4QsQ3z8TRyr23O1F
         mNJ01GNE5ZJacNDbsuw26QcDxAUCOi0sTrC+eOy3ynaQlPe8U6WCTqKI892uDgypxLlY
         nvJ7KGjehayj1IdsUByqbXyM7d231kmK1UHLTrunVdf96Hk23PoVz4QtWxyp2lneZuAa
         5SyLUF5wv/UJC5icpTdOhd1MDGICx6M1728FwRuq7XVbXYolF8eEIyyk77n3OvKBRfI0
         9X9zut3d9mQs1wO8qIdygfctYep5dma1kdUeyd7a3kIzhU0hqN8u33dUlXAkx1bdRhlK
         Q7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682505927; x=1685097927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fum2h4vOCuM0yfrU03CSUyK0uQDnmPhMoeasshxE19A=;
        b=lQw4/CaK+YFN4iswsq0tmo2QPWQC1BQHmrg7XT0W5lcCUmyHIMaiAzvbIdsftoeNds
         kCVMLtOSjtCkqdYGst3Qk1DlqWf/Le1Q+yUZUR2l1TLkXkGgxlIvwyfO9vnBRpAcuLbu
         XV2F+1eoaZdFv1P33pfaiWIfGbI5UFfp4yZJnAGaMwZybyPLSmS0rdVIY0WXQW2xlHW3
         fRmQofHtlX+HsjHxLjtbkaQISO1Bt84rzLtRGWjqtsezkAkVXJVwhxyPPmdAEqY8CvKR
         bgT6QlT94JxFm+EmQpLhhz7VdKE3dZdmnmyOHWxR4pLotYIA6NlowDP8bpvn/bSaE/EF
         xS1w==
X-Gm-Message-State: AC+VfDyZxrHezHpXqHDAiAUXEBefxFLy+CYyDUQRm1llacl86OpTsbj6
        BiG4BdTO+K9ACd9m4afo7phz
X-Google-Smtp-Source: ACHHUZ4fs0/m5kObbEoQzo++4Ep+u4lSMXioK+sPdJQMmLLkJipvw3WVsBiO4dUICd6K3EijhkZv8Q==
X-Received: by 2002:a81:8287:0:b0:556:9f48:cbe7 with SMTP id s129-20020a818287000000b005569f48cbe7mr8679878ywf.3.1682505927317;
        Wed, 26 Apr 2023 03:45:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8842:abce:33e9:20d2? ([2600:1700:e72:80a0:8842:abce:33e9:20d2])
        by smtp.gmail.com with ESMTPSA id c205-20020a814ed6000000b00545a0818483sm4114720ywb.19.2023.04.26.03.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 03:45:26 -0700 (PDT)
Message-ID: <86188f31-f492-d195-d4d5-b0582906621a@github.com>
Date:   Wed, 26 Apr 2023 06:45:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Commit graph not using minimal number of columns
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Javier Mora <cousteaulecommandant@gmail.com>
Cc:     git@vger.kernel.org
References: <CAH1-q0hReZoDWmXo7St10Dk6uc+6ZUQSxqvu1cJ7w3r7ftR9PQ@mail.gmail.com>
 <xmqq8refy114.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq8refy114.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2023 7:50 PM, Junio C Hamano wrote:
> Javier Mora <cousteaulecommandant@gmail.com> writes:
> 
>> git log --all --decorate --oneline --graph
>> # ^ displays a complete mess that doesn't resemble two tracks

That mess is this:

*   ac6812d (HEAD -> fork) Merge branch 'main' (early part) into fork
|\  
* \   92dbe19 Merge branch 'main' into fork
|\ \  
* \ \   c372f7b Merge branch 'main' into fork
|\ \ \  
* \ \ \   48cae29 Merge branch 'main' into fork
|\ \ \ \  
* \ \ \ \   1bd2ff0 Merge branch 'main' into fork
|\ \ \ \ \  
* \ \ \ \ \   a5ab648 Merge branch 'main' into fork
|\ \ \ \ \ \  
* | | | | | | 362d201 Introduced feature Z
| | | | | | | * d46dfcc (main) Add H
| | | | | | |/  
| | | | | | * ac40305 Add G
| | | | | |/  
| | | | | * 867e17a Add F
| | | | |/  
| | | | * 23b1d2b Add E
| | | |/  
| | | * 8c36fda Add D
| | |/  
| | * cae1373 Add C
| |/  
| * 808c738 Add B
|/  
* 20b84d5 First commit

This width is necessary to avoid crossing lines _given the order
of the commits_, which is picked independently of the graph
rendering.

> "git log --all --oneline --graph --date-order"?

Here is that output, breaking topological ties with the commit
date order:

*   ac6812d (HEAD -> fork) Merge branch 'main' (early part) into fork
|\  
| | * d46dfcc (main) Add H
| |/  
| * ac40305 Add G
* | 92dbe19 Merge branch 'main' into fork
|\| 
* |   c372f7b Merge branch 'main' into fork
|\ \  
| | * 867e17a Add F
| |/  
* |   48cae29 Merge branch 'main' into fork
|\ \  
| | * 23b1d2b Add E
| |/  
* |   1bd2ff0 Merge branch 'main' into fork
|\ \  
| | * 8c36fda Add D
| |/  
* |   a5ab648 Merge branch 'main' into fork
|\ \  
| | * cae1373 Add C
| |/  
* | 362d201 Introduced feature Z
| * 808c738 Add B
|/  
* 20b84d5 First commit

But really, the key issue is that both branches are being used
as tips. This means that in --topo-order (implied by --graph),
every commit reachable from 'fork' but not 'main' must be shown
before the first commit of 'main'.

If we only use 'fork' as a starting point, then the --topo-order
is the best of all the options:

*   ac6812d (HEAD -> fork) Merge branch 'main' (early part) into fork
|\  
| * ac40305 Add G
* | 92dbe19 Merge branch 'main' into fork
|\| 
| * 867e17a Add F
* | c372f7b Merge branch 'main' into fork
|\| 
| * 23b1d2b Add E
* | 48cae29 Merge branch 'main' into fork
|\| 
| * 8c36fda Add D
* | 1bd2ff0 Merge branch 'main' into fork
|\| 
| * cae1373 Add C
* | a5ab648 Merge branch 'main' into fork
|\| 
| * 808c738 Add B
* | 362d201 Introduced feature Z
|/  
* 20b84d5 First commit

I don't think there is anything actionable to do here, as
these commit-ordering options are well-defined and should not
be altered. If there was an algorithm to modify the commit
order in such a way that minimized the graph output, that
would be interesting, but the cases it minimizes are probably
too rare to be worth the effort.

Thanks,
-Stolee
