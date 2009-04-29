From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 4/9] Convert 'clone' to the use stgit.lib
Date: Wed, 29 Apr 2009 08:21:01 +0200
Message-ID: <20090429062101.GD18483@diana.vm.bytemark.co.uk>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com> <20090428150957.27261.83658.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 08:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz3AP-0000Hn-Jh
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 08:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbZD2GVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 02:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbZD2GVF
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 02:21:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:41793 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbZD2GVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 02:21:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lz3AD-0004sy-00; Wed, 29 Apr 2009 07:21:01 +0100
Content-Disposition: inline
In-Reply-To: <20090428150957.27261.83658.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117851>

On 2009-04-28 16:09:57 +0100, Catalin Marinas wrote:

> The patch also adds the stgit.lib.git.clone() function.

>      if os.path.exists(local_dir):
> -        raise CmdException, '"%s" exists. Remove it first' % local_d=
ir
> -
> -    print 'Cloning "%s" into "%s"...' % (repository, local_dir)
> +        raise common.CmdException, '"%s" exists. Remove it first' % =
local_dir

As recommended by PEP 8, consider using the "raise Exc(args)" syntax:

    - When raising an exception, use "raise ValueError('message')" inst=
ead of
      the older form "raise ValueError, 'message'".

      The paren-using form is preferred because when the exception argu=
ments
      are long or include string formatting, you don't need to use line
      continuation characters thanks to the containing parentheses.  Th=
e older
      form will be removed in Python 3000.

> +def clone(remote, local):
> +    """Clone a remote repository using 'git clone'."""
> +    run.Run('git', 'clone', remote, local).run()

You don't capture git's output here, but just let it through. Does
that look good in combination with the enclosing out.start() ...
=2Edone() stuff?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
