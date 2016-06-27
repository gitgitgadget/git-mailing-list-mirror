Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4676A2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbcF0Tjw (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:39:52 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35986 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcF0Tjv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 15:39:51 -0400
Received: by mail-io0-f170.google.com with SMTP id s63so157539876ioi.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 12:39:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2SFcQANL6yiZmbw3cofZ2XkY+xUW0bOdPdS2tsF7SzQ=;
        b=JHYF7Z2XDmpm4FnTxKOcFjgEAUAwWhEQBwYBMreozySao6VjkykToFdACvx07pnas2
         DTQZgVrK0MO8oP8DDWRGBmaBBQx7OG+eYMLHOzs1ABk9yTvyhZyHo2uL403bbbJXdS3p
         JJCcx2Af4lG11RLoy2BXF5R2K5TvWEZReIhAciAMsGS4YRb+YuiJo9p8a1DJlu2rAW6k
         yKJjeDK/OAmq3jSGOuFSkJRtb4Pdw1DU6ogMklhyh8AqJyBzY6t8JqNcH1eQneBxKX0p
         G3FuPf0kVO4qMHu9Ju1AvLl7OcRfch4nkGtpD/kVwm3dgLWjbbdvwsDYGqj9bhRncYyK
         1gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2SFcQANL6yiZmbw3cofZ2XkY+xUW0bOdPdS2tsF7SzQ=;
        b=VG9/fAE8DVss3h0GKwXv2vQExNTbCUJnfRlfg3YWOB0LtDZeaBNk/aO9jSivrIN9QG
         +UU2XPzs5dPfRkKpXbiNpl/3lbBgVqSfb1BJBP7+dwiXcxqPrD1hCHJE/ov8jeB22N+b
         cpEibYOMSzx3aeqbJLIxJW3+QSHZbK9hLZ3f98BQcHlKXlivZONOm9s3cdGzW/2ZJSqS
         0GpyJ31LiJYbPaVtec18rZerxMeAOAWHH4BVXI8bF0JLe+JMSOqhO9qFwrNHUQbbt2/e
         XQxEReIz8wjcnYK8er0sPQWSkj6RTuP4UpHpb5Fn2JUpWRog/bvolK7bdKQbG6Z2tmPt
         fdkA==
X-Gm-Message-State: ALyK8tJ5GihmUgo4LGq1ibRDCZa414JqWIHSJ+pigFLSUVUIphaUE2vXOeNN7jwtBJPIZJjWvIlY6IpQlinucg==
X-Received: by 10.107.22.6 with SMTP id 6mr2438015iow.128.1467056390922; Mon,
 27 Jun 2016 12:39:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 27 Jun 2016 12:39:21 -0700 (PDT)
In-Reply-To: <20160627193542.GC10877@sigill.intra.peff.net>
References: <20160626171616.27948-1-pclouds@gmail.com> <20160626171616.27948-4-pclouds@gmail.com>
 <20160627192426.GA10877@sigill.intra.peff.net> <CACsJy8BYsPCLiEM2syrGUa_VOCHnR3W+sSiG3sNFme1L0Hx7XA@mail.gmail.com>
 <20160627193542.GC10877@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 21:39:21 +0200
Message-ID: <CACsJy8AQt5SLBufuzGwjoAQVWjTZ3oSvTB+Yz4Kp8hKAy0sD9A@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] diff.c: add --relative-names to be used with --name-only
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 9:35 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 27, 2016 at 09:33:18PM +0200, Duy Nguyen wrote:
>
>> On Mon, Jun 27, 2016 at 9:24 PM, Jeff King <peff@peff.net> wrote:
>> > On Sun, Jun 26, 2016 at 07:16:16PM +0200, Nguyễn Thái Ngọc Duy wrote:
>> >
>> >> The difference with --relative option is, this option does not filter
>> >> paths outside cwd. You can add two more chars " ." on your command
>> >> line for that.
>> >
>> > Another difference seems to be that it applies only to --name-only, and
>> > not to other forms. I can see how "-p --relative-names" might be weird,
>> > because you'll get:
>> >
>> >   diff --git a/../foo/bar b/../foo/bar
>> >
>> > or something. But surely things like --name-status would want to support
>> > it?
>>
>> That's my plan :) Anything that does not start with a/ or b/ should
>> respect this new option.
>
> I guess it seems a bit unfortunate that:
>
>   git log -p --relative-names .
>
> would not be equivalent to:
>
>   git log -p --relative
>
> I am not entirely convinced that "a/../Documentation/git.txt" is that
> unreasonable. Sure, it looks weird, and probably nobody will be able to
> apply the patch. But it is what the user asked for.

If we go that far I would drop a/ and b/ because this is already
un-patchable, and without the prefix, the user can  happily copy and
paste again. Gaah lots more work..
-- 
Duy
