From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Mon, 13 Feb 2012 22:09:17 +0100
Message-ID: <20120213220917.4cf14eb1@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<m3y5s9rl3g.fsf@localhost.localdomain>
	<20120213074125.3e8793ad@mkiedrowicz.ivo.pl>
	<201202131944.50886.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 22:09:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx39M-0004Oj-UE
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 22:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757834Ab2BMVJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 16:09:24 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59663 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab2BMVJX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 16:09:23 -0500
Received: by eaah12 with SMTP id h12so1921894eaa.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 13:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=AfAv7wjkBYooHKzgxwdOoDzVg0hlEdOsK9q9LHXx/WQ=;
        b=DNyKKne/HYk6ddq+wcSrwsGFewneTcNstzRt6oEHOwz7CxQN3bF3mF+F0XVy9mgdl6
         u1Yld+SWQRkO7g+AHcJbNOrS0BVFiZ0UNy604HCqxmVQ3/jbupQOeDjKQSzTHg+DbPEw
         xQ9HPnWgEGy3bHlzKsIbdB96nMoYwegUf2JYw=
Received: by 10.14.22.65 with SMTP id s41mr5677963ees.50.1329167361896;
        Mon, 13 Feb 2012 13:09:21 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id o49sm64987607eeb.7.2012.02.13.13.09.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 13:09:21 -0800 (PST)
In-Reply-To: <201202131944.50886.jnareb@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190670>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Mon, 13 Feb 2012, Michal Kiedrowicz wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> > > Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
> > I haven't found *examples* on GitHub and Trac sites, but what about
> > these ones:
> >=20
> > https://github.com/gitster/git/commit/8cad4744ee37ebec1d9491a1381ec=
1771a1ba795
> > http://trac.edgewall.org/changeset/10973
>=20
> Thanks.  That is what I meant by "good examples".  Perhaps they shoul=
d
> be put in the commit message?

OK

>=20
> BTW GitHub is closed source, but we can check what algorithm does Tra=
c
> use for diff refinement highlighting (highlighting changed portions o=
f
> diff).
>=20

I think it's
http://trac.edgewall.org/browser/trunk/trac/versioncontrol/diff.py
(see markup intraline_changes()).


> > > It doesn't implement LCS / diff
> > > algorithm like e.g. tkdiff does for its diff refinement highlight=
ing,
> > > isn't it?
> >=20
> > I doesn't. I share the Jeff's opinion that:
> > a) Jeff's approach is "good enough"
> > b) LCS on bytes could be very confusing if it marked few sets of
> > characters.
>=20
> I wonder if we can use --diff-words for diff refinement highlighting,
> i.e. LCS on words.

I think we can try it, but I worry about performance of running `git
diff` on every diff chunk.


>=20
> Anyway Jeff's approach is a bit limited, in that it would work only f=
or
> change that does not involve adding newlines, for example splitting
> overly long line when changing something.
>=20
> See for example line 1786 (in pre-image) in http://trac.edgewall.org/=
changeset/10973
> =20

Yes, I'm aware of that. I was thinking about improving it later ("Let's
start with a simple refinment highlightning and maybe later add more
sophisticated algorithms").

> > > By completly different you mean that they do not have common pref=
ix or
> > > common suffix (at least one of them), isn't it?
>=20
> BTW. is it "at least one of prefix or suffix are non-empty" or "both =
prefix
> and suffix are non-empty"?
>=20

At least one. See:

	-a =3D 42;
	+b =3D 42;

Here prefix is empty but suffix is not.

> > I would also consider ignoring prefixes/suffixes with punctuation, =
like:
> >=20
> > 	- * I like you.
> > 	+ * Alice had a little lamb.
>=20
> But this patch doesn't implement this feature yet, isn't it?

No, but is a matter of adding

	-$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s/);
	+$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s|[[:punct:]]/);

(and the same for suffix)

> Well, here is another idea: do not highlight if sum of prefix and suf=
fix
> lengths are less than some threshold, e.g. 2 characters not including=
=20
> whitespace, or some percentage with respect to total line length.
>=20

That might be a good idea.

> > > Eeeeeek!  First you split into letters, in caller at that, then j=
oin?
> > > Why not pass striung ($str suggests string not array of character=
s),
> > > and use substr instead?
> > >=20
> > > [Please disregard this and the next paragraph at first reading]
> >=20
> > I will rename $str to something more self describing.
>=20
> Please do.
>=20
> BTW. don't you assume here that both common prefix and common suffix
> are non-empty?

Yes. The caller makes sure they are correct (at least=20

> > > > +sub format_rem_add_line {
> > > > +	my ($rem, $add) =3D @_;
> > > > +	my @r =3D split(//, $rem);
> > > > +	my @a =3D split(//, $add);
>=20
> BTW the name of variable can be just @add and @rem.
>

I know they are different scopes but I don't like it. It makes the code
more confusing IMO. But I won't insist.

> > > Shouldn't
> > > $prefix / $prefix_len start from 0, not from 1?
> >=20
> > It starts from 1 because it skips first +/-. It should become obvio=
us
> > after reading the comment from last patch :).
> >=20
> > +	# In combined diff we must ignore two +/- characters.
> > +	$prefix =3D 2 if ($is_combined);
>=20
> Anyway comment about that fact would be nice.

Will do.

> =20
> > > > +	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
> > > > +
> > > > +	while ($prefix < @r && $prefix < @a) {
> > > > +		last if ($r[$prefix] ne $a[$prefix]);
> > > > +
> > > > +		$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s/);
> > > > +		$prefix++;
> > > > +	}
> > >=20
> > > Ah, I see that it is easier to find common prefix by treating str=
ing
> > > as array of characters.
> > >=20
> > > Though I wonder if it wouldn't be easier to use trick of XOR-ing =
two
> > > strings (see "Bitwise String Operators" in perlop(1)):
> > >=20
> > >         my $xor =3D "$rem" ^ "$add";
> > >=20
> > > and finding starting sequence of "\0", which denote common prefix=
=2E
> > >=20
> > >=20
> > > Though this and the following is a nice implementation of
> > > algorithm... as it would be implemented in C.  Nevermind, it migh=
t be
> > > good enough...
> >=20
> > The splitting and comparing by characters is taken from diff-highli=
ght.
> > I don't think it's worth changing here.
>=20
> You are right.
>=20
> I'll try to come with hacky algorithm using string bitwise xor and re=
gexp,
> and benchmark it comparing to your C-like solution, but it can be lef=
t for
> later (simple is better than clever, usually).

If you have time :).

> > > >  # HTML-format diff context, removed and added lines.
> > > >  sub format_ctx_rem_add_lines {
> > > > -	my ($ctx, $rem, $add) =3D @_;
> > > > +	my ($ctx, $rem, $add, $is_combined) =3D @_;
> > > >  	my (@new_ctx, @new_rem, @new_add);
> > > > +	my $num_add_lines =3D @$add;
> > >=20
> > > Why is this temporary variable needed?  If you are not sure that =
=3D=3D
> > > operator enforces scalar context on both arguments you can always
> > > write
> > >=20
> > >   scalar @$add =3D=3D scalar @$rem
> >=20
> > You read my mind.
>=20
> BTW. the same comment applies to patch adding support for highlightin=
g
> changed part in combined diff.
>

OK
 =20
