From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: please strip MIME-Version and Content-T{ype,ransfer-Encoding} in git
 am --scissors
Date: Thu, 8 Oct 2015 09:17:28 +0200
Message-ID: <20151008071728.GO3982@pengutronix.de>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <5614CDAE.6070604@ti.com>
 <20151007075338.GH3982@pengutronix.de>
 <20151007102822.GT23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 09:17:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk5SI-0002qO-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 09:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbbJHHRb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 03:17:31 -0400
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48019 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbbJHHRa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 03:17:30 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1Zk5SD-0004hF-6G
	for git@vger.kernel.org; Thu, 08 Oct 2015 09:17:29 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1Zk5SC-0005Y7-Ae
	for git@vger.kernel.org; Thu, 08 Oct 2015 09:17:28 +0200
Content-Disposition: inline
In-Reply-To: <20151007102822.GT23801@atomide.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279217>

Hello,

when applying the mail below (without the '> ' prefix) using git am
--scissors the result looks like:

	$ git show
	commit 26ef0606927cc1979faa4166d7f9f3584b5cdc61
	Author: Tony Lindgren <tony@atomide.com>
	Date:   Tue Oct 6 05:36:17 2015 -0700

	    memory: omap-gpmc: Fix unselectable debug option for GPMC
	   =20
	    MIME-Version: 1.0
	    Content-Type: text/plain; charset=3DUTF-8
	    Content-Transfer-Encoding: 8bit
	   =20
	    Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for de=
bug")
	    added a debug option for GPMC, but somehow managed to keep it unse=
lectable.
	   =20
	[...]

	$ git version
	git version 2.6.0

The obvious improvement is to strip all headers like git am does withou=
t
--scissors.

If someone wants a bounce of the original mail, just ask per PM.

Best regards
Uwe


On Wed, Oct 07, 2015 at 03:41:19AM -0700, Tony Lindgren wrote:
> * Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [151007 00:57]:
> > On Wed, Oct 07, 2015 at 10:45:50AM +0300, Roger Quadros wrote:
> > >=20
> > > How about this instead?
> > >=20
> > > NOTE: Apart from matching the register setup with the bootloader =
you also need to
> > > match the GPMC FCLK frequency used by the bootloader else the GPM=
C timings
> > > won't be identical with the bootloader timings.
> > Yeah, sounds better, thanks.
> >=20
> > > Also you might need to build this patch on top of
> > > http://article.gmane.org/gmane.linux.kernel/2054796
> > I talked to Tony about this patch yesterday on irc, but I didn't fi=
nd it
> > in the archives yet when I sent my mail.
>=20
> Yes sorry here's a repost with your and Roger's changes folded in and
> edited a bit. Probably best to keep them together with this patch.
>=20
> Does the following look OK to you guys?
>=20
> Regards,
>=20
> Tony
>=20
> 8< ----------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 6 Oct 2015 05:36:17 -0700
> Subject: [PATCH] memory: omap-gpmc: Fix unselectable debug option for=
 GPMC
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug=
")
> added a debug option for GPMC, but somehow managed to keep it unselec=
table.
>=20
> This probably happened because I had some uncommitted changes and the
> GPMC option is selected in the platform specific Kconfig.
>=20
> Let's also update the description a bit, it does not mention that
> enabling the debug option also disables the reset of GPMC controller
> during the init as pointed out by Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> and Roger Quadros <rogerq@ti.com>.
>=20
> Fixes: 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug=
")
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -58,12 +58,18 @@ config OMAP_GPMC
>  	  memory drives like NOR, NAND, OneNAND, SRAM.
> =20
>  config OMAP_GPMC_DEBUG
> -	bool
> +	bool "Enable GPMC debug output and skip reset of GPMC during init"
>  	depends on OMAP_GPMC
>  	help
>  	  Enables verbose debugging mostly to decode the bootloader provide=
d
> -	  timings. Enable this during development to configure devices
> -	  connected to the GPMC bus.
> +	  timings. To preserve the bootloader provided timings, the reset
> +	  of GPMC is skipped during init. Enable this during development to
> +	  configure devices connected to the GPMC bus.
> +
> +	  NOTE: In addition to matching the register setup with the bootloa=
der
> +	  you also need to match the GPMC FCLK frequency used by the
> +	  bootloader or else the GPMC timings won't be identical with the
> +	  bootloader timings.
> =20
>  config MVEBU_DEVBUS
>  	bool "Marvell EBU Device Bus Controller"
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
