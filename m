From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: eval_gettextln does not work correctly?
Date: Wed, 22 Aug 2012 21:10:39 +0700
Message-ID: <CACsJy8C4pcAj48sBOATZY21AgE5TdWysY6x-S6Xw8mWfQ9F4CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 16:11:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4BeT-0002bJ-2A
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 16:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364Ab2HVOLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 10:11:14 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63714 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab2HVOLM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 10:11:12 -0400
Received: by yenl14 with SMTP id l14so695699yen.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=5XLRX+zwtrSiGPd9MSeKpu0mhZWQacvET5nFTWn+Okk=;
        b=FIJWTgujUUlY6ZfMQWae0QIcv5TjnBAmaVMK1fBrjmaDVCvCurglSQPbmB2Se1wRcL
         aWC+gnwc9WV18Ft3i7r1p0+OEKZAD/L6Gn2yshn+804H52Ijcv5gWbdZTSF5eQkoIxQH
         TnvY7rp57CJ/L0r9dLl2KrqGwCUQ4IuOo7k1BC76VJGmZc31TNKT4E8V3+69YSks5Igz
         Y0k43RmCYbyHhCNsyoB2yVMQyNVnlGvRGdo9ZgdpLTQVsMgPK7eHdiAQGCkG4KOMnjtn
         0agOlnRnP91kUoBNM+uiiJk6d+Q58cTkDZ0AA6LYcGNOBtAldTnlEo/Ckwz1dlzcvUDW
         644A==
Received: by 10.50.13.200 with SMTP id j8mr2273752igc.48.1345644670660; Wed,
 22 Aug 2012 07:11:10 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Wed, 22 Aug 2012 07:10:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204017>

I was running git with preloadable_libintl.so to catch unmarked
strings and I saw this

domain "git"
msgid "The copy of the patch that failed is found in:\n"
"   /home/pclouds/w/git/t/trash
directory.t4254-am-corrupt/.git/rebase-apply/patch"
msgstr ""

which means git performed a lookup on that string. It is from git-am.sh:

eval_gettextln "The copy of the patch that failed is found in:
   $dotest/patch"

I suppose it should look up "...  $dotest/patch" instead (i.e. no
variable expansion). Something is wrong here? I have a few local
patches on top of master, but none of them touches gettext shell
functions.
-- 
Duy
