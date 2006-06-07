From: Pavel Roskin <proski@gnu.org>
Subject: Re: http-fetch segfault fix?
Date: Wed, 07 Jun 2006 10:29:44 -0400
Message-ID: <1149690584.19551.2.camel@dv>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	 <7vodx6zus2.fsf@assigned-by-dhcp.cox.net> <1149610759.27253.9.camel@dv>
	 <20060606164618.GC3938@reactrix.com> <1149619097.25298.6.camel@dv>
	 <7vlks9le8b.fsf_-_@assigned-by-dhcp.cox.net> <1149658914.5648.5.camel@dv>
	 <7vhd2xld77.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Jun 07 16:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnz2k-0006Qn-7u
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 16:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWFGO3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 10:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWFGO3z
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 10:29:55 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:25511 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932230AbWFGO3y
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 10:29:54 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fnz2d-0007oB-86
	for git@vger.kernel.org; Wed, 07 Jun 2006 10:29:51 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fnz2X-00056h-87; Wed, 07 Jun 2006 10:29:45 -0400
To: git@vger.kernel.org
In-Reply-To: <7vhd2xld77.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21436>

On Tue, 2006-06-06 at 22:58 -0700, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > The Valgrind diagnostics confirms that obj_req->slot is not initialized
> > (as opposed to being a pointer to a freed area or something else):
> >
> > ==27182== Conditional jump or move depends on uninitialised value(s)
> > ==27182==    at 0x4070EA: abort_object_request (http-fetch.c:1059)
> > ==27182==    by 0x4071CE: fetch_object (http-fetch.c:1078)
> > ==27182==    by 0x4073EC: fetch (http-fetch.c:1126)
> > ==27182==    by 0x403125: loop (fetch.c:180)
> > ==27182==    by 0x403369: pull (fetch.c:248)
> > ==27182==    by 0x407A13: main (http-fetch.c:1271)
> >
> > Line 1059 is:
> > if (obj_req->slot) {
> 
> Thanks.  That is indeed a very good sign.

Both git-clone instances (with and without USE_CURL_MULTI) have
completed successfully on http://www.denx.de/git/linux-2.6-denx.git

Nick, thank you for fixing this bug!

-- 
Regards,
Pavel Roskin
