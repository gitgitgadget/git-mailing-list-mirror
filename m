Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C94C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2EB206E3
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL9pU/G/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJBUIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBUIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 16:08:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB85C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 13:08:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m12so2627219otr.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GkVmMIelmC1EjhJdWdPRAD7JAcYIJ8rU8e08Xo5hDPE=;
        b=cL9pU/G/ddcEGZWkJ18V27fIte00/TyXPXlSv1T3uGR+28xRnWIM19vNuzKPIXh7DL
         pb7p9h/SoBfbm3LihNb7tNbAUZf9pyzO1wG4CspvQyv9En0MXchUzgCJu7rQVixToHBJ
         leKpwCz8cCtHxBznr+D+b4J8qYiEGb1CaKkgFwF1q8vcE+h04i8qSYaGSkvbJAAp9s3J
         SEIn6bDq0ZAdpCxaWCTw2i7lFEh2NXwd1U17vuS+K9w7idpX9lwKNTa8PilmUAFaxJOG
         vQJ4kYc4WxPLZPHGbzg1l76Cfv//gglsFu47YkS2CmbN+GPl+ztqSx0jcJU1tCHf/Fm/
         s2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GkVmMIelmC1EjhJdWdPRAD7JAcYIJ8rU8e08Xo5hDPE=;
        b=Lwah1/hRa6j/Vea3XaUXrZ432nniXkzEhq6uoqIK+HSSi6NwZPgISTfHRjyl8LL2Z6
         yMzuO15FCu2P6OUr2Tzzqh5GH+xbhABVG2eX50KCPyC2s5rTQL8UjApiNt9q49GvioDg
         RIcAHasAiGIawOl39rKTERujKauWcIiqbJJszOd+oTVBrru2pPlvATeASwuU41S0J8bu
         4oRmpzPSoMTy10dC7hJfadaJTjdzloSc+ff/VNJczqUzhM0ey5CdbE2CT+2bb7xXIptm
         eaWdALBEWypcUT6bznBMJrw+pPkatmg9jshuNXBfGpW4Qj4M6j/kkzWyVtzVTRr5f153
         cYDA==
X-Gm-Message-State: AOAM531Pmtz799v0uVy93BQG6Vdxp19TwXJ5S+G8FXv93h/kaoAkPmI+
        aa/QE890h9D2tkjQC5Mvk9E=
X-Google-Smtp-Source: ABdhPJw4yAJGrsv5UyH3HNfGRCTS8MvDh+4uDTSTideRVX1EyFwjfk6cF8QRBrqNAjzE5EvP2ptaYQ==
X-Received: by 2002:a05:6830:200a:: with SMTP id e10mr2821650otp.335.1601669295055;
        Fri, 02 Oct 2020 13:08:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bd7f:7189:ff7:ce98? ([2600:1700:e72:80a0:bd7f:7189:ff7:ce98])
        by smtp.gmail.com with UTF8SMTPSA id n186sm690654oob.11.2020.10.02.13.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:08:14 -0700 (PDT)
Subject: Re: [PATCH] commit-reach: fix in_merge_bases_many bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.739.git.1601650736489.gitgitgadget@gmail.com>
 <xmqqv9fs8nre.fsf@gitster.c.googlers.com>
 <c6b163dd-d5f4-73a8-43ac-22460d1079ec@gmail.com>
 <xmqqr1qg8kfa.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ac3ac80d-7f8e-6b16-03fa-1cd38b5d860b@gmail.com>
Date:   Fri, 2 Oct 2020 16:08:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1qg8kfa.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/2/2020 4:03 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> Thanks for double-checking. I also think that dropping the
>> "hide the error" patch is prudent.
> 
> Thanks again for a quick and straight-forward fix.  As I mentioned
> elsewhere in the thread, it appears that we invented duplicate API
> with parallel implementation in get_reachable_subset(), which seems
> to be a strict superset of in_merge_bases_many(), and that may be
> what led to an initial and incorrect "get_reachable_subset() is not
> broken the same way as in_merge_bases_many() so use it instead"
> response.  I haven't paid attention to the quality of implementation
> of get_reachable_subset() as much as in_merge_bases_many() (e.g. I
> know of an obvious way to optimize the latter) so far, but it would
> be wonderful if we can eventually rewrite in_merge_bases_many() as a
> very thin wrapper() around get_reachable_subset() without any
> downside.

I have self-assigned myself https://github.com/gitgitgadget/git/issues/740
which will investigate these duplicates and see what can be done.

I know that the initial refactoring focused on keeping the "public"
interface the same and just creating shims between different method
prototypes. In this case, it might be worth doing a full replacement
since in_merge_bases_many() has so few callers.

I'll be proactive to look for other cases that might be tricky for
new contributors to find the "right" way to do it.

Thanks,
-Stolee

