From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Tue, 12 Apr 2016 13:40:13 -0700
Message-ID: <xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
	<1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 22:40:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq56n-0007rZ-62
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 22:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965371AbcDLUkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 16:40:19 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965328AbcDLUkR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 16:40:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BC10552D3;
	Tue, 12 Apr 2016 16:40:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9dG4qMja4yB+AE89B5XsqPGUIiA=; b=g1Acf5
	xLtHFsq6n6q2bmFrUoYozCOQHM26K5vLHi6aQ2K8yWR8yg3rxulRqhzpN/GfBnMW
	fho1awkbejsLYKZT3WJa4QE1xpnbq9smcVL4PxDwv0DXSaLStxKzocNLhTXVTuh4
	FbZVX+AQ+qHJe5f5kB29ipffu4jU86bXhefh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=draVLuSTEiI08IDjL5l51ipagUyTaPqM
	5ROAgQORmkyY+iwTw9JBV1LDyWgd7hWa21QMMr7CXouXf+FjmuguZCtI7JhjG4r5
	dJWbzplkOb+6135sxsY5dhMS5vkwGy/w5VqXUittF2xNhSM2Ch9PkerlWImAaSZ1
	dsM/wcxolOE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 014B1552D2;
	Tue, 12 Apr 2016 16:40:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71DC4552D1;
	Tue, 12 Apr 2016 16:40:14 -0400 (EDT)
In-Reply-To: <1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 10 Apr 2016 00:15:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C261E56A-00EE-11E6-8EC0-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291293>

Karthik Nayak <karthik.188@gmail.com> writes:

> +			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
> +			    remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
> +	} else {
> +		strbuf_addf(&local, "%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
> +			    branch_get_color(BRANCH_COLOR_RESET));
> +		strbuf_addf(&remote, "%s%s%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
> +			    branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));

The overlong lines are somewhat irritating, but the change above in
this round relative to the previous one shows a good use case for
the conditional formatting feature and illustrates how powerful the
concept it is.  I like it.

Thanks, will queue.
