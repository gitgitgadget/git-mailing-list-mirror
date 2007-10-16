From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Some git mv questions
Date: Tue, 16 Oct 2007 17:33:49 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710161733.49185.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:40:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhoWc-0005wO-R3
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 17:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbXJPPj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 11:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758225AbXJPPj4
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 11:39:56 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:4319 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757989AbXJPPjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 11:39:55 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9GFdrja092468
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 17:39:54 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61195>

Hi,

For the impatient, start [HERE].

I'm about to start shuffling files and directories around in a big project,
while others keep working on their files.  This is a bit scary as I
still feel pretty much newbie in the GIT world :-)  

I did a little test as follows.  Given a shared repository sandbox.git
with a file in there I did the following, which worked fine.

	* [player one] clone the DB, edit the file, commit and push
	* [player two] clone the DB
		- git branch shuffle
		- git checkout shuffle
		- mkdir SomeDir
		- git mv file SomeDir
		- edit SomeDir/file
		- git commit -a
	* Sofar so good, now merge:
		- git checkout master
		- git pull (get player 1 changes)
		- git merge shuffle
		- git branch -d shuffle
		- git commit -a
		- git push

Sofar so good, but during the tests I had two times problems:

	* Instead of "git mv file SomeDir" I simply used "mv file SomeDir"
	and git-add.  Now I end up with two files and of course the changes
	are not merged.  I can understand that.

[HERE]
	* On a somewhat bigger test I moved a large directory using
	"git mv dir newdir" (where newdir is an existing directory).
	Now "git status" gives a lot of new and deleted files!?  I
	guess I'm going to have a big mess if that happens in the
	real project.  Moving some smaller test directories simply
	showed a series of renames.

	Can this be explained?  Is this a bug?

	Thanks --- Jan
