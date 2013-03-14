From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Allow combined diff to ignore white-spaces
Date: Thu, 14 Mar 2013 14:43:19 -0700
Message-ID: <7v1ubhy7wo.fsf@alter.siamese.dyndns.org>
References: <7v7glayp4l.fsf@alter.siamese.dyndns.org>
 <1363294994-3127-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 22:43:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGFwD-0006A7-4c
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 22:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab3CNVnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 17:43:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab3CNVnV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 17:43:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 138E3CA9B;
	Thu, 14 Mar 2013 17:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jcLWHpGhLjgJWcq2/mWULSUX5WI=; b=JfVOrd
	dN0WZ3ggUPr+KbXEzhZGPMHw3cJFTM5XwCcAUihf98evIi8Y8EAg59lQl8PCcTr3
	/MblJRG7jBsBZGAl19JqDPe7m5psUbN4xsI2k9SP+7RKd5N07awIDHw7T8j0Sq9K
	kpza8VRzlasb2Ac/aveX6zdfiKB34CNQy7SYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWAEv51l7WsZS6GgpNUPxxCtC79/kBof
	79sVc/LePsByIn2N6da5RAnIF16/lM3GqAiUoWvCF1QjHR+LQWnM9tzun5tSZySR
	zWcSF0h1JeHvkjcN3IBD+cRv0wlNeuijsOYPIu6iuefnPgMaoH/LA6Rar1sinNt0
	oGIvvLSuBcU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08F38CA9A;
	Thu, 14 Mar 2013 17:43:21 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8150CCA98; Thu, 14 Mar 2013
 17:43:20 -0400 (EDT)
In-Reply-To: <1363294994-3127-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Thu, 14 Mar 2013 22:03:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3053DDF6-8CF0-11E2-B743-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218171>

Antoine Pelisse <apelisse@gmail.com> writes:

> +test_expect_success 'check combined output (no ignore space)' '
> +	git show >actual.tmp &&
> +	sed -e "1,/^@@@/d" < actual.tmp >actual &&
> +	tr -d Q <<-\EOF >expected &&
> +	--always coalesce
> +	- eol space coalesce
> +	- space change coalesce
> +	- all spaces coalesce
> +	- eol spaces
> +	- space change
> +	- all spaces
> +	 -eol space coalesce Q
> +	 -space  change coalesce
> +	 -all spa ces coalesce
> +	+ eol spaces Q
> +	+ space  change
> +	+ all spa ces
> +	EOF
> +	compare_diff_patch expected actual
> +'

Nicely constructed ;-)

Thanks.
