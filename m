From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 15:52:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031544110.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> 
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> 
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> 
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home> 
 <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org> 
 <20070403210319.GH27706@spearce.org>  <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
  <20070403211709.GJ27706@spearce.org>  <alpine.LFD.0.98.0704031730300.28181@xanadu.home>
 <56b7f5510704031540i4df918e6g5a82389b6759c50b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, Chris Lee <clee@kde.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrso-0003Fw-LB
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992476AbXDCWxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992478AbXDCWxn
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:53:43 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47111 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992476AbXDCWxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:53:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33MqXPD025837
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 15:52:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33MqWhF005619;
	Tue, 3 Apr 2007 15:52:33 -0700
In-Reply-To: <56b7f5510704031540i4df918e6g5a82389b6759c50b@mail.gmail.com>
X-Spam-Status: No, hits=-0.454 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43688>



On Tue, 3 Apr 2007, Dana How wrote:
> 
> Larger and larger pack files make me nervous.
> They are expensive to manipulate,
> and >2GB requires a file format change.

It sometimes also requires a new filesystem. There are a lot of 
filesystems that can handle more than 4GB total, but not necessarily in a 
single file.

The only really useful such filesystem is probably FAT, which is still 
quite useful for things like USB memory sticks. But that is probably 
already worth supporting.

So I think we want to support 64-bit (or at least something like 40+ bit) 
pack-files, but yes, I think that even if/when we support it, we still 
want to support the "multiple smaller pack-files" schenario exactly 
because for some uses it's much *better* to have ten 2GB packfiles rather 
than one 20GB pack-file.

			Linus
