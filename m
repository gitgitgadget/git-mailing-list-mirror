From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] send-email: lazily assign editor variable
Date: Mon, 22 Mar 2010 17:41:52 +0100
Message-ID: <20100322164152.GA30332@pengutronix.de>
References: <20100322145947.GA1709@pengutronix.de> <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 22 17:42:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtkhU-000259-6E
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 17:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab0CVQl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 12:41:57 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42520 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab0CVQlz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 12:41:55 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1NtkhO-0007nN-Bj; Mon, 22 Mar 2010 17:41:54 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1NtkhM-00039i-Ew; Mon, 22 Mar 2010 17:41:52 +0100
Content-Disposition: inline
In-Reply-To: <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142944>

Hello Michael,

On Mon, Mar 22, 2010 at 05:12:53PM +0100, Michael J Gruber wrote:
> b4479f0 (add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR",
> 2009-10-30) introduced the use of git var GIT_EDITOR which may lead t=
o
> problems when send-mail is used without a tty.
>=20
> Therefore, use git var GIT_EDITOR only when we actually edit somethin=
g.
>=20
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  git-send-email.perl |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index d612ae8..bb09c0d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -162,9 +162,12 @@ my $compose_filename;
> =20
>  # Handle interactive edition of files.
>  my $multiedit;
> -my $editor =3D Git::command_oneline('var', 'GIT_EDITOR');
> +my $editor;
> =20
>  sub do_edit {
> +	if (!defined($editor)) {
> +		$editor =3D Git::command_oneline('var', 'GIT_EDITOR');
> +	}
>  	if (defined($multiedit) && !$multiedit) {
>  		map {
>  			system('sh', '-c', $editor.' "$@"', $editor, $_);
I havn't tested yet, but (maybe apart from a comment) this looks exactl=
y
like the patch I would have done if I knew perl :-)

So, Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards and thanks for the quick response,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
