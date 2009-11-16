From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: Advice/help needed
Date: Mon, 16 Nov 2009 17:40:10 +0100
Message-ID: <551f769b0911160840k6ea274e9q33de777fac7cec70@mail.gmail.com>
References: <4B017D77.6060505@ianhobson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ian Hobson <ian@ianhobson.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 16 17:40:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA4d7-0004Jp-HW
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 17:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbZKPQkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 11:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbZKPQkG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 11:40:06 -0500
Received: from gv-out-0910.google.com ([216.239.58.184]:38411 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbZKPQkF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 11:40:05 -0500
Received: by gv-out-0910.google.com with SMTP id r4so657292gve.37
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=inyRD5BpickM642UBZ82d4y/GqyXi1vlL19fLZaIuA4=;
        b=KU/md5nS/Ydm1fy0GthL26B5Y1Z0854MnKC7jTDVP70xHN5zmrCMHhzp7/BT6Gts4q
         7+TqCKQlqcgcmV3yLU0dEpmb7WN3hsfVgadYl9d5XgGIaWfG/1sr8MM+CB1HB/uR6hqo
         4pgRAw92tGEwWNadIvLTguZm8hl1QKRL3gSVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jb1m6Np0WCb56EnjPsgwtlMqI7iWP5r+/QzqRtTSYLUYJdoit6jMcsh+J0Vv3JJP82
         tjtrW/IUlvxYRGy1pHN5ujqvG36GL9cN33VsPUI0NUL3R9HnCMX5FnblCQ7BYYo+f69d
         iAL8nY6lmG9/by6+0rzq74ISfA8WQR4wC8p1Y=
Received: by 10.216.85.134 with SMTP id u6mr474246wee.213.1258389610375; Mon, 
	16 Nov 2009 08:40:10 -0800 (PST)
In-Reply-To: <4B017D77.6060505@ianhobson.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133016>

2009/11/16 Ian Hobson <ian@ianhobson.co.uk>:
> My thoughts are to have 4 branches, one for each customer. 99% of all
> changes will be needed by all (or at least most)
> of the customers (P,W,S and E). How can I make a change to master and=
 then
> use git to apply those changes to the four branches, without losing t=
he
> differences between branches?
>
> For example (if this is the best way) go from this
> O-----O-----A-----B-----C =C2=A0(master)
> =C2=A0\----P
> =C2=A0\---W
> =C2=A0 \--S
> =C2=A0 =C2=A0\-E
>
> to first this, where D is the net effect of A B and C =C2=A0(this is =
for ease of
> reading logs, and commit messages),
> O-----O-----D =C2=A0(head) =C2=A0\----P
> =C2=A0\---W
> =C2=A0 \--S
> =C2=A0 =C2=A0\-E
>
> and then to this, (without editing all the files four times?)
> O-----O-----D =C2=A0(head)
> =C2=A0\----P-----D'
> =C2=A0\---W----D''
> =C2=A0 \--S-----D'''
> =C2=A0 =C2=A0\-E-----D''''

What I would do is:
- one branch for the common
- one branch for each customer, which contains the specific
differences compare to the common branch

You could program on the common branch.
When you are ready, you can checkout each specific branch and rebase
on the common branch.
=46or example:
$ git checkout common
edit, test, commit
$ git checkout client1
$ git rebase common
$ git checkout client2
$ git rebase common

Another solution is to have a branch for each customer, to commit on
one branch, and to cherry-pick this last commit on all the other
branches.

Yann
