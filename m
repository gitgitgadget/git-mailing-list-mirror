Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EA2C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 01:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3F2075A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 01:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDjT021y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDWBSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWBSQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 21:18:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC0BC03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 18:18:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o10so2034714pgb.6
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 18:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hiqwECpK6I46KLNRQEF+z79wBWqvmkmDor8mmwxQ2Zw=;
        b=YDjT021yxqoxVhwe0O+NpYL1VQPChA/qj1929W1PcJGu0Dib/y0d4xh+2jIFbpM9SX
         WkgwEMkYz3ha89y7+VlQ9Vn6zpuAZLL2BMU8kTUcU1Nw7jM/yfSYWYa9tAyOdp9xAZpG
         cwgFW9zTVd0AzO5SQpWQAm3fUV9Gjh2nPPX8hGUPoYC/LPyEDRlAkUYcJrVS/jG4SC3j
         PFqfjwlP/IRg1uchkI7zYU5poRXSWt362GlUDg0eFka2zdn9PqonW9nMz5hhfkX12Jut
         C/muBXarVPICKw3LSW7Dy6Wa+i82aBHSSxg6/Rn5KTysSNHpNOU/+4L4VxYvk8j3HaFy
         zD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hiqwECpK6I46KLNRQEF+z79wBWqvmkmDor8mmwxQ2Zw=;
        b=U8cZTPqT9S5M/5BV9ZBZtexhjMhWnDqNu9O4/xO9v1OfCN0gz1+O9Bvut3sV6iRzAy
         TCYCfa2KruR78Erpz0GRLRKN11P4tRm9HQ6RF/3AHWIjjFIm5QowBCgeQX5MXSGBLpnR
         Ip4lrkLcgVpyK29ottcEgUAB4dtMjD4UV+JpAr7mpoFky/YWkD2dIuok4LCrBksfadMm
         5THRhYvkAeKBLbjY2wMIASM/EdiNrJB4Nt0JYONgloTJp3FbVtwyT63ZR2NG0nWrbmsG
         LJMDETHDDbDdtKI8lcNkC6TncAICImcWYXzDtJjdCApbze9AL0bp0rOIuWIicZeR9v8w
         9Fqg==
X-Gm-Message-State: AGi0PubwLqJjEQlIbBcn/iHUP3x1Uhwok0vxmlaQMtvxtJo6FkOHgHqj
        0+u6wBiNnn8Qr5trdgWjUY0CgaWD
X-Google-Smtp-Source: APiQypJ6fhsHIqh91fF7Iazd+/jbDFEQAIgrn1oPi8MENaa3Kgg2WCg2fp1UCR5kD0Ynh1sg7EF2PA==
X-Received: by 2002:aa7:9724:: with SMTP id k4mr1332691pfg.309.1587604695150;
        Wed, 22 Apr 2020 18:18:15 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id b24sm769979pfd.175.2020.04.22.18.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 18:18:14 -0700 (PDT)
Date:   Thu, 23 Apr 2020 08:18:12 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/2] date.c: skip fractional second part of ISO-8601
Message-ID: <20200423011812.GA1930@danh.dev>
References: <cover.1586856398.git.congdanhqx@gmail.com>
 <cover.1587559135.git.congdanhqx@gmail.com>
 <c6d42785bb762f691b00c48b57c73a1933fadbc3.1587559135.git.congdanhqx@gmail.com>
 <xmqqk127jvrh.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk127jvrh.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-22 10:05:54-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> >  	/* Time? Date? */
> >  	switch (c) {
> >  	case ':':
> > -		if (num3 < 0)
> > +		if (num3 < 0) {
> >  			num3 = 0;
> > +		} else if (*end == '.' && isdigit(end[1]) &&
> > +			   tm->tm_year != -1 && tm->tm_mon != -1 &&
> > +			   tm->tm_mday != -1) {
> > +			/* Attempt to guess meaning of <num> in HHMMSS.<num>
> > +			 * only interpret as fractional when %Y %m %d is known.
> > +			 */
> > +			strtol(end + 1, &end, 10);
> 
> OK, so we saw ':' and parsed <num2> after it, and then saw ':' and
> <num3>, which we know is a good positive number.  We haven't checked
> what <num2> is at this point, but it has to be 0 or more digits
> (because we wouldn't have parsed for <num3> if it weren't terminated
> with the same c, i.e. ':').
> 
> *end points at the byte that stopped <num3> and we make sure <num3>
> is followed by "." and a digit.
> 
> Regardless of what <num2> is, we just discard the "fractional part
> of seconds" (assuming that <num3> is the "seconds" part).
> 
> > +		}
> >  		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
> >  			tm->tm_hour = num;
> >  			tm->tm_min = num2;
> 
> And after all that is done, if <num2> (and others) are within a
> reasonable range, we use that as HH:MM:SS.  
> 
> OK.  If <num2> (or <num3>, or even <num> for that matter) weren't
> reasonable, is it still sensible to discard the fractional part?
> The answer is not immediately obvious to me.
> 
> To be safe, it might make sense to extract a helper function from
> the next conditional, i.e.
> 
> static int is_hms(long num1, long num2, long num3)

I'll make it `is_time` on par with is_date check.
I'll look into it and check if int or long is suitable for parameter's
type.

> {
> 	return (0 <= num1 && num1 < 25 &&
> 		0 <= num2 && num2 < 60 &&
> 		0 <= num3 && num3 <= 60);

Does it worth to add an explicit comment that we intentionally ignore
the old-and-defective 2nd leap seconds (i.e. second with value 61)?

I saw in one of your previous email doubting if we should check for
`num3 <= 61` or not.

> }
> 
> and use it in the new "else if" block like so?
> 
> 
> 	} else if (*end == '.' && isdigit(end[1]) &&
> 		   is_date(tm->tm_year, tm->tm_mon, tm->tm_mday, NULL, now, tm) &&

When running into this, the code patch for non-approxidate hasn't
initialised value for now, yet.

And for non-approxidate, when trying to parse date, we initialise now
when guessing which value is year, month, day.

Does it make sense to initialise now from parse_date_basic, passed it
to match_multi_number via match_digit?

To me, it's too much a pain.

I /think/ it isn't worth to warrant a time(NULL) and another is_date
call here. We've checked it one when we set it before, no?

> 		   is_hms(num, num2, num3)) {
> 		/* Discard ".<num4>" from "HH:MM:SS.<num4>" */

Yeah, <num4> is better comment, since num meant different thing in
this file.


-- 
Danh
