From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 12:27:03 +0200
Organization: At home
Message-ID: <ehkpos$ga1$1@sea.gmane.org>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <453A7D7E.8060105@utoronto.ca> <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net> <vpq64eakpnh.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Tue Oct 24 12:27:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcJUq-0004vX-4n
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 12:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWJXK05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWJXK05
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 06:26:57 -0400
Received: from main.gmane.org ([80.91.229.2]:2983 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030270AbWJXK04 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 06:26:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GcJUe-0004t8-AT
	for git@vger.kernel.org; Tue, 24 Oct 2006 12:26:48 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 12:26:48 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 12:26:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29962>

Matthieu Moy wrote:
> "Matthew D. Fuller" <fullermd@over-yonder.net> writes:
>=20
>>> For example, how long does it take to do an arbitrary "undo" (ie
>>> forcing a branch to an earlier state) [...]
>>
>> I don't understand the thrust of this, either. =A0As I understand th=
e
>> operation you're talking about, it doesn't have anything to do with =
a
>> branch; you'd just be whipping the working tree around to different
>> versions. =A0That should be O(diff) on any modern VCS.

> There are two things to do:
>
> * Mark the tree as corresponding to a different revision in the past.
[...]
> * Then, do the "merge" to make your tree up to date. You can hardly d=
o
> =A0 faster than git and its unpacked format, but this is at the cost =
of
> =A0 disk space. But as you say, in almost any modern VCS, that's
> =A0 O(diff). In a space-efficient format, that's just the tradeoff yo=
u
> =A0 make between full copies of a file and delta-compression.

Actually, this would be "checkout" (in git terminology), i.e. overwriti=
ng
the files which differ in current revision, and the revision we rewind =
(do
undo) to. (That's of course simplification omitting for example removin=
g
and creating files.) Which would be O(changed files) which is lower bou=
nd
and cannot be faster. Finding which files changed is also O(changed fil=
es),
with a little bit of O(directory depth) in git, with very small constan=
t.

And even in the case of packed format, it wouldn't be O(diff)/O(history=
),
but O(delta length) where delta length is maximum length of delta chain
in pack, by default set to 10. Well, constant is a bit larges because g=
it
additionally gzip-compresses (even in loose, i.e. unpacked format).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
