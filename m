From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-pack-redundant returns the most containing pack
Date: Thu, 17 Nov 2005 08:45:46 +0100
Message-ID: <81b0412b0511162345g1483e7cfia768b18ba3eb1db@mail.gmail.com>
References: <20051116230956.GA21444@steel.home>
	 <437BBF5D.5040105@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 08:47:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EceT6-0005YP-2K
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 08:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbVKQHpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 Nov 2005 02:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbVKQHpr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 02:45:47 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:27097 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161161AbVKQHpr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 02:45:47 -0500
Received: by nproxy.gmail.com with SMTP id l37so385412nfc
        for <git@vger.kernel.org>; Wed, 16 Nov 2005 23:45:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IgmByOUtXpV2I70xxGlw8WFl8c1+wEaTBgI/hDysfjid8yKJH8UFYEXT5YwLyhXVts/mbSNoirdYX55nn73rq9Cnp2wPaETAPPbCjDcxOFPRzdibxOic4UB1powpdTujqkvtQsApqWTLdmdyc2lg5lmzlUbWfLqivF1PeQFUBWk=
Received: by 10.48.202.10 with SMTP id z10mr130292nff;
        Wed, 16 Nov 2005 23:45:46 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Wed, 16 Nov 2005 23:45:46 -0800 (PST)
To: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <437BBF5D.5040105@etek.chalmers.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12089>

On 11/17/05, Lukas Sandstr=F6m <lukass@etek.chalmers.se> wrote:
> > ...which very confusing: "git-repack -a -d" leaves the repository w=
ith
> > exactly the same packs as before, by creating a super-pack, and the=
n
> > happily removing it, because pack-redundant returns the newly creat=
ed
> > pack!
> >
> > So, even if it is logically correct, it's hardly useful in practice=
=2E
>
> That's bad. Your new pack should contain some objects not present in
> the older packfiles and thus it shouldn't be removed, unless there
> were no new objects to pack.

there weren't: "ls .git/objects" showed only pack/ and info/

> If no new objects were packed, the sum of the old packs might be smal=
ler
> than the new superpack, or the old packs could contain unreachable ob=
jects,
> which makes git-pack-redundant unable to detect that they should be r=
emoved.

that _could_ be the case. I run git-fsck-objects --full in that
repository and saw some unreferenced tags.

> Could you try updating to the latest snapshot? There was a bug in a
> list handling function which was fixed recently, perhaps your problem
> is related.

will try, but I didn't realize yesterday that it might be a good idea
to keep the old repository around. The lot of packs was automatically
created by incremental repacking after every pull. Sorry...
