From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 05/10] builtin-fsck: move common object checking code to fsck.c
Date: Tue, 26 Feb 2008 22:35:23 +0100
Message-ID: <20080226213523.GA26618@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at> <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at> <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at> <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at> <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at> <7vskzg6pmw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU7TC-0006kF-1b
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 22:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765615AbYBZVf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2008 16:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765595AbYBZVf0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 16:35:26 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55360 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765584AbYBZVfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 16:35:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id ABB27680BF87;
	Tue, 26 Feb 2008 22:35:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bHj5BbqwL+jD; Tue, 26 Feb 2008 22:35:23 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 85542680BF73; Tue, 26 Feb 2008 22:35:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vskzg6pmw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75177>

On Tue, Feb 26, 2008 at 01:19:51AM -0800, Junio C Hamano wrote:
> Is this series an unadjusted resend or something?  This particular on=
e
> had funny interaction with your own d4fe07f (git-fsck: report missing
> author/commit line in a commit as an error) that is already in
> 'master', so I had to munge it by hand.=20

I sent the series directly based on master, as Shawn suggested (21c34 i=
s only changing the prefix in Makefile):
3c5fb6a798a0b686e7818bf1da63791fb94a7b21 receive-pack: use strict mode =
for unpacking objects
786bf704ce4067c80055a1fa69be242a59880eb0 index-pack: introduce checking=
 mode
1f7ae754550fb6e0509c1498ba9de6b5f4bba438 unpack-objects: prevent writin=
g of inconsistent objects
143aa20e11c70595e4119a3adac0887446524c7f unpack-object: cache for non w=
ritten objects
997a515fccb3ef200cb96fbb757366eff8a2ee66 add common fsck error printing=
 function
b0785b6b99c641b2fec99eb48da340af627e3b0d builtin-fsck: move common obje=
ct checking code to fsck.c
fa9c45a16cc194c87c113c9740eb5a6e17b66cc1 builtin-fsck: reports missing =
parent commits
a93e35027c53f06d2db2adbb14fa916871e23e46 Remove unused object-ref code
19eae91b8e3d2e72616397edf77a13d4ac79d7ab builtin-fsck: move away from o=
bject-refs to fsck_walk
0ca75709265281548be81cad4f396f4cf936dbfb add generic, type aware object=
 chain walker
21c34821c02458f45422e747853bde913d43c625 Lokale Anpassung Makefile
99d8ea2c5ce6fc0b06fe8a43e7c0c108ddad853b git-bundle.txt: Add different =
strategies to create the bundle
8e0fbe671f6a63b885702917bf4e7d7a85c59ab4 builtin-for-each-ref.c: fix ty=
po in error message
8a8bf4690e20a545561249a9b393c1ef3239c03d send-email: test compose funct=
ionality

The patch was sent as usual, so I don't know, why it should not apply.

> It was not so pleasant
> (a large chunk of code was moved from builtin-fsck.c to fsck.c),
> but that is what the maintainer does, so it's Ok.  But I'd like
> you to eyeball the result to see if it looks sane.

I have compared it to 3c5fb6a798a0b686e7818bf1da63791fb94a7b21 and
everything seems to look OK. I'll do better verification in the next
days.

> I'll push it out as part of 'pu'.  The tip of your topic is
> 154a955 (receive-pack: use strict mode for unpacking objects)
> tonight:
>=20
> 	Side note: To find a tip of a topic yourself, look for "Merge
> 	mk/maint-parse-careful" in "git log --first-parent
> 	origin/next..origin/pu" output and find the latest one.

> One thing I noticed was that parse_$type_buffer() family all take
> non-const void *buf pointers but one new caller you introduced takes
> "const void *data" and passes that pointer to them.  I hated to, but
> ended up loose-casting it.  You may want to make the function take
> non-const pointer, but I did not look very carefully.

The easiest thing would be to remove the const from the data parameter
in sha1_object (index-pack.c).

How should I handle changes? Send a patch ontop of 154a955 or should I
send a amended version of the patches?

> By the way, while I was at it, many stylistic issues bugged me too
> much, so I ended up fixing them as well:
>
[...]
>=20
>  * If you cast, cast to the right type ;-)
>=20
> 	struct tree *item =3D (struct tree *) obj;
>=20
>    not
>=20
> 	struct tree *item =3D (struct item*) obj;
>
> Please do not make me do this again, as I do not have infinite amount
> of time.  This plea is not only about your patch but applies to
> everybody.

Sorry for struct item. I really should have looked more carefully at th=
e
make output.

I did not know all of these styling guidelines. SubmittingPatches only
talks about broken mailer. Maybe it would be a good thing to include
them somewhere.

As I'm not very good at catching all these issues, I tried
checkpatch.pl (from the linux.git:/scripts) on my patches. After
turning the 80 characters/line check off, it show me formating errors,
about which you complained. So I'll try to run it over my patches in
the future.

mfg Martin K=F6gler
