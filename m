From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: RFC: GIT networked storage
Date: Fri, 04 Nov 2005 15:40:18 -0500
Message-ID: <436BC732.3090809@pobox.com>
References: <7vwtjp2h59.fsf@assigned-by-dhcp.cox.net>	<436AE6A3.4040103@pobox.com> <7vd5lg22gm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 21:44:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY8Md-0004jz-DI
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 21:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVKDUkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 15:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbVKDUkW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 15:40:22 -0500
Received: from mail.dvmed.net ([216.237.124.58]:21947 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750833AbVKDUkV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 15:40:21 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EY8MG-0002WU-V9; Fri, 04 Nov 2005 20:40:21 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5lg22gm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11155>

Junio C Hamano wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
>>How easy is it to add a new storage backend to git?
> 
> 
> Almost everything is contained within sha1_file.c.
> 
> Object creation side is simple -- everybody who creates an
> object (e.g update-index registering blobs, write-tree writing
> the toplevel and intermediate level trees, commit-tree building
> a commit object, unpack-objects exploding a pack) goes through
> write_sha1_file(), which checks if the object is already
> available using has_sha1_file() and creates a new object in the
> local .git/objects/?? directory.  I am assuming that you are not
> planning to create objects in a remote peer from within the git
> code path, and instead to have background process that replicate
> them over the network to peer repositories, so you probably do
> not have to touch this side.
> 
> Extending inspection and reading from existing objects for your
> networked storage may be somewhat messy, but starting points
> are:
[...]

Thanks.  It looks pretty straightforward to add a new storage backend, 
grepping on the symbols you listed.

	Jeff
