From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [STGIT] stg refresh wish (splitting patches/removing files from a patch)
Date: Sun, 30 Dec 2007 20:03:33 +0100
Message-ID: <200712302003.33478.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 30 20:03:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J93RB-0000sX-Tw
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 20:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbXL3TCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 14:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbXL3TCi
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 14:02:38 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:36457 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752095AbXL3TCh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Dec 2007 14:02:37 -0500
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id BADBD32ED1C
	for <git@vger.kernel.org>; Sun, 30 Dec 2007 20:02:35 +0100 (CET)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id AAB9128EDED
	for <git@vger.kernel.org>; Sun, 30 Dec 2007 20:02:35 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 7CAD311274
	for <git@vger.kernel.org>; Sun, 30 Dec 2007 20:02:35 +0100 (CET)
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.2/5295/Sun Dec 30 18:16:46 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69375>

Hi,
I recently tried to split a stgit patch into 2 parts
and it was not as easy as i would like it to be.

How do i exclude a file from a patch(use version of file present in HEAD^)
without modifying the working dir?

with plain git i would use something like
git reset HEAD^ files_i_do_not_want_in_first_patch
git commit --amend
git add files_i_do_not_want_in_first_patch
git commit

So my idea was to add a --use-index [1] option to stg refresh
When it is passed stg refresh will use the current index for the contenst of the refreshed patch 
instead of looking at the working dir.
This would solve my problem[2] and also make it possible to use git-gui for 
staging hunks.

Do you think this would be a useful/good idea?
Or do we want a separate command for removing files from a patch anyway?

Another thing that might be useful (in my scenario) would be a stg commit --top extension
which commits at the top end of the stack
(unfortunately this will loose the patch history for splitting commits)
then i can edit this commits without being afraid of confusing stgit
and then stg assimilate /stg repair to make them managed by stg again

Greetings Peter

[1] rename by desire

[2] new way for splitting a patch with extension
git reset HEAD^ files_i_do_not_want_in_first_patch
stg refresh --use-index
stg refresh -e
git add files_i_do_not_want_in_first_patch
stg new
stg refresh --use-index
