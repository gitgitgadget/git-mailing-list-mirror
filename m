From: David Aguilar <davvid@gmail.com>
Subject: Re: Parallell Development / Switching to GIT
Date: Sun, 28 Jun 2009 15:33:20 -0700
Message-ID: <20090628223319.GA1951@gmail.com>
References: <loom.20090625T095000-90@post.gmane.org> <4A434D6F.2090105@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local> <20090628184714.GA8634@sigio.peff.net> <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>
To: "Patrick Neuner - Futureweb.at" <neuner@futureweb.at>
X-From: git-owner@vger.kernel.org Mon Jun 29 00:33:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML2wZ-0006r9-ST
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 00:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbZF1WdW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Jun 2009 18:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbZF1WdW
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 18:33:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:6921 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbZF1WdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 18:33:21 -0400
Received: by wa-out-1112.google.com with SMTP id j5so725297wah.21
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vkcbXyjFfWYf9JI05DSbqHXn94mPkXlu1PU3elrLLVw=;
        b=fcrMWl5m2bTKO845WKR0BTu0q8brI+rpW27wgVHpbSfsffKa3sYPDTKafRJHVLZBNu
         XG9291Y1u18sQFr3q2KH89fvRLrbo7R0VYGTcYPsDnN9ZM0fb98Ba0peugkzMsHscL3N
         3bnxcrnZaVYTZ3wahNTAQQONvoRNN+NpJbQ2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rzfwXls98a1erQRzsrEnVAe16JF3iGPRlqLQ3f0WKTUVd2868gKjscBlVKBg0WePZ3
         tA8Op40Cp+ipse3rDJ5dMjs/x63tOs4knGc4b0dJ1RwmTA3CLkJ4oS6nfEubhpMMrmKE
         PAg1rsdDNGTIqcNeeddCMCvu5ACszO32AoolE=
Received: by 10.114.169.20 with SMTP id r20mr10125295wae.222.1246228404650;
        Sun, 28 Jun 2009 15:33:24 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m6sm7772510wag.49.2009.06.28.15.33.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 15:33:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122425>

On Sun, Jun 28, 2009 at 10:08:45PM +0200, Patrick Neuner - Futureweb.at=
 wrote:
> Hi,
>=20
> thanks for your answers, I appreciate that.
> I read about cherry-picking, but I am not quite sure if that's really=
 what we need.=20
> Lets assume, you do a new feature:=20
>=20
> /featureX
>=20
> You will commit it, check it out on the testserver and probably see a=
 bug, fix it, commit and push it again. (and probably more commits afte=
r the testing person ran over other issues).=20


You are doing parallel development with a centralized resource:
the test server.

That is not going to fly, and there's no amount of tooling
that will resolve this conflict.

The only solution is spend some time on infrastructure and
use virtual machines (virtualbox and other systems are known to
work well; I'm sure you can find better recommendations from
others here) to remove your central test server bottleneck.
You don't even need virtual machines.  It sounds like you're
developing a webapp, in which case every normal workstation
would do just fine for hosting a test server.

Once you have the test environment duplicated on each
developers' machine then you will find that testing and
managing new features using "feature branches" will come
easily and naturally.

This exercise will also improve your deployment strategy
substantially.  There is no longer anything particularly
special about $production_server or $test_server.  They would
all be "just another instance" of the easily replicatable
environment that you've created for the development team.

I've intentionally described things at a high level.
There are plenty of good resources that go into the mechanics
of how to use feature branches in git.

Once all of your features and bugfixes are happening on
branches then knowing which commits went into a particular
feature or bugfix becomes trivial.

In summary: use branches.
They are a simple yet very powerful construct.


> With cherry-picking, I would need to know all commits I have to pick.=
=20
> But as there have been serveral commits, so wouldn't it be a pain to =
check all commits to that file or directory to have the same version?
>=20
> Just trying to find the right way to handle that.=20
>=20
>=20
> About the 2nd point - I am not sure if I get the different repositori=
es thing.=20
> Do you talk about to different clones of the rep, and give different =
directory permissions on it,=20
> or is there a way to have like to completly different git rep's runni=
ng and still merge things over (both ways)?
> I just thought this approach would break correct mergin, as it doesn'=
t know where it's comming from.=20
>=20
> The only thing I ran over so far is probably doing a hook for that (l=
ike a pre-pull hook if that exists). didn't get to read too much about =
hooks yet,
> just did the update hook that checks if the user with specific ssh ke=
y is allowed to push to a specific branch. That works pretty good and i=
s more important in fact.
>=20
> But having 2 completly different repos would be another solution, but=
 I kinda wonder that mergin would work correctly this way (if both side=
s have changes).=20
>=20
> Thanks
> Patrick=20
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Jeff King [mailto:peff@peff.net]=20
> Gesendet: Sonntag, 28. Juni 2009 20:47
> An: Patrick Neuner - Futureweb.at
> Cc: Andreas Ericsson; git@vger.kernel.org
> Betreff: Re: Parallell Development / Switching to GIT
>=20
> On Sun, Jun 28, 2009 at 07:51:26PM +0200, Patrick Neuner - Futureweb.=
at wrote:
>=20
> > 1) What if I only want to merge a specific file/directly, but not t=
he
> > whole branch, is there a way?
> > [...]
> > The reason is, that external developers will only commit to
> > development branch.  They are working on new features, and sometime=
s
> > some small bugfixes, or design templates.  Those need to be merged
> > separately, and we try to not have more branches. As developers can
> > access our testserver and then see what they have done and test
> > functionality.
>=20
> For the situation you describe, it is not about merging a specific
> _file_, but rather you want to pick specific _commits_ from the
> development branch that have the bugfixes (or whatever) that you need=
,
> and merge the changes introduced by those commits (but not the rest o=
f
> the history).
>=20
> And that is easy to do; it is called cherry-picking, and you can use
> "git cherry-pick" to pick specific commits from development to master=
=2E
>=20
> > 2) We are using gitosis to give external developers access to the
> > branches and have some kind of access restriction.  But we are only
> > able to limit push rights, not pull rights. In most cases, that's n=
ot
> > a problem, if they see master And development, but sometimes (like =
for
> > external designers), we might want them to only be able to checkout
> > some directories.
>=20
> There are two ways you can split access, and one will work but the ot=
her
> will not.
>=20
> In git, you generally cannot split your data by _tree_. That is, you
> cannot say "here is all of the history for the master branch, but you
> are only allowed to look at some subset of the files." Because at a
> fundamental level, git is about tracking changes to the _whole_ set o=
f
> files over time, and it makes the assumption that if you have commit =
X,
> which points to tree Y, which points to files A, B, and C, that you w=
ill
> have the data for X, Y, A, B, and C in your repository.
>=20
> However, if you have your data split by _history_, that might work. T=
hat
> is, if you have a "master" branch and a "development" branch, you can=
 in
> theory say "you may look at the history of master, but not of
> development". The usual way to do that is to actually keep "master" a=
nd
> "development" in two different repositories, and only grant read
> permission in the filesystem for the "master" one (which obviously
> implies doing your reading over something authenticated, like ssh).
>=20
> Hope that helps,
> -Peff

--=20

	David
