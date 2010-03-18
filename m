From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Not possible to see combined diff before committing a merge?
Date: Thu, 18 Mar 2010 11:21:13 -0400
Message-ID: <76718491003180821x777df87j245d134e32ec90dc@mail.gmail.com>
References: <76718491003172321j2a184643o47ec3a712a3b0c12@mail.gmail.com>
	 <4BA1F880.2090100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 18 16:21:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsHXE-000627-1G
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 16:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402Ab0CRPVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 11:21:15 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:52226 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0CRPVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 11:21:14 -0400
Received: by pzk38 with SMTP id 38so1767939pzk.33
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=HyNaOsCDWNc/PnltvI/GpPYJALN1/gahjy/WJInhPAc=;
        b=jUSpr940kugUxfAxZwQxk+wZCYuN5j2GoAsj3aMGb7UyQ7TTZRlJj6TDILZMCWMmGs
         Rftrq2kpdzAN+zzxFCxH664hbWvq9Gp2vsbnAr3qpL0vJHd/+5gBxaeOaiVYm2GOrBFQ
         CYA14U0Lq/ecr+liW74yQpTy7hrK1zjZGhWjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=meCGxb6yh6eb3nGN8ZeXRMZSL2Q/ESwdApgu5fWTcY/qaWosW7RECNqDB+qx2LnDor
         YEWfs6maFIM4elWeSWFgty5jo75BQat1xnxDvuERi/Ju9zucJr26WDk0SbhLEo4IQYJk
         PiIfttm+AMFgsEIY/fB/E+vg188bSlEtrR06k=
Received: by 10.142.202.16 with SMTP id z16mr1352191wff.55.1268925674049; Thu, 
	18 Mar 2010 08:21:14 -0700 (PDT)
In-Reply-To: <4BA1F880.2090100@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142478>

On Thu, Mar 18, 2010 at 5:55 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> If there are no conflicted files left you could do a throw-away commit
> with a temp index, but that looks ugly. Do we have a way of specifying a
> 3-way diff for some git diff --cc incarnation, i.e. pretending two
> commits to be the parents and a third (or index) to be the merge result?

It would seem that diff-index should take two <tree-ish>'s (it only
takes one) to support this.

> Junio would probably say that by adding the merge resolution you declare
> that you're not interested in that part of the merge any more ;)

The use case is that I use mergetool when I have merges with very
large conflicted regions that are too difficult to visualize using the
merge and/or diff3 conflict style. But because these conflict
resolutions are so difficult, I often want to look at the merge
resolution in combined-diff style before committing.

The way I would have to do this today is:

- git mergetool <path>
- save the result in my visual merge tool and quit
- in a separate shell, use git diff to see the 3-way diff
- in the first shell, answer mergetool's prompt that it's okay to use the result

Hmm, maybe there should be an option for whether mergetool
automatically add's the result for you.

Anyway, what I've noticed is that I've become gun shy about using "git
add" myself during conflict resolution because as soon as I do, I lose
some functionality compared to the unmerged state.

j.
