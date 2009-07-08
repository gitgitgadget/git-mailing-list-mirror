From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: git submodule remove?
Date: Wed, 08 Jul 2009 17:54:04 -0400
Message-ID: <4A55157C.7020103@fastmail.fm>
References: <32c343770907081241h5925545ah1cb551b31e45ddc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 00:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOfCM-0005Fm-LV
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 00:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbZGHWBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbZGHWA7
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 18:00:59 -0400
Received: from smtp109.rog.mail.re2.yahoo.com ([68.142.225.207]:20469 "HELO
	smtp109.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754191AbZGHWA7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 18:00:59 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2009 18:00:59 EDT
Received: (qmail 12486 invoked from network); 8 Jul 2009 21:54:17 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp109.rog.mail.re2.yahoo.com with SMTP; 8 Jul 2009 21:54:16 -0000
X-YMail-OSG: YLmPis4VM1lSFguTOxSUz4th1hlPqQaf7c5HXWQTPKADgTY3vIRV_6WlzxiDU7EnAA--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 6425221C0548;
	Wed,  8 Jul 2009 17:54:12 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GYIS-9+jxcHm; Wed,  8 Jul 2009 17:54:04 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 20E1121C0530;
	Wed,  8 Jul 2009 17:54:04 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <32c343770907081241h5925545ah1cb551b31e45ddc0@mail.gmail.com>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122923>

Tim Henigan wrote:
> The Git Submodule Tutorial [2] has instructions for removing submodules, but it
> seems natural to teach git how to "submodule rm".

I'd like to see this as well.

> This change would require git-submodule.sh to:
>     1. Modify the .gitmodules file (remove the entry for the submodule).
>     2. Modify the .git/config file (remove the entry for the submodule).
>     3. Delete the newly untracked files.

I'm not sure it should be removed from .git/config, and the untracked
files, automatically. If the module is only being removed on one
branch, then switching back to another branch will require the module
to be initialized again. Of course, then the user has to deal with
untracked files and to remember to prune entries from .git/config once
no more branches refer to them.

This is also a problem when renaming modules -- I always end up having
at least two entries in .git/config -- one for the branches using the
old name and one for the branches using the new name.

Perhaps one way to refactor submodule support in .git/config would be
to allow .git/config to specify search/replace expressions (simple or
regex-based) that would apply to the entries in .gitmodules. Most of
the time, a few simple expressions should be sufficient to cover all
of the necessary local settings.

Another possible useful change/addition would be to move the submodule
files in and out of the superproject (perhaps to/from a holding area
in superproject/.git) as the user switches their working copy between
branches that contain or do not contain specific submodules.

Cheers,
Raman Gupta
