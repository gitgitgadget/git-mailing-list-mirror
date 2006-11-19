X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 12:44:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611191242000.3692@woody.osdl.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com> 
 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>  <20061118184345.GO7201@pasky.or.cz>
  <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com> 
 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>  <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
  <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org> 
 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com> 
 <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org> 
 <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
 <e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
 <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 20:44:30 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31862>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GltWY-0002SY-G1 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 21:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933230AbWKSUoT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 15:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933247AbWKSUoS
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 15:44:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:30936 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S933230AbWKSUoR (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 15:44:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAJKiCix007606
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 19
 Nov 2006 12:44:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAJKiBIf017397; Sun, 19 Nov
 2006 12:44:12 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 19 Nov 2006, Linus Torvalds wrote:
> 
> So the optimizations that _can_ be done are:

Of course, doing a "git repack -a -d && git prune" is always the #1 
optimization. It will still look up the objects, but it will be a lot 
faster about it, and avoid a lot of the really bad IO patterns.

If you don't want to repack, you could try just doing a "git clone" and 
then doing the "git pack-refs --prune" in the clone too. And compare 
cold-cache times between the two "identical" repositories.

