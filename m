From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: Map email addresses to names
Date: Fri, 12 Jul 2013 09:31:31 -0700
Message-ID: <7vzjtrn3j0.fsf@alter.siamese.dyndns.org>
References: <7vzjttq9wk.fsf@alter.siamese.dyndns.org>
	<1373629769-23647-1-git-send-email-stefanbeller@googlemail.com>
	<1373629769-23647-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 18:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxgFw-0004vb-DZ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 18:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013Ab3GLQbg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 12:31:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964992Ab3GLQbe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jul 2013 12:31:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2F7C30FA6;
	Fri, 12 Jul 2013 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kCaD+bVRPo30
	uscni9ciXatgcPM=; b=Rf6UXZdKFpitMkKa0bgzvSu2bnehX4AxemplNJ3qwE1H
	VgNqH0GYZU67ODF/u8kzx+PlyzII/ScZos7vi3JQdJQFb6diWNrwzsKRc2Qc2cAd
	RB21G25+j6+60FPkqAtfWSg/fm66m/zBu2Fbbnffgu3h9A4OyZIK6HIOGqkskTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s5bdqw
	cY8WwR9a5NBFuMc4/K3KXFAhxRnEzv9y7gPoT5yG6afRDyQYDXGtBQz03V7RJ6CG
	T3nk5MwEmkUrada02kSQRLVyXoaBBeTw950NZxto7t2nh9WyoQJMXf1sT9a1F+kU
	pmW0EcEMXh6iM3UmnM/8akNktRqac20ip+2lA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3F2A30FA5;
	Fri, 12 Jul 2013 16:31:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF4E130FA1;
	Fri, 12 Jul 2013 16:31:32 +0000 (UTC)
In-Reply-To: <1373629769-23647-2-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Fri, 12 Jul 2013 13:49:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83541C22-EB10-11E2-9407-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230205>

Stefan Beller <stefanbeller@googlemail.com> writes:

> People change email addresses quite often and sometimes
> forget to add their entry to the mailmap file.
> I have contacted lots of people, whose name occurs
> multiple times in the short log having different
> email addresses. The entries in the mailmap of
> this patch are either confirmed by them or are trivial.
> Trivial means different capitalisation of the domain
> (@MIT.EDU and @mit.edu) or the domain was localhost,
> (none) or @local.
>
> Additionally to adding (name, email) mappings to the
> .mailmap file, it has also been sorted alphabetically.
> (which explains the removals, which are added
> 3 lines later on again)
>
> While the most changes happen at the email addresses,
> we also have a name change in here. Karl Hasselstr=C3=B6m
> is now known as Karl Wiberg due to marriage. Congratulations!
>
> To find out whom to contact I used the following small
> script:
> ---
>     #!/bin/bash
>     git shortlog -sne |awk '{ NF--; $1=3D""; print }' |sort |uniq -d =
> mailmapdoubles
>     while read line ; do
>         # remove leading whitespace
>         trimmed=3D$(echo $line | sed -e 's/^ *//g' -e 's/ *$//g')
>         echo "git shortlog -sne | grep \""$trimmed"\""
>     done < mailmapdoubles > mailmapdoubles2
>     sh mailmapdoubles2
>     rm mailmapdoubles
>     rm mailmapdoubles2
> ---
> Also interesting for similar tasks are these snippets:
>
>     # Finding out duplicates by comparing email addresses:
>     git shortlog -sne |awk '{ print $NF }' |sort |uniq -d
>
>     # Finding out duplicates by comparing names:
>     git shortlog -sne |awk '{ NF--; $1=3D""; print }' |sort |uniq -d
> ---
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---

Thanks, but please be careful about these three-dashes when sending
the next batch.  As you may have already guessed, Git cannot guess
reliably which one of the abouve four three-dash lines is the end of
the proposed log message, and cuts at the first one.

