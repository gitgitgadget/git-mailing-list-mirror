Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB631F424
	for <e@80x24.org>; Thu,  5 Apr 2018 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeDEKeC (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 06:34:02 -0400
Received: from smtp-out01.xworks.net ([31.25.48.13]:21761 "EHLO
        smtp-out01.xworks.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeDEKeB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 06:34:01 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Apr 2018 06:34:00 EDT
Received: from mailbackend2-1 (cluster06.xworks.net [10.100.1.80])
        by smtp-out01.xworks.net (Postfix) with ESMTP id E0A016126C;
        Thu,  5 Apr 2018 12:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=directbox.de;
        s=mail; t=1522923904;
        bh=xhcoN1QcFuIV7DOwD0y0HZJ5ie8pPituYRHmZpBz+hs=;
        h=Subject:To:References:From:Date:MIME-Version:In-Reply-To:
         Content-Type;
        b=N8K8f2Z8dxPZHz9KyWUa6WW7GR2PiDQHuiDHu1mgqZYQ9DpwnBfa/aK2QMc9XDBbt
         aGEjLj8rBuydw0hl1B8L28mpNmWhrPel2+6J/S8ATcamN7y7b0BnvJ12pvFoVTEI1j
         UMWVry/GtuWO6FS5W3XH4grGu0A+DFqsmc+88j4E=
Received: from [127.0.0.1] (tor-relay.zwiebeltoralf.de [5.9.158.75])
        (authenticated bits=0)
        by smtpa.mediabeam.com  with ESMTP id w35AOvIt010972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 5 Apr 2018 12:25:02 +0200
X-mediaBEAM-Originating-IP: [5.9.158.75]
X-mediaBEAM-AUTHID: [astian@directbox.de]
Subject: Re: How to configure sendemail for no-auth?
To:     git@vger.kernel.org
References: <20180405092358.569e0315.olaf@aepfle.de>
Cc:     Olaf Hering <olaf@aepfle.de>
From:   astian <astian@directbox.de>
Message-ID: <e80299e3-1e84-c043-0f30-5cf97aa83ffb@directbox.de>
Date:   Thu, 05 Apr 2018 10:24:00 +0000
MIME-Version: 1.0
In-Reply-To: <20180405092358.569e0315.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-mediaBEAM-AuthCheck: route13
X-mediaBEAM-AuthScore: 2.5/5.0, scanned in 1.101sec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olaf Hering:
> My ~/.gitconfig looks like this, because all cloned repositories require these settings:
> [sendemail]
>         from = Olaf Hering <olaf@aepfle.de>
>         envelopesender = olaf@aepfle.de
>         chainreplyto = false
>         ccover = yes
>         smtpencryption = tls
>         smtpdomain = sender
>         smtppass = smtppass
>         smtpAuth = PLAIN
>         smtpserver = smtp.strato.de
>         smtpuser = smtpuser
>         confirm = always
>         assume8bitEncoding = yes
>         transferEncoding = 8bit
> 
> Now there is that one repo that requires this:
> 
> [sendemail]
>         from = Olaf Hering <a@b.c>
>         envelopesender = a@b.c
>         smtpserver = otherhost
> 
> That "otherhost" does just plain oldstyle unencrypted SMTP.
> 
> How do I undo the global sendemail settings for that one repo?
> Setting the knobs to empty strings does not help:
> Command unknown: 'AUTH' at /usr/lib/git/git-send-email line 1455.
> 
> It seems the global smtpuser is causing the error.
> 
> Olaf

Hm, I remember successfully doing something like this, quite some time ago.

Couldn't you simply disable smtpEncryption in the .git/config of that one
repo?  E.g.:

[sendemail]
  smtpEncryption = none

You might also want to take a look at "identities" in the manual.  And related
to that, there's a patch in this old (never merged) series of mine which might
be useful since I believe the documentation bug it fixes still exists.

Cheers.

