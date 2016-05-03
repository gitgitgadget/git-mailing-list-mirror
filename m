From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/6] connect: remove get_port()
Date: Tue, 3 May 2016 14:11:08 +0900
Message-ID: <20160503051108.GA5696@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462082573-17992-2-git-send-email-mh@glandium.org>
 <e1056272-8c0e-0a0b-2295-4653a47cf86f@web.de>
 <20160503050338.GD32259@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 07:11:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axScP-00014B-8i
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 07:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbcECFLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 01:11:22 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40010 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbcECFLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 01:11:21 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1axSc0-0001Uu-2P; Tue, 03 May 2016 14:11:08 +0900
Content-Disposition: inline
In-Reply-To: <20160503050338.GD32259@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293326>

On Tue, May 03, 2016 at 01:03:38AM -0400, Jeff King wrote:
> On Sun, May 01, 2016 at 12:10:09PM +0200, Torsten B=F6gershausen wrot=
e:
>=20
> > On 2016-05-01 08.02, Mike Hommey wrote:
> > > get_port() is only used as a fallback when get_host_and_port() do=
es not
> > > return a port. But get_port() does the same search as
> > > get_host_and_port(), except get_host_and_port() starts from the e=
nd of
> > > the host, respecting square brackets for ipv6 addresses, and get_=
port(),
> > > operating after get_host_and_port(), works on a modified host str=
ing
> > > that has square brackes removed if there were any.
> > typo: brackets.
> > >=20
> > > I cannot think of any legal host:port string that would not have =
a port
> > > returned by get_host_and_port() *and* have one returned by get_po=
rt().
> > > So just remove get_port().
> > >=20
> > > Signed-off-by: Mike Hommey <mh@glandium.org>
> > Does this pass the test-suite ?
> > It doesn't pass here, t5601:
>=20
> Hmm. I do notice that Mike's patch only touches the ssh code path. Th=
e
> normal TCP code path _just_ uses get_host_and_port. Does that mean th=
e
> TCP side is missing some cases, or is the extra parsing just for
> handling bracketed "[host:port]:path" cases for ssh, like:
>=20
> > not ok 39 - bracketed hostnames are still ssh
> > #
> > #               git clone "[myhost:123]:src" ssh-bracket-clone &&
> > #               expect_ssh "-p 123" myhost src
> > #
>=20
> ?

The latter.

Mike
