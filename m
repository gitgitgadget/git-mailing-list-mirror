Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25B41F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 18:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273AbcHCSGs (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 14:06:48 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36013 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757992AbcHCSGo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 14:06:44 -0400
Received: by mail-yw0-f194.google.com with SMTP id u134so17363470ywg.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 11:06:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PGgS44zmxe3L4VQUzfettjA4w54uyec6LqOPesxPDZE=;
        b=fWOtD7Hu33TciANg1PKqoQ2/9OZlHB+KlqrDQSpPqQxpF3hNGlTwlNLuvSAJNlPvfL
         ArLuRYjm35CrzLzU/xLw3fQLnGk4Mc/gdWFN9mzLUU1/+4bJjGsq30ewGilPgegDkObH
         rVUY3SnCcnbV8wWgw3Irk8jxLoxgXyWqsYIl3NjIcqMgxRZqHPCujCIMY1IHDY6PsSFT
         tAtCliQuHA5/jmOeBXY+brpcxjVQufj+pysvTkykJbJLqKW3CYclLeakXZSHFbLpQHOA
         fkm3BISKz0I26BvihN+IodycwT345K5ljxBfEphXzGgbBHL76EVk3B0/egnyTZliwHPN
         y3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PGgS44zmxe3L4VQUzfettjA4w54uyec6LqOPesxPDZE=;
        b=OV8C/TFHL77dLo2jtaRVqlysa1yQl8byQ8lN5AxuFnUPLUTdKVm5ZR0VkVo9N3oFJ6
         VY4b0rIL1HAYsVdeszClCADCTtPuTF9Y+HUgUHURrBJVU5kizaWO7xX0pnXSTUlZEWJQ
         a63blzs+IQQUvcYsCFK0ROmuGnwNFH2FrhZ9ri7l+mu5XBN7rQuD4dWJJuz0JB/Y93t0
         ZjU4IyWOK4ypdTkCxO8a35rXBBOIB7BwZm5jOMyV2MEnkfF5XBMJWwm0Q7mDBnTzgqXU
         JMyCMjfDR2PyRVFifWIcjF6qiCuvfyZHwtK7NyXCBHwkPgw8ROCvvIm6znp9hqSLnit3
         h5VA==
X-Gm-Message-State: AEkoouu5h/v3BIzXpI8h/IprIfR2qCgyzApmIUcuQuERrelPf7B5j0VsYGDESa5fiFpCSzM6jCYfABek/dLSfw==
X-Received: by 10.129.106.197 with SMTP id f188mr50926097ywc.38.1470246745242;
 Wed, 03 Aug 2016 10:52:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 3 Aug 2016 10:52:04 -0700 (PDT)
In-Reply-To: <20160803174522.5571-1-pclouds@gmail.com>
References: <20160803160536.15596-1-pclouds@gmail.com> <20160803174522.5571-1-pclouds@gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 3 Aug 2016 10:52:04 -0700
X-Google-Sender-Auth: gjHsHM90Ud7zIZ1DlgpjUaZuiC8
Message-ID: <CAPc5daU49iVYw14sYeshXDbHGE_nW4vWyM=2XSz-buACVLFwoA@mail.gmail.com>
Subject: Re: [PATCH v3] t7063: work around FreeBSD's lazy mtime update feature
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 10:45 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>  v3 differs from v2 in one line
>
>     --- a/t/t7063-status-untracked-cache.sh
>     +++ b/t/t7063-status-untracked-cache.sh
>     @@ -11,7 +11,7 @@ test_description='test untracked cache'
>      # containing directory in sync with the reality after doing blah and
>      # before checking the fast path behaviour
>      sync_mtime () {
>     -   find . -type d -exec ls -ld {} \; >/dev/null
>     +   find . -type d -ls >/dev/null
>      }

"this and that" and "blah" are still there.

If you mean to tell the user "I won't describe it in detail, if you
really want to know,
go run blame yourself", spell it out like so. I was hoping that you
can summarize
in-line there to help the readers here.

> +# On some filesystems (e.g. FreeBSD's ext2 and ufs) this and that
> +# happens when we do blah, which forces the untracked cache code to
> +# take the slow path.  A test that wants to make sure the fast path
> +# works correctly should call this helper to make mtime of the
> +# containing directory in sync with the reality after doing blah and
> +# before checking the fast path behaviour
> +sync_mtime () {
> +       find . -type d -ls >/dev/null
> +}
> +
>  avoid_racy() {
>         sleep 1
>  }
> @@ -416,7 +426,8 @@ test_expect_success 'create/modify files, some of which are gitignored' '
>         echo four >done/four && # four is gitignored at a higher level
>         echo five >done/five && # five is not gitignored
>         echo test >base && #we need to ensure that the root dir is touched
> -       rm base
> +       rm base &&
> +       sync_mtime
>  '
>
>  test_expect_success 'test sparse status with untracked cache' '
> --
> 2.9.1.566.gbd532d4
>
