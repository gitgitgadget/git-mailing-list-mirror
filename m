From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Tue, 11 Oct 2005 21:25:58 -0700
Message-ID: <7vd5mbqs2x.fsf@assigned-by-dhcp.cox.net>
References: <20051010105008.GB30202@gentoo.org>
	<7vzmph42j2.fsf@assigned-by-dhcp.cox.net>
	<pan.2005.10.11.19.48.04.675482@smurf.noris.de>
	<434C2590.3040107@zytor.com>
	<pan.2005.10.12.01.20.17.917829@smurf.noris.de>
	<434C8095.4080201@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 06:29:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPYBp-0008Rr-EN
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 06:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVJLE0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 00:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVJLE0A
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 00:26:00 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:42117 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932419AbVJLE0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 00:26:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012042559.JLKH9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 00:25:59 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434C8095.4080201@zytor.com> (H. Peter Anvin's message of "Tue,
	11 Oct 2005 20:18:45 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10004>

"H. Peter Anvin" <hpa@zytor.com> writes:

> I thought about this, and probably the sanest way is to wrap malloc() 
> with something that creates a linked list of allocations.  If we abort, 
> we can unwind the linked list and free all allocations.

You can free() the allocated memory with something like that,
but it is likely that the aborted function would have already
created some linked structure out of those memory blocks, and
cleaning up that you would need the real exception handling
wouldn't you?
