From: SASAKI Suguru <sss.sonik@gmail.com>
Subject: SP in committer line in fast-import stream
Date: Mon, 18 Jul 2011 23:26:45 +0900
Message-ID: <CAE3X6mwJquoHj06FVGTsg0qtzyTwbd6gNqy7J4yWiVF-+p-23Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf303ea62af8f8d504a858c9e6
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 16:26:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiomZ-0005XJ-US
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 16:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab1GRO0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 10:26:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36709 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab1GRO0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 10:26:46 -0400
Received: by gyh3 with SMTP id 3so1299385gyh.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hkffPGE5g01b7A5YI+JwHPrrNTTF+U78dki8P9nLvf0=;
        b=s/zcojpSJdiqJGiwck4RIrQ2xre4FYFtZ6vkoXIqksEEYqnQDc99tWXibnNzHh1H+6
         aYesDCK8+tRL6Uqpw4Yj+860y/l16PMZEGSAdK9jO7iULgqCTbMxqsQMy7d4L93nPYhN
         x574sxqRm4h0fnhlchBQWkyBr9Gz9JYGRw/oI=
Received: by 10.236.155.5 with SMTP id i5mr7844885yhk.132.1310999205967; Mon,
 18 Jul 2011 07:26:45 -0700 (PDT)
Received: by 10.236.103.12 with HTTP; Mon, 18 Jul 2011 07:26:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177374>

--20cf303ea62af8f8d504a858c9e6
Content-Type: text/plain; charset=ISO-8859-1

Hi,


I'm working with data from `bzr fast-export` and `git fast-import`.
(bzr is 2.4b5, git is 1.7.5.4, on Debian GNU/Linux (sid))

Export and import themselves are OK,
but `git fsck --strict` exits with error, saying:

  error in commit 2e7a16fbe57b555c1c5954470ef66f3a2a089288: invalid
author/committer line - missing space before email

and pushing to remote like GitHub fails.


I found minimal OK-data unlike `bzr fast-export` outputs and NG-data
like `bzr fast-export`.
(Attached: test_NG.data.txt and test_OK.data.txt)

Only one difference between these is a space in committer line.
  * OK: 'committer' SP SP LT GT ...
  * NG: 'committer' SP    LT GT ...

`man git-fast-import` says:

  commit
    Create or update a branch with a new commit, recording one logical
change to the project.

      'commit' SP <ref> LF
      mark?
      ('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
      'committer' (SP <name>)? SP LT <email> GT SP <when> LF
      data
      ('from' SP <committish> LF)?
      ('merge' SP <committish> LF)?
      (filemodify | filedelete | filecopy | filerename | filedeleteall
| notemodify)*
      LF?

I think, from this notations, both data is OK.
What's the problem?

Regards,

-- 
SASAKI Suguru
  mailto:sss.sonik@gmail.com

--20cf303ea62af8f8d504a858c9e6
Content-Type: text/plain; charset=US-ASCII; name="test_OK.data.txt"
Content-Disposition: attachment; filename="test_OK.data.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gq9j1loz0

Y29tbWl0IHJlZnMvaGVhZHMvbWFzdGVyCm1hcmsgOjEKY29tbWl0dGVyICA8PiAxMTYyMzE2MTAz
ICswMDAwCmRhdGEgNAp0ZXN0Ck0gNjQ0IGlubGluZSBSRUFETUUKZGF0YSAxMQpUaGlzIGlzIE9L
LgoK
--20cf303ea62af8f8d504a858c9e6
Content-Type: text/plain; charset=US-ASCII; name="test_NG.data.txt"
Content-Disposition: attachment; filename="test_NG.data.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gq9j1lpi1

Y29tbWl0IHJlZnMvaGVhZHMvbWFzdGVyCm1hcmsgOjEKY29tbWl0dGVyIDw+IDExNjIzMTYxMDMg
KzAwMDAKZGF0YSA0CnRlc3QKTSA2NDQgaW5saW5lIFJFQURNRQpkYXRhIDExClRoaXMgaXMgTkcu
Cgo=
--20cf303ea62af8f8d504a858c9e6--
