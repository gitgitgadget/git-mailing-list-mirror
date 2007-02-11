From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Clean up geometry save code in gitk.
Date: Sun, 11 Feb 2007 19:56:43 +0300
Message-ID: <20070211195643.b1f548f2.vsu@altlinux.ru>
References: <11712040401127-git-send-email-mdl123@verizon.net>
	<11712040403973-git-send-email-mdl123@verizon.net>
	<1171204040779-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__11_Feb_2007_19_56_43_+0300_A74O_c=nbok7Fp.U"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Paul Mackerras <paulus@samba.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 17:57:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGI0j-0003K6-Dy
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbXBKQ47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbXBKQ46
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:56:58 -0500
Received: from master.altlinux.org ([62.118.250.235]:2016 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbXBKQ46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:56:58 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id 5A906E3F5D; Sun, 11 Feb 2007 19:56:57 +0300 (MSK)
In-Reply-To: <1171204040779-git-send-email-mdl123@verizon.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; x86_64-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39294>

--Signature=_Sun__11_Feb_2007_19_56_43_+0300_A74O_c=nbok7Fp.U
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello!

On Sun, 11 Feb 2007 09:27:20 -0500
Mark Levedahl <mdl123@verizon.net> wrote:

> gitk was saving widget sizes and positions when the main window was
> destroyed, which is after all child widgets are destroyed. The cure
> is to trap the WM_DELETE_WINDOW event before the gui is torn down. Also,
> the saved geometry was captured using "winfo geometry .", rather than
> "wm geometry ." Under Linux, these two return different answers and the
> latter one is correct.

> Leftover code was subtracting zero from several items before storing, an
> obvious noop now deleted.

These two patches fix saving of the window position for me; however,
some things still remain broken:

 - No matter what sizes of the commit tree, patch and filelist panes I
   set, on gitk restart they come up with their default sizes.

 - Sizes of commit tree columns are not saved properly - on every gitk
   restart the dividers are shifting more and more to the right.

This is on Linux (x86_64) with Tk 8.4.13.

I made two more patches which fix the above problems for me - please
test them (in particular, someone needs to check that the Cygwin
support is not broken - apparently something is different between Tk
on Linux and Cygwin to create the problem with commit tree columns).

See the followup messages.

--
Sergey Vlasov

--Signature=_Sun__11_Feb_2007_19_56_43_+0300_A74O_c=nbok7Fp.U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQFFz0rOW82GfkQfsqIRAuyrAJ9GGu4nxTpIAd5bE4V07jh/Y3GxewCfS91P
479ClheWgEP/DFzmCQuIJGw=
=essL
-----END PGP SIGNATURE-----

--Signature=_Sun__11_Feb_2007_19_56_43_+0300_A74O_c=nbok7Fp.U--
