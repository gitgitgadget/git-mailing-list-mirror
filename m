From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 08:42:26 +0200
Message-ID: <CAB9Jk9ApdbN+4Yk-6+u4Nje9+tbESSGGVj95iof1jnfG4Ga7GA@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
	<CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 08:42:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRdd0-00025y-Lb
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 08:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab2JZGm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 02:42:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63751 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507Ab2JZGm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 02:42:27 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1723538pad.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 23:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GEBkQCKUqj/sOcyREUeKA1gx/1vIrYbKB7tc0Vnal/c=;
        b=SiX14AAgEsjgaoVZ1EgZKGcOd5mlb0w6nVE3CPL2yFqqloyYm+qVvfKjeWGf1v78oP
         zLG2aOX92N4ISNixZV/u/IlBEjk/kl5Y1r6q85vS7faHpA97UrUps7IoEn1Q589m6VIy
         urxWtW57D5P1sivd9+jbSrnoa40V8YaneMT1aRnLFnbN71yBLixy37GMLAm3B9ixM0ZB
         naJ2lp3gsvrBLCDIXMmBdsKR70pQlAmih0CjZihstIU88197H+3Nomw96wpAvJMf3V/M
         Q3ovNsTCFmAV1ssZJyJL1XCI8LnWrHRXv/hHY07zKVNBEwcjM8QvTrYO0gpny/1Gd38w
         jXJw==
Received: by 10.66.87.163 with SMTP id az3mr59389468pab.62.1351233747060; Thu,
 25 Oct 2012 23:42:27 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Thu, 25 Oct 2012 23:42:26 -0700 (PDT)
In-Reply-To: <CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208430>

Hi Drew,

>
> Changing the tag in the local repository is a tag modification
> operation. Pushing that change to a remote repository DOES NOT execute
> "git tag...." in the remote. Plain and simple the two are different
> operations.
>

They are different for what concerns the implementation. They are not
necessarily so for what concerns their semantics, and the most
straightforward is to apply to the remote repository the changes done
on the local one -- the changes that can legally done on it -- and
changing a tag is not one allowed (unless forced).
Obviously, the semantics of git-push is different, and then needs to
be described clearly.
Note that some (probably most) of the operations that are disallowed
on the local repo are also disallowed by git-push, like, e.g. deleting
the current branch. But the user cannot tell what is disallowed and
what not if the man page does not state it.

> So here we come to the core argument. Is sounds to me like you want
> changes to remote tags to work differently from push updates to ALL
> other references. The required change, if I'm not mistaken, would be
> for tags to not permit fast-forward updates while all other references
> would be pushed normally. From my brief and un-enlightened look at the
> push code I can't see that being as easy as it sounds.
>

No, I was hoping that git-push refused to change tags at all, unless
forced (e.g. prefixing them with +), as it is on a local repository.

-Angelo
