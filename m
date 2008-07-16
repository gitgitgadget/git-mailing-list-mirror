From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] setup.py: don't try to import stgit.run before the python version check
Date: Wed, 16 Jul 2008 06:39:56 +0200
Message-ID: <20080716043956.GA31132@diana.vm.bytemark.co.uk>
References: <1215806972-18713-1-git-send-email-vmiklos@frugalware.org> <1215806972-18713-2-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 06:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIypg-0005ay-6h
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 06:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYGPEkl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jul 2008 00:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbYGPEkl
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 00:40:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4272 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYGPEkk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 00:40:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KIyo0-0008BZ-00; Wed, 16 Jul 2008 05:39:56 +0100
Content-Disposition: inline
In-Reply-To: <1215806972-18713-2-git-send-email-vmiklos@frugalware.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88636>

On 2008-07-11 22:09:32 +0200, Miklos Vajna wrote:

> @@ -68,6 +67,8 @@ if sys.argv[1] in ['install', 'build']:
>      __check_python_version()
>      __check_git_version()
> =20
> +from stgit.run import Run
> +
>  # ensure readable template files
>  old_mask =3D os.umask(0022)
> =20

I had to modify the second hunk to make it work:

@@ -37,6 +36,7 @@ def __check_python_version():
 def __check_git_version():
     """Check the minimum GIT version
     """
+    from stgit.run import Run
     gitver =3D Run('git', '--version').output_one_line().split()[2]
     if not __check_min_version(git_min_ver, gitver):
         print >> sys.stderr, 'GIT version %s or newer required. Found =
%s' \

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
