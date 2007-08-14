From: David Kastrup <dak@gnu.org>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 16:45:59 +0200
Message-ID: <86lkcefa3c.fsf@lola.quinscape.zz>
References: <1187080681.12828.174.camel@chaos> <20070814093357.GA14010@diana.vm.bytemark.co.uk> <1187086600.12828.177.camel@chaos> <20070814105056.GA14536@diana.vm.bytemark.co.uk> <1187089619.12828.183.camel@chaos> <20070814111828.GA15399@diana.vm.bytemark.co.uk> <1187101183.12828.191.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 16:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKxfJ-0007Ku-3Y
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 16:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbXHNOqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 10:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbXHNOqT
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 10:46:19 -0400
Received: from main.gmane.org ([80.91.229.2]:42673 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbXHNOqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 10:46:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IKxer-0007fl-0C
	for git@vger.kernel.org; Tue, 14 Aug 2007 16:46:10 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 16:46:08 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 16:46:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:NqflVSEwyGqpz1y5v1PlWpL64UA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55836>

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 2007-08-14 at 13:18 +0200, Karl Hasselstr=F6m wrote:
>> On 2007-08-14 13:06:59 +0200, Thomas Gleixner wrote:
>>=20
>> > On Tue, 2007-08-14 at 12:50 +0200, Karl Hasselstr=F6m wrote:
>> >
>> > > The result is exactly the same. git-mv is just a convenience.
>> >
>> > Fair enough, but it still does not solve my initial problem of
>> > keeping the history of B (former A) intact, while creating a new A
>> > which is necessary to compile the tree, simply because I can not
>> > change #include <A> to #include <B> for various reasons.
>>=20
>> Have you tried running blame with -C, or -C -C? That will make it tr=
y
>> harder to identify lines originating from other files.
>
> Does not help. Strange enough it results in
>
> # git blame include/B
>
> b4062b16 include/A (Joe Hacker      2007-08-14 10:52:28 +0200  1) #if=
ndef _A_H_
> b4062b16 include/A (Joe Hacker      2007-08-14 10:52:28 +0200  2) #de=
fine _A_H_
> b4062b16 include/A (Joe Hacker      2007-08-14 10:52:28 +0200  3)=20
> b4062b16 include/A (Joe Hacker      2007-08-14 10:52:28 +0200  4) #de=
fine TEST_1 1
> f098c4ad include/B (Thomas Gleixner 2007-08-14 16:01:05 +0200  5) #de=
fine TEST_2 2
> f098c4ad include/B (Thomas Gleixner 2007-08-14 16:01:05 +0200  6)=20
> f098c4ad include/B (Thomas Gleixner 2007-08-14 16:01:05 +0200  7) #en=
dif

So it tells you commit and corresponding file that are responsible for
the lines in question.

How does this not help?

--=20
David Kastrup
