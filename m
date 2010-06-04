From: =?UTF-8?Q?Adeodato_Sim=C3=B3?= <dato@net.com.org.es>
Subject: git stash deletes/drops changes of "assume-unchanged" files
Date: Fri, 4 Jun 2010 17:24:41 +0100
Message-ID: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 04 18:34:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKZqX-00038M-Ch
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 18:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab0FDQeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 12:34:08 -0400
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3776
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0FDQeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 12:34:07 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2010 12:34:07 EDT
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com [209.85.219.223])
	by etc.inittab.org (Postfix) with ESMTPSA id 0730E801C036
	for <git@vger.kernel.org>; Fri,  4 Jun 2010 18:24:44 +0200 (CEST)
Received: by ewy23 with SMTP id 23so358777ewy.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 09:24:43 -0700 (PDT)
Received: by 10.213.3.66 with SMTP id 2mr8164848ebm.32.1275668681828; Fri, 04 
	Jun 2010 09:24:41 -0700 (PDT)
Received: by 10.213.25.129 with HTTP; Fri, 4 Jun 2010 09:24:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148427>

Hello (and please CC me on replies).

I was unpleasantly surprised to discover yesterday that doing `git
stash` on a repository where I had previously run `git update-index
--assume-unchanged FOO` completely lost all changes I had in file FOO.

I understand the behavior is logical from the way git-stash is
implemented, but it strikes as very undesirable behavior to me. Does
somebody think something could be done to change it? In my opinion, both
including in the stash changes in FOO, or just leaving them in the
working tree, would be better alternatives.

Thoughts?

-8<-

% git init
% echo file1 contents >file1; echo file2 contents >file2
% git add file1 file2; git commit -m Initial.

% echo changes for file2 >>file2
% echo some other changes to file 1 >>file1
% git update-index --assume-unchanged file1

% git stash
% cat file1
file1 contents
% git stash show -p
--- a/file2
+++ b/file2
@@ -1 +1,2 @@
 file2 contents
+changes for file2

-8<-

-- 
- Are you sure we're good?
- Always.
        -- Rory and Lorelai
