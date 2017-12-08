Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1021FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbdLHUj6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:39:58 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34185 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdLHUj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:39:57 -0500
Received: by mail-qt0-f176.google.com with SMTP id 33so28470626qtv.1
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w+1VddSFFpMQF11NrMMRiVp184ii9VAkdcAz5So1pcs=;
        b=Fqddn1PuWxAM3jPYZ9KEA0G7Nl2lzsVXmGll5Cdr69dx8H9SH+E/5zlhhWcw3q8iTp
         TMVtkMMRaKHpSXb5TnJGdEUMOBhmJJ7Lz2QzgbOOVGqg0raTzv8bLP1b/N6Xu9Xq3X1P
         wjzxroQk+KBWXxh6cHUVewAV7uy1U2Etet6090OPPXU8Bk00Q7q5D+8hb2x7IZxRqxtN
         PdEbBICOCc/XHkNOnpfZWYxpRsiKNIHYO8cwMANYstIG9cfiUlPPL8R9qkuPPZQchvWX
         Ch65TCPKyorrka43LBM9OOAeVpTE+bfMVM16hMPwWIOtfRGl+dO1H9CTu7jnbvtvpUag
         BCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w+1VddSFFpMQF11NrMMRiVp184ii9VAkdcAz5So1pcs=;
        b=D9Y/CTyUfYi2EoY9O97s/NGCtjXXriarVGNDJNmb7FE49PTRd4sdrOOQKEpXrisQAc
         TtoX1tWYXQpoS1MsZiFZD+7Z0HSF19S3j+mIJ5Nzzbv2Z21KCoPifLfw4nY4jM2fSNxb
         sZPolhjKVfc4OAZzremWN4FGY0Q1QBrLXlQrdVf1SuzIoGyraoB9MrhIZn3p51ySRY/x
         7faGtcldUR5z2wMVRVzYRdFRMWZd9vHOpyke1OVoTXf4x2CszM391/z9EXYvCFDx2b80
         USSU92obPfauQ2ylIZHl3dbQLuSDuyScH6/V5bM9Ec2WcB4THjrFbmj+80ZriN0Z7sja
         EvhA==
X-Gm-Message-State: AKGB3mI2vxolAlbekmKo/ygPvXUJPfRoTPZn9/J7WdI6YG9zrZXngWtD
        3Q8PvYADftVtSRn37+waTnhvXrHOszEZnkYBRfQvlw==
X-Google-Smtp-Source: AGs4zMYNvwEaX4NkUz/Ulw6yHiXxeJ+ZAygety6RxWfYdXwPfcGppnj/eB3H77dxeyPJ+y+fevwv3uKAGZo7N8CVc/o=
X-Received: by 10.200.6.130 with SMTP id f2mr17608493qth.140.1512765596243;
 Fri, 08 Dec 2017 12:39:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Fri, 8 Dec 2017 12:39:55 -0800 (PST)
In-Reply-To: <20171208201957.GA456@sigill.intra.peff.net>
References: <20171208002447.20261-1-sbeller@google.com> <20171208002447.20261-2-sbeller@google.com>
 <20171208093434.GD26199@sigill.intra.peff.net> <643e1afd-43e2-7fcc-452b-8b9ceac6868c@ramsayjones.plus.com>
 <20171208201957.GA456@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 8 Dec 2017 12:39:55 -0800
Message-ID: <CAGZ79kaos7cmQe3bmR5gCVXbUjBBQdSYYOE11egnDEMaX-7xSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 8, 2017 at 12:19 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 08, 2017 at 04:28:23PM +0000, Ramsay Jones wrote:
>
>> On 08/12/17 09:34, Jeff King wrote:
>> > On Thu, Dec 07, 2017 at 04:24:47PM -0800, Stefan Beller wrote:
>> [snip]
>> >> Junio hinted at a different approach of solving this problem, which this
>> >> patch implements. Teach the diff machinery another flag for restricting
>> >> the information to what is shown. For example:
>> >>
>> >>   $ ./git log --oneline --blobfind=v2.0.0:Makefile
>> >>   b2feb64309 Revert the whole "ask curl-config" topic for now
>> >>   47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"
>> >>
>> >> we observe that the Makefile as shipped with 2.0 was introduced in
>> >> v1.9.2-471-g47fbfded53 and replaced in v2.0.0-rc1-5-gb2feb64309 by
>> >> a different blob.
>>
>> Sorry, this has nothing to do with this specific thread. :(
>>
>> However, the above caught my eye. Commit b2feb64309 does not 'replace
>> the Makefile with a different blob'. That commit was a 'last minute'
>> revert of a topic _prior_ to v2.0.0, which resulted in the _same_
>> blob as commit 47fbfded53. (i.e. a53f3a8326c2e62dc79bae7169d64137ac3dab20).
>
> Right, I think the patch is working as advertised but the commit message
> misinterprets the results. :)

Thanks for digging. I came to a similar realization.

> If you add --raw, you can see that both commits introduce that blob, and
> it never "goes away". That's because that happened in a merge, which we
> don't diff in a default log invocation.

We should when --raw is given.
--raw is documented as  "For each commit, show a summary of changes
using the raw diff format." and I would argue that 'each commit' includes
merges. Though I guess this may have implications for long time users.

> And in fact finding where this "goes away" is hard, because the merge
> doesn't trigger "-c" or "--cc". It's 8eaf517835, which presumably was
> forked before the revert in b2feb64309, and then the merge was able to
> replace that blob completely with the other side of the merge.
>
> Viewing with "-m" turns up a bunch of uninteresting merges. Looking at
> "--first-parent" is how I got 8eaf517835.
>
> So I think this one is tricky because of the revert. In the same way
> that pathspec-limiting is often tricky in the face of a revert, because
> the merges "hide" interesting things happening.

yup, hidden merges are unfortunate. Is there an easy way to find out
about merges? (Junio hints at having tests around merges, which I'll do
next)
