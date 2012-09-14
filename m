From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 09/11] t7810-grep: test multiple --author with
 --all-match
Date: Fri, 14 Sep 2012 10:58:52 -0700
Message-ID: <7vy5kc4hb7.fsf@alter.siamese.dyndns.org>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
 <cover.1347615361.git.git@drmicha.warpmail.net>
 <830d4a80bb229835b6b4898c3c4b8b2e0e17b056.1347615361.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:59:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCaAS-0000Lv-OH
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 19:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab2INR64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 13:58:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab2INR6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 13:58:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8E4799F1;
	Fri, 14 Sep 2012 13:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eeFWmLxUs6bSRDUvBDOlDM7QBMY=; b=sXozn8
	YeVcclPY68Tchhaq1G2HXfpcysHcU734FxqN3D2ulCjRRWKJuTj25TTDt6mNJGA6
	Kmt1xdHKKvLV91C6+gEZ1JUcxSqRlPnB0cB0bHN7cfemML7cPyHOhMXLcYsb6Llk
	akr4YA8bRyCK0eTTlrADcsWmjWAeJcRcGJTHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AzWAjDiK44+bMzgsMWXCisHzbX6OOo3t
	0GAlYcOUSW6uDdPPBSCra+vYKiMK4jdyiIHts8ws1rD3yx3vV4+Bpdh1OTjyO5WP
	I99Jh2LsLvi6AEgU5xZ15lwE1GValp31TthYLKBuLIgEr1t9qxrS0ohmpBzHYpO+
	ocG6UGcMKgA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D63F899EF;
	Fri, 14 Sep 2012 13:58:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5695F99EB; Fri, 14 Sep 2012
 13:58:54 -0400 (EDT)
In-Reply-To: <830d4a80bb229835b6b4898c3c4b8b2e0e17b056.1347615361.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 14 Sep 2012 11:46:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D917C8F6-FE95-11E1-A227-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205519>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> --all-match is ignored for author matching on purpose.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

It is more like "--all-match is about --grep and does not interact
with --author or --committer at all".  At least with the recent fix.


>  t/t7810-grep.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index b841909..be81d96 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -513,6 +513,14 @@ test_expect_success 'log with multiple --author uses union' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log --all-match with multiple --author still uses union' '
> +	git log --all-match --author="Thor" --author="Aster" --format=%s >actual &&
> +	{
> +	    echo third && echo second && echo initial
> +	} >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'log with --grep and multiple --author uses all-match' '
>  	git log --author="Thor" --author="Night" --grep=i --format=%s >actual &&
>  	{
