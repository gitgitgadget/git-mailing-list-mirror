From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: chapter and part in funcname for tex
Date: Sat, 02 Aug 2008 10:59:05 -0700
Message-ID: <7vprormh7a.fsf@gitster.siamese.dyndns.org>
References: <1217658945-29908-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1217678145-2630-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 20:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPLOn-0002c7-NK
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 20:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbYHBR7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 13:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbYHBR7N
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 13:59:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbYHBR7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 13:59:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC48F4CFEA;
	Sat,  2 Aug 2008 13:59:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E8EC94CFE9; Sat,  2 Aug 2008 13:59:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B51B1FC8-60BC-11DD-9415-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91161>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> This patch enhances the tex funcname by adding support for
> chapter and part sectioning commands. It also matches
> the starred version of the sectioning commands.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
> ---
>
> Resend, with Signed-off-by: line
>
>  diff.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index c253015..776bce1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1380,7 +1380,7 @@ static struct builtin_funcname_pattern {
>  			"^[ 	]*\\(\\([ 	]*"
>  			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
>  			"[ 	]*([^;]*\\)$" },
> -	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
> +	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\?{.*\\)$" },

Ok on idea, but NAK on implementation.

"A\?" to mean 0 or one "A" in BRE is GNU extention and we try to avoid it.
"A\{0,1\}" is equivalent and we already use the bound notation in "java"
section, so perhaps this is an Ok replacement?

	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
