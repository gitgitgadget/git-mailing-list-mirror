From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] fetch-pack: test cases for the new --stdin option
Date: Mon, 02 Apr 2012 12:34:56 -0700
Message-ID: <7v4nt2exlr.fsf@alter.siamese.dyndns.org>
References: <4F79C195.6090905@gmx.net> <4F79C2C8.3020009@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ivan Todoroski <grnch@gmx.net>
X-From: git-owner@vger.kernel.org Mon Apr 02 21:35:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEn1v-0003TO-MB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 21:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab2DBTfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 15:35:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36300 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab2DBTe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 15:34:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10C8F6221;
	Mon,  2 Apr 2012 15:34:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=SX842fYfjGj14nw3epuA0Wrwexs=; b=gAzgXZk2F31y+DO9D/Tz
	eAotRgBBLH16Lnv7/PjkzhumevLu5oo5AMfVqGcq5ntgYHLblkkS9Muxl8GIfTX3
	jk84bRq+7EZ1pY+/c+6U1/HR7x8pqAtuMYRJe9wKc6GxJEtiy+S1Fg6Q/IB9irJj
	i6s8BSlTLDW5GHHIsy5AKpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=m3716vkKHSmDRI7d6tWJgK98Pimm+bA8/lQRZgwpHiT1HD
	1ciQ2kB0XhDgH7UTWMIF4iiXPOI88ARj2DO0hHaFwvw/phLnhEVEE9WnTQ39HqXq
	y9lfSN/WxlqBHfJIOA2FuCCzgGeAF4Yi0VFLoFOtnKRdwV67JYq0bJgVsU9Xw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0937F6220;
	Mon,  2 Apr 2012 15:34:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65F75621F; Mon,  2 Apr 2012
 15:34:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDFD1FD6-7CFA-11E1-8495-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194552>

Ivan Todoroski <grnch@gmx.net> writes:

> +test_expect_success 'setup tests for the --stdin parameter' '
> +	for head in C D E F
> +	do
> +		add $head
> +	done &&
> +	for head in A B C D E F
> +	do
> +		git tag $head $head
> +	done
> +	cat >input <<EOF
> +refs/heads/C
> +refs/heads/A
> +refs/heads/D
> +refs/tags/C
> +refs/heads/B
> +refs/tags/A
> +refs/heads/E
> +refs/tags/B
> +refs/tags/E
> +refs/tags/D
> +EOF
> +	sort <input >expect
> +	(
> +	echo refs/heads/E &&
> +	echo refs/tags/E &&
> +	cat input
> +	) >input.dup
> +'


This breaks && chain; also it is easier to read if indentation is used
properly.

I'll queue it after fixing the above locally (the rest looked OK to me).

Thanks.
