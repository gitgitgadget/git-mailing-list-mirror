From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 19:01:15 +0200
Message-ID: <48A0705B.3030107@lsrfire.ath.cx>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com> <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de> <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com> <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com> <20080811164945.GI32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 11 19:02:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSamo-00009V-T7
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 19:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYHKRBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 13:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYHKRBX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 13:01:23 -0400
Received: from india601.server4you.de ([85.25.151.105]:41889 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbYHKRBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 13:01:22 -0400
Received: from [10.0.1.200] (p57B7DEB3.dip.t-dialin.net [87.183.222.179])
	by india601.server4you.de (Postfix) with ESMTPSA id 4A24B2F8041;
	Mon, 11 Aug 2008 19:01:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20080811164945.GI32184@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91963>

Petr Baudis schrieb:
> On Mon, Aug 11, 2008 at 04:59:32PM +0100, Reece Dunn wrote:
>>>> On Mon, 11 Aug 2008, Francis Moreau wrote:
>>>>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
>> does not work as expected. Replacing this with
>>
>>                case "$(read yesno; echo $yesno)" in [Nn]*) exit 1 ;;=
 esac
>>
>> would work as intended, as Mikael has pointed out.
>=20
>   Wouldn't it be more elegant to
>=20
> 	case "$(head -n 1)" in [Nn]*) exit 1 ;; esac

Only if head is a built-in, otherwise you fork needlessly.  Not that
this is a performance critical part, but I wouldn't call it "elegant".

What's wrong with the following variant, already used a few lines up in
the file?

	read yesno
	case "$yesno" in [Nn]*) exit 1 ;; esac

Ren=E9
