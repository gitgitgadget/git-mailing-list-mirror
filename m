Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F741F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbfIPTt1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:49:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43060 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbfIPTt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:49:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so567748pgb.10
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yn0rSOY348wKTiWtQKOtk2DJbKZHECzRkX+hK/cRfb0=;
        b=APuFGUMIFqqrD5iIQqL2ARpcWKYVpnv9hM5/M373/oCkpqle8eS7H7PSuEp0vrVg3p
         SmomgkoijuY4cKn3T6R16nLFWpwGE6rZFx8AZi6JNScMtzeyjThCS/TSyTc+Y2UU2RK4
         bDnUCFUggQj+6eG4oOLqSWZOVJUH2cQlhJiTUZJ0ybq/lZhF4u+o/LDGdz7z32hzMyVW
         Bt4ooYg8AkTLpC8H48CvQ+TLqz3X1GkiOVTtlW+l4AVE+iHPlwe0RKwoLHGP5lvDxAtz
         If4HkXMInfQS+rXMphFRN4i/Q7GhAOluh3x7+MWZqKpi0YnxBz3fWWy3VYC0gZCxCgf4
         Qnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yn0rSOY348wKTiWtQKOtk2DJbKZHECzRkX+hK/cRfb0=;
        b=rywrg5rf92sIrZekKSfw+IvTdjTAStSzhsF+7+8YoZkh92V/LQDcf2L60v7rJIrb2L
         XD6OGzolar9U5ETq2MdnwoBxNBLK3Wb9iUM0GNK9d+eAVF6NfcK0GLgU3uHT1Dc8k5OG
         qDyUiI6AGLSPKUBh8bRWIL9lumsJGx60jBKRHHJ15BaQLSefhP2ftIwv0/pLGPed3MHP
         TLi6ccg93+NocqUWRdxHV136cBY0SILdLQFQypwEelS48yh1ofpFYkfj44uu/joxveiU
         rD+I+CsMFqere3zz+BwjckE1Bm301wZ9ty0xc4H4rx6tuU/uXdOyc7niSWmd2nic9wKE
         LxkQ==
X-Gm-Message-State: APjAAAUbeERak2UUW14g1cVUGNLffLXh0iiJffj8MOdNS3tUIl815fUY
        wtZtOIW4hSZXIO6v3wh0Dts=
X-Google-Smtp-Source: APXvYqyGn7u3JZf9XO3mmWQ2ilDLE48zCCp5/lzIYW5GaJqi+0GFKs3BZ3EBO7nJ0Gl4iu++zq21qw==
X-Received: by 2002:a63:2a41:: with SMTP id q62mr796209pgq.444.1568663366738;
        Mon, 16 Sep 2019 12:49:26 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:9:3492:23e8:bf20:776])
        by smtp.gmail.com with ESMTPSA id c64sm54025398pfc.19.2019.09.16.12.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 12:49:25 -0700 (PDT)
From:   William Baker <williamtbakeremail@gmail.com>
Subject: Re: [PATCH 1/1] multi-pack-index: add --no-progress Add --no-progress
 option to git multi-pack-index. The progress feature was added in 144d703
 ("multi-pack-index: report progress during 'verify'", 2018-09-13) but the
 ability to opt-out was overlooked.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <0821a8073a48067ecd9ce08226656fa04d803f6b.1568216234.git.gitgitgadget@gmail.com>
 <xmqqlfutfewv.fsf@gitster-ct.c.googlers.com>
 <24c1a9aa-c83b-a984-8821-ecc51a4bc0e2@gmail.com>
 <xmqqo8zoc57y.fsf@gitster-ct.c.googlers.com>
Message-ID: <ec5e29f4-9aa1-b179-c71e-2693e4247b01@gmail.com>
Date:   Mon, 16 Sep 2019 12:49:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8zoc57y.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/19 1:26 PM, Junio C Hamano wrote:

> Compare the ways how dispatching and command line option parsing of
> subcommands in "multi-pack-index" and "commit-graph" are
> implemented.  When a command (e.g. "commit-graph") takes common
> options and also has subcommands (e.g. "read" and "write") that take
> different set of options, there is a common options parser in the
> primary entry point (e.g. "cmd_commit_graph()"), and after
> dispatching to a chosen subcommand, the implementation of each
> subcommand (e.g. "graph_read()" and "graph_write()") parses its own
> options.  That's bog-standard way.

Thanks for the pointer to "commit-graph", looking through that code
cleared up any questions I had.

After taking another look through the "multi-pack-index" code my plan
is to update all of the subcommands to understand [--[no-]progress].
I gave the public struct in midx.h approach a try, but after seeing
how that looks I think it would be cleaner to update "write" and "expire"
to display progress and have an explicit parameter.

> Started as an isolated experimental command whose
> existence as a standalone command is solely because it was easier to
> experiment with (as opposed to being a plumbing command to be used
> by scripters), it probably was an acceptable trade-off to leave the
> code in this shape.  In the longer run, I suspect we'd rather want
> to get rid of "git multi-pack-index" as a standalone command and
> instead make "git gc" and other commands make direct calls to the
> internal machinery of midx code from strategic places.  So in that
> sense, I am not sure if I should "recommend" fixing the way the
> subcommand dispatching works in this command, or just accept to keep
> the ugly technical debt and let it limp along...

Thanks for the background here, it helped with understanding why the
multi-pack-index parsing is different than the other commands.

My plan is to include 3 commits in the next (v2) patch series:

1. Adding the new parameters to midx.h/c to control progress
2. Update write/expire to display progress
3. Update the multi-pack-index.c builtin to parse the [--[no-]progress]
   option and update the tests.

I wasn't thinking that I would adjust the the subcommand dispatching in 
multi-pack-index.c in this patch series.  By updating all of the subcommands
to support [--[no-]progress] I should be able to keep the changes to 
multi-pack-index.c quite small.  If you see any potential issues with this
approach please let me know.

Thanks,
William
