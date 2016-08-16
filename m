Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7FE1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 14:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbcHPOoE (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 10:44:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34892 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbcHPOoD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 10:44:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so16868612wmg.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 07:44:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0XNVgC+Jo/fArT3imswfEs3tVoEquJcb/Efi/kB/mf0=;
        b=iVBiGp38VWzc4e5SFBgLcWrQqlsdp1OoEzmWbqOFaBeU865C+kK1Hiq0OC3rJU9bHt
         gItls8clWwvGnSqZ5gwCsabSpjyKSpF4pCsTLUBq5iGnjAGiTP3g6ADFTIKayXyT8x1A
         EbACCruinJ2YqOws3PqqLQFjjFXqMtw9URVX4YIRJsVQJeHNOBM+tIvfdXkmBgA87xF/
         V396/keZFDE7WwM50ezXVdDU3m1k2p57Ecr9YLApykCIXq9mFW/fqxMMdx3lLainPjT1
         2mtVc2zRQxuvGAu1BqNUeCgF+mrbKcYCBjcwPK2MCXbMVOWDKgmdY/GJRR4t9UUpRkH0
         S89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0XNVgC+Jo/fArT3imswfEs3tVoEquJcb/Efi/kB/mf0=;
        b=gV/QbRYpheS/Gfr8jHvmBJGjjk3pCX4ObP8/d9dAE7ywbqnQvUzEi31Yy1OHB520qE
         5HZYZJRtsaXigT1w0cDgQXKGf/qYcuqYvrKTK8AaFODIm6vfCOyZ7UCrIp3SVOGFwT8D
         /5JPY16QPYh1+c2sSKJmokNLVLsO3sQMm5v4uviDg4qBJ6yapu31SVVEGTYOIwdcskp9
         ViLQd9I77DyaqLHTP27YHwqagza8Ko49i4qI8lPFPDOWnguXfLLJsHq3CmYRFzxZhqm9
         kFp9oxaYjaQ8kP+6l8yYsNleeg/dROb9QX0Q+mexya4L/WEZVk5eFXKCx76JxAje54mH
         3nvg==
X-Gm-Message-State: AEkooutUaoSrGkqWsvuzCNW0cYGQJqmhWYGnP4F5Li2boUUErGZy+zgBWd78v4Ntv7xuM13/1ey6sF46+FXLBA==
X-Received: by 10.194.149.113 with SMTP id tz17mr44214975wjb.64.1471358642440;
 Tue, 16 Aug 2016 07:44:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Tue, 16 Aug 2016 07:44:01 -0700 (PDT)
In-Reply-To: <20160816131145.apq77nc2x7wb7lba@sigill.intra.peff.net>
References: <20160816081701.29949-1-chriscool@tuxfamily.org> <20160816131145.apq77nc2x7wb7lba@sigill.intra.peff.net>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Tue, 16 Aug 2016 16:44:01 +0200
Message-ID: <CAP8UFD0mhhfNbcsiOpLqJ-4ZWOkKwcoJ9k3yQyO4jTem=s+yBg@mail.gmail.com>
Subject: Re: [PATCH 0/3] limit the size of the packs we receive
To:	Jeff King <peff@peff.net>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 3:11 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 16, 2016 at 10:16:58AM +0200, Christian Couder wrote:
>
>>   - changed strtoul() to strtoumax() in the first 2 patches, as
>>     suggested by Peff,
>>
>>   - changed git_config_ulong() to git_config_int64() and used PRIuMAX
>>     and uintmax_t in the last patch, as suggested by Peff,
>
> Thinking a bit, off_t is actually signed. So maybe PRIdMAX (which we
> don't seem to have compat macros for) would make more sense. I dunno if
> anybody actually cares. This value shouldn't be signed anyway, and
> nobody should be approaching the limits of a 64-bit number anyway (there
> is no point in limiting the incoming pack to the exabyte range).
>
> So I'm inclined not to worry about it.

Yeah, you previously wrote:

> We seem to use strtoumax() elsewhere, so that's probably a good match
> (technically it can overflow an off_t, but in practice this value comes from
> the admin and they will set something sane).

and I thought that the same would apply to using PRIuMAX and uintmax_t
in this patch.

I can add something along your explanations in the commit message if
it is prefered.
