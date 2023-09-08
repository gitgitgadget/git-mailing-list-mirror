Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD354EE801C
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 16:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbjIHQ3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 12:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjIHQ3w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 12:29:52 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4461739
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 09:29:48 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59234aaca15so23284477b3.3
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694190587; x=1694795387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbup0Y+xK6FK3sRaZDepJ1BnWKcxgPaS5lv0bNM7IA0=;
        b=h0CMcwvRBM+fyYGr8POIWoyOwCRcsr/G+aqR750TRqgpvHvMrQ9BgWMdwtRS3KfOxa
         RPTbWguhdl2One7PNU4uXuaII6lI/NVUNdfsyRAjk+MVS3J7pBVdcv6xGgkFpdfqmKwf
         IX9g1rFfd6SF5C5Iz3hGJu9gNKCDuWo/d6zl20nDOwShGULrKhZJluMdumWD5WnwRWg2
         gPeu4FhnCtNzNCqDykxqtPTlsQ2TCWOLdCRYCeijhWiKaKkQmlzPax+OoEzD/HDHPklM
         RugpGoscMfDRbKHms9pzhR52Orx5M5lxPjFAxYYdceF2vl7dmKGOCoYW2b4nULJCf6x1
         cpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694190587; x=1694795387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbup0Y+xK6FK3sRaZDepJ1BnWKcxgPaS5lv0bNM7IA0=;
        b=tJQPp/v8orKLHVlEF6hCrt/J1IY/CEo3WzeS0lfJcF6bTvAkRo53zV3P+0AY3klUmT
         AoT7Qu3gLlyabGkENXpj8//IXKb7s0++ZJDexpEitRN/ssjH8JFkqlpVbpvb6tNIVNMi
         d11882mBQt01jXvZM/rHHcPxkNdcc57E0lMKCOWMywToYYTclhfSw7oqyLtq0c4sqjWI
         X/YjL7GeVr0Y8btcI1Cc/nFkdhi9lxAJKk8pJuirgYlBwwjJyPFFeGk2idCO6aINGxPu
         GmU1g8NmSDwX9eQmH6aQ3IC/7VUwc84fUdh9s3sPikaLsKyT3qwIG097vbhiyxccE0nh
         SmSA==
X-Gm-Message-State: AOJu0YzvL4JC/JMkANz0v4O5evHijhXHYQWxa+WXUX068xgFZiyk3gWs
        jzNB8VIf+iUQXfyX8jE8wnn86NX2xgxfD7g7aJ7XnA==
X-Google-Smtp-Source: AGHT+IE1sfc6BmL28uX/P+dJM4Ra5kZOePs/jVl4rwNrw2aoF5CRRCOLz2fkywPpSaPUUmIKcMDLhw==
X-Received: by 2002:a81:5fc5:0:b0:54f:9cd0:990 with SMTP id t188-20020a815fc5000000b0054f9cd00990mr3242971ywb.18.1694190587034;
        Fri, 08 Sep 2023 09:29:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z62-20020a0dd741000000b005869f734036sm506962ywd.19.2023.09.08.09.29.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:29:46 -0700 (PDT)
Date:   Fri, 8 Sep 2023 12:29:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2023
Message-ID: <ZPtL+eu90tRuTxM4@nand.local>
References: <ZMATKIaU1A1D0wJg@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMATKIaU1A1D0wJg@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2023 at 02:23:36PM -0400, Taylor Blau wrote:
> Hi everybody,
>
> As I mentioned a ~month ago[1], GitHub is not hosting an in-person Git
> Merge this year. Instead, we're focusing our efforts on hosting a
> Virtual Contributor's Summit, the details of which are below.
>
>   - We'll host the Contributor's Summit on either Zoom or Microsoft
>     Teams (since GitHub is in the process of transitioning from the
>     former to the latter).
>
>   - The schedule/duration is not fixed, there are options to vote on
>     preferred days, length, and timezones in the form(s) below.
>
>   - To participate, you must be either (a) an active Git contributor,
>     (b) planning on contributing soon, or (c) working on a Git-related
>     project that has interest in Git's internals. If you aren't sure
>     whether or not you are welcome, please ask!

Now that most folks have filled out the forms, it looks like the winning
dates are 2029-09-26 and 2023-09-27. Among those dates, there was a
pretty even split between preferring a single day (with 9 votes), and
preferring two days (with 8 votes).

Let's plan on meeting on both:

  - 2023-09-26: from 10am to 2pm CDT (UTC-5)
  - 2023-09-27: from 10am to 2pm CDT (UTC-5)

The meeting will be hosted on Zoom, and I'll email folks separately
off-list with the meeting URL and passcode to join.

If you have any topics you'd like to discuss or lead, make sure to add
them to the "Topics" sheet at:

    https://docs.google.com/spreadsheets/d/1EnhmTeEqRBlEI2pMAO3oZ4rO1xEwBzYp2vS4CMtvge8

Between now and then, please also feel free to share any thoughts on how
we should schedule topics, organize note-takers, make sure the discussion
keeps flowing and includes everybody, etc.

See you then!

Thanks,
Taylor
