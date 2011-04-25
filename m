From: Jon Seymour <jon.seymour@gmail.com>
Subject: git-work, git-base: an example of how to use it.
Date: Mon, 25 Apr 2011 20:43:12 +1000
Message-ID: <BANLkTim07-a5VwSAt7_vLMzOES_JZad9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 12:43:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEJGA-0000VB-MP
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 12:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276Ab1DYKnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 06:43:14 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64447 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262Ab1DYKnN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 06:43:13 -0400
Received: by ewy4 with SMTP id 4so664877ewy.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=glw+YwPblkAnAqS7ql0Ukmk9E35Emsr3zMcXtIVoId4=;
        b=ZGMKnu1Xomms4ql7mMQX5eUBFqZUb1jgJUN3kuoeINxKqDMx7DeaK51sA4KhIZ/1kl
         U5JHcKH9/HVqLu1PG6BDiUoaVBuUGbNR82CbxEDIisVljALGWfYt1nnZ3Zj0bfLYaVNr
         0geSzv1IwDV7Odx7u+8iNxhwMORABRWKp+0IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=grsDyuXBTiKsP8wXEjdzDiaRexZEJEEedEHSeiiv0szFtHXbfX/5/gQi2s/V8BE7TV
         r02MyR6ZG5R8+xklmeihP98QMF0kiE7jkjFPztr5bCp1FTsNXTunvhjJxd5IWG0dkBlB
         KRID1NKhQigM+CV7YwJD0waOzhPhh7N3RJiow=
Received: by 10.14.123.9 with SMTP id u9mr1314562eeh.53.1303728192437; Mon, 25
 Apr 2011 03:43:12 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Mon, 25 Apr 2011 03:43:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172024>

I haven't had much feedback about git-work, to this point. Peter
Baumann mentioned it was a little hard to grok. So, I have updated my
github fork with a README.md that shows how I use git work  and git
base to manage the README.md and the master branch of my git fork on
github.

The text of the section "HOW I MAINTAIN THIS DOCUMENT" is included
here for the convenience of readers, or you may prefer to read the
formatted version:

   https://github.com/jonseymour/git

Whenever I edit this document, I do the usual:

   git add README.md
   git commit -m "Updates to README"

Then I do:

   git work update jonseymour HEAD~1

The git work command above:
  * updates the jonseymour branch with the last commit,
  * merges that commit with $(git base) and updates $(git base) to
refer to that merge
  * rebases remaining unpublished work on top of the new $(git base)

Then, I publish the new base and the updated topic to github with:

    git push public $(git base):master jonseymour:jonseymour

The net effect is that:

  * My changes to README.md go to my jonseymour branch.
  * My public github branch reflects the work I have stabilised with
git work update - it contains my stable dependencies, but not work in
progress.
  * I keep my work in progress rebased on top of my public github master branch.
  * I keep my unpublished work private.
  * My working tree remains stable - git work update doesn't change
the tree, it only changes the history.

jon.
