From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH 1/5] t/t5800: skip if python version is older than 2.5
Date: Wed, 02 Jun 2010 10:15:23 -0500
Message-ID: <ECbjGSsMA4ZIaSU1sgkRHSvxlxbZZwsEBdVFoyCTLeEuJTxU_EI8Xw@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> <Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil> <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com> <meC0HM60UnAajjHuTX-y8qZO2Unmc9VZYk1ZAHZ86LlKSy4E9Rfc_w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 17:17:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJphe-0006IZ-DR
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 17:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580Ab0FBPRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 11:17:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37643 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340Ab0FBPRw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 11:17:52 -0400
Received: by mail.nrlssc.navy.mil id o52FFNOb020968; Wed, 2 Jun 2010 10:15:23 -0500
In-Reply-To: <meC0HM60UnAajjHuTX-y8qZO2Unmc9VZYk1ZAHZ86LlKSy4E9Rfc_w@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 02 Jun 2010 15:15:23.0549 (UTC) FILETIME=[6C347CD0:01CB0266]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148261>

On 06/02/2010 09:44 AM, Brandon Casey wrote:
> On 06/02/2010 01:21 AM, Sverre Rabbelier wrote:
>> Heya,
>>
>> On Wed, Jun 2, 2010 at 02:13, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>>> This test script depends on the git-remote-testgit python script.  This
>>> python script makes use of the hashlib module which was released in python
>>> version 2.5.  So, add a new pre-requisite named PYTHON_2_5_OR_NEWER to
>>> test-lib.sh and check for it in t5800.
>> Perhaps instead we can change git-remote-testgit to do:
>>
>> "try:
>> import hashlib
>> except ImportError:
>> import ?? as hashlib
>> "
> 
> I can only guess at what that does. :)

Correction, I have no idea what that does.

Here's the patch:

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 9253922..1371497 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -1,6 +1,9 @@
 #!/usr/bin/env python
 
-import hashlib
+try:
+    import hashlib
+except ImportError:
+    import ?? as hashlib
 import sys
 import os
 sys.path.insert(0, os.getenv("GITPYTHONLIB","."))



I get:

  File "<snip>/git-remote-testgit", line 6
    import ?? as hashlib
           ^
SyntaxError: invalid syntax
