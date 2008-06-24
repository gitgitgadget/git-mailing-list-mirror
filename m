From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 15:08:16 +0100
Message-ID: <BC8F2A2A-9817-401B-BAC3-F36ED42976E5@manchester.ac.uk>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com> <1214306517.6441.10.camel@localhost> <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com> <A3460448-8007-4E02-AC20-85C1A8C85786@manchester.ac.uk> <ce513bcc0806240653i45044297t3b963940c5b3daf0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Matthias Kestenholz" <mk@spinlock.ch>, git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 16:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB9Cv-0003a0-6O
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbYFXOIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756517AbYFXOIT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:08:19 -0400
Received: from tranquility.mcc.ac.uk ([130.88.200.145]:64316 "EHLO
	tranquility.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbYFXOIS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:08:18 -0400
Received: from gomwe.mcc.ac.uk ([10.2.18.2])
	by tranquility.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1KB9Bx-000DY3-0s; Tue, 24 Jun 2008 15:08:17 +0100
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:52077)
	by gomwe.mcc.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1KB9Bw-000IIs-R6; Tue, 24 Jun 2008 15:08:16 +0100
In-Reply-To: <ce513bcc0806240653i45044297t3b963940c5b3daf0@mail.gmail.com>
X-Mailer: Apple Mail (2.924)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:52077
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86060>

>> So your clone address for git:// is wrong, you don't need the /pub/ 
>> git:
>> git clone git://erez.zilber@kites/erez.zilber/my_test.git
>> As you've moved the root of the filesystem as far as git-daemon is  
>> concerned
>> to /pub/git with the --base-path option.
>
> I understand. However, when I try to run it according to your  
> suggestion:
>
> [root@kd001 t]# git clone git://erez.zilber@kites/erez.zilber/ 
> my_test.git
> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/ 
> my_test/.git/
> fatal: Unable to look up erez.zilber@kites (port 9418) (Name or
> service not known)
> fetch-pack from 'git://erez.zilber@kites/erez.zilber/my_test.git'  
> failed.

That error is saying that the name of the service is wrong, so you're  
right to do it without the "erez.zilber@" bit.

> I also tried to run it without "erez.zilber@":
>
> [root@kd001 t]# git clone git://kites/erez.zilber/my_test.git
> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/ 
> my_test/.git/
> kites[0: 172.16.1.11]: errno=Connection refused
> fatal: unable to connect a socket (Connection refused)
> fetch-pack from 'git://kites/erez.zilber/my_test.git' failed.

This looks like that either there is nothing listening (if you're  
running though xinetd have you restarted it? And have you added the  
right bits to /etc/services?) or there's a firewall in the way... git  
defaults to 9418 so check that it's open.

> Is there any log file on the server that can help me trace this
> problem (something like /var/log/httpd/error_log but for the git
> protocol)?


on my machine (running via xinetd) it goes straight into /var/log/ 
messages. A grep -i git on that file should produce something.

Cheers,
Rob
