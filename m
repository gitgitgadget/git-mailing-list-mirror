From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 3/5] Add stack creation and initialisation support to lib.Stack
Date: Sat, 7 Jun 2008 11:30:51 +0200
Message-ID: <20080607093051.GE32647@diana.vm.bytemark.co.uk>
References: <20080606204322.8805.32313.stgit@localhost.localdomain> <20080606204554.8805.37257.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 11:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ume-0008Nr-1Q
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 11:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbYFGJbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 05:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbYFGJbA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 05:31:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2401 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbYFGJbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 05:31:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K4ul9-0000Ox-00; Sat, 07 Jun 2008 10:30:51 +0100
Content-Disposition: inline
In-Reply-To: <20080606204554.8805.37257.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84193>

On 2008-06-06 21:45:54 +0100, Catalin Marinas wrote:

> This patch adds the create and initialise Stack classmethods to handl=
e
> the initialisation of StGIT patch series on a Git branch.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

I still have some comments, bu the patch looks good as-is.

> +    @staticmethod
> +    def create(stackdir):
> +        """Create the PatchOrder specific files
> +        """
> +        utils.create_empty_file(os.path.join(stackdir, 'applied'))
> +        utils.create_empty_file(os.path.join(stackdir, 'unapplied'))
> +        utils.create_empty_file(os.path.join(stackdir, 'hidden'))

Maybe s/create/create_files/ or soething to that effect here, as I
suggested in another mail a few minutes ago.

> +    def set_parents(self, remote, branch):
> +        if remote:
> +            self.set_parent_remote(remote)
> +        if branch:
> +            self.set_parent_branch(branch)

Much clearer now. Interesting that the only reason we need this
function at all is to make sure that set_parent_remote and
set_parent_branch are called in the correct order.

Maybe set_parent_branch should throw an exception instead of silently
doing nothing when there is no parent yet? It would force the callers
to be more aware of the limitation -- though we might not actually
want that. Your call.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
