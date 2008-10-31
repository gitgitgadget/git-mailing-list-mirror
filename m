From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 07:32:00 -0700
Message-ID: <20081031143200.GR14786@spearce.org>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com> <1225429753-70109-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 15:33:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvv3s-0000aa-3k
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 15:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbYJaOcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 10:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbYJaOcB
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 10:32:01 -0400
Received: from george.spearce.org ([209.20.77.23]:43023 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYJaOcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 10:32:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 430473835F; Fri, 31 Oct 2008 14:32:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1225429753-70109-1-git-send-email-benji@silverinsanity.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99590>

Brian Gernhardt <benji@silverinsanity.com> wrote:
> Not all /bin/sh have a builtin echo that recognizes -n.  Using printf
> is far more portable.
 
> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index c1850d2..f6a2dbd 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -424,7 +424,7 @@ cd "$WORKDIR"
>  test_expect_success 'cvs update (-p)' '
>      touch really-empty &&
>      echo Line 1 > no-lf &&
> -    echo -n Line 2 >> no-lf &&
> +    printf Line 2 >> no-lf &&

That needs to be:

	printf 'Line 2'

to have the same result.  Fortunately I don't think it matters
in this test, but it does read odd.

-- 
Shawn.
