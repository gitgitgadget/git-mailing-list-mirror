From: david@lang.hm
Subject: Re: using git-push to backup repo...strange behavior
Date: Fri, 30 May 2008 06:15:48 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0805300611230.4014@asgard.lang.hm>
References: <3a6159d2-e1ff-4aa8-bfeb-806af2bc82c8@8g2000hse.googlegroups.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 15:16:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K24TD-0002Ji-Qz
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 15:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYE3NPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 09:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbYE3NPm
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 09:15:42 -0400
Received: from mail.lang.hm ([64.81.33.126]:53062 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbYE3NPm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 09:15:42 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m4UDFekA020974;
	Fri, 30 May 2008 06:15:40 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <3a6159d2-e1ff-4aa8-bfeb-806af2bc82c8@8g2000hse.googlegroups.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83299>

On Fri, 30 May 2008, davetron5000 wrote:

> 3. On the remote side, I can find no way to update the working dir
> with the changes other than git reset --hard.  Do I even need to do
> this?  I'd like to be able to for automated builds/tests someday.
> 4. I made post-update executable, but it never runs (it echos a
> message to a file)

I just went though this.

in the remote repo I make .git/hooks/post-receive executable, then edited 
it and made the script that it optionally calls excecutable, and 
uncommented it.

I then added git checkout -f  and ran into a problem that was answered 
this morning by Johan Herland so the final script is

#!/bin/sh
if [ "$GIT_DIR" = "." ]; then
         GIT_DIR=`pwd`
fi

/usr/share/doc/git-core/contrib/hooks/post-receive-email
cd ..
/usr/bin/git checkout -f

David Lang
