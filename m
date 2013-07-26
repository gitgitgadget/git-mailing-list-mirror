From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: make sure the upstream remote is configured
Date: Fri, 26 Jul 2013 14:43:11 -0400
Message-ID: <20130726184311.GA29799@sigill.intra.peff.net>
References: <1374860377-17652-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jul 26 20:43:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2mz3-00014H-5N
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 20:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab3GZSnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 14:43:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:59724 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab3GZSnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 14:43:16 -0400
Received: (qmail 1369 invoked by uid 102); 26 Jul 2013 18:43:16 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 13:43:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 14:43:11 -0400
Content-Disposition: inline
In-Reply-To: <1374860377-17652-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231194>

On Fri, Jul 26, 2013 at 07:39:37PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> A command of e.g.
>=20
>     git push --set-upstream /tmp/t master
>=20
> will call install_branch_config() with a remote name of "/tmp/t". Thi=
s
> function will set the 'branch.master.remote' key to, which is
> nonsensical as there is no remote by that name.

Is it nonsensical? It does not make sense for the @{upstream} magic
token, because we will not have a branch in tracking branch refs/remote=
s
to point to. But the configuration would still affect how "git pull"
chooses a branch to fetch and merge.

I.e., you can currently do:

  git push --set-upstream /tmp/t master
  git pull ;# pulls from /tmp/t master

-Peff
