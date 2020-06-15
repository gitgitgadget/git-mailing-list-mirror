Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BC1C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B698207DA
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 18:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oww4iQbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbgFOSHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFOSHt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 14:07:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D52C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 11:07:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a127so8136727pfa.12
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1YRByHdpXGBxUsodC+kfejc77Y7b0hbOXMQ8rp7FS/M=;
        b=Oww4iQbKpB0p+zniIKF4OhRzRr5kmXBA4zFPPXJcIU0VfUHUrbLY9Ysoe7d0jOTsVf
         1BdWQxsE1yObpfFvod3cR+EJEe1ydr9NP8a+HYAnNAjXFYhrsPLSt3HJ+oueC8GsA+BF
         Kx1wBLIAcp/XQveaaZPZUFi+eGuPCwcB5iACzFMuzEFkvUDjcXig+GE5I9n9wbmlthyf
         gHEjeKDIbhECu5dX8ayjlmGHW31yL2LDwErx9NrjSt6BMTNr6ONYHUHGu16EeDZqeU8u
         9KmhP9OSxgaLA+e1lVX1p9oBX45nOJonK+qalkOcr+2EHCFwlzTLLRiqIHgLqGGHQgnk
         S9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1YRByHdpXGBxUsodC+kfejc77Y7b0hbOXMQ8rp7FS/M=;
        b=Eeexf9JaByQ8FSc/oDC4ylBqsn2/vLCPBQx5uOPw3BF6u3SvNoVP/E74ip8dlHqGo7
         HrUVqDLVT1tTvJ9E903ZAsBPvjQ/s3Uzbgj+qpBqvLRWp38is0bzpAdlIzzOmkulB3lt
         1JIxsS761t0+71TnP+q7c9I+V3voXaE9yGTnOchSxTT2wWPCShQcxvv18YBAhc87wM0Y
         hBwTkv6JRSE4swdMEQiVD1j7uaTkyWdSGQmEsK0LrmYBex46EoOAfOyVI9B5m/876xRu
         GShf4Hjfp8cqgQVYu4ZwZusEZdhGYPltMzN90MXSaWT3nxeu8pGL7BYG6ZbtSU4Gqzf2
         4Ffg==
X-Gm-Message-State: AOAM533RGInZ26k4diwBBo/VHm4TFnwlmleNrL+D6U9AIU8QEzfuTuHR
        Yx7UDbmxvoZOVgAqYPU5PqA=
X-Google-Smtp-Source: ABdhPJxv9F166z3JFn3XB9Bsp+G2i56x+gOPxajma7fK6cZ3InbzS5CgSpy2uBjAilrM8zm0ATWYLg==
X-Received: by 2002:a63:455c:: with SMTP id u28mr13220417pgk.374.1592244467092;
        Mon, 15 Jun 2020 11:07:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id f18sm12474668pga.75.2020.06.15.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:07:46 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:07:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>
Cc:     philipoakley@iee.email, Johannes.Schindelin@gmx.de,
        don@goodman-wilson.com, git@vger.kernel.org, msuchanek@suse.de,
        newren@gmail.com, sandals@crustytoothpaste.net, simon@bocoup.com,
        stolee@gmail.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200615180744.GB135968@google.com>
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
 <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sérgio Augusto Vianna wrote:

> There's nothing to be resolved because there is no problem. If someone reads
> "master" and gets triggered because all they can think of is racism, that
> person needs therapy.

Please stop.

Regardless of your opinions, this is not acceptable conduct on the
list.  It is perfectly possible to describe your needs as a user and
your opinions about best technical courses of action without insulting
people.

It's also not particularly effective.  There's a clear consensus
already among active Git contributors that changing the default branch
name is a problem worth solving, and there's active work being done in
that area.  You are free to roll back these patches in your own local
copy of git, but repeatedly asserting that *you* don't value this work
is not a particularly productive way to participate in the Git
project.

Jonathan
