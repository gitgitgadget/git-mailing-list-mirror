From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Sat, 1 Oct 2011 05:25:44 +0300
Message-ID: <20111001022544.GA31036@LK-Perkele-VI.localdomain>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 04:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9pH6-0000Lc-OH
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 04:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562Ab1JACZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 22:25:47 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:37438 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1JACZq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 22:25:46 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 67B41C7E60;
	Sat,  1 Oct 2011 05:25:45 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A033AE390CA; Sat, 01 Oct 2011 05:25:45 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 53B62E51A2;
	Sat,  1 Oct 2011 05:25:43 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182534>

On Sat, Oct 01, 2011 at 11:26:55AM +1000, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> This protocol has never been designed for pushing. Attempts to push
> over git:// usually result in
>=20
>   fatal: The remote end hung up unexpectedly
>=20
> That message does not really point out the reason. With this patch, w=
e get
>=20
>   error: this protocol does not support pushing
>   error: failed to push some refs to 'git://some-host.com/my/repo'

What about sticking code to return an error to git daemon instead of th=
is?

Here's what happens if I try to push to one of repos on this computer
over git://:

$ git push git://localhost/foobar
fatal: remote error: W access for foobar DENIED to anonymous

So send-pack can deal with ERR packet (and yes, that error message
is really from Gitolite).

Aside: git archive seemingly can't deal with ERR packets. And worse
yet, it doesn't even print what it received, resulting this:

$ git archive --remote=3Dgit://localhost/foobar HEAD
fatal: git archive: protocol error


-Ilari=20
