From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] tg-tred: Print the transitive reduction of the
	dependecies
Date: Wed, 25 Mar 2009 11:58:41 +0100
Message-ID: <20090325105841.GB27803@pengutronix.de>
References: <1237977341-32173-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 12:00:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmQqI-0007TI-5o
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 12:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbZCYK6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 06:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754383AbZCYK6q
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 06:58:46 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48506 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbZCYK6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 06:58:45 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LmQol-000874-8k; Wed, 25 Mar 2009 11:58:43 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LmQoj-0000D3-FT; Wed, 25 Mar 2009 11:58:41 +0100
Content-Disposition: inline
In-Reply-To: <1237977341-32173-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114583>

Hello,

On Wed, Mar 25, 2009 at 11:35:41AM +0100, Bert Wesarg wrote:
> +$tg summary --graphviz |
> +	tred |
> +	gvpr -a "\"${name}\"" '
> +BEG_G {
> +    node_t  ctr;
> +    edge_t  e;
> +
> +    ctr =3D isNode($, ARGV[0]);
> +    for (e =3D fstedge(ctr); e; e =3D nxtedge(e,ctr)) {
> +        if (e.head.name !=3D ARGV[0])
> +            printf("%s\n", e.head.name);
> +    }
> +    exit(0);
> +}
I don't know tred and gvpr, just looked shortly over the manpages.
Anyhow what I consider important is that the order of .topdeps is
stable.  That is

	t/topic1
	master
	t/topic2

must not be rewritten to

	t/topic2
	t/topic1

if master is redundant.  Is this asserted?

Moreover I wonder if the gvpr program could be optimized when E is used
instead of BEG_G, but as I said above, I don't know how gvpr works.

And note that I intend to change the semantic of tg summary s.t. it onl=
y
recurses on the current branch instead of all branches.  I think this
doesn't hurt here, though.

Best regards and thanks for your contribution,
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
