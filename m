Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411ED20951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdCNVuH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:50:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34144 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbdCNVuG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:50:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so20601062pfb.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7sF1Qw+ZKTOrn906vmI05z0MWVEdJwzq+X0nFH4U/x4=;
        b=nlJNnueH09Fcl03fPLor0xboQVg2EsIUo+Z7poFXpRjXdIJ42D598wJ5Ax8az5bPOd
         bUe0elOLXSw06i9b+1EEaCsWpAm0bF11JAZuAKWrb0ldOD95t/sp6zz31vO95cMmso8o
         BdqxRuX4KCmQ+1hibOxpDrX9RAunfOnM8RLqJGfgQXS3KAWqY66fPtGZEQUqZBYLUk5s
         1wAWqnYZGwdfK2nnfHAvJM/t6GoeJU/YSeoQJqicEeClxnu7igaAX4FyjO1N5/cVNqUo
         VgQ6c1ZDnRvazjk5BN1e8qb/sj4OkExeX/SgyMjZDy4PHdObGpOyriASad/1EwVCNk2b
         pEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7sF1Qw+ZKTOrn906vmI05z0MWVEdJwzq+X0nFH4U/x4=;
        b=KZpJhxuALyJa1jVVnYei5QQT2QIyht9/RSL1In2sNVKmfVTQGrj991ArkVwItYKM4G
         GNRoZnTHLhFW/unHVRwprTcwRMORPylxawTX+wCykkKjieJu61DM3qkP9jrd/vAKxmD/
         MWnmT+HhMdRTrjJ7YBPoT+d68DvovTZjFWbYTu7kSu9felsNq/XAeZaCJWg9XG7ZcUWI
         xSH/cKhQRWCzvCmHN5XtJj3ZGvLhcacCjNJDHVSkglQ8WK5MhTLxINVpKTwYHowKp7yQ
         bElpsGqhCt7mhcQExMm38prnkH4PqCJURBOHQFj4KsiyZfkyDI0RkepCu6lfOQYQFNH+
         sYdw==
X-Gm-Message-State: AMke39lWqSnqd3EmBgONS+6/KeucpI306lgwRrFQqO7MEeydQBJ70u57fngPVyFDqNTWgQ==
X-Received: by 10.98.107.194 with SMTP id g185mr47001708pfc.22.1489528205448;
        Tue, 14 Mar 2017 14:50:05 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:44b6:c180:5bab:cbd2])
        by smtp.gmail.com with ESMTPSA id b14sm40357007pfh.114.2017.03.14.14.50.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:50:04 -0700 (PDT)
Date:   Tue, 14 Mar 2017 14:50:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
Message-ID: <20170314215003.GK26789@aiede.mtv.corp.google.com>
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
 <20170314184126.GJ26789@aiede.mtv.corp.google.com>
 <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
 <xmqq1stzio5b.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1stzio5b.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> [jc: make BLK_SHA1 the fallback default as discussed on list,
> e.g. <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>; also
> remove SHA1_HEADER and SHA1_HEADER_SQ that are no longer used].
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for taking care of it.
