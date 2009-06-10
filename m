From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] more tests for git rev-parse --parse-opt
Date: Wed, 10 Jun 2009 16:16:14 +0200
Message-ID: <20090610141614.GA20299@pengutronix.de>
References: <7vzlcgr088.fsf@alter.siamese.dyndns.org> <1244626926-19841-1-git-send-email-u.kleine-koenig@pengutronix.de> <4A2F8CEC.4080600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEObI-0004y5-AB
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 16:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbZFJOQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 10:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbZFJOQP
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 10:16:15 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56686 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbZFJOQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 10:16:14 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MEObA-0008QQ-Db; Wed, 10 Jun 2009 16:16:16 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MEOb8-0005KP-Bc; Wed, 10 Jun 2009 16:16:14 +0200
Content-Disposition: inline
In-Reply-To: <4A2F8CEC.4080600@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121279>

Hello Johannes,

On Wed, Jun 10, 2009 at 12:37:32PM +0200, Johannes Sixt wrote:
> Uwe Kleine-K=F6nig schrieb:
> > -test_expect_success 'test --parseopt help output' '
> > -	git rev-parse --parseopt -- -h 2> output.err <<EOF
> > +OPTION_SPEC=3D"\
> >  some-command [options] <args>...
> > =20
> >  some-command does foo and bar!
> > @@ -36,8 +35,53 @@ C?        option C with an optional argument
> > =20
> >  Extras
> >  extra1    line above used to cause a segfault but no longer does
> > +"
> > +
> > +test_expect_success 'test --parseopt help output' '
> > +	git rev-parse --parseopt -- -h 2> output.err <<EOF
> > +$OPTION_SPEC
> >  EOF
> >  	test_cmp expect.err output.err
> >  '
>=20
> You use the same input in this and all new tests; make this:
>=20
> cat > optionspec <<EOF
> ...
> EOF
>=20
> test_expect_success 'test --parseopt help output' '
> 	git rev-parse --parseopt -- -h 2> output.err < optionspec &&
> 	test_cmp expect.err output.err
>=20
> (note the added &&).
OK, this should work.  I will rework it later today.

BTW: I wonder why

	git rev-parse --parseopt -- -h 2> output.err < optionspec

fills output.err, is there some magic that detects that the help should
be printed?  *read some source*  ah, -h is hardcoded to print the help.
This is a bit surprising, still more as -h is a valid option in the
specified optionspec.  Thoughts?

Thanks
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
