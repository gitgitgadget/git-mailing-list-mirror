From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Rebasing stgit stacks
Date: Mon, 22 Jan 2007 17:54:29 +0000
Message-ID: <tnxirezueui.fsf@arm.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
	<8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com>
	<20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net>
	<8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com>
	<20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net>
	<b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
	<20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net>
	<b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
	<20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net>
	<b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com>
	<20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net>
	<eoq439$7ml$1@sea.gmane.org>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 18:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H93Nb-0004Y2-GT
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 18:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbXAVRyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 Jan 2007 12:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbXAVRyf
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 12:54:35 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:49859 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932108AbXAVRye convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 12:54:34 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l0MHsUYo017688;
	Mon, 22 Jan 2007 17:54:31 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 22 Jan 2007 17:55:14 +0000
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eoq439$7ml$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
 19 Jan 2007 10:47:59 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 22 Jan 2007 17:55:14.0886 (UTC) FILETIME=[783B1E60:01C73E4E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37433>

Jakub Narebski <jnareb@gmail.com> wrote:
> Yann Dirson wrote:
>> On Thu, Jan 18, 2007 at 09:05:47AM +0000, Catalin Marinas wrote:
>
>>> As Jakub said, I would also call this command 'rebase' instead of
>>> 'pull --to', even if we duplicate a bit of code.
>>> It would make the implementation even simpler
>>=20
>> A new command is fine with me, it's just that I feel "rebase <target=
>"
>> may be confusing to beginners. =A0I'd rather say "rebase [<stack>] -=
-to
>> <target>", but it's just that I don't see the case for specifying a
>> different stack than the current one.
>
> If you want to move some stack from one branch to other, for example
> from 'next' or next-based branch to 'origin'/'master' or origin-based
> branch you could do either:
>
>   $ git checkout <newbase>
>   $ stg rebase <stack>

Currently, in the StGIT terminology stack and branch are about the
same. If you want to move to a different stack, just use the "stg
branch" command.

I think this should stay as it is since it gets confusing to have a
name for a stack and a different name for a branch. A stack is just a
branch with stgit-specific metadata.

If <newbase> is a branch and 'git checkout' causing to switch
branches, you end up on a different stack.

What you'd probably want is a way to import patches from a different
branch/stack onto the newly checked out branch.

> Although usually you have separate branch as StGIT stack "base", and
> you can simply rebase git branch, then do
>
>   $ stg rebase

I only see the 'rebase' command as a shortcut for:

stg pop -a
git reset --hard <newbase>
stg push -a (or just push the previously popped patches)

--=20
Catalin

P.S. could you cc me to your replies as I only read the GIT mailing
list via gmane and only when I'm at work (and usually work on StGIT at
home)
