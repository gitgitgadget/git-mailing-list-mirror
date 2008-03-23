From: Anton Gladkov <agladkov@parallels.com>
Subject: Re: [PATCH] [RFC] add Message-ID field to log on git-am operation
Date: Sun, 23 Mar 2008 20:16:21 +0300
Message-ID: <20080323171621.GA3886@atn.sw.ru>
References: <1206136805-20115-1-git-send-email-agladkov@parallels.com> <7v4payilkp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdTiE-0008Aw-Ub
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 18:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbYCWRJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 13:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbYCWRJq
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 13:09:46 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37886 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbYCWRJp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 13:09:45 -0400
Received: from atn.sw.ru ([10.30.3.212])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id m2NH9Snk013289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Mar 2008 20:09:30 +0300 (MSK)
Received: from atn.sw.ru (localhost.localdomain [127.0.0.1])
	by atn.sw.ru (8.14.2/8.14.1) with ESMTP id m2NHGOPB004007;
	Sun, 23 Mar 2008 20:16:24 +0300
Received: (from anton@localhost)
	by atn.sw.ru (8.14.2/8.14.2/Submit) id m2NHGLS0004005;
	Sun, 23 Mar 2008 20:16:21 +0300
X-Authentication-Warning: atn.sw.ru: anton set sender to agladkov@parallels.com using -f
Content-Disposition: inline
In-Reply-To: <7v4payilkp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77925>

Junio!
Thank you for your response :)

On Sat, Mar 22, 2008 at 12:51:34PM -0700, Junio C Hamano wrote:
> This is a mixed bag.
> 
> Your changes to mailinfo is fine, and I think it may make even more sense
> to also parse out In-Reply-To: and References: to capture the message
> context better.

I've found that all I need could be parsed by less changes in mailinfo.
By adding header fields I need to 'header' array :)

> 
> On the other hand, I'd NAK changes to pretty.c and commit-tree.c; it is
> wrong to place that information in new commit object header.  The commit
> object header is a place to store information common to all commit objects
> (authorship and committer) and the structural information that is required
> to correctly handle the commit objects (pointers to trees and commits, and
> encoding that tells what the message part is in if it is not in UTF-8).

I see...

> 
> Just like workflows inspired by the kernel project use Signed-off-by: and
> Acked-by: information in the commit message part to keep track of the flow
> of patches, and some distro folks say "Closes #nnn" in their messages to
> close their issue tracking system entries, your "message" is information
> only useful to a particular workflow and convention, and belongs to the
> commit log message body, not in the object header.

Ok.

> 
> Wouldn't it work equally well to use applypatch-msg hook?  Use your
> updated mailinfo to parse necessary information out of the incoming
> message, and add Message-ID: to the commit log messsage, perhaps at the
> end, in that hook?

applypatch-msg hook executed on message applying, after that there could be
useful to test applied patch, so it is not the place for notification sending.

-- 
Best regards,
		anton
mailto:agladkov@sw.ru
