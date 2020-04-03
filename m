Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A963C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0869E206F6
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hb6QkYFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgDCVfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:35:52 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:51640 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCVfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 17:35:51 -0400
Received: by mail-pg1-f202.google.com with SMTP id p13so6987751pgk.18
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 14:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sBHiyGFTUO9vbyVAWH2ZhViM5mNQQ/0wUgXnqL6+Mec=;
        b=Hb6QkYFnHncehJZREkny0zaLS5+qMSyuJb2GRLPkeIVruHImTMvGO3Pc02lBjdkmkn
         k2Bq+srhpWG7up9dY1dONH4jw3ghwJeS3iZaLqqub0ZW/KdVjS4bo/4BpfS4uPwltmy6
         fToL9tQV3iJyqbEYouJZJb6jW183vxzjdEL9yktEKhFNmsIRZQ5k6+Ajx9Xp2EEAqmbW
         D+G4uhysOQZKN4dqc3rTakR52CjsddeG6bCoYLl0/ITYGDsRjXgjTh1mYS5PaUTIp3y1
         FgV3n8MPpQTt4dgYgf/0+1gyFSwrhCrDjVpayhz9WATM1kGT9gIoY52KTF2M0dtkDQkv
         Bzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sBHiyGFTUO9vbyVAWH2ZhViM5mNQQ/0wUgXnqL6+Mec=;
        b=bw//VZ6VS2klF8rxvjF9Cuusj6A9s9kAo7i6UBOxtZIZzMNYcGjnVY4ol1TAXMG1ot
         zed/3c6jIw1HpRAXIUO6AENLKgtHc5mXCgK4OApWaBK6ksluLn6NLS554TE1SGBZ3GPn
         WaiFeOgwxo1hjbk7K6s9BK3Ox98ZnUT+8pigLaOnFuO13UO1s4a9UKK5/BP0mbl1B2qj
         KhJ7VuC21HWAFAjxKmz//mjObzRMgbwvuskOFXDXM1ICh4LZibhB4azDfc3IFoQMDaQo
         fvQ05FK5/IwXBpFVKlxjiP/RuQEQc92vW5sDckfj7kyFaYvs8+dX2NMsFr0ST4z9PGL3
         +ZoQ==
X-Gm-Message-State: AGi0PubNK3JYXknuf6m7Z/02bKzCz3GfmyXlBXAXFP+OFQRTU8x/cIFQ
        OyjJH3vOjXt7o+bgyV466W/RDWJCDb31kvBNxxa7
X-Google-Smtp-Source: APiQypLaJX7HrZtqdeohNgKbZyyYACzst+4ZvdIBibQqrhBa5/L/RVIxnZ8hPtblDV0KlUAXBKi0C6ZLZuNQT7fOjciJ
X-Received: by 2002:a63:5716:: with SMTP id l22mr10197953pgb.164.1585949748756;
 Fri, 03 Apr 2020 14:35:48 -0700 (PDT)
Date:   Fri,  3 Apr 2020 14:35:46 -0700
In-Reply-To: <xmqqsghl1m0p.fsf@gitster.c.googlers.com>
Message-Id: <20200403213546.237273-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqsghl1m0p.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: Re: [PATCH v2 2/2] diff: restrict when prefetching occurs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > My idea is that this prefetch is a superset of what diffcore_rebase()
> > wants to prefetch, so if we have already done the necessary logic here
> > (even if nothing gets prefetched - which might be the case if we have
> > all objects), we do not need to do it in diffcore_rebase().
> 
> s/rebase/rename/ I presume,

Ah, yes.

> but the above reasoning, while it may
> happen to hold true right now, feels brittle.  In other words
> 
>  - how do we know it would stay to be "a superset"?
> 
>  - would it change the picture if we later added a prefetch in
>    diffcore_break(), just like you are doing so to diffcore_rename()
>    in this patch?
> 
> So the revised version of my earlier "wondering" is if it would be
> more future-proof (easier to teach different steps to prefetch for
> their own needs, without having to make an assumption like "what
> this step needs is sufficient for the other step") to arrange the
> codepath from diffcore_std() to its helpers like so:
> 
>     - prepare an empty to_fetch OID array in the caller,
> 
>     - if the output format is one of the ones that wants prefetch,
>       add object names to to_fetch in the caller, but not fetch as
>       long as the caller does not yet need the contents of the
>       blobs.
> 
>     - pass &to_fetch from diffcore_std() to the helper functions in
>       the diffcore family like diffcore_{break,rename}() have them
>       also batch what they (may) want to prefetch in there.  Delay
>       fetching until they actually need to look at the blobs, and
>       when they fetch, clear &to_fetch for the next helper.
> 
>     - diffcore_std() also would need to look at the blob eventually,
>       perhaps after all the helpers it may call returns.  Do the
>       final prefetch if to_fetch is still not empty before it has to
>       look at the blobs.

Ah...that makes sense. Besides the accumulating of prefetch targets
(which makes deduplication more necessary - I might make a
"sort_and_uniq" function on oid_array that updates the oid_array
in-place), looking at the code, it's not only diffcore_break() which
might need prefetching, but diffcore_skip_stat_unmatch() too (not to
speak of the functions that come after diffcore_rename()). The least
brittle way is probably to have diff_populate_filespec() do the
prefetching. I'll take a further look.
