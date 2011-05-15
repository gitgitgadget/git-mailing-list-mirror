From: Philipp Metzler <phil@goli.at>
Subject: Re: git commit -a reports untracked files after a clone
Date: Sun, 15 May 2011 10:26:01 +0200
Message-ID: <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at> <7v39kgr5ln.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 10:26:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLWeY-0002ri-9m
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 10:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab1EOI0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 04:26:12 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:45943 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284Ab1EOI0G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 04:26:06 -0400
Received: from [80.120.110.118] (helo=[192.168.1.52])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <phil@goli.at>)
	id 1QLWeI-00012e-Dj; Sun, 15 May 2011 10:26:02 +0200
In-Reply-To: <7v39kgr5ln.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
X-Df-Sender: phil@goli.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173623>

Hi,

on OS X 10.6.7 it seemes to happen with any git repository - also with the git git repo itself:

[phil@Silberpfeil tmp]$ git --version
git version 1.7.5.1
[phil@Silberpfeil tmp]$ git clone git://git.kernel.org/pub/scm/git/git.git
Cloning into git...
remote: Counting objects: 140383, done.
remote: Compressing objects: 100% (33498/33498), done.
remote: Total 140383 (delta 105777), reused 139383 (delta 104980)
Receiving objects: 100% (140383/140383), 27.61 MiB | 642 KiB/s, done.
Resolving deltas: 100% (105777/105777), done.
[phil@Silberpfeil tmp]$ cd git
[phil@Silberpfeil git]$ git commit -a
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	vcs-svn/
#	xdiff/
nothing added to commit but untracked files present (use "git add" to track)
[phil@Silberpfeil git]$ git status
# On branch master
nothing to commit (working directory clean)
[phil@Silberpfeil git]$ git commit -a
# On branch master
nothing to commit (working directory clean)

Cheers,

Philipp

_______________________________________________________________

DI Philipp Metzler
Goli.at GesbR.
Dorf Rieden 7/11
A-6900 Bregenz
EU - Austria

E-Mail: phil@goli.at
Skype: googol
Tel: +43 / 676 / 72 94 176
ICQ: 13950954

o www.philippmetzler.com - Softwareentwicklung und Websites mit Django und Typo3.
o www.goli.at - Ihr Speicherplatz im Netz. Messen Sie uns an unseren Daten.
o www.clickshopping.at - Wir bringen Ihre Produkte auf den Punkt.
o www.greencar.at - Elektroautos und mehr ...
_______________________________________________________________

Am 15.05.2011 um 05:43 schrieb Junio C Hamano:

> Philipp Metzler <phil@goli.at> writes:
> 
>> This is how you can reproduce the problem:
>> 1. clone a repo
>> 2. run the command "git commit -a"
> 
> Does it reproduce with _any_ repository, or just a particular one?  If it
> is the latter, then the above description is useless for anybody to start
> formulating any theory on what goes wrong. Sorry.
> 
> You being on OS X, I would guess that you may have a pathname in the
> project that HFS+ does not like.
> 
> On HFS+, when a program creates a file with "open(filename, O_CREAT)",
> reading the directory the created path is in with readdir() does not
> return the string given when it was created but something else for certain
> pathnames; you may be seeing that git is confused by that behaviour.
> 
> But that is just a wild guess.
