From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Bug: pull --rebase with =?utf-8?Q?=C3=A9?= in name
Date: Mon, 5 Mar 2012 11:37:35 +0100
Message-ID: <87399nqqog.fsf@thomas.inf.ethz.ch>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
	<20120305102657.GB29061@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Haber <rene@habr.de>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 11:37:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4VIW-00083n-28
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 11:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811Ab2CEKhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 05:37:40 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:16716 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756418Ab2CEKhj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 05:37:39 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 11:37:35 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 11:37:36 +0100
In-Reply-To: <20120305102657.GB29061@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 5 Mar 2012 05:26:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192224>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 05, 2012 at 10:59:16AM +0100, Ren=C3=A9 Haber wrote:
>
>> I'm having trouble with the following scenario:
>> My name contains an =C3=A9 with accent. Having set
>> git config --global user.name "Ren=C3=A9 Haber"
>> and several commits with that name in a project.
>
> That should work in general, but...
>
>> git pull --rebase
>> [...]
>> /sw/lib/git-core/git-am: line 675: Haber: command not found
>>=20
>> The problem lies in .git/rebase-apply/author-script :
>>=20
>> GIT_AUTHOR_NAME=3D'Rene'=CC=81 Haber
>> GIT_AUTHOR_EMAIL=3D'rene@habr.de'
>> GIT_AUTHOR_DATE=3D'@1330931169 +0100'
>
> That's definitely not right.
>
> I can't seem to reproduce it here with a simple test (neither with
> "Ren=C3=A9" in the author name, nor with an author name containing
> single-quote). What version of git are you using (it looks like a rec=
ent
> one, as it has the magic @-date syntax). Have you set
> i18n.commitencoding, or are otherwise using an encoding besides utf8?=
 Is
> it possible to share the commits that trigger this bug?

Also, can you post a hex dump of the config that defines user.name (try
'xxd ~/.gitconfig'), so we can see the encoding of Ren=C3=A9?

I find it pretty odd that Git manages to split the =C2=B4 from the e, s=
o I'm
wondering if perhaps you are using UTF-8 in NFD or similar.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
