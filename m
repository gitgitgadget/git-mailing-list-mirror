From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 17:22:55 +0000
Message-ID: <32541b130908271022i6a825198i37e2ec82ed5f833c@mail.gmail.com>
References: <1251387045053-3527289.post@n2.nabble.com> <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com> 
	<20090827164657.GA17090@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 27 19:25:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgiiU-0000yu-Ui
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 19:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbZH0RXQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 13:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZH0RXP
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 13:23:15 -0400
Received: from mail-yw0-f184.google.com ([209.85.211.184]:39548 "EHLO
	mail-yw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbZH0RXN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 13:23:13 -0400
Received: by ywh14 with SMTP id 14so1690176ywh.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7P2NArPq2gQOx4I7c293MVTWgZA0coFlADDMBTsKEnk=;
        b=X7iOZ/2NfRgJ/0yCb07FtsBiKHX5rvoJZy5q9VEM+5B+BT1eY14LgcxWY70MvYRd0X
         Xka6REZ727/iCX9YGMFROfIWCD+vy4S4JCFPflQFAwtbPKPFAniSz2EuxT/6F4861eHL
         SqoUKuyENypGqDFUWzCZnY/FTCW8a9g+Y8ojE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IDjxDRCXNj6ROAwGOwCuSS7HCSKFz9kGGpF+PdrrIh9OlR0EwBtCJI2yPzJxcjflvG
         qs/wTSi8SRZtTQzcyxzaqJMAawa7Pyz1doujzG/38DAwph8to+UA0z3LOxzSJMZiIuPP
         bfcl9K/xxuesjWd1ZpzB33llRYP8nRm9dOIJg=
Received: by 10.150.46.31 with SMTP id t31mr175988ybt.285.1251393795201; Thu, 
	27 Aug 2009 10:23:15 -0700 (PDT)
In-Reply-To: <20090827164657.GA17090@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127179>

2009/8/27 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> It would also be pretty hard to implement that. Given the default fet=
ch
> refspec, it would "simply" be a matter of mapping the given ref to th=
e
> refspec, so e.g. "foo" becomes "refs/heads/foo:refs/remotes/origin/fo=
o".
> But even just using "git remote add -t master foo git://..." breaks
> that, as the fetch refspec in the config will no longer be a glob, an=
d
> thus no such mapping is possible.

Hmm, I don't really see why that introduces a problem.  If you use -t
to override explicitly which refs you want to save, then it's not a
problem if git doesn't save other refs, right?

I'd be more concerned about the inconsistency between

   git fetch git://whatever master
and
   git fetch origin master

There's no really good way for the first one to know it needs to
update any branches, even though 'origin' might be an alias for
git://whatever.  So users will still be confused.

Thinking of that also reminds me of another surprise.  If you do:

   git fetch git://whatever

=2E..it seems to do nothing at all, as far as I can see.  Which makes
sense, I guess, since I wouldn't really expect it to be meaningful.
But it seems to connect up to the remote server anyway just in case.

I suppose I have no useful suggestions here, other than an
interpretation of why users find the current behaviour confusing.

Have fun,

Avery
