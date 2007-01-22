From: Bill Lear <rael@zopyra.com>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Mon, 22 Jan 2007 16:16:05 -0600
Message-ID: <17845.14245.559835.112658@lisa.zopyra.com>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
	<7vfya57ast.fsf@assigned-by-dhcp.cox.net>
	<17842.29542.229557.460473@lisa.zopyra.com>
	<7vbqkt78n7.fsf@assigned-by-dhcp.cox.net>
	<7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
	<17845.2402.105688.56648@lisa.zopyra.com>
	<7vy7nusv52.fsf@assigned-by-dhcp.cox.net>
	<17845.5805.290668.552757@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 22 23:16:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H97Sw-0001LJ-L8
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 23:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbXAVWQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 17:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbXAVWQL
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 17:16:11 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61789 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932498AbXAVWQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 17:16:10 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0MMG9h07016;
	Mon, 22 Jan 2007 16:16:09 -0600
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <17845.5805.290668.552757@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37461>

On Monday, January 22, 2007 at 13:55:25 (-0600) Bill Lear writes:
>...
>>The attached patch on the local side (i.e. the one that pushes)
>>dumps "garbage" you are getting on the line from the remote
>>side, to help diagnosing the problem. ...
>
>I have asked the developer to install this and hopefully we'll
>get some feedback soon.

Looks like it is our developer's fault after all.  

% git push
[...]
Unpacking 7 objects
 100% (7/7) done
error: protocol error: bad line length character
<<<<<
Unknown command: "#alias"
refs/heads/tau_mt_1: 0a5a7ac9b81a90500b9c9c44a22793890513cd5a -> 3d0c74c15953ad5bc6a71eefa623933163c4f05f
[...]

The problem is that his mailer is putting out: 

    Unknown command: "#alias"

when it gets to the mail command at the bottom of the update hook.  So,
he's got a bad line in his .mailrc file.

I do think that some augmentation of the error output is in order,
either as previously posted, or something fancier.  It would be even
better if this sort of thing did not trip up git, though perhaps
I don't understand enough of how the update hook and git interact.


Bill
