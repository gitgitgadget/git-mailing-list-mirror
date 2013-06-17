From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Mon, 17 Jun 2013 07:31:22 -0700
Message-ID: <7vsj0ghkqt.fsf@alter.siamese.dyndns.org>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com>
	<7vli69iff2.fsf@alter.siamese.dyndns.org>
	<vpqip1d803r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 16:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoaSw-0007AG-Fl
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 16:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab3FQOb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 10:31:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab3FQObZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 10:31:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED47C28CB4;
	Mon, 17 Jun 2013 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WA/jTYxjvYK3WKlEn+TadJkff3Q=; b=O9wixg
	juDB9k6OtGXpPrSUukBNdhIhgxWiE5RrE2cq3S45pqErWhvoxa5fucefSvtX+ftH
	rKE/GPmunaqHRFHXur1Y2J1cN0tRx773OKf9KM7/VQ88werCyIsr9LpSl0vSA0k8
	RrcD5S24lcOoCTBmzR0arKSR6I+U7v6c05N3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WWaRMk0+2pcijBenGYpFl/+dWxphB7sX
	mBVdieWmTaDA7FiLMIkpdELnxPs+JYjU4mnFpHQ+rZE9Uyuv8yuuc18TSweBXJNi
	u49LsuqO3rn+8GOFhl1mAZphverbMllcCQ6V7T78rnXMzHXCKusHDEqu5pU62o0S
	bCq+CpMR9UU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE7C628CB3;
	Mon, 17 Jun 2013 14:31:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E24128CB0;
	Mon, 17 Jun 2013 14:31:24 +0000 (UTC)
In-Reply-To: <vpqip1d803r.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	17 Jun 2013 13:09:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9647A390-D75A-11E2-8CAC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228074>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> But then the place to warn loudly is the doc for --force. What about
> this?

Sounds sensible.  I am not sure if "--all" is all that common to be
singled out, though.  "I always push these out" refspecs, like

	[remote "origin"]
        	push = refs/heads/master
        	push = refs/heads/next

share the need for the same cautiousness against --force, and
"applies to all the refs that are pushed" already covers both.

Mentioning 'matching' here is a very good idea, as people may not
realize it is pushing out more than the current branch.

> ------- 8< ------- 8< ------- 8< ------- 8< ------- 8< ------- 8< 
>
> From a529588dd8df84e54e5ec267068248cc555373f5 Mon Sep 17 00:00:00 2001
> From: Matthieu Moy <Matthieu.Moy@imag.fr>
> Date: Mon, 17 Jun 2013 13:02:39 +0200
> Subject: [PATCH] Documentation/git-push.txt: explain better cases where
>  --force is dangerous
>
> The behavior of "git push --force" is rather clear when it updates only
> one remote ref, but running it when pushing several branches can really
> be dangerous. Warn the users a bit more and give them the alternative to
> push only one branch.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/git-push.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 938d1ee..0899a35 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -136,6 +136,13 @@ already exists on the remote side.
>         not an ancestor of the local ref used to overwrite it.
>         This flag disables the check.  This can cause the
>         remote repository to lose commits; use it with care.
> +       Note that `--force` applies to all the refs that are pushed,
> +       hence using `git push --all --force`, or `git push --force`
> +       with `push.default` set to `matching` may override refs other
> +       than the current branch (including local refs that are
> +       strictly behind their remote counterpart). To force a push to
> +       only one branch, use `git push <remote> +<branch>` instead of
> +       `--force`.
>  
>  --repo=<repository>::
>         This option is only relevant if no <repository> argument is
> -- 
> 1.8.3.1.495.g13f33cf.dirty
