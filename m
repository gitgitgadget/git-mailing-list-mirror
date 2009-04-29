From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 9/9] Use the default git colouring scheme rather than specific scripts
Date: Wed, 29 Apr 2009 08:43:31 +0200
Message-ID: <20090429064331.GI18483@diana.vm.bytemark.co.uk>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com> <20090428151025.27261.15964.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 08:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz3WH-00004w-QT
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 08:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZD2Gnd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 02:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbZD2Gnd
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 02:43:33 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:36691 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbZD2Gnc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 02:43:32 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lz3Vz-00051P-00; Wed, 29 Apr 2009 07:43:31 +0100
Content-Disposition: inline
In-Reply-To: <20090428151025.27261.15964.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117857>

On 2009-04-28 16:10:25 +0100, Catalin Marinas wrote:

> This patch adds the mechanism to check if the output is tty for the
> diff and show commands and passes the --color option to git if the
> color.diff config option is set auto or true. The patch also changes
> the default pager to 'less -FRSX' from the diffcol.sh script.

Seems like a nice improvement.

> +    # Set the PAGER environment to the config value if not already s=
et
> +    if not 'PAGER' in os.environ:
> +        os.environ['PAGER'] =3D config.get('stgit.pager')

You can replace these two lines with

  os.environ.setdefault('PAGER', config.get('stgit.pager'))

The only downside is that config.get() will be evaluated (and the
result discarded) even if PAGER _is_ set in the environment. But
config.get() should be dirt cheap, because we should be reading in all
the config values at once the first time we need one of them. But as I
recall we don't currently do that, so my one-liner might not be so
clever after all ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
