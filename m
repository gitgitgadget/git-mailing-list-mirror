From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: send-email adds redundant From: lines to message body
Date: Tue, 18 Jun 2013 14:42:07 +0300
Message-ID: <20130618114207.GD26857@redhat.com>
References: <20130618110904.GA20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 13:41:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouHv-0005rn-OA
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 13:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab3FRLlY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 07:41:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab3FRLlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 07:41:23 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5IBfKWF030233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 18 Jun 2013 07:41:20 -0400
Received: from redhat.com (vpn1-5-182.ams2.redhat.com [10.36.5.182])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r5IBfIeR010215;
	Tue, 18 Jun 2013 07:41:19 -0400
Content-Disposition: inline
In-Reply-To: <20130618110904.GA20052@goldbirke>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228199>

On Tue, Jun 18, 2013 at 01:09:04PM +0200, SZEDER G=E1bor wrote:
> Hi,
>=20
> 'git send-email' recently started to add redundant From: lines to my
> messages, see e.g.
>=20
>   http://article.gmane.org/gmane.comp.version-control.git/228132

Can you please show what do commits point to?
E.g. push to some public tree?

> Bisect points to:
>=20
> commit da18759e86bb1a7ee718c79a0c6cb15fbcbdf3c2
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   2013-06-05 21:11:00 +0300
>=20
>     send-email: make --suppress-cc=3Dself sanitize input
>    =20
>     --suppress-cc=3Dself fails to filter sender address in many cases=
 where it
>     needs to be sanitized in some way, for example quoted:
>     "A U. Thor" <author@example.com>
>     To fix, make send-email sanitize both sender and the address it i=
s
>     compared against.
>    =20
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> The exact commands I run were:
>=20
>   git format-patch --cover-letter --subject-prefix=3D'PATCH v2' 2847c=
ae835fa70f00e6e2286fbfa5595cb2247d0..bash-prompt-speedup
>   vim 0000-cover-letter.patch
>   git send-email --to=3Dgit@vger.kernel.org 00*
>=20
> i.e. no '--suppress-cc=3Dself' option at all.  Values of related conf=
ig
> variables are:
>=20
>   git config --get-regexp '(sendemail|user)\..*'
>   sendemail.smtpserver /usr/local/bin/putmail
>   sendemail.confirm auto
>   user.name SZEDER G=E1bor
>   user.email szeder@ira.uka.de
>=20
> The '=E1' in my first name is apparently significant: creating a comm=
it
> and sending it as a patch with that accent removed doesn't trigger a
> redundant From: line.
>=20
>=20
> Thanks,
> G=E1bor
