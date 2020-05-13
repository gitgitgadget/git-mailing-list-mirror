Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BBBC2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 06:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC29920708
	for <git@archiver.kernel.org>; Wed, 13 May 2020 06:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgEMGSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 02:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgEMGSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 02:18:13 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 May 2020 23:18:12 PDT
Received: from giant.haxx.se (www.haxx.se [IPv6:2a00:1a28:1200:9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99F1C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 23:18:12 -0700 (PDT)
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id 04D6H00E027923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 08:17:00 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id 04D6GxkN027912;
        Wed, 13 May 2020 08:16:59 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Wed, 13 May 2020 08:16:59 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
In-Reply-To: <20200512231331.GA6605@camp.crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.2005130812500.28445@tvnag.unkk.fr>
References: <cover.1589218693.git.jonathantanmy@google.com> <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com> <20200512231331.GA6605@camp.crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 12 May 2020, brian m. carlson wrote:

Sorry for going slightly off-topic, but I figure this could help as a sort of 
PSA.

> Since everyone uses HTTPS, it's not possible to perform this debugging using 
> a tool like Wireshark unless you use a MITM CA cert, which seems excessive.

When you want to Wireshark the connection with libcurl, your friend is 
SSLKEYLOGFILE. If you set that environment variable (assuming the libcurl TLS 
backend supports it - several do), libcurl will save the TLS secrets in the 
file that environment variable mentions - at run-time in a format that 
Wireshark understands.

Then you can analyze the traffic, in real time, with Wirehark without fiddling 
with a MITM etc.

-- 

  / daniel.haxx.se
