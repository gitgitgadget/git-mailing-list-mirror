From: Nikolaus Schulz <microschulz@web.de>
Subject: git-svn {show,create}-ignore chokes upon subdirs
Date: Tue, 27 May 2008 18:20:04 +0200
Message-ID: <20080527162002.GA21855@penelope.zusammrottung.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 18:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K11v8-0007Ap-VJ
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 18:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbYE0QUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 12:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755762AbYE0QUJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 12:20:09 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33226 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbYE0QUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 12:20:08 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 380CCE128F21
	for <git@vger.kernel.org>; Tue, 27 May 2008 18:20:07 +0200 (CEST)
Received: from [83.125.40.75] (helo=tunichtgut.zusammrottung.local)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1K11uA-00083S-00
	for git@vger.kernel.org; Tue, 27 May 2008 18:20:07 +0200
Received: from penelope.zusammrottung.local ([192.168.178.202])
	by tunichtgut.zusammrottung.local with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1K11u9-0006OK-88
	for git@vger.kernel.org; Tue, 27 May 2008 18:20:05 +0200
Received: from nikolaus by penelope.zusammrottung.local with local (Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1K11u8-0005iZ-2N
	for git@vger.kernel.org; Tue, 27 May 2008 18:20:04 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Sender: microschulz@web.de
X-Provags-ID: V01U2FsdGVkX19DYiX8oRrIBmJWYk5TVTTRgJOKB/k75Uuky9GT
	GFtEPVitLKn0ExOUFoPBri1FLwxY4wrJDiAClRKnb799Hr567l
	lBVp8bJBw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83029>

Hi, 

when importing subversion repositories into git, git-svn show-ignore and
create-ignore choke when scanning project subdirectories.  For example,
with the sequence

 git-svn init -s http://svn.red-bean.com/repos/producingoss producingoss-git-svn
 cd producingoss-git-svn
 git-svn fetch
 git-svn create-ignore 

the last command prints this: 

 HTTP Path Not Found: PROPFIND request failed on '/repos/producingoss/!svn/bc/1465/ca': '/repos/producingoss/!svn/bc/1465/ca' path not found at /home/nikolaus/nfs/nsbp/git/git/git-svn line 1897

Revision 1465 is the latest subversion revision of the project.  git-svn
create-ignore stages a correct .gitignore in the top level directory, then
aborts with the same error.  I have tested this with two svn projects, the
result is identical.  Bisecting suggested that this is broken since commit
01bdab84e31763a98206c31cf99b9dc3cb221356.

Nikolaus
