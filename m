From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 16:56:37 +0100
Message-ID: <alpine.LSU.2.00.1307041646250.26246@hermes-2.csi.cam.ac.uk>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <20130703215930.GT408@google.com> <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com> <alpine.LSU.2.00.1307040940400.26246@hermes-2.csi.cam.ac.uk> <CANQwDwd9siyeu5xqS5Un+=8ioEaDbpT30vBpgJCVNUEcszcv1g@mail.gmail.com>
 <alpine.LSU.2.00.1307041559140.26246@hermes-2.csi.cam.ac.uk> <CANQwDwfCYPBjGfmKOLju-Zey4WrVrXfaymJtu9g1OYvOUfBTcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-41951951-1372953222=:26246"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 17:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uultx-0005e3-NH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 17:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634Ab3GDP4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 11:56:38 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:33452 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3GDP4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 11:56:38 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:58853)
	by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Uultd-0002nR-0Q (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 16:56:37 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Uultd-0004Dn-1x (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 16:56:37 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <CANQwDwfCYPBjGfmKOLju-Zey4WrVrXfaymJtu9g1OYvOUfBTcw@mail.gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Content-ID: <alpine.LSU.2.00.1307041654130.26246@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229594>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-41951951-1372953222=:26246
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.LSU.2.00.1307041654131.26246@hermes-2.csi.cam.ac.uk>

Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>
> First, do I understand corrctly that @extra_breadcrumbs are rendered *aft=
er*
> $home_link*, and in exactly the same manner?

Before the home link, and yes, in the same manner. The extra breadcrumbs
are for links to parent pages above gitweb in some hierarchy.

> But now I think that we can do better, simply put $home_link_str and $hom=
e_link
> in @extra_breadcrumbs / @top_level_breadcrumbs / @nav_breadcrumbs before
> using it,

We could save a line that way:

-       print $cgi->a({-href =3D> esc_url($home_link)}, $home_link_str) . "=
 / ";
+       for my $crumb (@extra_breadcrumbs, [ $home_link_str =3D> $home_link=
 ]) {
+               print $cgi->a({-href =3D> esc_url($crumb->[1])}, $crumb->[0=
]) . " / ";
+       }

> P.S. It is a bit late, but wouldn't { name =3D> $link_name, href =3D> $li=
nk_url }
> (like %features hash) be a better solution than [ $link_name, $link_url ]=
,
> i.e. hashref (named parameters) instead of arrayref (positional parameter=
s).
> You wouldn't have to remember which is first: text or URL.

I thought the fat arrow would be mnemonic enough, and less verbose.

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first=
=2E
Rough, becoming slight or moderate. Showers, rain at first. Moderate or goo=
d,
occasionally poor at first.
--1870870024-41951951-1372953222=:26246--
