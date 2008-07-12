From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: [RFH] Finding all commits that touch the same files as a specific commit
Date: Sat, 12 Jul 2008 17:58:38 +0200
Message-ID: <bd6139dc0807120858vc058451lb10933b5225c8521@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 12 18:01:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhX2-0001al-Pf
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 18:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYGLP6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 11:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYGLP6j
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 11:58:39 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:13156 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbYGLP6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 11:58:38 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4133906wfd.4
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=j2U2NEz8kW3IcSr63SqpOBwk6LFJNYr4Tn5nFn1qlXg=;
        b=LDLaHflTUwwS2yxC/8C2V+avYFCuyZ3g2FiuWbxZKsLsiO6Inzd8XDVSzOb3ERippj
         TpeoPojvhV/BvceNjbK2ZW2xquRR0THEDwDDaHlBQ598e5bBcMDbq+jY4evyjE/GXYHk
         tXcz12Ni0j6wBLed8mqn5W7dTUTBxgnIO0C4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=KfgclDIJQvs6ogW8m/hFnK6Sb6QYBR61gqGpGTRtIXghMl6Mro2e35wgEgehOCr3NE
         83l8u/7T8kdoHKvd54JNpUaLYCosjFXbM91Gd3iMhoFFWsI7UDcDzVa14OiOcQurfmzZ
         fepF+h7UYCeYrjiTJous/dzmRcvV1wPYdNB9Y=
Received: by 10.142.222.21 with SMTP id u21mr3600724wfg.244.1215878318382;
        Sat, 12 Jul 2008 08:58:38 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sat, 12 Jul 2008 08:58:38 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88252>

Heya,

Currently I do the following:
$git diff-tree --name-status --no-commit-id -r <hash>
To get all the files touched by the commit, I do:
$git rev-list HEAD -- all the returned paths here
This works perfectly, except when the subtree merge strategy is used,
since in that case I get (example from git.git):
$ git diff-tree --name-status --no-commit-id -r
5821988f97b827f6ba81dfeebff932067c88ba6c
M	git-gui.sh
M	lib/diff.tcl
$ git rev-list HEAD -- git-gui.sh lib/diff.tcl
$

Now it was noticed on #git that git log has a --follow argument which
-does- catch the rename, but it only works on one file at a time. So,
my question is this:
How do I find all commits that touch the same files as a specific commit?
I have described my current approach above, which does not work when
the subtree merge strategy is used. I am not stuck to this approach
though, if someone comes up with a better way to do this than with
'git diff-tree' / 'git rev-list' I'm fine by that. I provided with my
current approach in the hope that someone comes up with a similar
solution which means I'll have to edit less ;).

-- 
Cheers,

Sverre Rabbelier
