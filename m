From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: push: point to 'git pull' and 'git push --force' in
	case of non-fast forward
Date: Sun, 9 Aug 2009 00:23:33 +0200
Message-ID: <20090808222333.GA12954@vidovic>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr> <1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr> <87prb6r9d1.fsf@iki.fi> <vpqab2aqqia.fsf@bauges.imag.fr> <7vy6pujmsc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 00:24:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZuKU-0000qw-MX
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 00:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbZHHWXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2009 18:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbZHHWXu
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 18:23:50 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:60505 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZHHWXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 18:23:49 -0400
Received: by fxm28 with SMTP id 28so360142fxm.17
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uZVuuStrbvD/1NNSAGrYm+dCn8P+Y/HhzSWzkWZRPJM=;
        b=QVkEqC2ysiIh/XkDsWIjpTBw69E5W/Qe8VXyLtV8OzuM4iZLEihsviY+CBlUerdfrH
         GhZAn7CYIvmQfPVPbWBQmpj8XCbhXAMxZsr5rA/j+3hCy0yfQydc1ACbJNDxJVR6i0hn
         K1F3pjUt5zRNyLwb/BpihjV2jk8NYL1hIb0A4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XjWaQ8Fl/haN7muUngRhRnBfqQFig/f5gGTUpKQ89QTeH/3pwdD7O6EDaKCdBOwYQt
         wn+OipBsABgYl9cXnPzJKaljGO7wQJuy5vcVwy/eMdNkaZZ4h7WhVPGEnOrDAk8WBCGF
         D5LFoYZ4XyFcMECYFw00yPjgdwMKSkHt70UmY=
Received: by 10.103.134.4 with SMTP id l4mr713343mun.53.1249770229186;
        Sat, 08 Aug 2009 15:23:49 -0700 (PDT)
Received: from @ (ABordeaux-258-1-17-85.w92-134.abo.wanadoo.fr [92.134.20.85])
        by mx.google.com with ESMTPS id g1sm12439713muf.46.2009.08.08.15.23.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 15:23:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy6pujmsc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125308>

The 08/08/09, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> > Teemu Likonen <tlikonen@iki.fi> writes:
> >
> > Right, but I don't think this error message is the place to discuss
> > that. Anything involving rebasing should be taken with care, and
> > pointing the user to it in a short sentence sounds like "try shooti=
ng
> > yourself in the foot, and read the man page if it hurts" ;-).
>=20
> Instead of saying "Merge in", we could say "Integrate" to cover both
> practices.  I also happen to think that the mention of --force falls =
into
> the same category as "try shooting and then study if it hurgs".

I'd say that everywhere we try to guess what the user should do (and
telling him to do so) falls into this category. Of course, some
operations are really destructive with no way to recover to a previous
state where some other operations aren't destructive at all. But Git ca=
n
be used in many various workflows and telling =E2=80=95 in an error/war=
ning
message =E2=80=95 what the user should do may hurt some of the workflow=
s and/or
finally confuse the beginners. Actually, I believe that a message with
only "See the /WONDERFULL/ section in the /LEARN_GIT/ man page" is the
best answer.

Also, I think that mentionning --force is the worst thing to do because
the beginner will immediatly run it without thinking of all the
consequences at all: "Oh, we could do that, let's try".

> So how about phrasing it like this?
>=20
>     Non-fast forward pushes were rejected because you would discard r=
emote
>     changes you have not seen.  Integrate them with your changes and =
then
>     push again. See 'non-fast forward' section of 'git push --help'.

Well, a beginner may rewrite a commit whithout realize what he did. If =
he is
the only to work on the projet, this message is somewhat wrong.

What about

     Non-fast forward pushes were rejected because you would discard re=
mote
     changes. See 'non-fast forward' section of 'git push --help'.

?

--=20
Nicolas Sebrecht
