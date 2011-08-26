From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Fri, 26 Aug 2011 10:43:43 -0700
Message-ID: <7vfwkodq5s.fsf@alter.siamese.dyndns.org>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 19:43:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx0Rb-0006Rx-HG
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 19:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab1HZRnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 13:43:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544Ab1HZRnq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 13:43:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56B9D4594;
	Fri, 26 Aug 2011 13:43:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=olAdo3H6kM+SNQk4QECyUqKhXyA=; b=j9Bw10
	8xrHAgFXmOIrFI+NLX099vqWhEZG5ss20kAeQmFSzCpf0zrqtMZ4QUN1g4jgpwOZ
	0iufZv25ApEM4fJR+J/Noe6rN1WzSjtx0s0uyN9VRcmaTZtXHHnZgafND+vYQHZs
	74zMN6NEs+3IU0luFJW87Xc41gmmLm/omC9co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZBzEN4ybF7RnJQKC8aG67Npn8TN4UkLM
	2lXlb1OVCJEvFOx1IJuAYn4H0SZtwO/9nMSrXPDg0jDbM2NutaKATls1mlRFzdo+
	Is379Ig16naJCefG2eUPTrnLVp4WhH8mWQ6qjcGaRHNJJzpy5UXx+228re/15bCW
	NxLhL1zOPzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 490D54593;
	Fri, 26 Aug 2011 13:43:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C44B34591; Fri, 26 Aug 2011
 13:43:44 -0400 (EDT)
In-Reply-To: <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 26 Aug 2011 16:05:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1EC23C8-D00A-11E0-B138-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180183>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, there is no way to invoke the list mode explicitly.

..., without giving -v to force verbose output.

> Introduce a --list option which invokes the list mode. This will be
> beneficial for invoking list mode with pattern matching, which otherwise
> would be interpreted as branch creation.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

> @@ -20,7 +20,8 @@ DESCRIPTION
>  
>  With no arguments, existing branches are listed and the current branch will
>  be highlighted with an asterisk.  Option `-r` causes the remote-tracking
> -branches to be listed, and option `-a` shows both.
> +branches to be listed, and option `-a` shows both. This list mode is also
> +activated by the `--list` and `-v` options (see below).

Very good to mention "and -v" here ;-)

> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 6b7c118..61e095c 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -32,6 +32,20 @@ test_expect_success 'git branch shows local branches' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git branch --list shows local branches' '
> +	git branch --list >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<'EOF'
> +  branch-one
> +  branch-two
> +EOF
> +test_expect_success 'git branch --list pattern shows matching local branches' '
> +	git branch --list branch* >actual &&
> +	test_cmp expect actual
> +'
> +

Could we have a test to check the code you updated to sanity check the
combination of options as well? I suspect the reason your initial round
botched the "branch -v -m foo" without realizing may be because we do not
cover the error checking.
