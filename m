From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 08/11] trailer: add tests for "git interpret-trailers"
Date: Tue, 01 Apr 2014 15:54:44 -0700
Message-ID: <xmqqa9c4y823.fsf@gitster.dls.corp.google.com>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
	<20140401192023.353.56221.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 11:11:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVdej-0004JW-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbaDAWys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 18:54:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbaDAWyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 18:54:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89A1179BCF;
	Tue,  1 Apr 2014 18:54:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=g0LVErlbktd19xkBIBSx5IsvGc8=; b=ihLhkW6uM6hxEE9pUjX1
	pO0Zqb0LUE6RPtR4XBlnysUCIUP0ZfybsvDSrakNUnqbKmVwlJIEO8s0RKkRacft
	vS92VT3oJLZRfNUqxOIdE7hqQh+7m13Kn23gASgdLTVx08VTjwVLsA/GtZn0rUR8
	BfkQxnL14rV7gS1zt8zD7eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=acSzFlgVgU54XIcXHTBlVp42/6Qbey+Ny1PiWBBuglnEzO
	X2YTarI5ddrFbTko6OmmEfWAjRWw4eOjH3myypS7LszqUlktVc26c2xCYZhr0KZS
	g5/OUpcOoDMP9Y9sa/N7n2uv5bFp+InMJAR7bJSEOKvZii9Ng/ZWU2MtIVQLI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7857279BCE;
	Tue,  1 Apr 2014 18:54:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C236679BCD;
	Tue,  1 Apr 2014 18:54:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9EC1B802-B9F0-11E3-8F07-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245666>

Christian Couder <chriscool@tuxfamily.org> writes:

> +test_expect_success '--trim-empty without config' '
> +	cat >expected <<-\EOF &&
> +		ack: Peff
> +		Acked-by: Johan
> +	EOF
> +	git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
> +	test_cmp expected actual
> +'

Let's avoid these overlong and unreadable lines by doing something
like this (just one hunk shown for illustration):

 		ack: Peff
 		Acked-by: Johan
 	EOF
-	git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
+	git interpret-trailers --trim-empty "ack = Peff" \
+		"Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
 	test_cmp expected actual
 '
 

I've queued the series on 'pu' with the 'chop-overlong-lines' and
another minor fix squashed in; hopefully we can merge to 'next'
soonish.

Thanks.
