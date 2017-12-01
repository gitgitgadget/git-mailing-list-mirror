Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEEC520954
	for <e@80x24.org>; Fri,  1 Dec 2017 20:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbdLAUGR (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 15:06:17 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33433 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbdLAUGR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 15:06:17 -0500
Received: by mail-pg0-f68.google.com with SMTP id g7so4935026pgs.0
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 12:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pE6EBur15xUj5N9ESqgKGvSE+itsUlLwMGgK9MlsTCM=;
        b=Hb5Sz0PkpsW51DKIEAk7J3gU6LvVRQkq8gYiejLYOUbhh/1yNTRbeGAdzAz3CYKmID
         toobwmJv6joifXDrR0F6QPXNOskaCnWtE22VxpTndnowp5mUX/A9k4uuXkYLptsIHCga
         kfdULtVmHuThAz0biiaEYzrC63hWZkKDPykHyubZhxzZLRWr3Xpa5wvKxo99kB0igEDM
         YEu6fe1TRrwN0RzKkiLv91pqpy+3fHMlGMFTgT7Xy5L4qVRoQo/w2047IHwkvCHWSEEq
         SF9gimovWEQTFYTyc0gW43fnp/ELTJSqB3woO1M0CRRruQejTNOg7Xwgw+SNKuLa93rq
         U+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pE6EBur15xUj5N9ESqgKGvSE+itsUlLwMGgK9MlsTCM=;
        b=a/03HjoO7K4Z/iapLBCU8zuxGno3Bo+MBADjTAgZuIqUjm2F0Seb5jgZV9P2ybdBBq
         ZpQ5IXPp3YpJW/D9ofwu5/FmRlbALavM+dtmy5TlzbsDjYxByAnxgJdk5gCuWiOAjqwA
         rQGpbqG2MMe8Eg8rfqZh/fnyyL1GyYgJBFTluUyD46oDuqTXK5jUDicMTA9XRs7DJOWf
         D+qhLDXh8rrxLBvmnl5f2awV9ltWt61EL/JfV8EdGYGASvyefuLyD77fZNULmtp1kERv
         0OuPIZWlCgRebOGKhsh2Evm18/wBCH5yLCrqnxMNwkmTcq/u7EYboYHQY212byLQkH9k
         BB+Q==
X-Gm-Message-State: AJaThX5nUU5ZeTPlozMUDFUd0IeeX4f1lscUM+3FIQ6hY6Apl72c4UtW
        /89dR0U7UPRg8Hg25egtiGM=
X-Google-Smtp-Source: AGs4zMZ9AfF+wi+TDXIRLrigzEnB9BRZIci0EmR5P57lRTgPL5fIO8SkH3c7VLLQdS4bfoHxuSQQGQ==
X-Received: by 10.101.71.205 with SMTP id f13mr4510291pgs.112.1512158776297;
        Fri, 01 Dec 2017 12:06:16 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g9sm13538298pfk.0.2017.12.01.12.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Dec 2017 12:06:15 -0800 (PST)
Date:   Fri, 1 Dec 2017 12:06:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 2/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171201200613.GC18220@aiede.mtv.corp.google.com>
References: <20171201041133.GF3693@zaya.teonanacatl.net>
 <20171201153241.27071-1-tmz@pobox.com>
 <20171201155653.29553-2-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201155653.29553-2-tmz@pobox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  t/lib-git-svn.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

This and the previous one are indeed still
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
