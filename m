From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: git rebase to move a batch of patches onto the current branch
Date: Thu, 24 Jul 2008 15:57:03 -0400
Message-ID: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:58:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM6xB-0000Og-Bq
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 21:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYGXT5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 15:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYGXT5H
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 15:57:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:45669 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYGXT5F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 15:57:05 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1302347ywe.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=6HX3Osq5Ik0ibVaKSflIuWbco1X4G+I2+oqUdW7LKuU=;
        b=cXg/zJuc3fuod8P2/UrcBG6cAERq6Og72C5HVH5KlebnIy/6l/8G7u4ZL2/oaZoixA
         bcCPcszJL0De3+4KW4Z3r7XvzUEAquLYYqD5l4wL+S92prhePs6t5nE/KQl6nPQifu+4
         go8poam82H8Vd8apMezFe1toLSUs2bGSa9z1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=SY40oUOtrYctuaPv6HHqdD8G2UI383rK34PwcNrDvNIGv7+DrJ7eDRMQITMxxztGhX
         8XrYbDTX6nqGIYP98oAfIGDKfBoYcmJLP7NWfwJxvvKrdytC++YI5JCfqwLHlud/JT5I
         gpiAWXLF2S1/MIDeltzrZfbsDef5CLiVU4NI0=
Received: by 10.114.184.7 with SMTP id h7mr1009374waf.183.1216929423482;
        Thu, 24 Jul 2008 12:57:03 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 24 Jul 2008 12:57:03 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89950>

Hi,

I often find myself being on a branch and wanting to do the equivalent
of a series of cherry-picks from another branch into the current one.
Unfortunately, "git cherry-pick" only does one patch at a time (which
is very tedious), and "git rebase", which is much less tedious to use,
seems to specializing in applying your current branch on top of
another branch, not the other way around.

Currently I do something like this:

      git checkout -b tmp branch_with_interesting_stuff~5
      git rebase --onto mybranch branch_with_interesting_stuff~15
      git branch -d mybranch
      git branch -m tmp mybranch

But it seems a little complex when what I *really* want to type is
something like:

      git cherry-pick
branch_with_interesting_stuff~15..branch_with_interesting_stuff~5

and have it give me a rebase-style UI in case of conflicts, etc.  And
of course, even more bonus points if I can get "rebase -i"
functionality.

Am I missing an obvious syntax option here or is this not something
normal people want to do?

I see that the second option to rebase sounds almost right:

       If <branch> is specified, git-rebase will perform an automatic git
       checkout <branch> before doing anything else. Otherwise it remains
       on the current branch.

So I could perhaps do this:

       git rebase --onto mybranch branch_with_interesting_stuff~15 \
              branch_with_interesting_stuff

But it sounds like that would rewrite branch_with_interesting_stuff
instead of mybranch.

Thanks,

Avery
