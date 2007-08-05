From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: possible bug in git apply?
Date: Sun, 5 Aug 2007 12:20:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708051219440.5037@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
 <alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
 <7vvebuh8g8.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org>
 <85hcndj2b5.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708051106020.5037@woody.linux-foundation.org>
 <853ayxiznp.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	git@vger.kernel.org, rob@landley.net
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:22:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHlg7-0000ti-MT
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbXHETWL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbXHETWK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:22:10 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57101 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751789AbXHETWJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 15:22:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75JKsf4004381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Aug 2007 12:20:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75JKm10022188;
	Sun, 5 Aug 2007 12:20:48 -0700
In-Reply-To: <853ayxiznp.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55057>



On Sun, 5 Aug 2007, David Kastrup wrote:
> 
> But your proposed three passes won't work with a patch removing
> "x/..."  and creating "x" in its place, since "x/" gets only removed
> in pass 3, and "x" needs to created in pass 2 already.

Yes, I was wrong. The current two passes are the right thing to do, and we 
should just always remove empty directories (and my patch was fine: we can 
leave them alone if it's a pure "modify file in place", but that's really 
the only case).

		Linus
