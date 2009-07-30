From: Diggory Hardy <diggory.hardy@gmail.com>
Subject: LESS env var and a pager
Date: Thu, 30 Jul 2009 09:10:23 +0200
Message-ID: <31718a220907300010t136885c6ldc2ea362f9c6e33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 09:10:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWPmb-0005fe-L8
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 09:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbZG3HKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 03:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbZG3HKY
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 03:10:24 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:39305 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbZG3HKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 03:10:24 -0400
Received: by fxm28 with SMTP id 28so439438fxm.17
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 00:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=QzYOFbDXSSx0/qSIYbhvLRmVkiOC6NqiOZV4SiQustE=;
        b=Sb3ohqXsdjc85ZEe18XsY5h29Ts9R5pIZI5opgyNuJ2uK/zcpB2TxlN1qoT5BVIEZz
         CiP84XO0mxHs++7VrKV9wK2gQfpTBweAJT6i+RBe6c6/xxnpM0C/snN02XvO24CMbIae
         G+6M82jtsnzIa7ag08fbmFnysSW5Qqf9ccE2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=YMXKUaR7XoSi5+WHIWoH+3LAj8AzPBPzVUSzlyKNetOh+839O39P8QMXU7hnCJ2AXV
         bXo5UvTGOvsPvaa5nU6M+hBBKjM3j/gCOi9WEBfzSaGAmPVMWCTT/nF/I+VD39gR7dxh
         YLrOx/oN8uCHEEvCvd4LLXlW1dAvNF0PYR0l8=
Received: by 10.204.117.65 with SMTP id p1mr812527bkq.91.1248937823413; Thu, 
	30 Jul 2009 00:10:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124446>

I was recently trying to work out why when git's output is piped
through a pager, it doesn't use the alternate screen buffer:
https://bugs.kde.org/show_bug.cgi?id=201899

Conclusion: removing the X option from the LESS environ var produced
the results I wanted (allow mouse-wheel scrolling, output is hidden
after closing the pager).
One relevent post I found:
http://article.gmane.org/gmane.comp.version-control.git/29565/match=less+frsx

So maybe it'd make sense to change this in pager.c to:
setenv("LESS", "FRS", 0);
(or even just FR:)
setenv("LESS", "FR", 0);

Just a suggestion of what seems preferable to me.
