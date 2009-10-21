From: David Roundy <roundyd@physics.oregonstate.edu>
Subject: confusion with git diff-tree output
Date: Wed, 21 Oct 2009 13:43:40 -0400
Message-ID: <117f2cc80910211043q3a92a7b6o15464cc049ee33dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 19:43:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0fDw-00022G-4u
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 19:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbZJURnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 13:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754613AbZJURnh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 13:43:37 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:5598 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbZJURng (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 13:43:36 -0400
Received: by qw-out-2122.google.com with SMTP id 9so963886qwb.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=+jZ8nZEovVKT1c0sumzW15Y/VdVGphyXbdkjPT/mfE4=;
        b=vRueGGiuQ1bpL+ctXivS04upKGmNNS2t2Iq6QWtxYfN+9g/LCFPhmljgk8j1pfPL86
         EUZJOzQO4JCMJpdxiCVGHwbGy0QAZEDS/GClsJD9J4WLSInJnsVelzDHO1oJXugp6U6w
         sCieLqTveK4z9nVQ9gG06JRyTW3LP65D0F5Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=c35NCywMbhd2/L8JEIHhV/Q9ieUqFV2+nA87ynKNGGsbkCwAHGvxqNm2KLm4eirLhz
         RD1qPJkWXUhxtn7KZNt9NQPN4asNSBzFBp9vzaq6RpmNO8pTlvUZbyjxevo2KKsQOR+z
         4qzEDS30IjVumu+r0BY27DTCvQXHC8v4u/nhU=
Received: by 10.224.87.228 with SMTP id x36mr4066722qal.287.1256147020921; 
	Wed, 21 Oct 2009 10:43:40 -0700 (PDT)
X-Google-Sender-Auth: 7771569520ca7aa1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130944>

Hi all,

I've been struggling with trying to figure out how to make diff-tree
output the actual files changed.  Below is the output when I run
diff-tree on a given commit.  It reports that the directory is
modified, rather than that a single file within that directory is
modified.  I can find out what *file* was modified by running
diff-tree -p --raw, which gives me output similar to what I expected
from a plain old diff-tree.  Is there a flag that will make diff-tree
give this information?

As background, what I really want is --name-only, which rarely reports
the files modified, instead reporting the directories as modified, and
I've been struggling to figure out what is going on.  The
documentation seems to imply that the --raw diff output will report
modified files, and I haven't found anything indicating when it would
report the directories containing the modified files instead.

Thanks!
David

$ git diff-tree fd99a198222c14cf42fee82087a13467ff4a8205
fd99a198222c14cf42fee82087a13467ff4a8205
:040000 040000 8cdb796ea801da99c34d8f60045d8eb08fbb0e41
66b67ea1763799c0b2ac01f6803177ca870f6544 M	Iolaus

$ git diff-tree fd99a198222c14cf42fee82087a13467ff4a8205 -p --raw
fd99a198222c14cf42fee82087a13467ff4a8205
:100644 100644 dab4c531f3f69f08e5dc202ad8b6dfad9e8855fe
0e3f305e641a6440bb478765dfcd089e0420c155 M	Iolaus/Lcs2.hs

diff --git a/Iolaus/Lcs2.hs b/Iolaus/Lcs2.hs
index dab4c53..0e3f305 100644
--- a/Iolaus/Lcs2.hs
+++ b/Iolaus/Lcs2.hs
(changes cut)
