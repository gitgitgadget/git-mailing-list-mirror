From: Martin Paraskevov <martin.paraskevov@gmail.com>
Subject: git apply won't work
Date: Thu, 12 Mar 2009 16:14:34 -0700
Message-ID: <a6d7dc140903121614s229ce97an2cb5737ef46c0421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 00:16:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhu8E-0000AY-BK
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 00:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbZCLXOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 19:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbZCLXOh
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 19:14:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:49126 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbZCLXOh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 19:14:37 -0400
Received: by rv-out-0506.google.com with SMTP id g9so218335rvb.5
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=GEndhZ/Jh7BNl+OE8N18cV+m5B/HOlVfSV9x8pKV3oA=;
        b=KWw/qBv8ZxtZEdB1UhnhftYfpQPy6P1NH6gkj23kAPiEqxOm7UfuiSbZ/R5AA76fAp
         feHgmSyQYDIteiVA1NpOWYw5a3XWcwTzBJaUv1BbHG7QN0sI7Bkzrr+PKpwZKneJunyH
         eS6KU59Tzpe8k846D3DhWSqxchPX16ELnZl5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=GhoExRW54wQJf8uOcrU/dYwzGrA5zBKM89BoCSRRxmf38Jq6BLIgXOYeiE+josvczL
         IDNMupgrBVfBUG+kttzv1KzUQxZAqNnle8agFEKN54Vjp+Y5HTqUNH1Tz1bPyxFXZNkF
         eZ+lhgrEkDZ/k3UomQsZnvqiz2UwGjltaCG68=
Received: by 10.141.122.1 with SMTP id z1mr230229rvm.275.1236899674166; Thu, 
	12 Mar 2009 16:14:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113126>

Hi all,

I did the following:

edited
did commit 1
edited
did commit 2
edited
did commit 3

Now I want to patch the changes between 2 and 3 onto 1, i.e. have commi=
t 3 but
with the changes from commit 2 removed. I created a branch where I rese=
t
it to commit 1 and then tried to apply the diff between 3 and 2.

The patch however won't patch certain files. It contains the excerpt be=
low,
for example, so it should be patching directory.c but it isn't. The com=
mand
I'm running is just:

% git apply filesys.patch

What am I doing wrong?


diff --git a/src/filesys/directory.c b/src/filesys/directory.c
index 0d265d5..31b7fd6 100644
--- a/src/filesys/directory.c
+++ b/src/filesys/directory.c
@@ -2,50 +2,57 @@
=A0#include <stdio.h>
=A0#include <string.h>
=A0#include <list.h>
+#include "filesys/file.h"
=A0#include "filesys/filesys.h"
=A0#include "filesys/inode.h"
=A0#include "threads/malloc.h"
-
-/* A directory. */
-struct dir
-=A0 {
-=A0=A0=A0 struct inode *inode;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 /* Backing store. */
-=A0=A0=A0 off_t pos;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 /* Current position. */
-=A0 };

=2E.. more lines ...


- Martin
