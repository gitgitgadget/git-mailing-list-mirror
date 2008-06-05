From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Thu, 5 Jun 2008 09:01:26 +0200
Message-ID: <20080605070126.GC23209@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211334.32531.74258.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 09:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K49UP-0004CA-Gc
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 09:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYFEHBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 03:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYFEHBc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 03:01:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4538 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbYFEHBb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 03:01:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K49TS-00068i-00; Thu, 05 Jun 2008 08:01:26 +0100
Content-Disposition: inline
In-Reply-To: <20080604211334.32531.74258.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83868>

On 2008-06-04 22:13:35 +0100, Catalin Marinas wrote:

> This class deals with Git-specific branch commands. The Stack class
> is a direct child of Branch and some of its functionality was moved
> to the new class.

Looks good except for a few minor points.

> @@ -619,3 +626,47 @@ class IndexAndWorktree(RunWithEnvCwd):
>      def update_index(self, files):
>          self.run(['git', 'update-index', '--remove', '-z', '--stdin'=
]
>                   ).input_nulterm(files).discard_output()
> +
> +class Branch(object):
> +    """Represents Git branch."""

Missing "a".

> +    def __init__(self, repository, name):
> +        self._repository =3D repository
> +        self._name =3D name

Using double leading underscores will give you a class-local name. Why
just one?

> +    @classmethod
> +    def create(cls, repository, name, create_at =3D None):

Minor nit: in case of things that are clearly "owned" by other things
(git objects are owned by a git repository, for example), I've tried
to put the creation function in the owner, not the owned. I'm not
insisting, though.

> +        """Create a new Git branch and return the corresponding L{Br=
anch} object."""

Long line.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
