Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CA9C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C1220885
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 15:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfKTPPr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 20 Nov 2019 10:15:47 -0500
Received: from elephants.elehost.com ([216.66.27.132]:58157 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfKTPPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 10:15:47 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xAKFFhO9064182
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Nov 2019 10:15:44 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <noloader@gmail.com>, "'Git List'" <git@vger.kernel.org>
References: <CAH8yC8n+ta4BSAE4rEfhKxe3T9poVdc94HvSk=6PEA4YbmwVyA@mail.gmail.com>
In-Reply-To: <CAH8yC8n+ta4BSAE4rEfhKxe3T9poVdc94HvSk=6PEA4YbmwVyA@mail.gmail.com>
Subject: RE: Commit signing and pinentry problems
Date:   Wed, 20 Nov 2019 10:15:38 -0500
Message-ID: <02c601d59fb5$60dfbbf0$229f33d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLolwpW5nFG0NH9h9vSuvfBtzZSuKVuOuNg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 20, 2019 7:41 AM, Jeffrey Walton wrote:
> I'm having an annoying problem that I can't figure out. I hope Git has a
> setting to fix it.
> 
> I have a desktop workstation where I sit at the keyboard about 1/3 of the
> time. Git signing works as expected. About 2/3 of the time I SSH into the
> machine. Git signing does not work when SSH'd in.
> 
> When Git signing fails over SSH an error looks like:
> 
>    $ git commit -S log.h -m "Remove unneeded header"
>    error: gpg failed to sign the data
>    fatal: failed to write commit object
> 
> I just noticed this today (but it makes sense)...
> 
>     - Go to desktop workstation, log in
>     - Go to remote machine, log in
>     - Sign at remote machine over SSH
>       - Desktop workstation will open GUI password prompt
>       - Remote machine sign operation will hang until GUI prompt times-out
> 
> The problem was reported to Ubuntu but no activity:
> https://bugs.launchpad.net/ubuntu/+source/pinentry/+bug/1852696 .

I would refer you to the GnuPG project lists for answers to this issue. However, AFAIK, gpg requires a real terminal from which to obtain a password with the intent of not allowing malicious code to capture the password by a man-in-the-middle attack. Depending on the platform, stdin is not acceptable. Check the GnuPG project common/ttyio.c module. It may be that your setup is not providing an apparent terminal so the prompt may actually be happening elsewhere than where you expect. I have had a similar issue with Jenkins when not running fully headless, and the password prompt was on the tty where Jenkins was started. This is unlikely a "hang" per se.

Good luck,
Randall


