From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git svn dcommit: new option --interactive.
Date: Tue, 6 Sep 2011 13:26:01 -0700
Message-ID: <20110906202601.GA11668@dcvr.yhbt.net>
References: <1315164113-26539-1-git-send-email-frederic.heitzmann@gmail.com>
 <1315164113-26539-2-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jaysoffian@gmail.com
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 22:26:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R12Dh-0003hO-BS
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 22:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab1IFU0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Sep 2011 16:26:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44507 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755114Ab1IFU0C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 16:26:02 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B424921062;
	Tue,  6 Sep 2011 20:26:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1315164113-26539-2-git-send-email-frederic.heitzmann@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180832>

=46r=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com> wrote:
> Allow the user to check the patch set before it is commited to SNV. I=
t is then
> possible to accept/discard one patch, accept all, or quit.
>=20
> This interactive mode is similar with 'git send email' behaviour. How=
ever,
> 'git svn dcommit' returns as soon as one patch is discarded.
>=20
> Part of the code was taken from git-send-email.perl

> Thanks-to: Eric Wong <normalperson@yhbt.net> for the initial idea.
> Signed-off-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail=
=2Ecom>

I agree with this feature, a few comments inline.

>  I would have preferred not duplicating the code snippets taken from
>  git-send-email ('ask' function, Term related code, ...) but I prefer=
red not
>  to spoil Git.pm with it.
>  Any comment on a better way to factor perl code would be appreciated=
=2E

We should put this into Git.pm at some point.
(Somebody should refactor git-svn.perl into separate files too... :x)

>  Documentation/git-svn.txt |    8 +++++
>  git-svn.perl              |   71 +++++++++++++++++++++++++++++++++++=
+++++++++-
>  2 files changed, 78 insertions(+), 1 deletions(-)

Tests and feature should be the same patch

> +	return defined $default ? $default : undef
> +		unless defined $term->IN and defined fileno($term->IN) and
> +		       defined $term->OUT and defined fileno($term->OUT);

Things to make life easier for (mainly) C programmers:

* Use C-style "&&" and "||" for conditionals.  "and" and "or" are lower
  precedence and better used for control flow (see perlop(1) manpage).

* Also, use parentheses for defined(foo) to disambiguate multiple
  conditions/statements.

--=20
Eric Wong
