From: Matt McClellan <mcclellan.mj@gmail.com>
Subject: Unstaging during a merge conflict
Date: Mon, 1 Oct 2012 20:13:21 -0500
Message-ID: <CAHUDv6qM37nua2uB6TDOmf1a5L_TUFz=0q=v5W=9MrpEmWoShg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 03:14:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIr3N-0006Pq-6t
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 03:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab2JBBNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 21:13:24 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55983 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2JBBNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 21:13:23 -0400
Received: by wibhr7 with SMTP id hr7so205507wib.1
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 18:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1oFREY4MZMo+mBbYgV39YylPkzMRQNoMVtqZawtUF2c=;
        b=mPSfiZGBF1tguYIXApfL9a2JtWebMptEjSltOTzKinR1JreZQcYfDlq5RUDyngZwPs
         HOnglW6EJ/x2PaGXHwh1JTdGVpbf830Hqspku+z8GIthVAcro4uxxUlzfrmrlBGYlyZ9
         ksYll3+WpyIjq/aeqBGSfVswW7Q14CPI8KCD9wxscPLL2y8NdboqE0SyLf2Mc4uYhD3X
         VkrtJuc35cJw0WrR3Jq1qkkbC//dhCkrqJS3HQ8uEixrcl4X+9raUmWYr3e+lkL3es6d
         eMX8yYjfJV/j+9DZYyCPz15oACoTWnot8lPBf7OMff0ArHA7K1PO9rFkymcoOY5Taypt
         APOw==
Received: by 10.180.107.163 with SMTP id hd3mr18106813wib.19.1349140401683;
 Mon, 01 Oct 2012 18:13:21 -0700 (PDT)
Received: by 10.223.161.195 with HTTP; Mon, 1 Oct 2012 18:13:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206782>

We had an issue at our organization where changes were reverted when a
user was merging his local repo with the remote repo changes.  The
merge conflicted and he unstaged all the changes that were not a
conflict, he then resolved the conflict and added just the conflicted
file and committed.  The end result was that he reverted every change
from his last pull of the remote to his merge point.  The problem I'm
having how hard it is to see this problem as both git show and git log
on the merge commit do not show any reverted files.  It was found by
diffing his commit to each of the parents and seeing the opposite of
what we expected in the patch output.

Anybody have ideas how we can prevent these mistakes?  While we are
going to do more training, a hard stop that wouldn't even let these
make it to remote would be preferred.

I've done this using git add --interactive then reverting a files
changes, though the actual crime was done using egit staging tool.  It
seems the command line won't let you unstage changes but gui tools and
interactive tools seem to allow it.
