Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08ABA20179
	for <e@80x24.org>; Fri, 17 Jun 2016 12:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbcFQMsu (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 08:48:50 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33711 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbcFQMst (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 08:48:49 -0400
Received: by mail-yw0-f172.google.com with SMTP id g20so70478301ywb.0
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 05:48:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o4VkVh3QrdEnLKcEcnqYazyQjhSYlMM5H6ycO1J0MsU=;
        b=jv5Iy66I3NCTcerj3tgGKpS+06kc2442/JSSNjuBfF3t5SFr2IXU0XGoIJvgikICm0
         cOcPWboyPBLZvLlb4JxJ82Nvwua13GMVlDmfC0YrFtv8g2urV0pwcR4AmMOycKnvCpWK
         QDjtbqyGGpmtKsfxxUKHZc19N7MVwL+zvfNWJmu4Ndg+1F7r6+R16nrYwtnFXaYR7Wv+
         Lyyc9QXX4MnxLjIdt8eYkgdwV3E0SrSC7Y54wdD2/c4pxDOw5N5W90h5DOBhYcn8H48A
         aeKOxllYcroRcYycgXvyCRv8i99wG2ghGmXh3/8QbA2azLx9HiQIigDuKDX98J9PqdtY
         aikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o4VkVh3QrdEnLKcEcnqYazyQjhSYlMM5H6ycO1J0MsU=;
        b=T7awrkgKG4eANQCe2FSafZWZIsU+WW21Fo7daq5BuWK3AVnqGSB4lODLGzw3MdnXHu
         cs3mNGfp60hvAvTTFY9TJgKkcy93Wcaoe7S9hjyPj6ayWfbAetrFOuP5HqrMKwODiJLx
         sj8nvgVmVJzGeqaz9weByq4mtO6/QAiL49htYYRWNIkMbDjM6imPxd3ZMFcJcd7f82xE
         KpkJGrbaFj6wIb2xVeRIckWbyaVd29qDoCT5MsI65PA0W2G8uNv2WstrdqPS0sC8HQzs
         ItmpbGyNBbCr57t3gJaM8i2dNaXqinrQx4tGHD76vX6n9OsdGXZwO8Dv0RgZUj+93R23
         EmEw==
X-Gm-Message-State: ALyK8tKQl3uQPPM2L9Jro9hLTC2fHlXg44ZRizhnNrSScWoIUuFXfqIROFmtFQpeCB1RpGSWVys2LfM7Atf9KQ==
X-Received: by 10.13.254.130 with SMTP id o124mr1059911ywf.30.1466167728565;
 Fri, 17 Jun 2016 05:48:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.116.193 with HTTP; Fri, 17 Jun 2016 05:48:48 -0700 (PDT)
In-Reply-To: <B8F28BE0-B43A-489F-9BCC-B40712C450D3@gmail.com>
References: <20160524072124.2945-1-pranit.bauva@gmail.com> <20160524072124.2945-3-pranit.bauva@gmail.com>
 <B8F28BE0-B43A-489F-9BCC-B40712C450D3@gmail.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 17 Jun 2016 18:18:48 +0530
Message-ID: <CAFZEwPNJLk3Y2KQopsc6AC4-LHUeam-ts5sHn4qdhbKM8UWiGA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] bisect: rewrite `check_term_format` shell function
 in C
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Lars,
Hope you enjoyed your vacations. :)

On Thu, Jun 16, 2016 at 12:40 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> On 24 May 2016, at 09:21, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>
>> Reimplement the `check_term_format` shell function in C and add
>> a `--check-term-format` subcommand to `git bisect--helper` to call it
>> from git-bisect.sh
>>
>> Using `--check-term-format` subcommand is a temporary measure to port
>> shell function to C so as to use the existing test suite. As more
>> functions are ported, this subcommand will be retired and will
>> be called by some other method/subcommand. For eg. In conversion of
>> write_terms() of git-bisect.sh, the subcommand will be removed and
>> instead check_term_format() will be called in its C implementation while
>> a new subcommand will be introduced for write_terms().
>>
>> Helped-by: Johannes Schindelein <Johannes.Schindelein@gmx.de>
>> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>
> Hi Pranit,
>
> please drop my Mentored-by until I contribute something
> useful. I feel bad being mentioned in the same way as
> Christian although he does all the work.

Sure! I will looking forward for you to comment more!

Regards,
Pranit Bauva
