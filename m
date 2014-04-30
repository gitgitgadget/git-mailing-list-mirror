From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFD] use approxidate for "git commit --date=xyz"?
Date: Wed, 30 Apr 2014 14:09:10 -0700
Message-ID: <CA+55aFx=LizEyS6hq=av_qwRZuu_q3xPSXO-Jr4CAfXqaAuUtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 23:09:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfbki-00054e-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946052AbaD3VJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:09:12 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48937 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbaD3VJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:09:11 -0400
Received: by mail-vc0-f174.google.com with SMTP id ib6so2951232vcb.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=e6uDQqLqE7ri72edOEmf2pLIGkwArIvthyfY+2BF0SM=;
        b=aE+dk7EFqC8nvylatUYnF7a+VuDLA8yE2x2JSqLR90RfopET4WgeCGSXEv+H5ejvC8
         eHXNQe7lodQ+xUh39rzy+zB4JwCCfjG18q47YKnbhL+p/4qYM+Iy4dwxPpitKEWBKql9
         5W7GVkiGNU8fOkjl2KBF75tJXw4xjl6ISdmqigZF9nP4Trv/HxJT7tCv7o8/7FhPVgPX
         W7kEKE0J75jeJEizc/Crjxibg+2YIASHSa11ALN5DJl8oQxFluEz8X1zxmszChbEUX15
         6XrXrdMhKOp4JKPbo0aYGM4Qia4AB7URb3pcn6KvQffgiVpoJMIo84PxGJSq9JFlvVH1
         jc9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=e6uDQqLqE7ri72edOEmf2pLIGkwArIvthyfY+2BF0SM=;
        b=A8j62jD7oAYZDISuqcxTRxaFgCIuAvpxe9ZXQy3bZ1iXw9EqhDrlpGA8mJurphogcG
         LS0zzbDu2RWSuwy7ToGDWN8xDFu5Sl+RF9fJ9slbjRUyxoCd85TjAtb7d3/uGnoOOVyL
         RnRzaVyIjHWoyIDTOeDGumIXWvCUKLDpNMskg=
X-Received: by 10.58.178.130 with SMTP id cy2mr5251vec.55.1398892150396; Wed,
 30 Apr 2014 14:09:10 -0700 (PDT)
Received: by 10.220.13.2 with HTTP; Wed, 30 Apr 2014 14:09:10 -0700 (PDT)
X-Google-Sender-Auth: jw9ZuewRr2JNeXVq5o2XzHcBKAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247780>

I just got a comment saying that

    git commit --amend --date=now

doesn't work. I replied that you can use

   --date="$(date)"

but I do wonder if we should accept the approxidate format - we do in
other equivalent places. Hmm?

The code uses fmt_ident(), which uses parse_date(), which in turn uses
parse_date_basic(). Maybe parse_date() could use
"approxidate_careful()" instead of "parse_date_basic()"?

            Linus
