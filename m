From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH/RFC 2/3] git-fetch: Split fetch and merge logic
Date: Mon, 19 Feb 2007 23:13:35 +0100
Message-ID: <8aa486160702191413p10c8ca0ek949580ffe953ea79@mail.gmail.com>
References: <874ppmplw7.fsf@gmail.com> <87vei2o75x.fsf@gmail.com>
	 <7v649x7u90.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 23:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJGlT-00067o-E9
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 23:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbXBSWNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Feb 2007 17:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbXBSWNj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 17:13:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:62855 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbXBSWNi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 17:13:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so680592uga
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 14:13:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mBOFtZL63k7XV3toFiaYS36n83AcUvlFMskxC5HKlarcGT04As+dcqjo3NoLDVBg79HfuXuYzhSMwGoo9WuCuBYkE9Ia1xcA0iw3lw+GxWIKHxIleNAyWdaqsEUt0g8M2D2CaWrkHhtt7kHevWj99SiJ/Ku82LwDxiIKB8XYLiY=
Received: by 10.78.149.13 with SMTP id w13mr584983hud.1171923215650;
        Mon, 19 Feb 2007 14:13:35 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Mon, 19 Feb 2007 14:13:35 -0800 (PST)
In-Reply-To: <7v649x7u90.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40155>

On 2/19/07, Junio C Hamano <junkio@cox.net> wrote:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
> > git-fetch fetches the branches from the remote and saves this
> > information in .git/FETCH_FETCHED, and at the end it generates
> > the file .git/FETCH_HEAD.
> >
> > There are two cases where the behaviour is changed:
> >
> > 1) branch.*.merge no longer must exactly match the remote part
> >    of the branch fetched. Both are expanded in full (as refs/heads/=
=2E..)
> >    and matched afterwards.
>
> How hard would it be to fix this?

At least it is not a 2 lines "fix".

>  I see this as a regression.
> If you are setting configuration, wouldn't you rather see the
> behaviour consistent even when remote adds new refs?

I don't see it a regression. All current setups continue to work
properly and, sorry but I don't see how adding a new ref changes this.

>
> > 2) When the remote is specified with $GIT_DIR/branches/... and ther=
e is
> >    a branch.*.merge, the remote branch name must match to get them =
merged.
> >    Before the branch in $GIT_DIR/branches/... was always merged.
>
> I do not think the current $GIT_DIR/branches/ support with
> respect to choosing which remote branch to choose was done with
> any deep thinking, other than to stay backward compatible, so I
> would not put too much trust in what is in the documentation.
> At the same time, I personally can be pursuaded to go either
> way, exactly because I do not think the current behaviour has
> strict reasoning behind it.

I prefer my way, but I don't mind much either and it can be "fixed".

>
> However, I wonder how this change would affect existing setups
> people may have.
>
> Merging this at this moment would be a pain even if there were
> no downsides, as there are a few topics that want to touch
> parse-remote and fetch (two already in 'pu', and git-bundle
> series also wants to hook into git-fetch); these topics would
> need to get adjusted if this clean-up goes in first.

A problematic decision :)

Santi
