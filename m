From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 14:13:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
 <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
 <20070403210319.GH27706@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:14:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqKT-0000AD-OA
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945945AbXDCVOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945943AbXDCVOK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:14:10 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44442 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945945AbXDCVOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:14:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33LD7PD023031
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 14:13:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33LD6Mt003389;
	Tue, 3 Apr 2007 14:13:06 -0700
In-Reply-To: <20070403210319.GH27706@spearce.org>
X-Spam-Status: No, hits=-0.456 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43666>



On Tue, 3 Apr 2007, Shawn O. Pearce wrote:
> 
> So even with --paranoid (aka what we have now) index-pack still
> should be faster than unpack-objects for any sizeable transfer,
> and is just as "safe".

I agree 100% that index-pack is much much MUCH better than unpack-objects 
ever was, so ..

> If its the missing-object lookup that is expensive, maybe we should
> try to optimize that.  We do it enough already in other parts of
> the code...

Well, for all other cases it's really the "object found" case that is 
worth optimizing for, so I think optimizing for "no object" is actually 
wrong, unless it also speeds up (or at least doesn't make it worse) the 
"real" normal case.

		Linus
