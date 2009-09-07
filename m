From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: how to skip branches on git svn clone/fetch when there are errors
Date: Mon, 7 Sep 2009 15:53:44 +0200
Message-ID: <9accb4400909070653s4ddb07e4k54dde8d801b4b5e4@mail.gmail.com>
References: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com>
	 <9accb4400909070230n413c6ecfqef8238422dd5d3b@mail.gmail.com>
	 <9accb4400909070634oee46b78g9270586a2b0eb4b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 07 15:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkefP-0006Rz-Mn
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 15:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZIGNxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2009 09:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbZIGNxr
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 09:53:47 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:43888 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbZIGNxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 09:53:45 -0400
Received: by fxm17 with SMTP id 17so2001393fxm.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Ck4nQJjHMcCjBq6D7iT27s11zRptKyfC9qdHBwfmqok=;
        b=ApmVzOj2XSYG4944hRprHAgreo8tBrVjmV+5ECa+/ksvq8y9tUuyOiYZIria+wcvlW
         fVTmNFKQk/ewZdWCdCMG/+6EWEvePYLfWP47tIlVdd8wQUXxIdbo3GFnThzfMbbZPSPY
         80rCxXjG9LdrNiIBAPLSVhJz6c02M3oaLcKtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=GP7Ta5TRzBAYujFj0xulCMrYTfHQ2EfBNku8wDl7OLy1OKofNAPZ5AqKI6eGTmA73U
         oktcJmRW7fJkdlidZ6oH42Mu4OL3SEkI77iAyugVObqp4s3RX+laC77IVK2Z0R+xw32p
         LIdqb1k4iPl5hjjZs0cIcmS4WKyoKXXKOHyXs=
Received: by 10.204.163.65 with SMTP id z1mr12135120bkx.145.1252331625753; 
	Mon, 07 Sep 2009 06:53:45 -0700 (PDT)
In-Reply-To: <9accb4400909070634oee46b78g9270586a2b0eb4b9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 7, 2009 at 3:34 PM, Daniele Segato<daniele.bilug@gmail.com>=
 wrote:
> + =C2=A0 =C2=A0 =C2=A0 $SVN::Error::handler =3D sub {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (my $err) =3D @_;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $errno =3D $err=
->apr_err();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $err_key =3D $e=
rr->expanded_message;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($errno =3D=3D =
175007) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 warn "W: Ignoring error from SVN, path probably ",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "does not exist: ($errno): ",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $err->expanded_message,"\n";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;



ups..
this should have been return inside the if and die otherwise

and the error is 170001 (wrong copy/paste)

please ignore the patch I posted before

this is the "right" one:


=46rom a17dfb0e268e11ce70587ccb48c359348f22ad99 Mon Sep 17 00:00:00 200=
1
=46rom: Daniele Segato <daniele.bilug@gmail.com>
Date: Mon, 7 Sep 2009 15:30:14 +0200
Subject: [PATCH] Ignore err:170001 authorizationfailed on checkpath

I don't know if this is the best solution to solve the issue but it doe=
s
let me download the repo skipping the problematics paths
---
 git-svn.perl |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a366c89..80f958d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3756,7 +3756,24 @@ sub check_path {
 		return $cache->{data}->{$path};
 	}
 	my $pool =3D SVN::Pool->new;
+	my $err_handler =3D $SVN::Error::handler;
+	$SVN::Error::handler =3D sub {
+		(my $err) =3D @_;
+		my $errno =3D $err->apr_err();
+		my $err_key =3D $err->expanded_message;
+		if ($errno =3D=3D 170001) {
+			warn "W: Ignoring error from SVN, path probably ",
+				"does not exist: ($errno): ",
+				$err->expanded_message,"\n";
+			return;
+		}
+		die "Error from SVN, ($errno): ", $err->expanded_message,"\n";
+	};
+
 	my $t =3D $self->SUPER::check_path($path, $r, $pool);
+
+	$SVN::Error::handler =3D $err_handler;
+
 	$pool->clear;
 	if ($r !=3D $cache->{r}) {
 		%{$cache->{data}} =3D ();
--=20
1.5.6.5
