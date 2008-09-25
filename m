From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg 0.14.3 breakage on push after moving hunk
Date: Thu, 25 Sep 2008 10:37:47 +0200
Message-ID: <20080925083747.GC27632@diana.vm.bytemark.co.uk>
References: <20080924232654.GY4985@nan92-1-81-57-214-146.fbx.proxad.net> <20080925072322.GA27632@diana.vm.bytemark.co.uk> <20080925075732.GA17458@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 10:16:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kim1w-0006xe-Tj
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 10:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbYIYIPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 04:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbYIYIPl
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 04:15:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4179 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbYIYIPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 04:15:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KimM8-0007Va-00; Thu, 25 Sep 2008 09:37:48 +0100
Content-Disposition: inline
In-Reply-To: <20080925075732.GA17458@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96733>

On 2008-09-25 09:57:32 +0200, Yann Dirson wrote:

> Thanks, it does fix the exception - I feel a bit ashamed of not
> having looked at the code myself ;)

:-)

> Nevertheless, that error was only hiding another more annoying
> problem:
>
> $ ../stgit/stg push
> Checking for changes in the working directory ... done
> Pushing patch "factorize" ...
>   Error: File "t/t4030-diff-rename-factorize.sh" added in both, permi=
ssions conflict
>   Error: The merge failed during "push". =20
>          Use "refresh" after fixing the conflicts or revert the opera=
tion with "push --undo".
>   stg push: GIT index merging failed (possible conflicts)
> $ md5sum t/t4030-diff-rename-factorize.sh*
> cc313acd2824036556128b3e0879dd07  t/t4030-diff-rename-factorize.sh
> cc313acd2824036556128b3e0879dd07  t/t4030-diff-rename-factorize.sh.cu=
rrent
> cc313acd2824036556128b3e0879dd07  t/t4030-diff-rename-factorize.sh.pa=
tched
>
> AFAICT, adding the same file in 2 branches used not to produce a
> conflict at all. Is that intended ?

"permissions conflict" sounds like it was added with the exec bit in
one branch, and without in the other. Is that right? And

  1. Does it work if there's no permissions conflict?

  2. Did it work before if there was a permissions conflict?

Just a guess, but it's entirely plausible that this case never worked,
and you're the first to hit it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
