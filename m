From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Show URL in the "Getting <foo> list" http-fetch messages
Date: Sat, 12 Nov 2005 09:22:02 -0800
Message-ID: <20051112172201.GF4051@reactrix.com>
References: <20051112004958.21857.95728.stgit@machine.or.cz> <20051112005803.GZ30496@pasky.or.cz> <7vwtjeis09.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 18:23:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eaz5E-0002zI-Pz
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 18:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVKLRWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 12:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVKLRWZ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 12:22:25 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:19889 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932423AbVKLRWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 12:22:25 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jACHM32Q024158;
	Sat, 12 Nov 2005 09:22:03 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jACHM2HF024156;
	Sat, 12 Nov 2005 09:22:02 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtjeis09.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11695>

On Fri, Nov 11, 2005 at 05:17:42PM -0800, Junio C Hamano wrote:

> > Therefore, can I somehow stall fetching of an object? The idea is:
> >
> > 	I want to check the alternates list!
> > 	I don't have it yet...
> > 	...but a request for it is already queued. Ok, I'll wait.
> 
> I agree, and probably this applies when index request is in
> transit as well.

I just posted a patch to prevent another alternate request from starting
if one is already in progress.

This should not be an issue with index requests because they are only
initiated from fetch().  The previous patch to load alternates on demand
added alternate handling to process_curl_messages() so that a 404 for an
object can be handled immediately rather than waiting for the fetch()
call for that object to notice.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
