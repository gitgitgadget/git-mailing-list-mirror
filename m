From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: git-http-push and hooks
Date: Tue, 7 Feb 2006 14:45:51 -0800
Message-ID: <20060207224551.GB3833@reactrix.com>
References: <20060206205203.GA20973@guybrush.melee> <20060206232231.GK3873@reactrix.com> <20060207195458.GA7217@c165.ib.student.liu.se> <20060207202351.GA3833@reactrix.com> <7vwtg6uaw6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 23:46:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6bbb-0003VB-Br
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 23:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWBGWqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 17:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWBGWqa
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 17:46:30 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:20731 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030239AbWBGWq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 17:46:29 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k17MjpNV025992;
	Tue, 7 Feb 2006 14:45:51 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k17MjpA8025990;
	Tue, 7 Feb 2006 14:45:51 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtg6uaw6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15721>

On Tue, Feb 07, 2006 at 01:17:13PM -0800, Junio C Hamano wrote:

> If the server info updates is the _only_ problem, then perhaps
> that would be the easiest and cleanest.  Whenever you update or
> add a ref you would need to update info/refs (otherwise
> ls-remote would not give you the latest info), and whenever you
> repack you would need to update objects/info/packs.

What happens if someone else updates a ref and it no longer matches your
local ref?  Should the push scan the remote versions of all local refs
and update whatever doesn't match?

> You may probably want to have a CGI to allow you manage the
> repository remotely anyway, to trigger a repack or remove a
> stale branch head, for example.  Once you go that route maybe
> having the CGI to do something like the pack protocol for more
> efficient transfer might become more attractive.

That's an option if the user has the ability to install CGI scripts on the
DAV server, which doesn't seem like it will always be true.  Perhaps it
would make sense to do both:

- add a git-http-repack command that works in a DAV-only environment
- add a CGI script to provide remote management, and a config
  setting to git-http-push for the remote management URL

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
