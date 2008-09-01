From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] for-each-ref: `:short` format for `refname`
Date: Mon, 1 Sep 2008 12:10:51 -0700
Message-ID: <20080901191051.GD7482@spearce.org>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org> <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com> <20080901131523.GA6739@neumann> <36ca99e90809010713h7c673d10j6addd1624a655371@mail.gmail.com> <36ca99e90809011052s568fa6e4y89e56769f63806c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER GGGbor <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaEog-0003H3-9E
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbYIATKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 15:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYIATKw
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:10:52 -0400
Received: from george.spearce.org ([209.20.77.23]:52905 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbYIATKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:10:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C380238375; Mon,  1 Sep 2008 19:10:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <36ca99e90809011052s568fa6e4y89e56769f63806c1@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94601>

Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> IMHO the goal of this new format for refname should be, that it can b=
e
> used as an ref on the command line. This isn't given with my current
> :short proposal (which I call :strip as of now), as G=C3=A1bor showed=
=2E What
> we need is the reverse of what happened with refnames given on the
> command line to commands like checkout/merge/... The only thing that
> comes near to this is this from refs.c:
>=20
>     const char *ref_rev_parse_rules[] =3D {
>             "%.*s",
>             "refs/%.*s",
>             "refs/tags/%.*s",
>             "refs/heads/%.*s",
>             "refs/remotes/%.*s",
>             "refs/remotes/%.*s/HEAD",
>             NULL
>     };
>=20
> Which doesn't look very useful, because every ref from for_each_ref
> would match rule one. So we probably need to try the reverse of this
> list.

Yup.  If you search the list backwards and extract the part of the
ref that matches %.*s you'll get a name that other tools can find,
and which is the shortest name possible.

You can still get ambiguous names.  Avoiding them requires going
through all refs and building their short forms, then using the
full ref name for any ref which had more than one name shorten to
the same string.  Ugly, but implementable, and probably something
that should be considered.

--=20
Shawn.
