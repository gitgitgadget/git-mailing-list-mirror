From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-receive-pack doesn't understand objects/info/alternates?
Date: Mon, 16 Apr 2007 10:34:18 -0700
Message-ID: <7v3b30usth.fsf@assigned-by-dhcp.cox.net>
References: <E1HdQDl-0005ia-Bn@candygram.thunk.org>
	<8aa486160704160613t3ac17e4co9177ad91fda8eb36@mail.gmail.com>
	<20070416153040.GG27533@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdV6P-0000bQ-9c
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 19:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbXDPRei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Apr 2007 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754129AbXDPReh
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 13:34:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62587 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbXDPReT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 13:34:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416173418.ZGR1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 13:34:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ntaJ1W00P1kojtg0000000; Mon, 16 Apr 2007 13:34:19 -0400
In-Reply-To: <20070416153040.GG27533@thunk.org> (Theodore Tso's message of
	"Mon, 16 Apr 2007 11:30:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44679>

Theodore Tso <tytso@mit.edu> writes:

> On Mon, Apr 16, 2007 at 03:13:25PM +0200, Santi B=C3=A9jar wrote:
>> On 4/16/07, Theodore Ts'o <tytso@mit.edu> wrote:
>> >
>> >When I push a kernel repository to master.kernel.org, where the
>> >repository only has at most a dozen changes on top of 2.6.21-rc7, I
>> >noticed that it tried to push a *lot* of objects over ssh.  As in:
>>=20
>> This is because git only trusts the the commits in $GIT_DIR/refs.
>> Since commit v1.5.1-107-ge3c6f24 (in next) git-fetch first checks if
>> we have all the objects that we are going to fetch available locally=
=2E
>> This could be added for the push. But for now you could add a branch
>> in your repo in master.kernel.org to track linus' master branch.
>
> Thanks for the explanation! =20
>
> So if I add a symlink from .git/refs/heads/kludge to
> <linus'-tree-on-master>/.git/refs/heads/master this should work as a
> workaround now, right?

Theoretically speaking, not necessarily.  Practically speaking
it perhaps may.

When Linus runs 'pack-refs --prune', your kludge symlink would
not be of any help, as the command removes everything under his
linux-2.6.git/refs directory and records the equivalent
information in linux-2.6.git/packed-refs file.

        Word of caution.  Symlinking his packed-refs file to
        your repository would not work either.
