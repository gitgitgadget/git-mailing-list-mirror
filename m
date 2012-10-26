From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Fri, 26 Oct 2012 09:37:42 -0400
Message-ID: <20121026133742.GA10829@sigill.intra.peff.net>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us>
 <CABURp0pqg7XC6makK2OcundMabV9AtcBNGNK6Q0TMZfJbt3anw@mail.gmail.com>
 <20121022225546.GO23101@odin.tremily.us>
 <CABURp0rpPqeTJMYXmgMG2CmU=SzzvCMeX46rnMVB0EeB_LXPiA@mail.gmail.com>
 <20121025011227.GH801@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Oct 26 15:37:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRk6o-0001Vp-AK
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 15:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880Ab2JZNhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 09:37:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37877 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123Ab2JZNhp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 09:37:45 -0400
Received: (qmail 22710 invoked by uid 107); 26 Oct 2012 13:38:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Oct 2012 09:38:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2012 09:37:42 -0400
Content-Disposition: inline
In-Reply-To: <20121025011227.GH801@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208444>

On Wed, Oct 24, 2012 at 09:12:27PM -0400, W. Trevor King wrote:

> On Wed, Oct 24, 2012 at 02:12:18PM -0400, Phil Hord wrote:
> > +                                       VAR_NAME=$(printf '%s'
> > "$VAR_NAME" | tr A-Z a-z | sed -e 's/^[^a-z]/_/' -e 's/[^a-z0-9]/_/g')
> 
> Is there a reason why you use printf instead of echo?

Sadly, echo is not entirely portable for arbitrary content. We have run
into problems with backslashes being interpreted differently (bash
requires "echo -e" to interpret them, dash will always do it, and POSIX
leaves it vague).

> Also, this sort of name cleaning should probably live in a new
> function:
> 
>   clean_environment_variable()
> 
> or some such.  Is there a git-utility-functions.sh library hiding
> somewhere in the source? ;)

git-sh-setup?

-Peff
