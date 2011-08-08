From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC] helping smart-http/stateless-rpc fetch race
Date: Tue, 9 Aug 2011 02:08:12 +0300
Message-ID: <20110808230812.GA16974@LK-Perkele-VI.localdomain>
References: <7vbow337gx.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com>
 <7vbow01ols.fsf@alter.siamese.dyndns.org>
 <7vsjpbzv07.fsf@alter.siamese.dyndns.org>
 <CAGdFq_i=8p4jvKo1C=UFpmQyPtUd9JOtr9VW8vn7viC0dQkQmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 01:08:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYvw-0005DN-QF
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 01:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab1HHXI1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 19:08:27 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:40494 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab1HHXI0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 19:08:26 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 2DE73EB8AB;
	Tue,  9 Aug 2011 02:08:25 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A00489238DF; Tue, 09 Aug 2011 02:08:25 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 67B7527D86;
	Tue,  9 Aug 2011 02:08:06 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <CAGdFq_i=8p4jvKo1C=UFpmQyPtUd9JOtr9VW8vn7viC0dQkQmg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179005>

On Mon, Aug 08, 2011 at 11:05:27PM +0200, Sverre Rabbelier wrote:
> Heya,
>=20
> On Mon, Aug 8, 2011 at 19:13, Junio C Hamano <gitster@pobox.com> wrot=
e:
> >> =C2=A0(1) It might make sense to give admins who run upload-pack n=
ot behind
> >> =C2=A0 =C2=A0 =C2=A0smart-http an option to allow fetching from a =
non-tip; and
>=20
> You said earlier it isn't needed since the server process caches the
> refs for git and ssh, that leaves dumb-http right?

It seems that everything currently possible falls into three
categories:

1) Stateful upload-pack (git://, file://, ssh://, CONNECT): No fix
needed.
2) Stateless upload-pack (smart http://, some bizarre helper):
Needs fix to avoid races.
3) Dumb protocols (dumb http://, ftp://, rsync://): Won't invoke
upload-pack anyway, no fix needed.

So I think that the only thing that needs the option to allow
fetching from non-tips is anything using --stateless-rpc.

-Ilari
