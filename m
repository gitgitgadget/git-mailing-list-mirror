From: Tim Henigan <tim.henigan@gmail.com>
Subject: git submodule remove?
Date: Wed, 8 Jul 2009 15:41:14 -0400
Message-ID: <32c343770907081241h5925545ah1cb551b31e45ddc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 21:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOd1Y-00041q-3s
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 21:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483AbZGHTlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 15:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757063AbZGHTlR
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 15:41:17 -0400
Received: from ey-out-1920.google.com ([74.125.78.147]:11673 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756535AbZGHTlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 15:41:16 -0400
Received: by ey-out-1920.google.com with SMTP id 3so1216891eyh.36
        for <git@vger.kernel.org>; Wed, 08 Jul 2009 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=vDOJJQLIj74dEaw8R8+QvesQ2J43Pt9zyJsDfsknVcQ=;
        b=G+YSw4/1xzLOmZ/GAAfzuE5rUG24pn6IdueUA3jkNjPd8c0a01fLdHPrM4O4mNc9JZ
         l6DuZpIHJHBF3nR69YxtsZADDchVm5COI2ixgJZM4qoNthrNS4LGDYGBXVLOdPipryy0
         FkffEXlIiCmznYC6Bv4F4PkBqccYz0HHsw8OE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=v3xZ9WjeRseZ8tI5XQ2iLGrtiSk7Pq5WpFXRA0vIbrHZHE5jVR68lsUzoPHyE/UKXf
         Th/YOBw89cnxQeR24Ka9LZw0VKFSX1pdpx0+AFTBwib2GlRhkjdqK5Po/8ygLyBCXjEg
         QLRX9icf46s10aYLDaaMiJWvk9yGINoKvMcd4=
Received: by 10.216.29.72 with SMTP id h50mr1984401wea.137.1247082074449; Wed, 
	08 Jul 2009 12:41:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122913>

Hello,

I recently encountered a situation where a user wanted to remove a submodule
from a repository.  Searching the mail archive, I found this thread
[1], but it does
not appear that it was ever followed up.

The Git Submodule Tutorial [2] has instructions for removing submodules, but it
seems natural to teach git how to "submodule rm".

This change would require git-submodule.sh to:
    1. Modify the .gitmodules file (remove the entry for the submodule).
    2. Modify the .git/config file (remove the entry for the submodule).
    3. Delete the newly untracked files.

Another option to consider would be a "submodule rm --cached" option which would
keep the newly untracked files.  However, with this option, I believe
it should still
descend into the submodule directory to remove the leftover submodule
".git" folder.

Is there another way of doing this?  If not, does this sound like a
reasonable change?

Thanks,
Tim Henigan

[1] http://article.gmane.org/gmane.comp.version-control.git/101610/match=submodule+remove
[2] http://git.or.cz/gitwiki/GitSubmoduleTutorial
