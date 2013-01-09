From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git branch case insensitivity (Possible bug)
Date: Wed, 09 Jan 2013 10:47:54 -0700
Message-ID: <50EDAD4A.4070108@workspacewhiz.com>
References: <CAL+iW28LdnNiho4KksLX_S_-+bKX+77GPJ0zqQfkz4JpBJRskw@mail.gmail.com> <50ED925B.2060402@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexander Gallego <gallego.alexx@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 09 18:48:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TszlC-0003uf-71
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 18:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286Ab3AIRr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 12:47:58 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:49668 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148Ab3AIRr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 12:47:57 -0500
Received: (qmail 18311 invoked by uid 399); 9 Jan 2013 10:47:57 -0700
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@70.196.192.15)
  by hsmail.qwknetllc.com with ESMTPAM; 9 Jan 2013 10:47:57 -0700
X-Originating-IP: 70.196.192.15
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50ED925B.2060402@op5.se>
X-Antivirus: avast! (VPS 130109-0, 01/09/2013), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213074>

----- Original Message -----
From: Andreas Ericsson
Date: 1/9/2013 8:52 AM
>
> Are you using Mac OSX?
> Are you using the HFS+ filesystem shipped with it?
> Did you use the filesystem's default settings rather than reinstall your
> system with sensible settings?
>
> If you said "yes" to all of the above, this is a filesystem "feature",
> courtesy of (cr)Apple, and you're screwed.
>
> You can work around it by running "git pack-refs" every time you create
> a branch or a tag though.
There are two popular default file systems that are case preserving, 
case insensitive.  One is on Mac.  One is on Windows.

Since Git relies on file system behavior to store the equivalent of 
database entries like these refs, it cannot give a consistent user 
experience across platforms or even file systems within platforms.

That sounds like a bug in Git to me.

Perhaps pack-refs should be run automatically by any internal command 
that updates a ref to ensure a non-confusing, consistent user experience.

Further, if refs are no longer entries on the disk, then this nasty 
namespacing issue goes away.

User A:
$ git branch render
$ git push

User B:
$ git pull
$ git branch render/myfeature

render/myfeature can't be created, because Git assumes a filesystem 
structure.  The render namespace is locked out forever.

-Josh
