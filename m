From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git init --bare --shared does not set group for some files/dirs
Date: Sun, 18 Jul 2010 15:08:20 +0300
Message-ID: <20100718120820.GA20761@LK-Perkele-V2.elisa-laajakaista.fi>
References: <201007181314.41894.ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Sun Jul 18 14:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaSfZ-0008W2-54
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 14:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab0GRMIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 08:08:18 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:46928 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab0GRMIR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 08:08:17 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 4CB9F8C599;
	Sun, 18 Jul 2010 15:08:16 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0305C31332; Sun, 18 Jul 2010 15:08:16 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 3CC0D1C6383;
	Sun, 18 Jul 2010 15:08:14 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <201007181314.41894.ville.skytta@iki.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151206>

On Sun, Jul 18, 2010 at 01:14:41PM +0300, Ville Skytt=C3=A4 wrote:
> Hello,
>=20
> git init --bare --shared does not set the group for some files.  See =
below; it=20
> did set g+s for all dirs, and did set the group for the root dir, con=
fig,=20
> HEAD, and objects, but failed to set group for branches, description,=
 hooks,=20
> info, and refs.  I discussed/reproduced this on #git today with drizz=
d and was=20
> instructed to post here.
>=20
> In particular, I hit a problem with this and the refs dir; members of=
 the=20
> desired group (gituser in my example) can not write into it.  I can o=
bviously=20
> fix this locally with chgrp, but for which files/dirs should the gitu=
ser group=20
> be set, and are there some files/dirs that it is intentionally not se=
t?

AFAIK, there are none that intentionally don't have it (at least usuall=
y every
file and directory there has the repository group as owner). The usual =
quick
and dirty rules are:

- For fetching, +r for all regular files, +rx for all directories.
- For pushing, +r for all regular files (but +rw for regular files unde=
r
/logs/ if any), +rwx for all directories.

BTW: '/branches/' is used by pre-1.5 remotes stuff and pretty much tota=
lly
obsolete.

-Ilari
