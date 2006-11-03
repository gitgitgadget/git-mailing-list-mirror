X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 10:48:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611031034520.25218@g5.osdl.org>
References: <20061101090046.1107.81105.stgit@localhost>
 <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
 <20061102113631.GA30507@diana.vm.bytemark.co.uk>
 <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
 <20061103095859.GC16721@diana.vm.bytemark.co.uk> <20061103100142.GD16721@diana.vm.bytemark.co.uk>
 <454B30E4.8000909@shadowen.org> <454B4C43.2040607@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 3 Nov 2006 18:49:38 +0000 (UTC)
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <454B4C43.2040607@shadowen.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30872>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg46M-0006zH-QX for gcvg-git@gmane.org; Fri, 03 Nov
 2006 19:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753463AbWKCStH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 13:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbWKCStG
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 13:49:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58507 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1753461AbWKCStE (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 13:49:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA3ImooZ026163
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 3
 Nov 2006 10:48:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA3ImnoD029241; Fri, 3 Nov
 2006 10:48:50 -0800
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org



On Fri, 3 Nov 2006, Andy Whitcroft wrote:
> 
> Heh, well the copy thunderbird wrote directly to my mailbox is also
> 8bit.  And thinking about it I've seen talk of MTA's not supporting 8bit
> xfers between themselves, so thats probabally when it gets switched.

If your ISP mailer doesn't answer with "8BITMIME" to your EHLO, your mail 
client is supposed to downgrade to a 7-bit format (or the same thing can 
happen anywhere in between on one of the other hops).  Of course, that 
would be a really old and broken mailer, and if you find one of those at 
the ISP you use, you should probably switch ISPs.

Some other mailers have other issues, and qmail for example is apparently 
totally broken (it accepts 8-bit input, but cannot forward it properly to 
somebody who wants it converted to 7-bit).

And some of us use "fetchmail" and ask it do do mimedecode for us, so that 
even if it arrived as 7-bit crud, we don't have to see it. So the fact 
that some people see it as 8-bit can be because the hops to them didn't 
involve a broken remailer, but it could also be because something in 
between (like fetchmail) tries to fix it up after the fact.

That said: it tends to be unusual to see true 7-bit mailer setups these 
days.

So the most _likely_ cause of unnecessary 7-bit QP crud is not in fact a 
7-bit mailserver, but usually just the mail client that is just lazy and 
just sends out everything as 7-bit because it's too bothersome to even 
look at whether the mail server supports 8-bit data. Check your 
Thunderbird settings - it's quite possible that there's a flag there 
somewhere to turn on 8-bit mail transfers.

