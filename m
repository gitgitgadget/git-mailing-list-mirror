Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75026C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 21:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48CCA206E6
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 21:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyeRKReM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgFCVXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCVXj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 17:23:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2613C08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 14:23:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so2579122pgm.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B/L07VcJ9X6V3ZIg4uVEZcn5+G0kfZ2FI9K8lQVA0Vo=;
        b=WyeRKReMyDGw8WK9dRO1SvikCllpdnFim6Bo8XRw3teVdJ8g7Kzrat0plk54vno+0W
         KDr1BgBblcUbm1VLTEGbY0cHjE4ym/9ijiHBFwT/pnVKucgsJG4XFBfU+y00OlHwKPtf
         Ot92+Dmy0N58xZiVf3VQ+eQU5dGuYb1khX07qSK74lMMHOjdh3GFOpPIhLlKQdblbexA
         nwGQsfpT+4EjmHRMFRskTLbjCqI0Jk0odHHP3/hxv5aHDszoD0d55TW+i8NcS9Z2Txqe
         2A5VQWmJ5e+vNrSsZiU7rTsOepEsuwYhB/epH8C3lZnCFsvKL1q8TbT2uGZ0rxQQ7Hk/
         Mgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B/L07VcJ9X6V3ZIg4uVEZcn5+G0kfZ2FI9K8lQVA0Vo=;
        b=sQaSJSMZjDjqiOrTvfF6Ahbwd9t14VeR1IvMPertI/14wxRdgE7cHW/AVv9o9zNrWU
         p3erElhncAbapMz0il5mnrgryRuMGwUUdOgF4g5k9XCI51pfaSzke0b+TUCRydZq8v0e
         WG7e9slvMpGPp/+47YOkRJUFe/9Wyj5g1FN/Oc0lF6EjnwdEw00wRY+bRxE4j+CnuJT7
         S7gnlk9pJfe85oNVKfEP/q0anGOMZ+nNFa0TtbBwcdFclBGzzkJBwapXGLWdFdK5YUqa
         MgPk9WfIXbDHp3cB0vo+X3HZiSOY6zp3jJxpTpfXIb5blqCSCI7KMpoH2+cw73K0cwT8
         hNzQ==
X-Gm-Message-State: AOAM533undOJ3P1mmIsr2mFCMShbeZow2PC2X0Db3LSN+Xd8VoPaKT14
        jLfbw/eekUfMzKLn0Zlt+DM=
X-Google-Smtp-Source: ABdhPJyrpwhCxklxQAYmfaZq4I+aywoReZAoyvNPAKLPeZi04EKaH6aThCgrTCW/1NhHc1dlsx82dw==
X-Received: by 2002:a63:534d:: with SMTP id t13mr1366464pgl.32.1591219419267;
        Wed, 03 Jun 2020 14:23:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id n4sm73692pjt.48.2020.06.03.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 14:23:38 -0700 (PDT)
Date:   Wed, 3 Jun 2020 14:23:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com,
        Jay Conrod <jayconrod@google.com>
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200603212336.GD253041@google.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
 <20200603034213.GB253041@google.com>
 <20200603045248.GA20266@syl.local>
 <20200603051631.GA20678@syl.local>
 <1253efb6-f1bc-0a16-68e3-c1bc07e1bc18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1253efb6-f1bc-0a16-68e3-c1bc07e1bc18@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:
> On 6/3/2020 1:16 AM, Taylor Blau wrote:

>>   * Keep the shallow bit sticky, at least for fetch.writeCommitGraph
>>     (i.e., pretend as if fetch.writecommitgraph=0 in the case of
>>     '--unshallow').
>
> I'm in favor of this option, if possible. Anything that alters the
> commit history in-memory at any point in the Git process is unsafe to
> combine with a commit-graph read _or_ write. I'm sorry that the guards
> in commit_graph_compatible() are not enough here.

As described in [1], I agree --- this kind of "dirty bit" is a good
option and seems like the right thing to do here.

And I'm glad you said read _or_ write here.  I hadn't realized that
this check already applies for reads, and I'm very happy it does.

[...]
>>   * Dump the object cache upon un-shallowing, forcing us to re-discover
>>     the parents when they are no longer hidden behind a graft.
>>
>> The latter seems like the most complete feasible fix. The former should
>> work fine to address this case, but I wonder if there are other
>> call-sites that are affected by this behavior. My hunch is that this is
>> a unique case, since it requires going from shallow to unshallow in the
>> same process.
>
> The latter would solve issues that could arise outside of the commit-graph
> space. But it also presents an opportunity for another gap if someone edits
> the shallow logic without putting in the proper guards.

This, however, I don't agree with.

I'm a strong believer in having clear invariants --- without them,
code can only be understood empirically, and
https://ieeexplore.ieee.org/document/9068304 describes how painful of
a world that can be.

So because shallow is specifically about changing the set of parents
in objects used for traversal, I want to make sure that we as
reviewers will push back on any potential other new meaning of
shallow.  *If* we had a safe way to invalidate the object cache, it
would be sufficient and would be the right thing to do.  As described
in [1], we unfortunately don't have such a thing.

Okay, that's all an aside.  Now for the actual reason I'm replying:

I had been wondering why this wasn't caught at read time, but of
course --unshallow clears away the shallows so there was no way for
that to happen.  So what I wonder is, why isn't this caught by fsck?
Can "git fsck" run "git commit-graph verify" automatically and include
its result as part of what it reports?

Thanks,
Jonathan

[1] https://lore.kernel.org/git/20200603205151.GC253041@google.com/
