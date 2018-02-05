Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0AE1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 16:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeBEQHE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 11:07:04 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:38343 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeBEQHC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 11:07:02 -0500
Received: by mail-qt0-f171.google.com with SMTP id z10so40233621qti.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 08:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yP0qJpGHKBSMbIHvRu4Jo4sKsjbdi0c8XpJ8BZPkjEo=;
        b=GKTLw07r6qtdk9k2NZBZzeZyDtH51CXwt4+0V+wa3EGUq2Ok/3nL5J6iN9yOZm4Jkx
         DuH8h18xWCyvFvyRgqLHSWfMXscfKvK774uRLpptYI077r5PT2VKf/63YZjxEfn47ryv
         jD1RlfQcHgtqA3OtNKArs17fY4Xmslm8xw1YSrlYRgjG+Sn7hocQoH9vKR+XH/UtAIrN
         GmEvYoVE/q7ub3hCW3bdtyIRX2HhetVWG2v6b4u3T+XOvtWD9AIPtPpr+XdI0kkGEP2M
         GYABNF3vhr1u7siuC0Z2WxrAWPOsDGJhc14CY/aot8XY4xspLn/GwuJdvJk6BURI8mxB
         UrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yP0qJpGHKBSMbIHvRu4Jo4sKsjbdi0c8XpJ8BZPkjEo=;
        b=bQnRa6GIshGJdgl12w9VX9/mzBt+l+DBi+T5nsvWW1zy2z6fX8Xq1Px7HcEv3gK4Qf
         ihJfFBycSASRIQ9GhL1f63xHwxArs/Fc1m/zzMx9EglRBHwzTzX3aFga6cEsGMY+z1dV
         LYjqoyGnHn/D/kb0tQmHTh8aaXRRODiO6xs+owRC4mZcq+25YlVVMgvIAajAG6nUhvNV
         kVAIATHYBPXyV1w3/fyYsgWoh8k2FUWMPEuymXNzplQLBig1pSgnNfzV8RDaCkvQt8jx
         mPpX32lAZukJ5Mdq2vuKexueVD2LupN7b6mIvhwyhXWF9saoEi2ScXAHKF+LcXXVgoD7
         Mhkw==
X-Gm-Message-State: AKwxytfN5v02X7VME57oYE6XyyxhRdn+sl3vCfEugWuuX3fMW3+2YHGX
        hytC9jH3UBc/YmRexqwfAvY=
X-Google-Smtp-Source: AH8x225dtwUrE3jLKpCdxg4x4KbA3Ruu2Efy0z9INFPOppjKuZe1fH58XI4bLCE5s82MzNH6IGaCtQ==
X-Received: by 10.200.27.136 with SMTP id z8mr6770005qtj.58.1517846821223;
        Mon, 05 Feb 2018 08:07:01 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id d20sm5651139qte.88.2018.02.05.08.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 08:06:57 -0800 (PST)
Subject: Re: [PATCH v2 04/14] commit-graph: implement construct_commit_graph()
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-5-git-send-email-dstolee@microsoft.com>
 <20180202153212.29746-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b7f45961-35c8-6e13-646c-9574fb5d56da@gmail.com>
Date:   Mon, 5 Feb 2018 11:06:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202153212.29746-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/2/2018 10:32 AM, SZEDER Gábor wrote:
>> Teach Git to write a commit graph file by checking all packed objects
>> to see if they are commits, then store the file in the given pack
>> directory.
> I'm afraid that scanning all packed objects is a bit of a roundabout
> way to approach this.
>
> In my git repo, with 9 pack files at the moment, i.e. not that big a
> repo and not that many pack files:
>
>    $ time ./git commit-graph --write --update-head
>    4df41a3d1cc408b7ad34bea87b51ec4ccbf4b803
>
>    real    0m27.550s
>    user    0m27.113s
>    sys     0m0.376s
>
> In comparison, performing a good old revision walk to gather all the
> info that is written into the graph file:
>
>    $ time git log --all --topo-order --format='%H %T %P %cd' |wc -l
>    52954
>
>    real    0m0.903s
>    user    0m0.972s
>    sys     0m0.058s

Two reasons this is in here:

(1) It's easier to get the write implemented this way and add the 
reachable closure later (which I do).

(2) For GVFS, we want to add all commits that arrived in a "prefetch 
pack" to the graph even if we do not have a ref that points to the 
commit yet. We expect many commits to become reachable soon and having 
them in the graph saves a lot of time in merge-base calculations.

So, (1) is for patch simplicity, and (2) is why I want it to be an 
option in the final version. See the --stdin-packs argument later for a 
way to do this incrementally.

I expect almost all users to use the reachable closure method with 
--stdin-commits (and that's how I will integrate automatic updates with 
'fetch', 'repack', and 'gc' in a later patch).

>
>> +char* get_commit_graph_filename_hash(const char *pack_dir,
>> +				     struct object_id *hash)
>> +{
>> +	size_t len;
>> +	struct strbuf head_path = STRBUF_INIT;
>> +	strbuf_addstr(&head_path, pack_dir);
>> +	strbuf_addstr(&head_path, "/graph-");
>> +	strbuf_addstr(&head_path, oid_to_hex(hash));
>> +	strbuf_addstr(&head_path, ".graph");
> Nit: this is assembling the path of a graph file, not that of a
> graph-head, so the strbuf should be renamed accordingly.
>
>> +
>> +	return strbuf_detach(&head_path, &len);
>> +}

