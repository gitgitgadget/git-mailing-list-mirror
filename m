Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E688E1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbcHCQ1N (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:27:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35126 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758048AbcHCQ1L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 12:27:11 -0400
Received: by mail-it0-f66.google.com with SMTP id f6so16302487ith.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:25:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HhAaFTl7gG/Bavf2LBr5oAI2t6diNKm0WvB13UlBnUY=;
        b=eXhDgJSqtnqqjGskdwwpHG1eNpB+LWgdu6W/ULQ9ZgRTXldQ79dG94RA9eNdgasB2h
         KzOOvKFCl1ospYVMtSfM8kcdLKfjNQHOo+uxql1BtVNxkn1/xTcawPSlMLpgTb8iNjV4
         5pabchHkKkFwTlHSWiqd4tWXmLpwz/NnD/G8zw5X5AaaExyVoklnDY58P+d2f18bWXPS
         PutfcIY83qA2GtCjKm+Qz7cYZ64eeieChdn4qNWws1czJY6N5RWCM6g1OKP8cgA60ap6
         G5xELIqzU/S/8Eb0WIocJhp8bGP9pVbTbAtBrpq94kWGeZMr75c0SgEf41iy1BI1Uokq
         1kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HhAaFTl7gG/Bavf2LBr5oAI2t6diNKm0WvB13UlBnUY=;
        b=MS61pNU6a6cQubzeBN8HWDCfLHZYCGXKRZTr0oh55OA96Rq+ekQywXNT2lM3vF3lRZ
         pPCuKElUSZs+6Jj4UjXP3wpxTbBM7jaY2tp+H5ZDhnKK3nQ6J0NqsUa08kBJo3z3yPMO
         b7GXTgrrp8/36M+JjGUWb4Ulwh34eEQWJgH00dezQ49+oCkaVi06TM3DCMSNYq7WkRCL
         lPajC2ck/EKX2XPA739mhXnV4LB/pxw+6SIFnAAZdyhdDJ+9Mxdus2wdRP4qa5qQxPDU
         gTif11WRMb0zsnjp+Sl0i4eOANW/PcOBLorTzfKJ6W9/qNOWGDFEhrqVgEP5pJ7PIUrs
         oO7w==
X-Gm-Message-State: AEkoouv6sEA6DmzVu8uq3LH5VEo6R89YUW/3G76f85holvHld84Sx6+TccW1v7hNk5zYiWm0Uo2S6NojW/Yd0A==
X-Received: by 10.36.91.134 with SMTP id g128mr71708726itb.42.1470241540613;
 Wed, 03 Aug 2016 09:25:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Wed, 3 Aug 2016 09:25:09 -0700 (PDT)
In-Reply-To: <xmqqmvktakvt.fsf@gitster.mtv.corp.google.com>
References: <20160730182005.14426-1-pclouds@gmail.com> <20160803160536.15596-1-pclouds@gmail.com>
 <xmqqmvktakvt.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 3 Aug 2016 18:25:09 +0200
Message-ID: <CACsJy8C3xuCj-2=8B18qpDhbRtW=S2UQ1zFLTaeqRqgXYSeyBw@mail.gmail.com>
Subject: Re: [PATCH v2] t7063: work around FreeBSD's lazy mtime update feature
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 6:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>>  v2 goes with Junio's suggestion (good one!).
>
> Ehh, have you even read what you copied and pasted?  "this and that"
> and "blah" are meant to be placeholders for you to fill in.

I did. But after a bit of consideration, I think the confusion caused
by "this and that" would force the reader to blame and read the entire
commit message.

> I am not sure if "-exec ls -ld" is a good idea.  Doesn't "find" by
> itself does enough lstat(2) call to work already?

Hmm.. because in some cases we could have dtype from readdir()?

> Even if it were
> necessary to trigger a separate stat(2) call, wouldn't "-ls" be
> sufficient?

Yep. Let me run some tests before sending v3.
-- 
Duy
