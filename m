Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA7AC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 00:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKDAbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 20:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKDAbw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 20:31:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB9E22532
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 17:31:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so1952378pjs.4
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 17:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8Uu9PactP36Z1xCA62AzetFv9Fq/ygYaD0qPiJ4O4A=;
        b=Ez6FD0iSbn+Rz90DevUHPDMddxx/tTCtFE881LbAGZJsLN+QIduP1dFYymz6K+yuPB
         /Jh7eQaQuIhb3yEkqFIhof9WyzSucko29u062stWEonBQYqp+jdSRXzonMKCbwD5lL5J
         8pFiRI8wHsGkF4aTxfPFNArbMIHYgsL9PjTmpsAuZ6FkFXZaYEUYtNOjHDHpzFHdfgTw
         iDeQ/vijnQxSfhyVXmWHlatYgr/WZKv6piBR15wGsFjNZtE1EPvjPnTgTF7R42V6e2D0
         26U3pkGraUpJm2Zvc5HloiSYOAOLGr+U7ZmX9iwiMbBV0nDOE6wPYsREEfBvW6SPOxl9
         8yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8Uu9PactP36Z1xCA62AzetFv9Fq/ygYaD0qPiJ4O4A=;
        b=q87O2+vqCxY8Tvh4lgICF5UlTRx8zWu6IhhwNORZWt8tGXtuaCTDsapqz95AdHClv5
         27F9lCf3/rt5rWoF9Lmeybr6nsifODugnedGCGXvWkYXRfiRu60HaXKPN2WisaGH5HZb
         tNNQ6+CIh+Uv8//qqFNv314dsOWhRuJL5nIddauzVnHFkq4tSjzhIPsod15FFKwV3lJf
         5LzaEVXNqf504XxW935cVbqLAQsuumwyhZiahKRygVBlnyTlhG3iMrMhP6Odh+lGWeHF
         n8DNcI1WSp/Sovj254mRrK2HWhEARrMxSLHOTpi2eWDFaPcO8y2n45w8hTiXwClslJKm
         sipg==
X-Gm-Message-State: ACrzQf2i23DXj+XH6O7hXFLEKfHAYd6HDXLooOQr74rhW0L8l0ixbWii
        XcgeK9V/WDczvIpwgnodhP08xXIc32E3
X-Google-Smtp-Source: AMsMyM6y3LBMz1gEqkJRgqLrsKTLo0shgQ2ixQ2dFh284FE6hCshZBFpXQw7ArQ3xww5xr+AEUKKuQ==
X-Received: by 2002:a17:903:26ce:b0:186:9029:fa22 with SMTP id jg14-20020a17090326ce00b001869029fa22mr31612352plb.140.1667521911595;
        Thu, 03 Nov 2022 17:31:51 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id r12-20020aa7988c000000b0056c681af185sm1350340pfl.87.2022.11.03.17.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 17:31:50 -0700 (PDT)
Message-ID: <123628cc-1410-aaa0-0151-2dff35bd1855@github.com>
Date:   Thu, 3 Nov 2022 17:31:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: rebase -i --update-refs can lead to deletion of branches
To:     "herr.kaste" <herr.kaste@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>, erik@cervined.in
References: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

herr.kaste wrote:
> Now, I should just have not used `--update-refs` in the first place but anyway
> I decide late that I rather don't want to update "master" etc. and it should
> probably not delete the local refs.
> 

Agreed, this doesn't seem like desired behavior - the opposite of "update
the ref" isn't "delete the ref". ;)

The reason it's happening is because, when '--update-refs' is used, the
rebase starts by constructing a list of 'update_ref_record's for each of the
refs that *could* be updated. Each item in that list contains the
corresponding ref's "before" commit OID (i.e., what it currently points to)
and initializes the "after" OID to null. When an 'update-ref' line is
encountered in the 'rebase-todo', the "after" OID is updated with the
newly-rebased value. However, if an 'update-ref' line is removed from the
'rebase-todo', the "after" value is never updated. Then, when the rebase
finishes and the ref state data is applied, all of the entries with null
"after" OIDs are deleted.

The three options for a fix I can think of are:

  1. initialize the "after" OID to the value of "before".
  2. don't update refs with a null "after" OID.
  3. initialize the "after" OID to the value of "before", don't update the
     ref if "before" == "after".

I think #3 is the best option, since it avoids the unnecessary updates of #1
and leaves a cleaner path to a 'delete-ref' option (like the one proposed
elsewhere in the thread [1]) than #2. I'll send a patch shortly. 

[1] https://lore.kernel.org/git/CA+JQ7M-GbBTHZZ9xOLR=FitWFpUnkfuep9kSfNPxuSbJbKteGw@mail.gmail.com/

Thanks for reporting!
- Victoria

