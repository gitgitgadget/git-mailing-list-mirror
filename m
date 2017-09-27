Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F63A2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 18:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbdI0SAL (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 14:00:11 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:45636 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdI0SAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 14:00:09 -0400
Received: by mail-pg0-f42.google.com with SMTP id 188so8188021pgb.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKB4FU4mNUa86QHz2quvMfKJL1KRtJJ2rDZz1wijwus=;
        b=vAWI5AnWLDHdjV0XiJtj8xnSojCJByUEhJEvyej65/v4syqNxBSPdDd2oLp2T/pOCB
         hPS9iTqVTVQr50xdlncF7Fl+klJRQu4/UJJTNocnUbxDfIy3hUIFKhnH+DuEMSuDMGQO
         MJ/RUoMoseCheh5WJAe8L/RItSKAFh6HxFeXFti2HsYvkc6mIa7yyCVpil7P8lh8cmSX
         5fQfvucr9IO7JmFM+IXpFdQIA2dTe5VSsMgHd8QiyiGTi0wqBa+bZ8PEtTQeE4tf0ob+
         9gsO4WNmzdmVY4QUKnrSlKnXqAa2xpMlnmtwX3BMx6Jwvmp1k0ib63Cq5bWx0gVyRhpz
         w+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKB4FU4mNUa86QHz2quvMfKJL1KRtJJ2rDZz1wijwus=;
        b=nLORh9TwkYMtmhRKnzVMLWqsTmMxGeYhluKCsEHaDD9aY1ukdkG+xzAILr3AaMawU8
         OKgRFgqzLiFYpwdocbVQaFYB5aq7pGWaGxZCJuERr/8TBHq4UnBG+3lKo4Vqdcrrd7tw
         JFK/RqkoANihH7z99lu/80xLdhNeLaFuAzCn1M9xixo7InZYoB2OeHwblxQYx36itMoh
         9HD0JvLPyA6PkcUhSUDHf10qkzTFeRDrQy1Bom6ysM0KidWkUAVLXUe4jlB6z/E8wT8G
         baZK+0/6LAz/iIF9MqmwKzOOWv4zDUIyoZ6pcBJhZlPa8WOqxab4RHugB+ISh0P+M2hP
         W4JA==
X-Gm-Message-State: AHPjjUh3CnZcg01IyNRoYnXEdN1yRmNfulADCCNhRtMS4pivM1t+wgVX
        0nDTU0QsKMhRU/Do2h3b/5ir8g==
X-Google-Smtp-Source: AOwi7QD7745Llk5t3fsOO4fnO8Ta5a4CfsnPVmR3uRWEjB96IjZCV91abfn5lvUv5J75PTBPdnUuEA==
X-Received: by 10.99.95.212 with SMTP id t203mr1992185pgb.391.1506535209020;
        Wed, 27 Sep 2017 11:00:09 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:51cf:598a:e16a:8a0b])
        by smtp.gmail.com with ESMTPSA id 13sm22098980pfm.138.2017.09.27.11.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2017 11:00:08 -0700 (PDT)
Date:   Wed, 27 Sep 2017 11:00:07 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jeffhost@microsoft.com
Subject: Re: [PATCH 03/13] list-objects: filter objects in
 traverse_commit_list
Message-Id: <20170927110007.9ee2f725c01f0c7465838c04@google.com>
In-Reply-To: <d5de0eda-18aa-a796-e7d0-d536d2e59605@jeffhostetler.com>
References: <20170922202632.53714-1-git@jeffhostetler.com>
        <20170922202632.53714-4-git@jeffhostetler.com>
        <20170926153141.6a8d7e5024eeed5bbda838c8@google.com>
        <d5de0eda-18aa-a796-e7d0-d536d2e59605@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Sep 2017 13:04:42 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> The sparse filter is looking at pathnames and using the same rules
> as sparse-checkout to decide which to *include* in the result.  This
> is essentially backwards from the other filters which are looking for
> reasons to *exclude* a blob.  If I see a {pathname, sha} pair and the
> pathname is not wanted (by the sparse-checkout rules), I still don't
> know anything about the object -- since the same SHA may appear later
> in the treewalk but with a different pathname that *does* match the
> patterns and *is* wanted.
> 
> The net-net is that I have to mark the blob as "provisionally omitted"
> until I've seen all the pathnames associated with it.  Only then can I
> say it should be omitted.

How is this different from refraining from marking the blob as
LOFR_MARK_SEEN? When you would provisionally omit the blob, return
LOFR_ZERO so that a future iteration will revisit the blob again, and
when you would include it in the output, return
LOFR_MARK_SEEN|LOFR_SHOW.

> Likewise, there are things about the tree object that we cannot
> decide until we've seen all possible directory paths that reference it.
> For example, if you rename a tree/directory between 2 commits, but make no
> other changes within the directory, it will/should have the same SHA in the
> second commit.  If one of those paths is included in the sparse-checkout
> and one is not, then you need include those blobs (and the tree object)
> in the result.  If the treewalk visits the excluded case first, you don't
> want to discard the tree object (and shortcut future treewalks) because
> the filter won't get a chance to see the included directory path case.

For trees, I guess it's slightly different in that you do need an extra
flag to keep track of whether the tree has been shown. So mark SHOWN and
return LOFR_SHOW on the first time the tree is shown, and LOFR_ZERO
otherwise. And trees must never be marked as LOFR_MARK_SEEN.

(This SHOWN flag might play a similar role to your FILTER_REVISIT.)

Until now, it seems to me that the _END event is not required.

> Also, the current code does not attempt to omit tree objects, but a
> future version may.  And having the _BEGIN_ and _END_ events means the
> filter can keep track of the nesting without the expense of having to
> discover it by parsing the pathname looking for slashes as we do elsewhere.

A feature that omits tree objects would need _END, true. But until
then, I personally don't think we should add such infrastructure until
we have a feature that needs it.
