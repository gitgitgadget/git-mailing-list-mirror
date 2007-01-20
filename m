From: Martin Waitz <tali@admingilde.org>
Subject: Re: SEGV in git-apply
Date: Sat, 20 Jan 2007 19:36:15 +0100
Message-ID: <20070120183615.GA6459@admingilde.org>
References: <20070120014851.GF5231@admingilde.org> <Pine.LNX.4.63.0701200312000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 19:36:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8L4f-0004fn-Fp
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 19:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbXATSgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 13:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965339AbXATSgQ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 13:36:16 -0500
Received: from mail.admingilde.org ([213.95.32.147]:52810 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965297AbXATSgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 13:36:16 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1H8L4Z-0000bC-9D; Sat, 20 Jan 2007 19:36:15 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701200312000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37280>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Jan 20, 2007 at 03:14:46AM +0100, Johannes Schindelin wrote:
> But without that patch I cannot tell.

patch was this one:

------------------ 8< -------------------------------
--- src/callbacks.cc	2006-11-02 10:16:50.000000000 +0100
+++ src/callbacks.cc	2007-01-17 20:47:00.000000000 +0100
@@ -12890,12 +12890,11 @@ void on_unknown_edit_optionmenu_sign_cha
 	}
 }
=20
-gboolean on_key_press_event(GtkWidget*, GdkEventKey *event, gpointer) {
+gboolean on_key_press_event(GtkWidget *o, GdkEventKey *event, gpointer) {
 	if(!GTK_WIDGET_HAS_FOCUS(expression) && (event->keyval > GDK_Hyper_R || e=
vent->keyval < GDK_Shift_L)) {
-		bool return_val =3D FALSE;
 		GtkWidget *w =3D gtk_window_get_focus(GTK_WINDOW(glade_xml_get_widget (m=
ain_glade, "main_window")));
-		if(w) g_signal_emit_by_name((gpointer) w, "key_press_event", event, &ret=
urn_val);
-		if(return_val) return TRUE;
+		if(gtk_bindings_activate_event(GTK_OBJECT(o), event)) return TRUE;
+		if(w && gtk_bindings_activate_event(GTK_OBJECT(w), event)) return TRUE;
 		focus_keeping_selection();
 	}
 	return FALSE;
------------------ 8< -------------------------------

git-apply inside the "src" directory segfaulted.

--=20
Martin Waitz

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFsmEfj/Eaxd/oD7IRAl2aAJsHCixSUxlgCwb1qcgLtSxg+44m5QCfY8Oo
0K/Q0mKa+17kzFWfkb0m9b4=
=EvPq
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
