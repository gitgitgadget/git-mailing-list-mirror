From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Emit helpful status for accidental "git stash" save
Date: Sat, 22 Dec 2007 08:22:34 -0800
Message-ID: <7vmys2ya0l.fsf@gitster.siamese.dyndns.org>
References: <7vmys36d7n.fsf@gitster.siamese.dyndns.org>
	<1198333369-17788-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 17:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J678B-0006XS-CY
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 17:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbXLVQWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 11:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbXLVQWr
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 11:22:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbXLVQWp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 11:22:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E1D37630E;
	Sat, 22 Dec 2007 11:22:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 72946630B;
	Sat, 22 Dec 2007 11:22:41 -0500 (EST)
In-Reply-To: <1198333369-17788-1-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Sat, 22 Dec 2007 15:22:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69141>

Wincent Colaiuta <win@wincent.com> writes:

> diff --git a/git-stash.sh b/git-stash.sh
> index f16fd9c..a2f3723 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -99,7 +99,8 @@ save_stash () {
>  
>  	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
>  		die "Cannot save the current status"
> -	printf >&2 'Saved "%s"\n' "$stash_msg"
> +	printf >&2 'Saved working directory and index state "%s"\n' "$stash_msg"
> +	echo >&2 '(To restore them type "git stash apply")'
>  }
>  
>  have_stash () {

I like that "To restore them..." insn, and I like that this is
much less invasive than anything we have seen during the
discussion.  But can we do this only for an accidental "git
stash" not for a deliberate "git stash save"?
