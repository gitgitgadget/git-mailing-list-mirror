From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] t6030 (bisect): work around Mac OS X "ls"
Date: Sun, 27 Jul 2008 05:19:41 +0200
Message-ID: <200807270519.41441.chriscool@tuxfamily.org>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu> <20080724060647.GA24587@glandium.org> <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Sun Jul 27 05:17:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMwkk-0006IS-OY
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 05:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbYG0DP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jul 2008 23:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbYG0DP6
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 23:15:58 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:46350 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755021AbYG0DP6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jul 2008 23:15:58 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 388755FD48;
	Sun, 27 Jul 2008 05:15:52 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 141F45FD3D;
	Sun, 27 Jul 2008 05:15:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90301>

Le jeudi 24 juillet 2008, Jonathan Nieder a =E9crit :
> t6030-bisect-porcelain.sh relies on "ls" exiting with nonzero
> status when asked to list nonexistent files.  Unfortunately,
> /bin/ls on Mac OS X 10.3 exits with exit code 0.  So look at
> its output instead.
>
> Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>

Acked-by: Christian Couder <chriscool@tuxfamily.org>

Thanks,
Christian.

> ---
>
> Mike Hommey wrote:
> > On Thu, Jul 24, 2008 at 07:57:26AM +0200, Christian Couder wrote:
> >> Le jeudi 24 juillet 2008, Jonathan Nieder a =E9crit :
> >>> -	test_must_fail ls .git/BISECT_* &&
> >>> +	echo .git/BISECT_* | test_must_fail grep BISECT_[^*] &&
> >>
> >> Perhaps the following is simpler:
> >>
> >> +	test -z "$(ls .git/BISECT_*)" &&
> >
> > That is still a useless use of ls ;)
>
> It is much better than what I wrote, at least.
>
> Good night (well, good morning I guess), and thanks.
>
>  t/t6030-bisect-porcelain.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.s=
h
> index 0626544..244fda6 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -76,7 +76,7 @@ test_expect_success 'bisect fails if given any junk
> instead of revs' ' test_must_fail git bisect start foo $HASH1 -- &&
>  	test_must_fail git bisect start $HASH4 $HASH1 bar -- &&
>  	test -z "$(git for-each-ref "refs/bisect/*")" &&
> -	test_must_fail ls .git/BISECT_* &&
> +	test -z "$(ls .git/BISECT_* 2>/dev/null)" &&
>  	git bisect start &&
>  	test_must_fail git bisect good foo $HASH1 &&
>  	test_must_fail git bisect good $HASH1 bar &&
