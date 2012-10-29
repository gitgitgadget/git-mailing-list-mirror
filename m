From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] Move code from builtin to libgit.a
Date: Mon, 29 Oct 2012 03:43:52 -0400
Message-ID: <20121029074352.GF5102@sigill.intra.peff.net>
References: <20121026120253.GA1455@sigill.intra.peff.net>
 <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:44:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSk12-0007ty-JV
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 08:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab2J2Hn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Oct 2012 03:43:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41894 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab2J2Hnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 03:43:55 -0400
Received: (qmail 16539 invoked by uid 107); 29 Oct 2012 07:44:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 03:44:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 03:43:52 -0400
Content-Disposition: inline
In-Reply-To: <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208601>

On Fri, Oct 26, 2012 at 10:53:48PM +0700, Nguyen Thai Ngoc Duy wrote:

> These two are big code moves, basically all {fetch,send}-pack code.
> While I think this is good cleanup (I get surprise every time I look
> at transport.c and it leads to buitin/fetch-pack.c), this is probably
> not a good idea if we have on flight topics, which may cause lots of
> conflicts for you and Junio. Fortunately we don't at the moment.
>=20
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
>   Move try_merge_command and checkout_fast_forward to libgit.a
>   Move estimate_bisect_steps to libgit.a
>   Move print_commit_list to libgit.a
>   Move setup_diff_pager to libgit.a
>   send-pack: move core code to libgit.a
>   fetch-pack: remove global (static) configuration variable "args"
>   fetch-pack: move core code to libgit.a

This does not seem to disturb anything in pu, so I am very tempted.

I tweaked the last one, which removed the inclusion of pkt-line.h from
builtin/fetch-pack.c; it is still needed by the use of packet_read_line
when reading stateless rpc refs from stdin (caught by "-Wall -Werror").

-Peff
