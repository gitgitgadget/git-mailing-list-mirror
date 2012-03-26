From: James Pickens <jepicken@gmail.com>
Subject: Bug? Bad permissions in $PATH breaks Git aliases
Date: Mon, 26 Mar 2012 16:48:29 -0700
Message-ID: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCJei-0000eQ-Go
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 01:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734Ab2CZXsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 19:48:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36165 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab2CZXsu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 19:48:50 -0400
Received: by wibhq7 with SMTP id hq7so4903968wib.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 16:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=drFDZ0EUyTqtSaWWk8Z+xWcDRkTzmj4YpTMrSUnzUBA=;
        b=YVQTKlbAe9E2UuPUzer7e74tW6e8lgvKDho+nP96jmxHbRIx1ZMC3xYOzhD5vd2Utr
         d7tOU1zHIK6K+Aw/hecl8AW7sN/0QoDzzkjUYGG/Ts1eqABUd1sTgJwtWmVzT5Yoougd
         1ZoIVcnonlzBlmyEboUH+l0iHTleDADZNVAXpygyJkfodzZgzQOHtoRpEFQBpVaHLqzr
         KRlOU7fVdy6zpO4okFwrQyFnApnmjeUV5FctE26c3SF6LglrbW5WwGCsUn5J2//RSvdU
         9dY6hr4QMOLF2IvFT4fJUdUdP+gmXjLzuoQBsjBQYjbagjBUdabqjds906M+DHckFeHC
         wUDw==
Received: by 10.180.82.136 with SMTP id i8mr22370154wiy.19.1332805729787; Mon,
 26 Mar 2012 16:48:49 -0700 (PDT)
Received: by 10.223.154.205 with HTTP; Mon, 26 Mar 2012 16:48:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193988>

Hi,

I'm not sure if this should be considered a bug or not, but I've noticed that
when my $PATH contains an inaccessible directory, Git fails to execute aliases.
For example:

git config alias.l log
git l
# works fine
PATH=boguspath:$PATH
mkdir boguspath
chmod 000 boguspath
git l
# fatal: cannot exec 'git-l': Permission denied

I lean towards calling it a bug, since my shell doesn't seem to care if there
are inaccessible directories in my $PATH.  It just ignores them, and I think Git
ought to do the same.

James
