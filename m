From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sun, 5 Feb 2012 20:39:57 +0100
Message-ID: <87sjipxe5u.fsf@thomas.inf.ethz.ch>
References: <1328373162-25188-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 20:40:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru7wd-0003t6-TH
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 20:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab2BETkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 14:40:08 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:33320 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840Ab2BETkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 14:40:07 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 5 Feb
 2012 20:40:03 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (84.73.49.17) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 5 Feb
 2012 20:40:03 +0100
In-Reply-To: <1328373162-25188-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 4 Feb 2012 18:32:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189950>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Currently bad addresses like 'Foo Bar <foo@bar.com>>' will just be sent
> verbatim -- that's not good; we should either error out, or sanitize
> them.
>
> The following patch adds extra sanitazion so the following
> transformations are performed:
>
>   'Foo Bar <foo@bar.com>' -> 'Foo Bar <foo@bar.com>'
>   '"Foo Bar" <foo@bar.com>' -> '"Foo Bar" <foo@bar.com>'
>   'foo@bar.com' -> 'foo@bar.com'
>   '<foo@bar.com>' -> 'foo@bar.com'
>   'Foo Bar' -> 'Foo Bar'

Am I the only one who stared at this for ten seconds, only to then
realize that there is no sanitizing whatsoever going on here?

>   'Foo Bar <foo@bar.com>>' -> 'Foo Bar <foo@bar.com>'
>   '"Foo Bar" <foo@bar.com>>' -> '"Foo Bar" <foo@bar.com>'
>   '<foo@bar.com>>' -> 'foo@bar.com'

All of these are the same underlying issue.  Does your patch fix any
other malformed addresses, or just this particular type?

> Basically, we try to check that the address is in the form of
> "Name <email>", and if not, assume it's "email". According to commit
> 155197e[1], the "prhase" should not be empty, so if it is, remove the
                   ^^^^^^
"phrase"

>  git-send-email.perl |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)

Tests?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
