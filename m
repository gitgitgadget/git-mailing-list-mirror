From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 14:17:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141415540.5498@g5.osdl.org>
References: <1150269478.20536.150.camel@neko.keithp.com> 
 <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org>  <1150307715.20536.166.camel@neko.keithp.com>
  <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org>  <1150311567.30681.28.camel@neko.keithp.com>
  <Pine.LNX.4.64.0606141514000.2703@localhost.localdomain>
 <1150319115.30681.54.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 23:17:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqckF-0005J3-Fe
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 23:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWFNVRo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 17:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFNVRo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 17:17:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932352AbWFNVRn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 17:17:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5ELHUgt012151
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Jun 2006 14:17:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5ELHRXW020238;
	Wed, 14 Jun 2006 14:17:29 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1150319115.30681.54.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21864>



On Wed, 14 Jun 2006, Keith Packard wrote:
> 
> > In that case it 
> > might be preferable that the reuse of already deltified data is made of 
> > backward delta which is the reason you might consider feeding object in 
> > the prefered order up front.
> 
> Hmm. As I'm deltafying along branches, the delta data should actually be
> fairly good; the only 'bad' result will be the sub-optimal object
> ordering in the pack files. I'll experiment with some larger trees to
> see how much additional savings the various repack options yield.

The fact that git repacking sorts by filesize after it sorts by filename 
should make this a non-issue: we always try to delta against the larger 
version (where "larger" is not only almost invariable also "newer", but 
the delta is simpler, since deleting data doesn't take up any space in the 
delta, while adding data needs to ay what the data added was, of course).

		Linus
