From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 18:41:20 +0100
Message-ID: <20130320174120.GA32426@paksenarrion.iveqy.com>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
 <CALkWK0=b80U5dxGMpwKwL+jFURisEuSapWuuNRFcP+5R2f3+GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, spearce@spearce.org,
	git@vger.kernel.org, pclouds@gmail.com, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIN09-00045p-22
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab3CTRkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 13:40:07 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:61063 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab3CTRkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:40:05 -0400
Received: by mail-la0-f51.google.com with SMTP id fo13so3390500lab.24
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k0Qm3iwAcfuA2Wf9vNTLjRajBU0HBgv4Ayz5kNM2DMI=;
        b=CNTikIsE0WZuRKOxUfh/vHDbppfQWpHiYF2eMt2IjDDF/MMfIxOIjqUxvZpNxg3Deh
         KkHXDUA+v+t+V9aXAE3fyEql0+RA3mrjKcgnGtQekYweeaM+AWLy5pW2gdXJhHZuW/xV
         Rm/0rmtD71bXDl4S6j5tIBPp43lxCLpl2QaHLSUqe3Ycl0iwkwPmwrgsHSxl7zDCTSoE
         HDiDqd/JnXMrSzBLEnXsy6Zm3fVmrGCdV7rXLYh1R+6EOHKL2K7+m9Lqdx1dbp5xrJ4+
         uM0ZZGhGLYoHw+gLdV3bQ+vcLu9tjT3pd/sezjI0L3X48dKI21/wK3nAOHzpaG4M0mHq
         bRAw==
X-Received: by 10.152.105.244 with SMTP id gp20mr5970289lab.34.1363801204174;
        Wed, 20 Mar 2013 10:40:04 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id o11sm862030lbu.6.2013.03.20.10.40.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 10:40:03 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UIN0q-0000hJ-TP; Wed, 20 Mar 2013 18:41:20 +0100
Content-Disposition: inline
In-Reply-To: <CALkWK0=b80U5dxGMpwKwL+jFURisEuSapWuuNRFcP+5R2f3+GA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218627>

On Wed, Mar 20, 2013 at 10:45:22PM +0530, Ramkumar Ramachandra wrote:
> Fredrik Gustafsson wrote:
> > When entering a git working dir, optionally run a forked process th=
at
> > stat all files in the whole workdir and therefore loads stat inform=
ation
> > to RAM which will speedup things like git status and so on.
>=20
> This is misleading.  You just execute the equivalent of `git status`
> everytime I request a prompt inside a git working directory.  And thi=
s
> is if I'm using __git_ps1() to augment my prompt, which I'm not- I us=
e
> ZSH's vcs_info, which is arguably better.  Also, you forgot to say ho=
w
> to turn on the feature.

The invokation place is quesionable (Junio also had some thoughts about
that). I don't find vcs_info in the contrib/completition/. Do you have
any suggestion about where the best way is to inwoke this kind of thing=
?

I added documentation about how to turn the feature on, in the same way
the other features is documented. (Is there an other way/better way I
should do this?)

>=20
> That said, this feature is extremely gross; it thrashes my filesystem
> and hard drive.  Modern software is written to minimize IO, not
> maximize it!  I'm completely against the inclusion of this patch.

It's extremly gross. I don't like this, _but_ it does speed up my work.
I'm unsure if it should be included in git though (hence the RFC-tag).

>=20
> However, I would not mind a feature that runs `git status` the very
> first time I enter a git working directory: when I enter my clone of
> linux.git, it takes my first `git status` invocation a good ten
> seconds to complete, and we can fix this pretty easily.

That's the problem I try to solve. However "the first time" is
irrelevant. We will run git status a bit before we need it. If we enter
linux.git, do other work (in an other project) for an hour and go back
to linux.git our cache will probably be empty. We will need to run this
more than "the first time". But still, we don't want it to run too
often. (Which is does now).

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
