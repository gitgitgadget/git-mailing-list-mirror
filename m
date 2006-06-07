From: Junio C Hamano <junkio@cox.net>
Subject: Re: http-fetch segfault fix?
Date: Tue, 06 Jun 2006 22:58:04 -0700
Message-ID: <7vhd2xld77.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	<7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
	<1149610759.27253.9.camel@dv> <20060606164618.GC3938@reactrix.com>
	<1149619097.25298.6.camel@dv>
	<7vlks9le8b.fsf_-_@assigned-by-dhcp.cox.net>
	<1149658914.5648.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Jun 07 07:58:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnr3V-0005m6-4r
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 07:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWFGF6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 01:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWFGF6H
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 01:58:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:18606 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750868AbWFGF6G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 01:58:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060607055805.XLWB11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Jun 2006 01:58:05 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1149658914.5648.5.camel@dv> (Pavel Roskin's message of "Wed, 07
	Jun 2006 01:41:54 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21432>

Pavel Roskin <proski@gnu.org> writes:

> The Valgrind diagnostics confirms that obj_req->slot is not initialized
> (as opposed to being a pointer to a freed area or something else):
>
> ==27182== Conditional jump or move depends on uninitialised value(s)
> ==27182==    at 0x4070EA: abort_object_request (http-fetch.c:1059)
> ==27182==    by 0x4071CE: fetch_object (http-fetch.c:1078)
> ==27182==    by 0x4073EC: fetch (http-fetch.c:1126)
> ==27182==    by 0x403125: loop (fetch.c:180)
> ==27182==    by 0x403369: pull (fetch.c:248)
> ==27182==    by 0x407A13: main (http-fetch.c:1271)
>
> Line 1059 is:
> if (obj_req->slot) {

Thanks.  That is indeed a very good sign.
