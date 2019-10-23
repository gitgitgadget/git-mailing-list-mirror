Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910E51F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 00:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbfJWAgB (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 20:36:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39351 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJWAgA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 20:36:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id t8so12211437qtc.6
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 17:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FATMUDzf/bbG4kQ+u1b91aWMBUHadXvTaRkBqWZoN8o=;
        b=Kpogy1t+0rkPZBvnCWkWIbG/8gsWKXQxwYC01EbId/q2MdHFl7/f7egl1+HRcHlNsA
         B/UsQ0Dp4UTfuoKlZKcTwu20b2fGf1bZDYtc9BKUkCy37ixspbm36RPkySy6/BtRQjuX
         /LjSFbQxwYonANnB+G0hFMzrPJ++btNS8b8qFTUpfhdFrkYhozSB4Fru3wx7Z3jTaVMa
         gSgJoEL+BidQ4CY2AvrTLrpa6PMAFZ8G5IZk8A1gHjlvPGCQEpni1sOFDTX8Cij90qay
         vNKH1q/3R4Y/UVJzeT4EAYFixZ3KiPZmqFa6Ta7/ZdGImy6qkXy/DOOFvhVPpPCBBs70
         TgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FATMUDzf/bbG4kQ+u1b91aWMBUHadXvTaRkBqWZoN8o=;
        b=rBwV0BR48rK1gRQxI/zQkVfqONtzBSoxxR3g4IFw+c0bUyZGE/OTGk4i1IyCER0aIc
         COeV2nCYK1DnZhFDz07MUVQl242B4kIl9CCEuroMXygHc7OjlH1Vy4wh/bUoxVFqJVg8
         ak5Pof9WZamI2q7XkbGlK5658DB+bdLQn2w15erbGiF1XeruUoQJNB0UZ3GUJJl72Sl/
         ciqKjMJXxbKl+TmpXlhG/sk3mrOYc+7IkTCNXEjs7EGs5ZqlR8N0QeIEEYijvTaVA9pF
         82O9H4J9y0qO1V2Uo/EHJjKYTPVdv/NJSGHhJZr583eUuM0cL/IOT9hEV3U5a50mZhKo
         pNIQ==
X-Gm-Message-State: APjAAAVyiKEduA3eh8DXu+vG9EJSaO2fzYF1mpCeZEJrtjUlOxket+FH
        QYULF0TL0t+X+iMmEVKpaUk=
X-Google-Smtp-Source: APXvYqyolgb7RZXZlLQNlw0Vh5cUWboPwOXiOhJHUDWCIP/g+ZOEIz0wonzDSZaIc2SfUV79iUAgSQ==
X-Received: by 2002:ac8:92a:: with SMTP id t39mr6559178qth.170.1571790959304;
        Tue, 22 Oct 2019 17:35:59 -0700 (PDT)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id o13sm4632670qto.96.2019.10.22.17.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 17:35:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit-graph: fix writing first commit-graph during
 fetch
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <a1e5280d4b61a972426063574f1ea890a7dab73b.1571765336.git.gitgitgadget@gmail.com>
 <20191022203316.GC12270@sigill.intra.peff.net>
 <20191022214553.GA18314@sigill.intra.peff.net>
 <20191022233556.GF4348@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b7473363-b257-c00b-7338-a7e1d51bb01b@gmail.com>
Date:   Tue, 22 Oct 2019 20:35:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191022233556.GF4348@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/22/2019 7:35 PM, SZEDER Gábor wrote:
> On Tue, Oct 22, 2019 at 05:45:54PM -0400, Jeff King wrote:
>> Puzzling...
> 
> Submodules?
> 
>   $ cd ~/src/git/
>   $ git quotelog 86cfd61e6b
>   86cfd61e6b (sha1dc: optionally use sha1collisiondetection as a submodule, 2017-07-01)
>   $ git init --bare good.git
>   Initialized empty Git repository in /home/szeder/src/git/good.git/
>   $ git push -q good.git 86cfd61e6b^:refs/heads/master
>   $ git clone good.git good-clone
>   Cloning into 'good-clone'...
>   done.
>   $ git -c fetch.writeCommitGraph -C good-clone fetch origin
>   Computing commit graph generation numbers: 100% (46958/46958), done.
>   $ git init --bare bad.git
>   Initialized empty Git repository in /home/szeder/src/git/bad.git/
>   $ git push -q bad.git 86cfd61e6b:refs/heads/master
>   $ git clone bad.git bad-clone
>   Cloning into 'bad-clone'...
>   done.
>   $ git -c fetch.writeCommitGraph -C bad-clone fetch origin
>   Computing commit graph generation numbers: 100% (1/1), done.
>   BUG: commit-graph.c:886: missing parent 9936c1b52a39fa14fca04f937df3e75f7498ac66 for commit 86cfd61e6bc12745751c43b4f69886b290cd85cb
>   Aborted
> 
> In the cover letter Derrick mentioned that he used
> https://github.com/derrickstolee/numbers for testing, and that repo
> has a submodule as well.

I completely forgot that I put a submodule in that repo. It makes sense
that the Git repo also has one. Thanks for the test! I'll get it into
the test suite tomorrow.

-Stolee
