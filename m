From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/5] Fix setup of $GIT_DIR in git-sh-setup.sh
Date: Mon, 18 Feb 2008 09:41:12 +0100
Message-ID: <8c5c35580802180041g5a193c31qeac1b9c920e41abf@mail.gmail.com>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
	 <1203286456-26033-2-git-send-email-hjemli@gmail.com>
	 <1203286456-26033-3-git-send-email-hjemli@gmail.com>
	 <7v1w7au8d4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:42:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR1a6-0007Sc-2v
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 09:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147AbYBRIlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 03:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758250AbYBRIlP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 03:41:15 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:12580 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147AbYBRIlN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 03:41:13 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2683444wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 00:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Gu2+d2PO0H/0zJ4J6MrFm7K0ZlCZ1twkFucLV1o1svM=;
        b=ACiMs4sH907+zUYYFC41AgUPDoEgchhS0FzEwHx5Ij9fw+yKDiea1doLuT2EDD2RpZoGN3r+L0hJldxsE68zHjtNr8AWEqEJUswO2y2iJhg5ZAR3cbpANetXckqIH2tfJGx83CTanWe5Gm9395vdN0bYe+rDL5q3Kq3GmRnyMmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tb1hO/Vk8ha0X+JYzlwl+yGUETUixzW93uP/Uu+/02cSuvDrNxWEe0vCUOXPuk50ElLR3zTCadfVvtWELh1yI3uyw3wVQWipdEqPDZonJ/IgVbgDB2Kwzn+yJq/25E0vm2d87afkMg4YmkD55kDei2JFxygtACu9cTR9NJxLzCI=
Received: by 10.115.14.1 with SMTP id r1mr2337580wai.31.1203324072208;
        Mon, 18 Feb 2008 00:41:12 -0800 (PST)
Received: by 10.115.92.8 with HTTP; Mon, 18 Feb 2008 00:41:12 -0800 (PST)
In-Reply-To: <7v1w7au8d4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74249>

On Feb 18, 2008 6:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > Since .git can be a file refering to the real GIT_DIR, git-sh-setup needs
> > to use 'git rev-parse --git-dir' to obtain the location of the git
> > repository.
>
> I wonder if this depend on your [1/5].  Isn't this actually a
> simplification (removing 7 adding 5 lines) that applies to the
> mainline already?

True. I'll resend as [1/5] with a fixed up commit message.

> > @@ -127,20 +127,18 @@ get_author_ident_from_commit () {
> >  # if we require to be in a git repository.
> >  if test -z "$NONGIT_OK"
> >  then
> > +     GIT_DIR=$(git rev-parse --git-dir) || {
> > +             exit=$?
> > +             echo >&2 "Failed to find a valid git directory."
> > +             exit $exit
>
> rev-parse --git-dir would have said "fatal: Not a git
> repository" already.  Do we still need to say "Failed to
> find..."?
>

Absolutely not. Thanks.

-- 
larsh
