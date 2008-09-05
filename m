From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Avoid warning when bisecting a merge
Date: Fri, 5 Sep 2008 08:14:36 +0200
Message-ID: <200809050814.36937.chriscool@tuxfamily.org>
References: <1220562150-19962-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Sep 05 08:12:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbUYc-0004Pm-48
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 08:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbYIEGLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 02:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbYIEGLD
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 02:11:03 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:54123 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570AbYIEGLB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 02:11:01 -0400
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id CF7493EA0BE;
	Fri,  5 Sep 2008 08:10:58 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 983893EA0D9;
	Fri,  5 Sep 2008 08:10:58 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1220562150-19962-1-git-send-email-hendeby@isy.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94993>

Le jeudi 4 septembre 2008, Gustaf Hendeby a =E9crit :
> Trying to compare an empty string as a number results in an error,
> hence make sure checkout_done is set before using it.

This patch seems to work fine.=20

> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>

Acked-by: Christian Couder <chriscool@tuxfamily.org>

Thanks,
Christian.

PS: After thinking about it, I wonder if we should remove $checkout_don=
e=20
entirely and use the return value from "check_merge_bases"=20
and "check_good_are_ancestors_of_bad" to know if a checkout was done.

> ---
>
> This one should go on top of cc/bisect.
>
> /Gustaf
>
>  git-bisect.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 69a9a56..05d14b3 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -437,6 +437,7 @@ bisect_next() {
>  		"refs/bisect/skip-*" | tr '\012' ' ') &&
>
>  	# Maybe some merge bases must be tested first
> +	checkout_done=3D0
>  	check_good_are_ancestors_of_bad "$bad" "$good" "$skip" || exit
>  	test "$checkout_done" -eq "1" && checkout_done=3D'' && return
