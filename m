From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 11:32:21 +0200
Message-ID: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 11:32:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q48oK-0004nm-DI
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 11:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab1C1JcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 05:32:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35485 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1C1JcW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 05:32:22 -0400
Received: by fxm17 with SMTP id 17so2474186fxm.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=BcN1ZNSq89jhY7puKf/En0AhLos9YxCGh6zrimCz8gQ=;
        b=DLOJhl/wcZQ/+T7QiYRx1HiYFH9qree5kxLZOLPJYKKRaBFUYmSD9gllXafRDB0GUm
         qLDKPyE7W7U71wNBfIXGVU3Zo0P+0HYjVm4TZ3nW4vG6RHvjV+2txO17wAmgPlDFwkLG
         8Brdz38ix6XXWhrIFxabN5h8RxBfFJudUTpGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ph791YDeDNiEMmXtzo57k/W5k/5tDVlG0XAB+YV6/dQETC2SxQzSCjwhN1Tl7SatVK
         cLst8rytzDY0HSPaTfRqya8FOQrW8Zal2FDAUdw2FpnpauJm6tVfIsLJc4yxFfn3pXaz
         uY6T8N7dcnuOko8uEJUQW77dJFMLsxAiCHF8E=
Received: by 10.223.112.83 with SMTP id v19mr4108192fap.122.1301304741332;
 Mon, 28 Mar 2011 02:32:21 -0700 (PDT)
Received: by 10.223.93.196 with HTTP; Mon, 28 Mar 2011 02:32:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170113>

Something was broken a 100 revisions ago, has now been fixed, but I
want to find when it was fixed.

I'd expect this to work:

    $ git bisect start
    $ git bisect good
    $ git bisect bad HEAD~100
    Some good revs are not ancestor of the bad rev.
    git bisect cannot work properly in this case.
    Maybe you mistake good and bad revs?

But instead I have to do:

    $ git bisect start
    $ git bisect bad
    $ git bisect good HEAD~100

And then proceed to mark good revisions as bad, and bad revisions as
good.

That works, but it's very confusing.

Why can't bisect just do the right thing here and accept that your
more recent revesion is the good one, and the old one is the bad one?
