From: John Tapsell <johnflux@gmail.com>
Subject: Implicit stashes
Date: Wed, 30 Jun 2010 11:48:38 +0900
Message-ID: <AANLkTilTaQP6qARY1A495vm9HAvLVX_lqIQd1l3WIv7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 30 04:48:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTnLx-0008U8-22
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 04:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629Ab0F3Csk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 22:48:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44621 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab0F3Csj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 22:48:39 -0400
Received: by iwn7 with SMTP id 7so369054iwn.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 19:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=OKP53Hu0BgofQftcJqOzw7SDoC1n2moRQbkFgCs+40w=;
        b=kQDkUwcO9l622nWaKYieDkgM5BhF4wWMZl6lZ7HLseV4uBlBpIt9DxtMkAQH0w+bGK
         PInEkjvfm2JDp4yq1SX024nX85qkG1e6520oE/0no8bxpPq56Nv94X4BW8BWUzDg23tr
         OOkzTwg/yfYRqVKVctSEOlkOtSqa79Pz2g6y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HQ0hSgOTz6UFZkaqcWCv6+NeyIbAekVxjxHW2UiUBz3BU/qF8643vcKULSjXyanAzw
         12ITRYdkZtqNtJ/6gi36FKxrOk7db2jpPT4/9fYJoVIc/UqFb9GIrwtP9s0zxvRR86N4
         rz5vdGEidsJk+GvWzEvfEfFxkbAoJae7VCyAE=
Received: by 10.231.37.77 with SMTP id w13mr5257788ibd.199.1277866119041; Tue, 
	29 Jun 2010 19:48:39 -0700 (PDT)
Received: by 10.231.182.146 with HTTP; Tue, 29 Jun 2010 19:48:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149941>

Hi,

  I was thinking that it would be nice if everything was undoable in
git.  Currently there are some easily typed by irreversible commands
that I keep seeing people doing.

For example:

$ git checkout folder

Now all changes that you just worked on are deleted, with no way of recovering.

$ git reset --hard

I know this seems very explicit to delete changes, but I myself have
done this and accidentally lost changes.  For example, I write a unit
test and don't commit it in on purpose because I know that it
currently fails and I want to test it against older versions.  I
carefully git checkout older versions to find if the unit test fails,
then in stupidity reset back to origin/master ..


  Anyway, I think a nice solution is to have a separate stash for
implicit stashes.  Then irreversible commands would simply stash
before making the changes.
  It would also be nice to add a 'git undo' which just undoes whatever
the last operation was - i.e  unstash or reset to an earlier HEAD@{1}

John
