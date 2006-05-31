From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Remove possible segfault in http-fetch.
Date: Wed, 31 May 2006 09:07:31 -0700
Message-ID: <20060531160731.GA12261@reactrix.com>
References: <87fyj4y1lx.fsf@mid.deneb.enyo.de> <BAYC1-PASMTP082397700A9527CC2F3786AEA40@CEZ.ICE> <7vverzzukg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 18:08:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlTF8-0006GN-PW
	for gcvg-git@gmane.org; Wed, 31 May 2006 18:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWEaQIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 12:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWEaQIT
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 12:08:19 -0400
Received: from 241.37.26.69.virtela.net ([69.26.37.241]:46173 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751631AbWEaQIS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 12:08:18 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k4VG7WiH010624;
	Wed, 31 May 2006 09:07:32 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k4VG7VeO010622;
	Wed, 31 May 2006 09:07:31 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vverzzukg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21070>

On Sun, May 21, 2006 at 12:49:19AM -0700, Junio C Hamano wrote:

> curl_easy_cleanup() which is called from http_cleanup() says it
> is safe to remove the strings _after_ you call that function, so
> I think the change makes sense -- it was apparently unsafe to
> free them before calling cleanup.
> 
> Knowing nothing about quirks in curl libraries, one thing that
> is mystery to me is that we slist_append() to other two lists
> (pragma_header and range_header) but we do not seem to ever free
> them.  Another slist dav_headers is allocated and then freed
> inside a function, so that call-pattern seems well-formed.
> 
> Nick, care to help us out?

I just got back from a trip to the midwest and am still getting caught
up.  I was only gone for 10 days, you've all been quite busy...

You're correct wrt the other slists, I'll get to work on a patch for
that after I've caught up.

I'm also doing additional testing to see whether this fixes the DAV/405
segfault as I think there may be something else going on there.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
