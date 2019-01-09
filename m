Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE93211B5
	for <e@80x24.org>; Wed,  9 Jan 2019 22:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfAIWtO (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 17:49:14 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:47097 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfAIWtN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 17:49:13 -0500
Received: by mail-io1-f43.google.com with SMTP id v10so7355671ios.13
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJSPJGCC5blNabaRNaBDbG1YylFWuYk/Q/IOazBWf20=;
        b=ZlPhqRCmTYLO5O/LXSzzBqUHqiz6f6zdldzEr3XdaKhzxeYHlKApXeNVWkR7GGPw/R
         SKJpbwcHpXoPy1Fec1jyLKEqmTOm2Hcu7gLFJSQkqlYC7/DRmhAO0bgAGkt26yYeHfBT
         aTEu20rAlWOPZsMB2ni64NXISaTkeLxEPp3lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mJSPJGCC5blNabaRNaBDbG1YylFWuYk/Q/IOazBWf20=;
        b=fH1M+h8/EcaJW9OW6yEngNTfCdPu21qlXu+0//y8urR/HhKaMic1x+Gxje3/Fi/Sbu
         ZvJ0aD9kLaKhY2xFDpmZq7QmhvvCJUFtnEpRPP46ogU9jotBKzfCRsMTd6nEcCQzHuoZ
         PVmQLUlkVvQEWbv6S/e0ZcGsziOfzQD4xGfbic/KGMn99x6lySzXKYjx5h7eIQrgt18T
         NbY08UuqhUtulIswBmGtFtYGID2zEDlsYUrsxF3og1k2trzm9d4qX6S0/H7ENOHcquyy
         dpBrt/i8BRpxf1MkOx0WGkHzvDK1XanDK/JmVErMbdbXcNZMawEbHQHSUNKpeC6WChhy
         PMbQ==
X-Gm-Message-State: AJcUukdIth+kY3OuOoCdJD7AS1QfrBbC1FuZ3Ko2Cp5xOkSRQXqQLlTp
        t3q/CnqtEbdSfrsWJoo6Utt1LvH4FW5sMg==
X-Google-Smtp-Source: ALg8bN6rVKdL6g/Y7THBX5f8SZjxJ99sopc39+elyALPptqy2WNQ3spfKaQl65loi7N+LZc3HI15qg==
X-Received: by 2002:a6b:8f08:: with SMTP id r8mr5294117iod.56.1547074152700;
        Wed, 09 Jan 2019 14:49:12 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id y76sm9473205ita.18.2019.01.09.14.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 14:49:12 -0800 (PST)
Date:   Wed, 9 Jan 2019 17:49:09 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     Eric Wong <e@80x24.org>, git <git@vger.kernel.org>,
        meta@public-inbox.org
Subject: Re: "IMAP IDLE"-like long-polling "git fetch"
Message-ID: <20190109224909.GC8258@pure.paranoia.local>
Mail-Followup-To: Stefan Beller <sbeller@google.com>,
        Eric Wong <e@80x24.org>, git <git@vger.kernel.org>,
        meta@public-inbox.org
References: <20181229034342.11543-1-e@80x24.org>
 <20181229035621.cwjpknctq3rjnlhs@dcvr>
 <20181229043858.GA28509@pure.paranoia.local>
 <CAGZ79kb9Tbnxe1mSnxpqT_FO6Gdi6wxd-r2YarHXRF1sVRyxLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb9Tbnxe1mSnxpqT_FO6Gdi6wxd-r2YarHXRF1sVRyxLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 09, 2019 at 02:27:25PM -0800, Stefan Beller wrote:
> > > I would've thought somebody had done this by now, but I guess
> > > it's dependent on a bunch of things (TLS layer nowadays, maybe
> > > HTTP/2), so git-daemon support alone wouldn't cut it...
> >
> > Polling is not all bad, especially for large repository collections.
> 
> I disagree with that statement.
> 
> IIRC, More than half the bandwidth of Googles git servers are used
> for ls-remote calls (i.e. polling a lot of repos, most of them did *not*
> change, by build bots which are really eager to try again after a minute).

Oh, that's not the kind of polling I meant -- we monitor a single
manifest file containing the state of all repositories. It's a static
file served directly by any httpd daemon, and the only traffic is
usually the "not modified" http header.

-K
