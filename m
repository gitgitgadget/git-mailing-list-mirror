From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/9] revision.c: introduce --cherry-mark
Date: Wed, 09 Mar 2011 13:29:17 -0800
Message-ID: <7vy64o7zki.fsf@alter.siamese.dyndns.org>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
 <4b4b4f78372167c76224903f0a360c3c9ab62728.1299499429.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:29:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQwm-0006nJ-R6
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 22:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab1CIV31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 16:29:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1CIV30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 16:29:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4852445C3;
	Wed,  9 Mar 2011 16:30:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CtJoTZEpIpfxKEWcxCVrJITz3Sk=; b=XcpZM3
	rOBJPRRNwbQOfrdXVv4jRAjQvZ8saBqC+4L8yNItvuxPrPWg3q9pkV/ZZVwO5WLU
	iq4/X33MTb3b3oGrq/6N6s/n24GZxERQ3bz3GRJzm9ZVfCHx7tST56bt/UzggVoh
	poWvPyiHgEf6binPflkUSQFKf7mpR8Y5BqPh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VGzumKzKk5xVdLHinjS8FBi4o8V+7vNM
	i67S7kkUsNQpBI0QSqCJpKxCrXzKlLStQQIIMfgbug7EWiKNNpr7LHABeJfPSCCE
	EtSwv5hyikQpcGvWDqnSbXxL/zEV1t/8TdVQde5TH1bAURjLXMnX4J9QK2B0jw/z
	ocf0Vz/K0lA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 253E045C1;
	Wed,  9 Mar 2011 16:30:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2F37B45C0; Wed,  9 Mar 2011
 16:30:46 -0500 (EST)
In-Reply-To: <4b4b4f78372167c76224903f0a360c3c9ab62728.1299499429.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon, 7 Mar 2011 13:31:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80F98D6E-4A94-11E0-86A8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168763>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> for marking those commits which "--cherry-pick" would drop.

Please do not start your second paragraph with a half-sentence.

> The marker for those commits is '=' because '-' denotes a boundary
> commit already, even though 'git cherry' uses it.
>
> Nonequivalent commits are denoted '+' unless '--left-right' is used.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  revision.c |   21 ++++++++++++++++++---
>  revision.h |    4 +++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 49d9ba8..3da403e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -535,6 +535,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
>  	int left_count = 0, right_count = 0;
>  	int left_first;
>  	struct patch_ids ids;
> +	unsigned cherryflag;

s/cherryflag/cherry_flag/;

> diff --git a/revision.h b/revision.h
> index 0e4b35e..ee380ad 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -14,7 +14,8 @@
>  #define CHILD_SHOWN	(1u<<6)
>  #define ADDED		(1u<<7)	/* Parents already parsed and added? */
>  #define SYMMETRIC_LEFT	(1u<<8)
> -#define ALL_REV_FLAGS	((1u<<9)-1)
> +#define PATCHSAME	(1u<<10)
> +#define ALL_REV_FLAGS	((1u<<10)-1)

I think you meant (1u<<9) so that ALL can cover that bit with
((1u<<10)-1).
