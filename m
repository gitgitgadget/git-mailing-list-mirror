From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/4] Build in git-repack
Date: Wed, 07 Aug 2013 16:28:50 +0200
Message-ID: <vpqzjsth8wt.fsf@anie.imag.fr>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
	<1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
	<1375884049-14961-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, iveqy@iveqy.com, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 16:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V74jb-0007zb-JC
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 16:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587Ab3HGO3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Aug 2013 10:29:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49905 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341Ab3HGO27 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 10:28:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r77ESmpB012166
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 7 Aug 2013 16:28:49 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V74jK-0006yH-Gn; Wed, 07 Aug 2013 16:28:50 +0200
In-Reply-To: <1375884049-14961-2-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Wed, 7 Aug 2013 16:00:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 07 Aug 2013 16:28:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r77ESmpB012166
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376490532.31379@6P1qmvFdVFhu4dLp8jANNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231828>

[ It's cool you're working on this, I'd really like a git-repack in C.
  That would fix this
  http://thread.gmane.org/gmane.comp.version-control.git/226458 ]

Stefan Beller <stefanbeller@googlemail.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> pack-objects learns a few more options to take over what's been done
> by git-repack.sh. cmd_repack() becomes a wrapper around
> cmd_pack_objects().

I think the patch would read easier if these were split into two
patches: one doing the real stuff in pack-objects, and then getting rid
of git-repack.sh to replace it with a trivial built-in.

Actually, I'm wondering why pack-objects requires so much changes.
git-repack.sh was already a relatively small wrapper around
pack-objects, and did not need the new options you add, so why are they
needed? In particular adding the new --update-info option that just doe=
s

> +	if (repack_flags & REPACK_UPDATE_INFO)
> +		update_server_info(0);

seems overkill to me: why don't you just let cmd_repack call
update_server_info(0)?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
