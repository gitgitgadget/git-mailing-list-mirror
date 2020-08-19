Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFDC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB8620897
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BROmolVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHSPFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgHSPE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:04:57 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C673C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:04:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s23so17971168qtq.12
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=td34xuUpRT+XI3h2ujl/xe/oPFKfiIw6kdM1WZiDhfM=;
        b=BROmolVx5WDPpZkhNyuOOib57oQVRnxVeZ1v7oLiMAM6qpns0Ta5z7oea1pbpRJcHA
         g3iaXSchVO10moM7d4ga7JbvfnHy8EuIuJjC0Bf2knphpbB9xADb8s2P5lcQ/q+ODIBK
         3BmJicoVnxoV7bNHh1RuMFtnCV06M683FqgbqHTTGUyVh5LV8jI25fIz+E8NATqQbliE
         TUNUSJ0D3gv1eSyGhnYzWwUW1htT2fIm85RQ7EYR8boZpYP39fV/c6DxnPqdHMaj7dPB
         +qI+1Tunr+RajGugbV7nlFvDKs0SDguBaL/jP9DQtMud1Y7tLS6lUj4AlzXNF68CTjmd
         vmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=td34xuUpRT+XI3h2ujl/xe/oPFKfiIw6kdM1WZiDhfM=;
        b=ZpD8HHdXPshRXmKKj96HemF2YeHyqQc7joGnUH7TawYBOT/sL3QAU/cZOfd7E+jlHZ
         0CweLpqY8M8BxaclGxvpuqWoQ5JS52EHVjikHsdLpxdezlqFRBro/8xyth42U6JkRg2e
         2wZd9LDfoWLaF6L1VtfQC1mpePpQB2xmf1ovzItZWoXn5h77AKVGrAgYdBC3cjoKgwsL
         nJ20qBX11TdqmcDWBrmfGBpa6c+JNDD5C5Yosub74DwJIoDuSonb3IuEbREUYmPZt3eY
         BGedVuNagrqZeCGPFdifbovXDxYsIMtfIu1DHSOO1oI/XhcXgf0e32FV0UaT7COQbSuL
         kSTg==
X-Gm-Message-State: AOAM533uQpkwOezuClwnSSnS+5byYc3SFD3iZlBWggmVBMkKucDnfnCO
        bsPknZXACfUUMPYbKpvwsm+BPVpH3DrdDSB0
X-Google-Smtp-Source: ABdhPJwt4KoejL4kumQdoYFPGFBPn/Q5h6KPxxRGVbgRElSgWoYzG85gKsMLyEhlW7hJVltlv/EtoA==
X-Received: by 2002:ac8:7b51:: with SMTP id m17mr22431065qtu.80.1597849496568;
        Wed, 19 Aug 2020 08:04:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:641b:4ef3:c176:5ed3? ([2600:1700:e72:80a0:641b:4ef3:c176:5ed3])
        by smtp.gmail.com with ESMTPSA id n6sm22200065qkh.74.2020.08.19.08.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 08:04:55 -0700 (PDT)
Subject: Re: [PATCH v2 05/11] maintenance: add commit-graph task
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com
References: <50b457fd57aef4e9ac6a15549561936dc962ef36.1597760589.git.gitgitgadget@gmail.com>
 <20200818235126.2836309-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <66ae9121-80c9-4030-1119-a11eab8d392b@gmail.com>
Date:   Wed, 19 Aug 2020 11:04:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200818235126.2836309-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2020 7:51 PM, Jonathan Tan wrote:
>> By using 'git commit-graph verify --shallow' we can ensure that
>> the file we just wrote is valid. This is an extra safety precaution
>> that is faster than our 'write' subcommand. In the rare situation
>> that the newest layer of the commit-graph is corrupt, we can "fix"
>> the corruption by deleting the commit-graph-chain file and rewrite
>> the full commit-graph as a new one-layer commit graph. This does
>> not completely prevent _that_ file from being corrupt, but it does
>> recompute the commit-graph by parsing commits from the object
>> database. In our use of this step in Scalar and VFS for Git, we
>> have only seen this issue arise because our microsoft/git fork
>> reverted 43d3561 ("commit-graph write: don't die if the existing
>> graph is corrupt" 2019-03-25) for a while to keep commit-graph
>> writes very fast. We dropped the revert when updating to v2.23.0.
>> The verify still has potential for catching corrupt data across
>> the layer boundary: if the new file has commit X with parent Y
>> in an old file but the commit ID for Y in the old file had a
>> bitswap, then we will notice that in the 'verify' command.
> 
> I'm concerned about having this extra precaution, because it is never
> tested (neither here or in a future patch). When you saw this issue
> arise, was there ever an instance in which a valid set of commit graph
> files turned invalid after this maintenance step? (It seems from your
> description that the set was invalid to begin with, so the maintenance
> step did not fix it but also did not make it worse. And it does not make
> it worse, that seems not too bad to me.)

The cases we've seen this happen were root-caused to hardware
problems (disk or RAM), and the invalid data was present immediately
after the "git commit-graph write" command. Since implementing the
"verify" step after each write, we have not had any user reports of
problems with these files.

Are you suggesting one of these options?

 1. Remove this validation and rewrite entirely.

 2. Remove the rewrite and only delete the known-bad data.

 3. Insert a way to cause the verify to return failure mid-process,
    so that this function can be covered by tests.

Thanks,
-Stolee
