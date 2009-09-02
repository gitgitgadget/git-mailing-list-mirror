From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [BUG] 'add -u' doesn't work from untracked subdir
Date: Wed, 2 Sep 2009 10:03:05 +0200
Message-ID: <20090902080305.GA11549@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 10:03:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MikoP-00071W-TC
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 10:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZIBIDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2009 04:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbZIBIDK
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 04:03:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:60704 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZIBIDH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 04:03:07 -0400
Received: from [127.0.1.1] (p5B1315E4.dip0.t-ipconnect.de [91.19.21.228])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MKuxg-1Miko60Pzr-000RQ3; Wed, 02 Sep 2009 10:03:06 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/v7pEdYfOEQvhBiiY0gQkKPumWF71nszzB5be
 P8ML+qZhjPa2Gl5HuJ/CQwi2tv7R/uo0w8dnnp6yEC1xdjwky8
 BpbJburWMQNEhweNdsu9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127593>


Hi,


As the subject says, 'git add -u' does not work from an untracked
subdir, because it doesn't add modified files to the index.  The
following script reproduces the issue:

mkdir repo
cd repo
git init
echo 1 >foo
git add foo
git commit -m first
echo 2 >foo
mkdir untracked_subdir
cd untracked_subdir
git add -u
git diff

It worked in the initial 'git add -u' implementation (dfdac5d, git-add
-u: match the index with working tree, 2007-04-20), but 2ed2c222
(git-add -u paths... now works from subdirectory, 2007-08-16) broke it
later, and is broken ever since.


Regards,
G=E1bor
