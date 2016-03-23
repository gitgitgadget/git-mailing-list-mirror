From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add option -n (--no-checkout) to git-worktree add
Date: Wed, 23 Mar 2016 08:51:16 -0700
Message-ID: <xmqq7fgtdwgb.fsf@gitster.mtv.corp.google.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ray Zhang <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:51:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ail48-0006ot-9x
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 16:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbcCWPvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 11:51:20 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752120AbcCWPvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 11:51:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CABF54D49A;
	Wed, 23 Mar 2016 11:51:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4lm68Yj5BbvaQXhw32XSMEO1c74=; b=Ah/x23
	ILcZAuGby/twupJfIJHiTaRV455X1FScq9t6o7d2IDaeE/gAIxhIBCQT7qiGmdxv
	SUoxCLIw05TnPlBln6bHZIUjx8FBH+NcnnLM7MT26SOxAjcQzHvHP4/5CjEnSkI6
	HnusBuT6aE0DqVbIp8WMjsRZb+vcSAPevnyA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HZNMVZHrz4+sKQL9kyyEKonpnNbIPdA0
	sGwrP3KON8vf6MmMrcsDcT/BTR9CS7XeFFPujrCNSsTn43soEQiDrX7/daP0j0CT
	GTCUnuaoXC09jA+NxL/YYBnC9WLgH4sEBwxNWFs1iLMAvPSnjIItuJuYzrID6i6d
	3fNzVHNrW9c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C30AC4D499;
	Wed, 23 Mar 2016 11:51:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 456704D498;
	Wed, 23 Mar 2016 11:51:18 -0400 (EDT)
In-Reply-To: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
	(Ray Zhang's message of "Wed, 23 Mar 2016 15:08:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14F37400-F10F-11E5-B1BB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289662>

Ray Zhang <zhanglei002@gmail.com> writes:

> @@ -320,6 +323,7 @@ static int add(int ac, const char **av, const char *prefix)
>  		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
>  			   N_("create or reset a branch")),
>  		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
> +		OPT_BOOL('n', "no-checkout", &opts.no_checkout, N_("don't create a checkout")),

This would allow --no-no-checkout, which is idiotic, wouldn't it?

How about

    OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree"))

and set opts.checkout to true when initializing?
