From: Fergus McMenemie <fergus@twig.me.uk>
Subject: Re: git 1.6.0.2 make test fails at t1301 under mac os x 10.4.
Date: Wed, 22 Oct 2008 07:11:04 +0100
Message-ID: <p06240806c52472a2e0ab@[192.168.47.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 08:12:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsWxD-0003m2-BW
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 08:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbYJVGLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 02:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYJVGLI
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 02:11:08 -0400
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:47080 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYJVGLH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 02:11:07 -0400
Received: from 110.88.155.90.in-addr.arpa ([90.155.88.110] helo=twig.me.uk)
	by c.painless.aaisp.net.uk with smtp (Exim 4.69)
	(envelope-from <fergus@twig.me.uk>)
	id 1KsWvv-0000NX-BD
	for git@vger.kernel.org; Wed, 22 Oct 2008 07:11:03 +0100
Received: from [192.168.47.12] (pb.twig.me.uk [192.168.47.12])
	by twig.me.uk (Postfix) with ESMTP id B15B630910E
	for <git@vger.kernel.org>; Wed, 22 Oct 2008 07:11:02 +0100 (BST)
X-Virus-Scanned: Clear (Version: ClamAV 0.94/8467/Wed Oct 22 03:32:13 2008, by smtp.aaisp.net.uk)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98830>

Johannes,

Thanks for the prompt response. On the systems that work:-

>fergus:pwd
>/usr/local/packages/git-1.6.0.2
>fergus:mkdir y
>fergus:dir y
>total 0
>drwxr-xr-x    2 fergus  fergus     68 21 Oct 22:52 ./
>drwxr-xr-x  692 fergus  fergus  23528 21 Oct 22:52 ../
>fergus:id
>uid=501(fergus) gid=501(fergus) groups=501(fergus),98(_lpadmin),101(com.apple.sharepoint.group.1),66(_uucp),80(admin)

on the system that fails I see

>fergus:mkdir y
>fergus:dir y
>total 0
>drwxr-xr-x     2 fergus  wheel     68 Oct 21 22:52 ./
>drwxr-xr-x   693 fergus  wheel  23562 Oct 21 22:52 ../
>fergus:id
>uid=501(fergus) gid=501(fergus) groups=501(fergus), 81(appserveradm), 79(appserverusr), 80(admin)

Looking into this further, creating a file/dir on a BSD based system such
as OSX, the group ownership of the file/dir is taken from the enclosing
dirs group. Unlike say Solaris or Linux where it is based on your primary
group. I had not noticed this difference before!

All test passed, after changing the group ownership.

>On Tue, 21 Oct 2008, Fergus McMenemie wrote:
>
>> >++ mkdir sub
>> >++ cd sub
>> >++ umask 002
>> >++ git init --shared=1
>> >fatal: Could not make /usr/local/packages/git-1.6.0.2/t/trash
>> >directory/sub/.git/refs writable by group
>
>I guess this is the problem.
>
>Could you inspect what owner/group that directory has?
>
>Ciao,
>Dscho

-- 

===============================================================
Fergus McMenemie               Email:fergus@twig.me.uk
Techmore Ltd                   Phone:(UK) 07721 376021

Unix/Mac/Intranets             Analyst Programmer
===============================================================
