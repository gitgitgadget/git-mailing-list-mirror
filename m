From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Remove .git auto detection from setup_git_env()
Date: Fri, 5 Feb 2010 10:12:40 -0500
Message-ID: <20100205151239.GC14116@coredump.intra.peff.net>
References: <1265370468-6147-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 16:13:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdPrR-000737-Kp
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 16:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833Ab0BEPMj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 10:12:39 -0500
Received: from peff.net ([208.65.91.99]:44777 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932268Ab0BEPMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 10:12:38 -0500
Received: (qmail 25246 invoked by uid 107); 5 Feb 2010 15:12:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 05 Feb 2010 10:12:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2010 10:12:40 -0500
Content-Disposition: inline
In-Reply-To: <1265370468-6147-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139049>

On Fri, Feb 05, 2010 at 06:47:48PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> When GIT_DIR environment variable is not specified, .git will be
> searched if a repository is needed. Currently this can be done in two
> places: setup_git_directory_gently() and setup_git_env().
>=20
> The one in setup_git_env() is no longer correct and should IMHO have
> been removed since the introduction of setup_git_directory_gently() i=
n
> d288a70. Having two ways of auto detection may lead to obscure errors
> because .git may be misdetected by setup_git_env(),
> automatically called via git_path(), which is all over the place.
>=20
> This patch makes setup_git_env() die if GIT_DIR is not explictly
> set. That's setup_git_directory_gently()'s job. If you ever want to
> touch things inside $GIT_DIR, you should have already called
> setup_git_directory_gently().
>=20
> This patch breaks commands (in a good way) and obviously not for
> mainline. I still have to go through "make test" to see how many are
> impacted. But I think this is a good change. Am I missing something?

It has been a while since I looked at this code, but I think this is a
good direction forward. I remember trying something like this and
getting discouraged at all of the ensuing breakage. So if you can track
down all of the fallouts and fix them, I think we will be better off in
the long run.

-Peff
