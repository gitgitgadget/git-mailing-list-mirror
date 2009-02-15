From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: offer more options for gitk
Date: Sun, 15 Feb 2009 01:33:55 -0800
Message-ID: <7vfxigniws.fsf@gitster.siamese.dyndns.org>
References: <1234641270-14342-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 15 10:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYdPR-00081r-Tj
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbZBOJeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZBOJeG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:34:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbZBOJeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:34:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C0972B2BB;
	Sun, 15 Feb 2009 04:34:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5744A2B2B7; Sun,
 15 Feb 2009 04:33:57 -0500 (EST)
In-Reply-To: <1234641270-14342-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Sat, 14 Feb 2009 20:54:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C6FF58CC-FB43-11DD-9B67-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109985>

Thomas Rast <trast@student.ethz.ch> writes:

> Add some more git-log options to the gitk completion.  Not all of them
> make sense, unfortunately.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> I was simply too lazy to keep typing --simplify-by-decoration.
>
> I made two passes over the git-log manpage and simply selected all
> options that seemed to make sense, _seemed_ to work, and that didn't
> mangle the history view in horrible ways (such as disconnecting it
> into little pieces).  It does handle --left-right correctly, very
> nice!

The --left-right support in gitk was done in tandem with the low-level
support.

> +		__gitcomp "
> +			--not --all $merge
> +			--branches --tags --remotes
> +			--first-parent
> +			--dense --sparse --full-history
> +			--simplify-merges --simplify-by-decoration
> +			--since= --after= --until= --before=
> +			--left-right
> +			"

Many options you add here are useful for git-log and not present in its
completion, but as you point out not all git-log options necessarily make
sense for gitk.  I think it would make sense to introduce an extra
variable $__git_log_basic_options that holds the basic ones that can be in
both, and add the ones that are specific to gitk or git-log in their own
completion functions.  I suspect gitk's addition will be nil, while
git-log would add --graph, --walk-reflogs and --no-merges to the basic
set.

>  		return
>  		;;
>  	esac
> -- 
> 1.6.2.rc0.293.g947001
