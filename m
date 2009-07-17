From: Mike Frysinger <vapier.adi@gmail.com>
Subject: infinite loop in git-send-email with alias files
Date: Thu, 16 Jul 2009 21:10:00 -0400
Message-ID: <8bd0f97a0907161810w22726ffdye5c8d64719b77b53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 03:10:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRby3-0001EL-3W
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 03:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933899AbZGQBKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 21:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933897AbZGQBKW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 21:10:22 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:47801 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890AbZGQBKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 21:10:22 -0400
Received: by yxe14 with SMTP id 14so911945yxe.33
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 18:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=muHVNNwXpqCaDKc1Fjtj7jbm+MVsRTbqPhpQ5yLRN9Y=;
        b=dHze5qOaIplSlpp1EEfZK8pGzhUh/TjpLGlQn5bva3rFAjVdfRwVPdg9S7/QyKIbFW
         ZPMSGMKJccUS/Djt7X1PTYuFCRhGJ3zUBMAdy62wPmlWyJL/n5XdMa74bECy6rlOiGl7
         g0iysmdM4TaExp4bbRylIlqzgGDetWdsw+2os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=u60+GDxOOlKhXyH3+EPIFdlZs1t+LSe8dtyzCq97/awlPAFmCuayVhU31hCgE5oNSW
         2wHSFSkAvEu4yPsgukRjPWmRxK7ikVplSiz0vU5vnEw4412hX+aMdI6a244zYxb1Ov1y
         2i7EGLa+SUYSjxpuHgDssPXhMplmgPgMARLgo=
Received: by 10.151.6.19 with SMTP id j19mr854529ybi.183.1247793021664; Thu, 
	16 Jul 2009 18:10:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123437>

i was setting up an aliasesfile for git-send-email, but in doing so, i
inadvertently made a typo creating an infinite loop.  i didnt notice
right away, but i did notice when `git-send-email` hung using 100% of
a cpu.

simple way to reproduce:
$ $ git config sendemail.aliasesfile
.git/mail
$ git config sendemail.aliasfiletype
mutt
$ cat .git/mail
alias a b
alias b a
$ git send-email HEAD^ --to a
<hit enter a few times and watch it hang>

noticed with 1.6.3.3, but seems to be in 1.6.4-rc1 too
-mike
