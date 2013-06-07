From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: is there a fast web-interface to git for huge repos?
Date: Fri, 7 Jun 2013 19:57:17 +0200
Message-ID: <20130607175717.GA25127@paksenarrion.iveqy.com>
References: <CAPKkNb4bYfBeqkBKqe-22iJsqjmvrYNSe4oWUnPo7QeghLK59Q@mail.gmail.com>
 <20130607063353.GB19771@paksenarrion.iveqy.com>
 <CAPKkNb5PyurX1eNsCsckdfiwgM3dqb5KpN9OS0NpLZw1+VsSdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: "Constantine A. Murenin" <mureninc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 19:54:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul0sH-0006Ov-Mo
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 19:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab3FGRyu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 13:54:50 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:48852 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab3FGRyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 13:54:49 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so3481252lbv.27
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uPEd13p+yZsdfMydvayeVIn3AFQK3kjkbeH56qvIjSw=;
        b=L0jUsp2PpssKw4LNEGdpN16O701bigIzo2qYVexKXKp1qr89PLlD75/bFl4ge2mSSs
         U3Wt3oUgkyAr30iSNSIT8xIk9RkB3JlmCkPv+XpjADH4rsH47jByEhTW+OkSMiEQ5tz5
         RiQP5/30/qRYxg/rk6+p7ye8pXdRVgcWQqyl30KkzJImvw9o72JoZcD4Y6KqnmOAfHLH
         dS7eVP+Bh4O9hQ3HZsHNCaoox+gxYXkV7bGyEsvlfznEpjuFV9gCygPD2fpVSOuETO7n
         1XyprzyPRZd9dBhzqNpBUgZMvVU6nd2gJ2Nmx+Teu4JmBO4hU0ES4zd8QM80iIDvhKb1
         QQlg==
X-Received: by 10.152.44.137 with SMTP id e9mr2973856lam.80.1370627687501;
        Fri, 07 Jun 2013 10:54:47 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id w8sm1372532lbi.14.2013.06.07.10.54.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 10:54:46 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Ul0ub-0006eO-1y; Fri, 07 Jun 2013 19:57:17 +0200
Content-Disposition: inline
In-Reply-To: <CAPKkNb5PyurX1eNsCsckdfiwgM3dqb5KpN9OS0NpLZw1+VsSdg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226656>

On Fri, Jun 07, 2013 at 10:05:37AM -0700, Constantine A. Murenin wrote:
> On 6 June 2013 23:33, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> > On Thu, Jun 06, 2013 at 06:35:43PM -0700, Constantine A. Murenin wr=
ote:
> >> I'm interested in running a web interface to this and other simila=
r
> >> git repositories (FreeBSD and NetBSD git repositories are even muc=
h,
> >> much bigger).
> >>
> >> Software-wise, is there no way to make cold access for git-log and
> >> git-blame to be orders of magnitude less than ~5s, and warm access
> >> less than ~0.5s?
> >
> > The obvious way would be to cache the results. You can even put an
>=20
> That would do nothing to prevent slowness of the cold requests, which
> already run for 5s when completely cold.
>=20
> In fact, unless done right, it would actually slow things down, as
> lines would not necessarily show up as they're ready.

You need to cache this _before_ the web-request. Don't let the
web-request trigger a cache-update but a git push to the repository.

>=20
> > update cache hook the git repositories to make the cache always be =
up to
> > date.
>=20
> That's entirely inefficient.  It'll probably take hours or days to
> pre-cache all the html pages with a naive wget and the list of all th=
e
> files.  Not a solution at all.
>=20
> (0.5s x 35k files =3D 5 hours for log/blame, plus another 5h of cpu t=
ime
> for blame/log)

That's a one-time penalty. Why would that be a problem? And why is wget
even mentioned? Did we misunderstood eachother?

>=20
> > There's some dynamic web frontends like cgit and gitweb out there b=
ut
> > there's also static ones like git-arr ( http://blitiri.com.ar/p/git=
-arr/
> > ) that might be more of an option to you.
>=20
> The concept for git-arr looks interesting, but it has neither blame
> nor log, so, it's kinda pointless, because the whole thing that's slo=
w
> is exactly blame and log.
>=20
> There has to be some way to improve these matters.  Noone wants to
> wait 5 seconds until a page is generated, we're not running enterpris=
e
> software here, latency is important!
>=20
> C.

Git's internal structures make just blame pretty expensive. There's
nothing you really can do for it algoritm wise (as far as I know, if
there was, people would already improved it).

The solution here is to have a "hot" repository to speed up things.

There's of course little things you can do. I imagine that using git
repack in a sane way probably could speed things up, as well as git gc.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
