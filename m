From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid spurious error messages on error mistakes.
Date: Tue, 13 Jan 2009 00:20:44 -0800
Message-ID: <7vk58zd3c3.fsf@gitster.siamese.dyndns.org>
References: <20090112230228.GA28545@chistera.yi.org>
 <1231801776-20724-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 09:22:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMeXP-0006ue-VN
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 09:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbZAMIUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 03:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492AbZAMIUv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 03:20:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbZAMIUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 03:20:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A44211C5ED;
	Tue, 13 Jan 2009 03:20:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7474E1C5E1; Tue,
 13 Jan 2009 03:20:46 -0500 (EST)
In-Reply-To: <1231801776-20724-1-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Tue, 13 Jan 2009 00:09:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15D5992E-E14B-11DD-9569-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105471>

Pierre Habouzit <madcoder@debian.org> writes:

> Prior to that, if the user chose "squash" as a first action, the stderr
> looked like:
>
>     grep: /home/madcoder/dev/scm/git/.git/rebase-merge/done: No such file or directory
>     Cannot 'squash' without a previous commit
>
> Now the first line is gone.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  git-rebase--interactive.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index c8b0861..8ed2244 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -349,7 +349,7 @@ do_next () {
>  	squash|s)
>  		comment_for_reflog squash
>  
> -		has_action "$DONE" ||
> +		test -f "$DONE" && has_action "$DONE" ||
>  			die "Cannot 'squash' without a previous commit"
>  
>  		mark_action_done
> -- 
> 1.6.1.161.g5e07b.dirty

Make sense.  Will apply to maint.
