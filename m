From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Tue, 16 Jan 2007 13:43:39 +0100
Message-ID: <873b6b87lw.fsf@morpheus.local>
References: <871wm08kcu.fsf@morpheus.local> <7vd55jrj38.fsf@assigned-by-dhcp.cox.net> <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net> <7vmz4nog5b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701131217410.22628@wbgn013.biozentrum.uni-wuerzburg.de> <877ivo446n.fsf@morpheus.local> <Pine.LNX.4.63.0701161239590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 16 13:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6nfs-0007Ix-Bq
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 13:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbXAPMoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 07:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXAPMoH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 07:44:07 -0500
Received: from main.gmane.org ([80.91.229.2]:57954 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbXAPMoG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 07:44:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H6nfR-0003RS-GX
	for git@vger.kernel.org; Tue, 16 Jan 2007 13:43:57 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 13:43:57 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 13:43:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:rlDGlVL4D6qq1txBN0ubYwyErGs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36935>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 15 Jan 2007, David K=C3=A5gedal wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>=20
>> > On Fri, 12 Jan 2007, Junio C Hamano wrote:
>> >
>> >> Side note.  The previous patch does not help if your commit were
>> >> made in non UTF-8 with not too recent git; the code assumes that
>> >> commit messages without the new "encoding" headers are in UTF-8.
>> >
>> > Why not just use is_utf8() and warn, or error out, if the message =
is not=20
>> > UTF-8? (I tend towards the erroring out, since this _is_ a new fea=
ture,=20
>> > and gives undesired results with "old" commits.)
>>=20
>> What do you mean? I have an old repository with latin1 commits witho=
ut
>> any encoding markers.  I want to be able to use format-patch from th=
at
>> and at least get a From: line with something readable.  You can't ju=
st
>> barf and say "This isn't UTF-8, go away".
>
> So what do you want to do instead? Just pretend that the unrecoded --=
=20
> Latin-1 encoded -- text is UTF-8? That's plain wrong.

That is what git did before I wrote my patch, so it obviously not what
I want.  I want to be able to tell git what encoding it is.

My patch reused the i18n.commitencoding configuration parameter for
that, but Junio is probably right in that that is only meant for new
commits, and an evironment variable makes more sense.

So just barfing on a commit that isn't utf-8 isn't a complete
solution.  But maybe there was some context to your comment above that
I missed.

--=20
David K=C3=A5gedal
