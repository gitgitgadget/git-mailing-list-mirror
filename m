From: David Kastrup <dak@gnu.org>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 13:12:55 +0200
Message-ID: <86wsvyfjyg.fsf@lola.quinscape.zz>
References: <1187080681.12828.174.camel@chaos> <20070814093357.GA14010@diana.vm.bytemark.co.uk> <1187086600.12828.177.camel@chaos> <20070814105056.GA14536@diana.vm.bytemark.co.uk> <1187089619.12828.183.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 13:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKuKz-0008FN-UV
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 13:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726AbXHNLNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 07:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbXHNLNQ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 07:13:16 -0400
Received: from main.gmane.org ([80.91.229.2]:59659 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350AbXHNLNP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 07:13:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IKuKj-0002u8-CX
	for git@vger.kernel.org; Tue, 14 Aug 2007 13:13:09 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 13:13:09 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 13:13:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:wu4Hp/aDETv7ksIay2RzflKe1/I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55826>

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 2007-08-14 at 12:50 +0200, Karl Hasselstr=F6m wrote:
>> > Err.
>> >
>> > git-mv A B
>> > git commit
>> > edit B
>> > git commit
>> > git blame B <- shows the full history of A & B
>> >
>> > IMHO that's why we have git-mv
>>=20
>> Try replacing
>>=20
>>   $ git-mv A B
>>=20
>> with
>>=20
>>   $ mv A B
>>   $ git rm A
>>   $ git add B
>>=20
>> The result is exactly the same. git-mv is just a convenience.
>
> Fair enough, but it still does not solve my initial problem of keepin=
g
> the history of B (former A) intact, while creating a new A which is
> necessary to compile the tree, simply because I can not change #inclu=
de
> <A> to #include <B> for various reasons.

Sigh.  Please use the right options for calling your history viewing
commands.  It is not like I haven't told you that already.  For
example, take git-blame.  Its manual page clearly states:

	-M|<num>|
	   Detect moving lines in the file as well. When a commit
	   moves a block of lines in a file (e.g. the original file
	   has A and then B, and the commit changes it to B and then
	   A), traditional blame algorithm typically blames the
	   lines that were moved up (i.e. B) to the parent and
	   assigns blame to the lines that were moved down (i.e. A)
	   to the child commit. With this option, both groups of
	   lines are blamed on the parent.

	   <num> is optional but it is the lower bound on the number
	   of alphanumeric characters that git must detect as moving
	   within a file for it to associate those lines with the
	   parent commit.

	-C|<num>|
	   In addition to -M, detect lines copied from other files
	   that were modified in the same commit. This is useful
	   when you reorganize your program and move code around
	   across files. When this option is given twice, the
	   command looks for copies from all other files in the
	   parent for the commit that creates the file in addition.

	   <num> is optional but it is the lower bound on the number
	   of alphanumeric characters that git must detect as moving
	   between files for it to associate those lines with the
	   parent commit.


--=20
David Kastrup
