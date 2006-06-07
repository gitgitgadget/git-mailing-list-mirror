From: Junio C Hamano <junkio@cox.net>
Subject: http-fetch segfault fix?
Date: Tue, 06 Jun 2006 22:35:48 -0700
Message-ID: <7vlks9le8b.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	<7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
	<1149610759.27253.9.camel@dv> <20060606164618.GC3938@reactrix.com>
	<1149619097.25298.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Jun 07 07:36:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnqhs-0002HC-Pk
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 07:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWFGFfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 01:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWFGFfu
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 01:35:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60392 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750916AbWFGFft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 01:35:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060607053548.EKPN6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Jun 2006 01:35:48 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1149619097.25298.6.camel@dv> (Pavel Roskin's message of "Tue, 06
	Jun 2006 14:38:17 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21430>

Pavel Roskin <proski@gnu.org> writes:

> It's a different backtrace this time.  abort_object_request() has this code:
>
> if (obj_req->slot) {
>      release_active_slot(obj_req->slot);
>      obj_req->slot = NULL;
> }
>
> Apparently just because obj_req->slot is not NULL doesn't mean it's a
> valid pointer.  I'm going to use Valgrind now.

Nick's one-liner to explicitly initialize newreq->slot to NULL
looks obviously correct to me.  Does it fix this problem for
you?
