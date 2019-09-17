Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023FE1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 00:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfIQAJH (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 20:09:07 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:40435 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIQAJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 20:09:06 -0400
Received: by mail-pf1-f181.google.com with SMTP id x127so966331pfb.7
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lyBsTuxeIDaw3shtppfxK3QrSqmwE5edaa1cGT1gKKc=;
        b=mBlrraBCj+YW4J8Eh6lzyDIvIRPdP4fmBVW620C47f7O7o2eFQAD8a/b18nziTyvAs
         lwTZGwc/n68vtbKuuKR4z2TGXjHTrRgBWMuOkEKTMR2a4JJtkICUiu56+P3ArVBIIK/+
         dHQxV9S9x4AvhT8PAI6VSAKJQUDCgLmzVh5DSbwFHECY7ooAlM0Tm/lx3VMMfWSL6auG
         YH8uOKXtFqh08r/LCyVk2LJPOct6FHc6eFTseO7rA6sqd3aklsfNfZfzqzMLA/rd2dzC
         8tNDHFAeciaPHCUfbziPTktPsse9hmpcYNVFmMkvJNMDvVwsEuar6wY1lVFwg19e3ATI
         K7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lyBsTuxeIDaw3shtppfxK3QrSqmwE5edaa1cGT1gKKc=;
        b=pFon/0f/91GFnyi8P8TwXLf76K0L7W3TASH/IENxQkbtMn4uq+hthxIor9Onj+8i/o
         lYixSRqmdn9w9AGtVuCe6kHoLMP5Wa7NcgyPV8+jU+wh0ewE15bDqgKnAUCiqT84Ow5E
         2LJZGDoDoy+AtU1X5LTg4+1dkHW4Pc3eM24rrOzQmnuS+7gLTu1elhTcg+BrdD+Z8D3+
         AKvEhlBK0keN2g+HCxiBPZeZej0CCJvMJDtI/7zYgxPGv98++ohyvaKHp9t5sNbix+rp
         0bXKUsY+Q2KscRrMy0gvMZTJf9NLzw7ViXN/tdRavgpWoLVDrZIwcwjw/BFgquRFkFlo
         sBww==
X-Gm-Message-State: APjAAAV1lqaTW5Bi/LbJ6cQtmnjjcbbhcDwraDGwBPj/GSkZwSWxP+TN
        gy42M+BAs/juzG/7jZG7gX/P1Wnw
X-Google-Smtp-Source: APXvYqx1xijUYoO0t6GzHPJxloSmSoiI1Sw7EGmWSdn1OTLpGBx2RyEMmVet5Bwm4LI7K3ms/O9tGw==
X-Received: by 2002:aa7:96ab:: with SMTP id g11mr1148690pfk.61.1568678945757;
        Mon, 16 Sep 2019 17:09:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id z13sm277414pfq.121.2019.09.16.17.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 17:09:04 -0700 (PDT)
Date:   Mon, 16 Sep 2019 17:09:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        szeder.dev@gmail.com
Subject: Re: merge-recursive thinks symlink's child dirs are "real"
Message-ID: <20190917000902.GC67467@google.com>
References: <20190916214707.190171-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190916214707.190171-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> This was raised by a coworker at $DAYJOB. I run the following script:
[reproduction recipe from (*) snipped]
> The cherry-pick must be manually resolved, when I would expect it to
> happen without needing user intervention.
>
> You can see that at the point of the cherry-pick, in the working
> directory, ./foo is a symlink and ./foo/bar is a directory. I traced the
> code that ran during the cherry-pick to process_entry() in
> merge-recursive.c. When processing "foo/bar", control flow correctly
> reaches "Case B: Added in one", but the dir_in_way() invocation returns
> true, since lstat() indeed reveals that "foo/bar" is a directory.

Gábor covered the "what happened", so let me say a little more about
the motivation.

The "foo" symlink is being replaced by a "foo" directory containing a
"bar" file.  We're pretty far along now: we want to write actual files
to disk.  Using the index we know where we were going from and to, but
not everything in the world is tracked in the index: there could be
build outputs under "foo/bar" blocking the operation from moving
forward.

So we check whether there's a directory there.  Once we are writing
things out, there won't be, but the symlink confuses us.  Nice find.

[...]
> Is this use case something that Git should be able to handle, and if
> yes, is the correct solution to teach dir_in_way() that dirs reachable
> from symlinks are not really in the way (presumably the implementation
> would climb directories until we reach the root or we reach a filesystem
> boundary, similar to what we do when we search for the .git directory)?

The crucial detail here is that "foo" is going to be removed before we
write "foo/bar".  We should be able to notice that and skip the
dir_in_way check.

Just my uninformed guess --- I haven't tried it. :)

Thoughts?

Thanks,
Jonathan

(*) https://public-inbox.org/git/20190916214707.190171-1-jonathantanmy@google.com/
