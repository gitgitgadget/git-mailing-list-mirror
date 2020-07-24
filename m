Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A43C433E8
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 14:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E69206C1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 14:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bay0Qw/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGXOuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgGXOuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 10:50:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EF7C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 07:50:15 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so7114770qkn.4
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yvAzMtAe6QRdu7opsaGdLTtWjE1cej0CIcKDoVVTB6g=;
        b=Bay0Qw/MAGUarfPxN+DeM3bCNfCRpyhZ1gnU0OgRgQWss0s8HdT/cTEcelALUvhG/V
         HdhNbv1F7N3y8i8gLoU1j5r40ja2u4Dam5qdUf6vyBJoHLLy4trIq8ixPMiGs4JjU+pF
         vhkVyFqfWznQxnI7V5+KyNkNhFKe9xfIY2cO4oAfea0RwknoaBu63Q4mygoA8zqdlUXc
         QEyToNa3nZnO56/w36pL9Q3uqeBkrcLbj743E2NgeNHew3OeYvsqv0egOKE9XrWBUrvk
         qvfaWl6IoeaHBo7VgNmcysYNbT6FYxdE3WwgOko369XGdJ6QNCEthOQLJDPG/LQNxhwF
         NEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yvAzMtAe6QRdu7opsaGdLTtWjE1cej0CIcKDoVVTB6g=;
        b=GqJTfyZlIhOU2eSUrF/hw0CWyDixKMS3gxAlKRCWWqhq5FcrpvRyxLXfPhnfDZjTmU
         Xss/4g1YfvjC01f/N27iXrBRL17IPgUSf/PMUytdvmwsKOQT0KPPHQ7B4RTiUl2uoIT6
         UwxjaDZdwPDKmk124Bhu62bEcfOp4kQ7yuHL5WnVCid8W7cH9xJ+1v/s8EVI+AmzWYSo
         40XZb1zj70KM2ggKQvFnTdRP5OdCe0qh2CGsPteDjRn5XDx3QoVZIkBjgZ2Ud62yt18K
         ufJg7hqNCVvBD6fE4rjCYJ0qaZrlkkPLm+qiTZ7L0JUFQuBSpgBj1ZDlS9hy2Ydu28wz
         jUYQ==
X-Gm-Message-State: AOAM533Y0Lgz6tEWLkjOscz8aY5rBFToR54KV4q89LytRMftbdH642JZ
        S4W6IYA48ATYpYSYpDQAs8I=
X-Google-Smtp-Source: ABdhPJxljzHxxDcOnUHevem8xOhXG85IpXqWr/6V0giHi/OwB2OOC3TsbBr+T089pA42Hpp6DgaEjA==
X-Received: by 2002:a05:620a:9d0:: with SMTP id y16mr11088569qky.353.1595602214991;
        Fri, 24 Jul 2020 07:50:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dd66:75cb:8c22:1387? ([2600:1700:e72:80a0:dd66:75cb:8c22:1387])
        by smtp.gmail.com with ESMTPSA id k9sm1472762qtu.1.2020.07.24.07.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:50:13 -0700 (PDT)
Subject: Re: [PATCH v2 09/18] maintenance: add loose-objects task
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <83648f48655ba68126110018d81c1d2e2bcc7a6f.1595527000.git.gitgitgadget@gmail.com>
 <xmqqr1t2osm3.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b861244c-af0d-581f-b1c8-6c6cb667eed8@gmail.com>
Date:   Fri, 24 Jul 2020 10:50:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1t2osm3.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2020 4:59 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Create a 'loose-objects' task for the 'git maintenance run' command.
>> This helps clean up loose objects without disrupting concurrent Git
>> commands using the following sequence of events:
>>
>> 1. Run 'git prune-packed' to delete any loose objects that exist
>>    in a pack-file. Concurrent commands will prefer the packed
>>    version of the object to the loose version. (Of course, there
>>    are exceptions for commands that specifically care about the
>>    location of an object. These are rare for a user to run on
>>    purpose, and we hope a user that has selected background
>>    maintenance will not be trying to do foreground maintenance.)
> 
> OK.  That would make sense.
> 
>> 2. Run 'git pack-objects' on a batch of loose objects. These
>>    objects are grouped by scanning the loose object directories in
>>    lexicographic order until listing all loose objects -or-
>>    reaching 50,000 objects. This is more than enough if the loose
>>    objects are created only by a user doing normal development.
> 
> I haven't seen this in action, but my gut feeling is that this would
> result in horrible locality and deltification in the resulting
> packfile.  The order you feed the objects to pack-objects and the
> path hint you attach to each object matters quite a lot.
> 
> I do agree that it would be useful to have a task to deal with only
> loose objects without touching existing packfiles.  I just am not
> sure if 2. is a worthwhile thing to do.  A poorly constructed pack
> will also contaminate later packfiles made without "-f" option to
> "git repack".

There are several factors going on here:

 * In a partial clone, it is likely that we get loose objects only
   due to a command like "git log -p" that downloads blobs
   one-by-one. In such a case, this step coming in later and picking
   up those blobs _will_ find good deltas because they are present
   in the same batch.

 * (I know this case isn't important to core Git, but please indulge
   me) In a VFS for Git repo, the loose objects correspond to blobs
   that were faulted in by a virtual filesystem read. In this case,
   the blobs are usually from a single commit in history, so good
   deltas between the blobs don't actually exist!

 * My experience indicates that the packs created by the
   loose-objects task are rather small (when created daily). This
   means that they get selected by the incremental-repack task to
   repack into a new pack-file where deltas are recomputed with modest
   success. As mentioned in that task, we saw a significant compression
   factor using that step for users of the Windows OS repo, mostly due
   to recomputing tree deltas.

 * Some amount of "extra" space is expected with this incremental
   repacking scheme. The most space-efficient thing to do is a full
   repack along with a tree walk that detects the paths used for each
   blob, allowing better hints for delta compression. However, that
   operation is very _time_ consuming. The trade-off here is something
   I should make more explicit. In my experience, disk space is cheap
   but CPU time is expensive. Most repositories could probably do a
   daily repack without being a disruption to the user. These steps
   enable maintenance for repositories where a full repack is too
   disruptive.

I hope this adds some context. I would love if someone who knows more
about delta compression could challenge my assumptions. Sharing that
expertise can help create better maintenance strategies. Junio's
initial concern here is a good first step in that direction.

Thanks,
-Stolee
