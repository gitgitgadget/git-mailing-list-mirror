Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8109FCDB46E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjJKXoG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Oct 2023 19:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJKXoF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:44:05 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE99E
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:44:03 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0358C420D7;
        Wed, 11 Oct 2023 23:44:03 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0454C42075;
        Wed, 11 Oct 2023 23:44:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697067842; a=rsa-sha256;
        cv=none;
        b=GY5oPP2YqI60oQtzDFioGcI59iSqeBABQh9ekh8fHY7VUuJBjMiiPEM048nJD1Lvrv+KYs
        EaJQO4jTp9dc9j5XL00gr8vbhqcgginne+JYIDljQsRa3wzVpgO6Cpap0PZaXc7gASsjty
        11YQGrSSGTS0/xJnCD/94dfG7MrUHxN0+YjNlpYnIbjnsMd9J9tKa0yhjgpJlg8JMELbqx
        MhV/jl3Jhoj4s3jvDbw+OCIpxqFgjV7l4rlihojwdFfbecRszk0EvNzeVYt1xkuF3/Zst0
        5XUa65go4ty7jPz7cVTITsHVGlcTMhhTXXQ0DiW/Wtl3YXHZ02+JUEZXnDZoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697067842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKcntRd29sp0n7N82UhpIYCuthwRKmQM7AFHv6uMQ50=;
        b=c6V3dhY5fIQHxAfNTTALkS5E5rI6QEzsjFNxCZ4vOx/UDrWhROOFOAqvt4erCh45/MH15s
        3cSoo53VCYi7Y3cuDniL4Ms5XQv1D456cUSXeL8zKzzpzkhrvuAPnYcVLfTLBhesWx2/Fh
        jxmiJx1n5rToUtw0QbvV7SkbEIcKB6VGAnFvT+jGVSSml3QAzbnRZltOvtZIsGw5BYFltx
        Y7mzpmVCzbC2ou796H9l6FRgxUm8XuObksu7zI7hbCGTciIfOMVQ7UX5snv9BB4pfjVWpr
        wS3TVn/ihnqm0GwY4txyXzmVph1BsJrFuDnc4+XBQ82TQL6FSbsSyJhlfziVKw==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-g6jkh;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Broad-Spill: 559b88a76a2012cc_1697067842788_862166112
X-MC-Loop-Signature: 1697067842788:1491282793
X-MC-Ingress-Time: 1697067842788
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.222.7 (trex/6.9.1);
        Wed, 11 Oct 2023 23:44:02 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:37786 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qqirt-0002dP-1w;
        Wed, 11 Oct 2023 23:44:00 +0000
Message-ID: <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Thu, 12 Oct 2023 01:43:54 +0200
In-Reply-To: <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
         <xmqqa5sokdd3.fsf@gitster.g>
         <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
         <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
         <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
         <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2023-10-12 at 01:29 +0200, Dragan Simic wrote:
> I'm not sure what do you mean by the non-cleared remains being
> chopped 
> off...  Could you clarify that a bit, please?

Well if I do say:
$ reset
$ git diff HEAD~10

and from there scroll down a bit and then q to exit less (and the
screen is not cleared), I see the output only so far as I've had
previously scrolled down in less.

Everything that would have come after that is of course not visible.
The place where I exited may be some "well defined" border, like the
end of a commit... or anywhere it the middle of a patch (making the
left over remains on the terminal perhaps even ambiguous).

What's worse, when (in less) I scroll down and up again, perhaps
repeating several times, and then quit... I see (at least in my
less/terminal combination) things twice and mangled up (i.e. when I
scroll up the terminal (outside of less)).

So AFAICS, not clearing the screen only works properly when never
scrolling up again (in less).


> As I already mentioned above, everyone is free to configure the pager
> behavior in any way they like.

Sure :-)

> 
> > > Exiting if less contents than one full screen was displayed (i.e.
> > > "-
> > > F")
> > > is there to save people from the frustration of quitting a pager
> > > that
> > > actually wasn't needed to be executed.
> > 
> > Same actually here, at least strictly speaking, ... though I (and
> > probably everybody else?) would really hate it, if that was
> > removed. ^^
> 
> I'm afraid that I don't understand very well are you complaining
> about 
> the presence of "-F" or not?

No :-) As I've said, I like it that way and I and probably everyone
else would be annoyed, if -F was not present.

I just meant that strictly speaking the same reason why "S" was
removed, could be applied to "F" as well.

It is - like -R - not necessary for less to work with git.

But it is, of course, what virtually everyone will want in practise.


> Quite frankly, I can't stand scrolling in less(1) using the mouse
> wheel, 
> but I do understand why some people like it.

The main reason I want it is, that things don't get messy, when I
forget being in less and mouse scroll. ;-)


Thanks,
Chris.
