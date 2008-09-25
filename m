From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg 0.14.3 breakage on push after moving hunk
Date: Thu, 25 Sep 2008 09:23:22 +0200
Message-ID: <20080925072322.GA27632@diana.vm.bytemark.co.uk>
References: <20080924232654.GY4985@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 09:03:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiksU-0001vQ-6S
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 09:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbYIYHB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 03:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYIYHBz
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 03:01:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2768 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYIYHBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 03:01:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KilC7-0007FW-00; Thu, 25 Sep 2008 08:23:23 +0100
Content-Disposition: inline
In-Reply-To: <20080924232654.GY4985@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96727>

On 2008-09-25 01:26:54 +0200, Yann Dirson wrote:

> Just saw the following problem - ever saw that ?
>
> $ stg push
> Checking for changes in the working directory ... done
> Pushing patch "factorize" ... Traceback (most recent call last):
>   File "/usr/bin/stg", line 43, in <module>
>     main()
>   File "/var/lib/python-support/python2.5/stgit/main.py", line 281, i=
n main
>     command.func(parser, options, args)  =20
>   File "/var/lib/python-support/python2.5/stgit/commands/push.py", li=
ne 102, in func
>     push_patches(crt_series, patches, options.merged)
>   File "/var/lib/python-support/python2.5/stgit/commands/common.py", =
line 202, in push_patches
>     modified =3D crt_series.push_patch(p)
>   File "/var/lib/python-support/python2.5/stgit/stack.py", line 1112,=
 in push_patch
>     git.merge(bottom, head, top, recursive =3D True)
>   File "/var/lib/python-support/python2.5/stgit/git.py", line 790, in=
 merge
>     stages['2'][0], stages['3'][0]) !=3D 0:
>   File "/var/lib/python-support/python2.5/stgit/gitmergeonefile.py", =
line 268, in merge
>     % path)
> TypeError: not all arguments converted during string formatting

No, but try this ...

diff --git a/stgit/gitmergeonefile.py b/stgit/gitmergeonefile.py
index c1af2f8..55b62db 100644
--- a/stgit/gitmergeonefile.py
+++ b/stgit/gitmergeonefile.py
@@ -264,7 +264,7 @@ def merge(orig_hash, file1_hash, file2_hash,
                     __conflict(path)
                     return 1
                 if file1_mode !=3D file2_mode:
-                    out.error('File "s" added in both, permissions con=
flict'
+                    out.error('File "%s" added in both, permissions co=
nflict'
                               % path)
                     __conflict(path)
                     return 1

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
