Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3005C2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 17:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbcGARUr (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 13:20:47 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36269 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbcGARUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 13:20:46 -0400
Received: by mail-io0-f182.google.com with SMTP id s63so105669328ioi.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 10:20:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JbQKsMeuFpIxpPykfS8ErLZwwHtkmCMn7pTqRLTq0ns=;
        b=RiDFY8QhRyZpdJf6eaMgfD7FciLCsLWFKYDJ9Ktf36cBEgu4wyxHRETFSKaEQdKC1I
         qhJ9KHBs0clHoy80Rc7wrSgVkjNo7MXCuRKD0l/KKeZe9M2p8HpCCPFEOJHLMQ+1v8s/
         dOQX+Yj213kRmDMfTa3g43rSWDDNR0lbId2XohEn0GDqH6+5kC1kgkOv7Wg3enxVLhav
         3pHZ8nGaQlmqmpu6qUpoOlbbOKayiJC3TL/WH2UhIhQpMGEA/kHu2RKfWQsbk9sayW+j
         MlrfqhSBlBJ+mUZwd6vHViCEvpZOK7ezo/3/vtssgvpPt2c+o1CMEY49AtMnVfBlD7Sj
         F4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JbQKsMeuFpIxpPykfS8ErLZwwHtkmCMn7pTqRLTq0ns=;
        b=QJE67QJ+m8P7CWQe4xM2U6mzxh+NiFG23wYgPAodzzfZ9rKtllDKiLq8wgXreNi3xV
         EZGA9VsaFiH2ms+TCs0ShYpp3+dmrq+y7gmLV0cf3nLavqoW3fb70UeXBGBIi58t9KlG
         ujzDtDaPAHZv5n14R88f/UU7ax2xVqYidjkGMovlMyaCc585/bTTIDiUeTkKoOwEf5Z2
         DbsGwXLg+Xmq35jauFQt/3lfTDIxJBq9MY7nztB4GjJfM63gtedJ/JOWNVxH0iBwD1tA
         Nu0ftyDg9gXbUshRAalQ/G54B02LpUj91W6keoWBSaVWjZ/XVA6eRqgegPJqf4ipe02A
         VBVw==
X-Gm-Message-State: ALyK8tKcdKzl2SSa/pkZMq5IueaYHAi00NCiyyZWrhQ8nZjz9E798eR8tG0JYKedNFDIhoWwuod7NYiUL9IgUlkT
X-Received: by 10.107.186.196 with SMTP id k187mr22015294iof.173.1467393632825;
 Fri, 01 Jul 2016 10:20:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 1 Jul 2016 10:20:32 -0700 (PDT)
In-Reply-To: <20160701071410.GG5358@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com> <20160630005951.7408-2-sbeller@google.com>
 <20160701071410.GG5358@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 1 Jul 2016 10:20:32 -0700
Message-ID: <CAGZ79kaDCLm3BBURJKfkYWKKvozkFTGCn0wGiQCtspUvtQBd+g@mail.gmail.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 12:14 AM, Jeff King <peff@peff.net> wrote:
>
> Putting the data into a file does alleviate some issues. But it also
> makes parsing annoying, and opens up new issues (like what happens
> to content that has a newline in it?). Wouldn't multiple files be a bit
> more convenient? Especially for your example of eventually carrying
> larger binary content like images.

Yeah I did not think about having multiple files. I think that is the
way to go now.
In the environment variable you'd have the paths, such that

process_hook_option_from_file()
{
 ... # do a thing with $1
}

for p in $GIT_HOOK_OPTION_FILES ;
do
  process_hook_option_from_file $p
done

is a viable hook.


>> The rationale for keeping the actual options inside a file instead of
>> putting them directly into an environment variable has multiple reasons:
>
> Thanks for including this rationale; my first thought on seeing the
> patch was "wouldn't this be much more convenient for a hook if each
> value had its own environment variable?".

That's what I thought as well. Office discussion ensued and I am still
offended by this solution, but it sucks less than multiple environment variables
(I tried writing a script to construct and evaluate the environment
variables and
that doesn't look nice)

If we did not have a GIT_PUSH_OPTIONS_COUNT and GIT_PUSH_OPTION_<N>
but rather GIT_PUSH_OPTIONS_VARIABLES that contains the other variables,
it may be easier to handle, but whether you read from a file or evaluate the
environment variable is only a minor step, the indirection is there anyway
and this would be very close to what we have above.

Thanks,
Stefan

>
> -Peff