>  .mailmap | 95 ++++++++++++++++++++++++++++++++++++++++++++++++------=
----------
>  1 file changed, 71 insertions(+), 24 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 345cce6..1179767 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -5,99 +5,146 @@
>  # same person appearing not to be so.
>  #
> =20
> -Alex Benn=C3=A9e <kernel-hacker@bennee.com>
> +Alejandro R. Sede=C3=B1o <asedeno@MIT.EDU> <asedeno@mit.edu>
>  Alexander Gavrilov <angavrilov@gmail.com>
> +Alex Benn=C3=A9e <kernel-hacker@bennee.com>
> +Alex Riesen <raa.lkml@gmail.com> <fork0@t-online.de>
> +Alex Riesen <raa.lkml@gmail.com> <raa@limbo.localdomain>
> +Alex Riesen <raa.lkml@gmail.com> <raa@steel.home>
> +Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
> +Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
>  Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> +anonymous <linux@horizon.com>
> +anonymous <linux@horizon.net>
> +Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
>  Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
>  Cheng Renquan <crquan@gmail.com>
>  Chris Shoemaker <c.shoemaker@cox.net>
> -Dan Johnson <computerdruid@gmail.com>
>  Dana L. How <danahow@gmail.com>
>  Dana L. How <how@deathvalley.cswitch.com>
>  Daniel Barkalow <barkalow@iabervon.org>
> +Dan Johnson <computerdruid@gmail.com>
>  David D. Kilzer <ddkilzer@kilzer.net>
>  David K=C3=A5gedal <davidk@lysator.liu.se>
> +David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
>  David S. Miller <davem@davemloft.net>
>  Deskin Miller <deskinm@umich.edu>
>  Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
>  Eric S. Raymond <esr@thyrsus.com>
>  Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
> -Fredrik Kuivinen <freku045@student.liu.se>
> +Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.ac=
hleitner2.6.31@gmail.com>
> +Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
> +Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
> +Frank Lichtenheld <frank@lichtenheld.de> <flichtenheld@astaro.com>
>  Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com>
> +Fredrik Kuivinen <freku045@student.liu.se>
> +Han-Wen Nienhuys <hanwen@google.com> Han-Wen Nienhuys <hanwen@xs4all=
=2Enl>
>  H. Merijn Brand <h.m.brand@xs4all.nl> H.Merijn Brand <h.m.brand@xs4a=
ll.nl>
> -H. Peter Anvin <hpa@bonde.sc.orionmulti.com>
> -H. Peter Anvin <hpa@tazenda.sc.orionmulti.com>
> -H. Peter Anvin <hpa@trantor.hos.anvin.org>
>  Horst H. von Brand <vonbrand@inf.utfsm.cl>
> +H. Peter Anvin <hpa@zytor.com> <hpa@bonde.sc.orionmulti.com>
> +H. Peter Anvin <hpa@zytor.com> <hpa@smyrno.hos.anvin.org>
> +H. Peter Anvin <hpa@zytor.com> <hpa@tazenda.sc.orionmulti.com>
> +H. Peter Anvin <hpa@zytor.com> <hpa@trantor.hos.anvin.org>
>  =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
>  Jakub Nar=C4=99bski <jnareb@gmail.com>
> -Jay Soffian <jaysoffian+git@gmail.com>
> +Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
> +J. Bruce Fields <bfields@citi.umich.edu> <bfields@fieldses.org>
> +J. Bruce Fields <bfields@citi.umich.edu> <bfields@pig.linuxdev.us.de=
ll.com>
> +J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.or=
g>
>  Jeff King <peff@peff.net> <peff@github.com>
>  Joachim Berdal Haga <cjhaga@fys.uio.no>
> +Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindeli=
n@gmx.de>
>  Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
> -Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
>  Johannes Sixt <j6t@kdbg.org> <J.Sixt@eudaptics.com>
> +Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
> +Jonathan Nieder <jrnieder@gmail.com> <jrnieder@uchicago.edu>
>  Jon Loeliger <jdl@freescale.com>
>  Jon Seymour <jon@blackcubes.dyndns.org>
> -Jonathan Nieder <jrnieder@uchicago.edu>
>  Junio C Hamano <gitster@pobox.com> <gitster@pobox.com>
> -Junio C Hamano <gitster@pobox.com> <junio@pobox.com>
> -Junio C Hamano <gitster@pobox.com> <junio@twinsun.com>
> -Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
>  Junio C Hamano <gitster@pobox.com> <junio@hera.kernel.org>
>  Junio C Hamano <gitster@pobox.com> <junio@kernel.org>
> +Junio C Hamano <gitster@pobox.com> <junio@pobox.com>
> +Junio C Hamano <gitster@pobox.com> <junio@twinsun.com>
>  Junio C Hamano <gitster@pobox.com> <junkio@cox.net>
> -Karl Hasselstr=C3=B6m <kha@treskal.com>
> -Kevin Leung <kevinlsk@gmail.com>
> +Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
> +Karl Wiberg <kha@treskal.com> Karl Hasselstr=C3=B6m <kha@treskal.com=
>
> +Karl Wiberg <kha@treskal.com> Karl Hasselstr=C3=B6m <kha@yoghurt.hem=
ma.treskal.com>
> +Kay Sievers <kay.sievers@vrfy.org> <kay@mam.(none)>
> +Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
> +Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
>  Kent Engstrom <kent@lysator.liu.se>
> +Kevin Leung <kevinlsk@gmail.com>
> +Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
> +Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
>  Lars Doelle <lars.doelle@on-line ! de>
>  Lars Doelle <lars.doelle@on-line.de>
>  Li Hong <leehong@pku.edu.cn>
> -Linus Torvalds <torvalds@linux-foundation.org> <torvalds@woody.linux=
-foundation.org>
> -Linus Torvalds <torvalds@linux-foundation.org> <torvalds@osdl.org>
> -Linus Torvalds <torvalds@linux-foundation.org> <torvalds@g5.osdl.org=
>
>  Linus Torvalds <torvalds@linux-foundation.org> <torvalds@evo.osdl.or=
g>
> +Linus Torvalds <torvalds@linux-foundation.org> <torvalds@g5.osdl.org=
>
> +Linus Torvalds <torvalds@linux-foundation.org> <torvalds@osdl.org>
>  Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl=
=2Eorg>
>  Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl=
=2Eorg.(none)>
> +Linus Torvalds <torvalds@linux-foundation.org> <torvalds@woody.linux=
-foundation.org>
>  Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
>  Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
>  Mark Rada <marada@uwaterloo.ca>
>  Martin Langhoff <martin@laptop.org> <martin@catalyst.net.nz>
>  Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@=
gmail.com>
> +Matthias Kestenholz <matthias@spinlock.ch> <mk@spinlock.ch>
> +Matthias Urlichs <matthias@urlichs.de> <smurf@kiste.(none)>
> +Matthias Urlichs <matthias@urlichs.de> <smurf@smurf.noris.de>
>  Michael Coleman <tutufan@gmail.com>
>  Michael J Gruber <git@drmicha.warpmail.net> <michaeljgruber+gmane@fa=
stmail.fm>
> +Michael Witten <mfwitten@gmail.com> <mfwitten@mit.edu>
> +Michael Witten <mfwitten@gmail.com> <mfwitten@MIT.EDU>
>  Michael W. Olson <mwolson@gnu.org>
>  Michele Ballabio <barra_cuda@katamail.com>
> +Miklos Vajna <vmiklos@frugalware.org> <vmiklos@suse.cz>
> +Namhyung Kim <namhyung@gmail.com> <namhyung@kernel.org>
> +Namhyung Kim <namhyung@gmail.com> <namhyung.kim@lge.com>
>  Nanako Shiraishi <nanako3@bluebottle.com>
>  Nanako Shiraishi <nanako3@lavabit.com>
>  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>  <nico@fluxnic.net> <nico@cam.org>
> -Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwo=
lves.pp.se>
> +Pascal Obry <pascal@obry.net> <pascal.obry@gmail.com>
> +Pascal Obry <pascal@obry.net> <pascal.obry@wanadoo.fr>
> +Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(none)>
> +Paul Mackerras <paulus@samba.org> <paulus@pogo.(none)>
>  Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
> +Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwo=
lves.pp.se>
>  Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
> +Petr Baudis <pasky@ucw.cz> <xpasky@machine>
>  Philippe Bruhat <book@cpan.org>
>  Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
>  Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
>  Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
>  Robert Fitzsimons <robfitz@273k.net>
>  Robert Zeh <robert.a.zeh@gmail.com>
> +Robin Rosenberg <robin.rosenberg@dewire.com> <robin.rosenberg.lists@=
dewire.com>
> +Salikh Zakirov <salikh.zakirov@gmail.com> <Salikh.Zakirov@Intel.com>
>  Sam Vilain <sam@vilain.net>
> -Santi B=C3=A9jar <sbejar@gmail.com>
> +Santi B=C3=A9jar <santi@agolina.net> <sbejar@gmail.com>
>  Sean Estabrooks <seanlkml@sympatico.ca>
> +Sebastian Schuberth <sschuberth@gmail.com> <sschuberth@visageimaging=
=2Ecom>
>  Shawn O. Pearce <spearce@spearce.org>
> -Steven Grimm <koreth@midwinter.com>
> +Stephen Boyd <bebarino@gmail.com> <sboyd@codeaurora.org>
> +Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
> +Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
> +Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac=
=2Ebe>
>  Tay Ray Chuan <rctay89@gmail.com>
>  Theodore Ts'o <tytso@mit.edu>
> +Thomas Ackermann <th.acker@arcor.de> <th.acker66@arcor.de>
>  Thomas Rast <trast@inf.ethz.ch> <trast@student.ethz.ch>
> +Timo Hirvonen <tihirvon@gmail.com> <tihirvon@ee.oulu.fi>
> +Toby Allsopp <Toby.Allsopp@navman.co.nz> <toby.allsopp@navman.co.nz>
>  Tony Luck <tony.luck@intel.com>
> -Uwe Kleine-K=C3=B6nig <Uwe_Zeisberger@digi.com>
> -Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
>  Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.de>
> +Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
> +Uwe Kleine-K=C3=B6nig <Uwe_Zeisberger@digi.com>
>  Uwe Kleine-K=C3=B6nig <uzeisberger@io.fsforth.de>
>  Uwe Kleine-K=C3=B6nig <zeisberg@informatik.uni-freiburg.de>
>  Ville Skytt=C3=A4 <scop@xemacs.org>
>  Vitaly "_Vi" Shukela <public_vi@tut.by>
>  William Pursell <bill.pursell@gmail.com>
>  YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
> -anonymous <linux@horizon.com>
> -anonymous <linux@horizon.net>
> +
