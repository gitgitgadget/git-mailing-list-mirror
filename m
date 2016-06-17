Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF00720179
	for <e@80x24.org>; Fri, 17 Jun 2016 16:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbcFQQS6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 12:18:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36337 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbcFQQS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 12:18:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id m124so854964wme.3
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 09:18:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DtEklnHFyCrjDEUxojY8acbIN+ZZm4Zx+LMcqxSBAT8=;
        b=fyd6b+LTqNsdcf+6yd34ehKPEpm5hXFs9/2UqQqaXldGtJg6eCqWP+eGk6uG7nAPz4
         0PDuU3UfwTZEILBx4i+ubK7QLqpwFBiQiewGrInjPttrtW5Q8UsiTvxV0bYSpYfYoWZ0
         LcbMpP+LfOUXfu10BQlMp4yV4doC0yyykSsYZKuJvzD7MpxzKekPw4AAxm69Y3qHbNyI
         CSyTf+7OytWPh7z4hdGli6tDvXFwesnlgOO4pr2V38GD1cK1+wVdoAh9Eut/dtytIR62
         yjyvhAOjfvHznZFrQhtocl5tNthZ1KmuJOKbdMqR37aa5n16hO4Ieb8tHLQrTFXdDSC7
         BsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DtEklnHFyCrjDEUxojY8acbIN+ZZm4Zx+LMcqxSBAT8=;
        b=nDrcRdzmboUtor443QuehqQB9egJFTFiD54CGj6A8zpUgBavfS9cCOTjCDC+gAwQbp
         2QU7BTPthCE/pB41lH0X7fEm5CrYXSlNNwUWwjUrylOEmTFJVr0nndxo3n8ZrbwaJ5Cj
         9SQDosTN/y9Cxb/fq26826oI+x2pvcQJKRxGqSTeefegklx2oeurQqGFdq4SWks6fgi1
         vNCe0qprQklHgoOl80a5ncmX4Q5XsiRKDji1DoUYzwMLWb3yBaeVUEXJHW9uCDle50IR
         GUpis42bMrUCghS2UjlImqlxXMH2gqTvpXZ954qol22XXqixwS7gsL15KMvmtjkXktg7
         omzA==
X-Gm-Message-State: ALyK8tJH91sOcCraKmk5z7hijVH8vkHRikL80zcfonpYYxau6y+gBBhd9DmoToLicIdV8iV4kdkw0llHpkYitQ==
X-Received: by 10.195.17.166 with SMTP id gf6mr3129500wjd.124.1466180336620;
 Fri, 17 Jun 2016 09:18:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Fri, 17 Jun 2016 09:18:56 -0700 (PDT)
In-Reply-To: <1463694357-6503-17-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-17-git-send-email-dturner@twopensource.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Fri, 17 Jun 2016 18:18:56 +0200
Message-ID: <CAP8UFD0qW3Xja2F3CyXzeA+-mVCAQ40iGcx6+xuvQnA2BBa3tA@mail.gmail.com>
Subject: Re: [PATCH v12 16/20] index-helper: don't run if already running
To:	David Turner <dturner@twopensource.com>
Cc:	git <git@vger.kernel.org>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
>
> diff --git a/index-helper.c b/index-helper.c
> index 4a171e6..ddc641a 100644
> --- a/index-helper.c
> +++ b/index-helper.c
> @@ -438,6 +438,13 @@ int main(int argc, char **argv)
>                 return 0;
>         }
>
> +       /* check that no other copy is running */
> +       fd = unix_stream_connect(git_path("index-helper.sock"));
> +       if (fd > 0)
> +               die(_("Already running"));

I wonder is we should also die if fd == 0.
