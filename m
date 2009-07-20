From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 2/3] push: add --current
Date: Mon, 20 Jul 2009 09:14:13 +0200
Message-ID: <20090720071413.GA29915@atjola.homenet>
References: <1248071820-18289-1-git-send-email-bonzini@gnu.org>
 <1248071820-18289-3-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 09:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSn4q-0002Dl-Rd
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 09:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbZGTHOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 03:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbZGTHOR
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 03:14:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:52006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750879AbZGTHOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 03:14:17 -0400
Received: (qmail invoked by alias); 20 Jul 2009 07:14:14 -0000
Received: from i59F55693.versanet.de (EHLO atjola.local) [89.245.86.147]
  by mail.gmx.net (mp050) with SMTP; 20 Jul 2009 09:14:14 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+HqWFnXW6HGTFVVA4APhzcSo4ZayR3Maxge4GqFZ
	xu+bFM6Nid/sYV
Content-Disposition: inline
In-Reply-To: <1248071820-18289-3-git-send-email-bonzini@gnu.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123576>

On 2009.07.20 08:36:59 +0200, Paolo Bonzini wrote:
> +--current::
> +	Independent of the other options, restrict pushing to the current
> +	HEAD.

To me, this sounds like there are multiple HEADs and this selects the
current one to be pushed, which would be wrong. Maybe this could be
written as:

	Restrict pushing to the currently checked out branch head.

Which is also in line with the error message that is produced when
you're on a detached HEAD.

> +Refspecs given in the configuration are still used to find the
> +destination name of the current branch.  However, this option cannot
> +be specified if an explicit refspec is given on the command line,
> +because it would be useless and possibly confusing.

Hm, this only talks about refspecs in the config, but your patch series
is especially about push.default=3Dtracking, which is not a refspec set=
 in
the config, but causes a refspec to be generated on the fly. Maybe:

	With this option, defaults given in the configuration, either as
	push refspecs for the remote or as a global push default, are
	still evaluated, but only the currently checked out branch is
	pushed. This means that this option, unlike the `HEAD` refspec,
	supports a destination name that differs from the source name.
	However, this option cannot be specified if an explicit refspec
	is given on the command line, because it would be useless and
	possibly confusing.

Which also explains a bit how this option differs from using the HEAD
refspec.

> ++
> +Additionally, if there is no refspec in the configuration and no
> +`push.default` configuration either, with this option git will use a
> +default refspec of `HEAD` rather than `:`.

Hm, this looks kind of funny with my rewrite of the previous paragraph,
so:

	Additionally, if there are no push defaults given in the
	configuration at all, this option makes git default to `HEAD`
	instead of `:`.

Bj=F6rn
