From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] Documentation: fix linkgit references
Date: Mon, 2 May 2016 16:34:45 -0400
Message-ID: <20160502203445.GA19509@sigill.intra.peff.net>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
 <1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
 <1462220405-12408-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com, gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon May 02 22:34:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axKYS-0003F9-VO
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 22:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbcEBUeu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 16:34:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:60569 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754680AbcEBUet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 16:34:49 -0400
Received: (qmail 15767 invoked by uid 102); 2 May 2016 20:34:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 16:34:48 -0400
Received: (qmail 18700 invoked by uid 107); 2 May 2016 20:34:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 16:34:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 May 2016 16:34:45 -0400
Content-Disposition: inline
In-Reply-To: <1462220405-12408-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293285>

On Mon, May 02, 2016 at 10:20:04PM +0200, larsxschneider@gmail.com wrot=
e:

> From: Lars Schneider <larsxschneider@gmail.com>
>=20
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

=46ix how? Your commit message doesn't say why this is a good idea. Sin=
ce
this is v3, I'm guessing that reasoning is on the list, but it needs to
be summarized here in the commit message.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c7bbe98..c5f1d6b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -894,7 +894,7 @@ branch.<name>.description::
>  browser.<tool>.cmd::
>  	Specify the command to invoke the specified browser. The
>  	specified command is evaluated in shell with the URLs passed
> -	as arguments. (See linkgit:git-web{litdd}browse[1].)
> +	as arguments. (See linkgit:git-web--browse[1].)

The existing code renders fine for me with "make git-config.1". But wit=
h
your patch, I get a unicode emdash, which is wrong:

--- old	2016-05-02 16:27:53.242050262 -0400
+++ new	2016-05-02 16:27:57.742050360 -0400
@@ -978,7 +978,7 @@
=20
        browser.<tool>.cmd
            Specify the command to invoke the specified browser. The sp=
ecified command is evaluated in shell with the
-           URLs passed as arguments. (See git-web--browse(1).)
+           URLs passed as arguments. (See git-web=E2=80=94browse(1).)
=20
        browser.<tool>.path
            Override the path for the given tool that may be used to br=
owse HTML help (see -w option in git-help(1))

In case it's hard to see with your font, the generated roff looks like
this:

-\fBgit-web--browse\fR(1)\&.)
+\fBgit-web\(embrowse\fR(1)\&.)

So I think that's a step backwards. I did check the asciidoctor
rendering on git-scm.com, though, and it gets the {litdd} case wrong. S=
o
I think it does need fixing, but we need a solution that looks correct
in both cases. Maybe linkgit:`git-web--browse`[1] would work; it seems
OK with my version of asciidoc, but I have a feeling it will run into
the same problem with asciidoctor (if it's not respecting {litdd} in
that context, it's probably also not respecting backticks).

-Peff
