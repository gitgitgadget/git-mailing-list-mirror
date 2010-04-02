From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 4/4] git status: refresh the index
Date: Fri, 2 Apr 2010 21:37:03 +0100
Message-ID: <201004022237.04130.markus.heidelberg@web.de>
References: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de> <1270211241-10795-5-git-send-email-markus.heidelberg@web.de> <20100402165759.GB18576@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 02 22:35:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxnaJ-0007J1-SG
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 22:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880Ab0DBUfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 16:35:14 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:45892 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab0DBUfL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 16:35:11 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 00E1F1541D2FD;
	Fri,  2 Apr 2010 22:35:10 +0200 (CEST)
Received: from [91.19.8.199] (helo=pluto.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1Nxna9-0000AO-00; Fri, 02 Apr 2010 22:35:09 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.30-gentoo-r8; KDE/4.3.5; i686; ; )
In-Reply-To: <20100402165759.GB18576@coredump.intra.peff.net>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX194gEZBKPnPRjj1RYGnejhmzuPL1IteU1AhWZaV
	gGYB4sZgNUr60aphZBZoOy+AAW3JD1VvHWPl8WqRXAogYDc1RO
	djv+fw7k0mCjBsTAPP4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143847>

Jeff King, 2010-04-02 18:57:
> On Fri, Apr 02, 2010 at 02:27:21PM +0200, Markus Heidelberg wrote:
> 
> > +	fd = hold_locked_index(&index_lock, 1);
> > +	if (write_cache(fd, active_cache, active_nr) ||
> > +	    commit_locked_index(&index_lock))
> > +		die("unable to write new_index file");
> 
> Does this mean we will fail to run in a read-only repository?

You're right.
But that was already the case when "status" was "commit --dry-run".
I have to admit, I didn't think about this scenario, but simply looked
for the differences between these two commands.

> I think
> that status, like diff, should refresh the index on disk if it _can_,
> but as that refresh is a side effect of the main purpose (which is to
> output information), it should not be fatal if it cannot do so.

Sounds sensible.

Markus
