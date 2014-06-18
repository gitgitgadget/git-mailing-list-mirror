From: James Coleman <jtc331@gmail.com>
Subject: Possible bug in `git reset` in 1.9
Date: Wed, 18 Jun 2014 13:01:59 -0400
Message-ID: <CAAaqYe9FcjE9v+bkcnkPim8ntFvbUy72dJJCGs7974dq_9eSOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:02:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJFO-000756-1W
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbaFRRCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:02:01 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52908 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbaFRRCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:02:00 -0400
Received: by mail-vc0-f174.google.com with SMTP id hy4so1091357vcb.33
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=lkaQB9imNPGBfyKsevav4rqbsekvUlQ8T42hfw3yk8U=;
        b=fauU4qtMvybdG9vt6KmbgKLIpNiOgGQa9l8oQJOsivxOBttJk6yD6W1gtm0pptR4Ch
         vA/PUQyd2YMq6iWnn0w0wnxqsw+YTnkKsyKolxAFbCApSr3kYMrMk7ZPFeX82/WWimBX
         vIyM5Vn4Pdszka6BwIr+xBY68aYjsH444nmsAhk3PWa57+kaQBtbY1CnaYa7/k+Umoqr
         s51S+/fkTIGUmuUco12KwaFe7Rw1clfbIlHmMs5yvUPYuPHNnZQkFh79gbqggTWX2nyZ
         sLnwBk6n+VmPEzsfbDwUH6lVYqJTTe+94BecWqMi6qIEqq6N/08EK5fdRA3kreqh/yPT
         Gg1w==
X-Received: by 10.53.6.162 with SMTP id cv2mr1179368vdd.73.1403110919430; Wed,
 18 Jun 2014 10:01:59 -0700 (PDT)
Received: by 10.58.199.131 with HTTP; Wed, 18 Jun 2014 10:01:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251990>

Suppose I have the following branches:
* branch-1 with commits A - B - C
* branch-2 with commits A - B - C - D

Prior to version 1.9, running `git reset --hard D` while branch-1 is
checked out will result in changing the current branch HEAD to commit
hash D (essentially what update-ref would do).

In 1.9.1 (I haven't tested on 1.9.0 yet), however, running `git reset
--hard D` while branch-1 is checked out will result in the following
output:
$ fatal: Could not parse object 'D'

I assume that this is not an expected change as nothing about changes
to the reset command is present in the change log for 1.9.0 or 1.9.0.
Is this a bug or was the previous behavior unexpected as well? Either
way, it's a regression in terms of what can be expected based on
previous version.
