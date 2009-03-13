From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/5] Add mergetool support to the classic StGit infrastructure
Date: Fri, 13 Mar 2009 03:02:43 +0100
Message-ID: <20090313020243.GB15393@diana.vm.bytemark.co.uk>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com> <20090312120902.2992.25192.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhwkx-00059a-4Z
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbZCMCCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 22:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbZCMCCq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:02:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:49341 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbZCMCCq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:02:46 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LhwjT-0004A9-00; Fri, 13 Mar 2009 02:02:43 +0000
Content-Disposition: inline
In-Reply-To: <20090312120902.2992.25192.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113129>

On 2009-03-12 12:09:02 +0000, Catalin Marinas wrote:

> Since Git already has a tool for interactively solving conflicts
> which is highly customisable, there is no need to duplicate this
> feature via the i3merge and i2merge configuration options. The
> user-visible change is that now mergetool is invoked rather than the
> previously customised interactive merging tool.

I agree wholeheartedly with the idea. Just one issue:

> +def mergetool(files =3D ()):
> +    """Invoke 'git mergetool' to resolve any outstanding conflicts. =
If 'not
> +    files', all the files in an unmerged state will be processed."""
> +    err =3D os.system('git mergetool %s' % ' '.join(files))
> +    # check for unmerged entries (prepend 'CONFLICT ' for consistenc=
y with
> +    # merge_recursive())
> +    conflicts =3D ['CONFLICT ' + f for f in get_conflicts()]
> +    if conflicts:

Mmm, os.system()? That'll break things as soon as we have a file name
with a space in it. I'm pretty sure there's something in stgit.run
that you could use.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
