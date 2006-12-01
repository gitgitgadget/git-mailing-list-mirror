X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 14:26:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de>
 <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> <200612012306.41410.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 22:27:26 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612012306.41410.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32975>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqGqe-0003bs-CV for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162113AbWLAW1J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162112AbWLAW1J
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:27:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:7861 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162113AbWLAW1H (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:27:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB1MQqjQ011667
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 1
 Dec 2006 14:26:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB1MQpfK029662; Fri, 1 Dec
 2006 14:26:51 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Fri, 1 Dec 2006, Josef Weidendorfer wrote:
> > 
> > Well, I would actually argue that you may often want to have a supermodule 
> > and then at least have the _option_ to decide to not fetch all the 
> > submodules.
> 
> If you want to allow this, you have to be able to cut off fetching the
> objects of the supermodule at borders to given submodules, the ones you
> do not want to track. With "border" I mean the submodule commit in some
> tree of the supermodule.
>
> This looks a little bit like a shallow clone

No. 

I would say that it looks more like a "partial checkout" than a shallow 
clone.

A shallow clone limits the data in "time" - we have _some_ data, but we 
don't have all of the history of that data.

In contrast, a submodule that we don't fetch is an all-or-nothing 
situation: we simply don't have the data at all, and it's really a matter 
of simply not recursing into that submodule at all - much more like not 
checking out a particular part of the tree.

So if a shallow clone is a "limit in time", a lack of a module (or a lack 
of a checkout for a subtree in general - you could certainly imagine doing 
the same thing even _within_ a git repository, and indeed, we did discuss 
exactly that at one point in time) is more of a "limit in space".

