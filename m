Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6EB211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 12:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLDMHn (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 07:07:43 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:44855 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDMHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 07:07:43 -0500
Received: by mail-qt1-f179.google.com with SMTP id n32so17642491qte.11
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 04:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=g0M78HZqVN7sMbQBrrDsNg2byO/HdUuGniU/+3YjeOc=;
        b=iJxnSsYVlWJLT/vniIyH0aQIRJi5zvAaR/z+qCfdLYl8vuAUOJMXV7z03q2zBfUjHD
         YTWiaHS+ayaflUChLFW4lZchNBUf6gSz9EB+SKKFWMOXYUY1Alvrsns3wjDnU2loRVCk
         Xjt/Gbez1eO8iPBBgzz9swQ7c2WCgfwotD17ZwXkKdpqT/IR54FxGeDo3rsvqgR4H62z
         OkUQXkQSeQbhK8wUowfYNWWfcYNPZiBI74xbers/+YDprm49Gw1RIllHplc4rtt2OOvu
         e0Gkm/je/m4jL4FSLuyBHCU2XsiufapjZ1IrinGowOcqSf2Xvznz3MTK8ueKTmgIqACF
         V6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g0M78HZqVN7sMbQBrrDsNg2byO/HdUuGniU/+3YjeOc=;
        b=CCk4S+F26HkXlqtYsjC2JQhA+9mqjMd2MW+HDGwDke0SOjoX1xXtXjw2jprifTXU1F
         jnn0CV4fCFpRFBvKkiWgJwryNHHuthd7EtTKgJGvRIYjcIfkQtw56xgk+tUPxuYzhpR4
         zWlKipNfcWpowowQNzhZMUdcsTqaPAk956UAWD3O0ltcHWOWgDW542b1ivcn2u/67zC+
         shRhQcVbcskAncDX32CJdr4zcVuSrxIXtFUW/AKROKfdhZj7AiDJtS0gg6TsO2Z8QBWT
         NwS7tgKc8vOp1DxpQqMwJztK+eNb90HOJ/pa0RwYp9zpNWU3vpchkhVhMj2Zvy2WxJeU
         hXpA==
X-Gm-Message-State: AA+aEWaxMAMNeZVEktVrCSoBpStRre10oAdJd4ZloZmY/Z4sPvMfN8MD
        d5fzZW+ZbkZcdaK5hAh+JfqWxc69
X-Google-Smtp-Source: AFSGD/W7YnV0P1dvy3im0FCGhCc2oVFPxQP5gDifha8fKSMra12gh1RwpoCchpbNPhA7/tJSUhHD3A==
X-Received: by 2002:aed:3ff3:: with SMTP id w48mr18726816qth.214.1543925260879;
        Tue, 04 Dec 2018 04:07:40 -0800 (PST)
Received: from [10.0.1.11] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id x49sm11642079qta.89.2018.12.04.04.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 04:07:40 -0800 (PST)
Subject: Re: How de-duplicate similar repositories with alternates
To:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, git-users@googlegroups.com,
        Christian Couder <christian.couder@gmail.com>
References: <87zhtsx73l.fsf@evledraar.gmail.com>
 <CAGZ79ka1sjU+rHctRP4SVMP0GQsK2iZghkU46=f96ugqvX5Neg@mail.gmail.com>
 <20181204070602.GB11010@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5f2f5c9f-c27b-2577-ca4d-375c92ab9186@gmail.com>
Date:   Tue, 4 Dec 2018 07:07:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181204070602.GB11010@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2018 2:06 AM, Jeff King wrote:
> On Thu, Nov 29, 2018 at 10:55:49AM -0800, Stefan Beller wrote:
>
>> I view alternates as a historic artefact as the deduping
>> of objects client side can be done using worktrees, and on the
>> serverside - I think - most of the git hosters use namespaces
>> and put a fork network into the same repository and use pack islands.
> By contrast, object storage is pretty easy to share. It scales
> reasonably well, and the security model is much simpler due to the
> immutable nature of object names.

And for the client side, we use alternates as an important way to scale 
VFS for Git to multiple enlistments on the same machine. VFS for Git 
manages a "shared object cache" (the alternate) that is updated in the 
background (including multi-pack-index and commit-graph).

Using worktrees for the same effect would add complications to the user 
interactions, not only when creating an enlistment but the fact that two 
enlistments cannot check out the same ref will confuse users.

Thanks,
-Stolee
