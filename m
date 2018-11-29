Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134E4211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 04:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeK2PJ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 10:09:56 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42535 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeK2PJz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 10:09:55 -0500
Received: by mail-yw1-f68.google.com with SMTP id x2so224353ywc.9
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 20:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3WqlFDkyA5H8b1lH1D3mdrZZncUqfa1GbVRTq63z9QA=;
        b=b5xSMhAyoKEaM9uvgzyxoGocHyltefRLgjBfWd8eAOiFXfyf5178tKUsWMoVHDX0zc
         wky1lJylrRAjzFIv6bTXtQ30d676gv6IFIMUi1Hxq14LTRTHLtdeqF7Sgljr39G6JgLA
         8xLPbSaF1nYGANm9Zuthu2T2cfqsltqDQu3Ewj331SSu9HvobmhC7LS73EkZoME6lOjF
         4XypqxANdc6bqaPeeFQ43PlakqBRrnJL658r7elYvwIKenN2N5LQJ8JPIfUDYQY/NQeH
         +CR5SQa9AGSKFA9tNR5pi4n31jLLEcgq0hWFiqUYZH+gdyWke9S1xqJVVmKcaB2vESsd
         Zlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3WqlFDkyA5H8b1lH1D3mdrZZncUqfa1GbVRTq63z9QA=;
        b=scM79O5iyZM9iM5lRLXgL/0NX76c7MSA3u/bE0G1iA5Q4KgAKmX9H0xuRI3ht0DoJh
         HkHIFzwmO75vWOYWHqBgo6l5Z3TOTdjkJIbHuznk16UVn/2MeprLOMAaVugefG48nCCH
         qd7tXna+60vSuSUTLb7/U/FyzZ6Co1725Q7pBIS1JuIur26RVMg/axHLHKN30E1WCSbZ
         HezkDziean35rxm6iiCvSQuJgANmlykBBVDMpfXCY0ivPnyCuJ0AnZrZ/Hym/noDvSz1
         jZTtjg9Rjd49cdxx3wSjWdJYlzSGVTkhEP88dfpRdAWoh5G95JDo7BBbJWW7xKrDme78
         LCDQ==
X-Gm-Message-State: AA+aEWaIC/GIT1vYiTPYVmxzmUa55g9pcbJm/NUnsO7vYy5j2E2ignJU
        xvneHdOGGlyfsZTmSwn3uMA=
X-Google-Smtp-Source: AFSGD/VEuFqawfpAbHXut2gfZ0vEMv0iL6pGigPp6QqKTug4n2B6tKCD+ZecyySg51g797moTiie4A==
X-Received: by 2002:a81:b342:: with SMTP id r63mr40222777ywh.475.1543464357988;
        Wed, 28 Nov 2018 20:05:57 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id a71sm173949ywe.66.2018.11.28.20.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 20:05:57 -0800 (PST)
Subject: Re: [PATCH 0/5] Add a new "sparse" tree walk algorithm
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.89.git.gitgitgadget@gmail.com>
 <874lc0zw0p.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d739ad00-d4f7-2a1b-7e03-3b69d74bdb5f@gmail.com>
Date:   Wed, 28 Nov 2018 23:05:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <874lc0zw0p.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2018 5:18 PM, Ævar Arnfjörð Bjarmason wrote:
> This is really interesting. I tested this with:
>
>      diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>      index 124b1bafc4..5c7615f06c 100644
>      --- a/builtin/pack-objects.c
>      +++ b/builtin/pack-objects.c
>      @@ -3143 +3143 @@ static void get_object_list(int ac, const char **av)
>      -       mark_edges_uninteresting(&revs, show_edge, sparse);
>      +       mark_edges_uninteresting(&revs, show_edge, 1);
>
> To emulate having a GIT_TEST_* mode for this, which seems like a good
> idea since it turned up a lot of segfaults in pack-objects. I wasn't
> able to get a backtrace for that since it always happens indirectly, and
> I didn't dig enough to see how to manually invoke it the right way.

Thanks for double-checking this. I had run a similar test in my 
prototype implementation, but over-simplified some code when rewriting 
it for submission (and then forgot to re-run that test).

Specifically, these null checks are important:

diff --git a/list-objects.c b/list-objects.c
index 9bb93d1640..7e864b4db8 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -232,6 +232,10 @@ static void add_edge_parents(struct commit *commit,
         for (parents = commit->parents; parents; parents = parents->next) {
                 struct commit *parent = parents->item;
                 struct tree *tree = get_commit_tree(parent);
+
+               if (!tree)
+                       continue;
+
                 oidset_insert(set, &tree->object.oid);

                 if (!(parent->object.flags & UNINTERESTING))
@@ -261,6 +265,8 @@ void mark_edges_uninteresting(struct rev_info *revs,

                 if (sparse) {
                         struct tree *tree = get_commit_tree(commit);
+                       if (!tree)
+                               continue;

                         if (commit->object.flags & UNINTERESTING)
                                 tree->object.flags |= UNINTERESTING;

I will definitely include a GIT_TEST_* variable in v2.

Thanks,

-Stolee

