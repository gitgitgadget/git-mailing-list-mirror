From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] refs_from_alternate: helper to use refs from
 alternates
Date: Fri, 11 Mar 2011 15:32:34 -0800
Message-ID: <7v62rpfd2l.fsf@alter.siamese.dyndns.org>
References: <1299876671-12838-1-git-send-email-gitster@pobox.com>
 <201103120008.27973.j6t@kdbg.org> <7vaah1fdv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 00:32:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyBpF-0006D0-7V
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 00:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab1CKXcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 18:32:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab1CKXcr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 18:32:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3ECC412A;
	Fri, 11 Mar 2011 18:34:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m80FNMbCTkNoZDwO7gwOhzzOsbc=; b=Bltx9S
	2M60hx8Xyl+y189pK/1+88wT7dTrX/jlU1xoHVadWb29yIpJxZD9x3ge/gSwS9mZ
	+hHjwriXisXhGc46/9Z2U9TrZiMLMejGM1hR3/PFtZne+8/oFCVuGeUEcHhbikWd
	83QQZPkQ2qx1OhfAr9ScC4LcYUuMuUJYefzGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b8LIBqBBhW9SbrO2eoxiA34H6d1NKhGB
	0C8SJ9Od8qfvpusYqz1a0GF2Va1ckxzef/rbvsn+Gjo01mrtE2cQ6DtOcFYt8hcM
	73YDEWFQDLU2cqTjGsASI3vBg7yEUKxJogfwEk6AfevWN2PeNR7bylfNtHhykuyu
	yANpaNoV1R8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9475F411B;
	Fri, 11 Mar 2011 18:34:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 85B114117; Fri, 11 Mar 2011
 18:34:05 -0500 (EST)
In-Reply-To: <7vaah1fdv8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 11 Mar 2011 15:15:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 116BD628-4C38-11E0-B6E4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168934>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Can we have this without using dc? (We don't have it on Windows.)
>>
>> diff --git a/t/t5501-fetch-push-alternates.sh 
>> b/t/t5501-fetch-push-alternates.sh
>> index 564ef7c..eb844cf 100755
>> --- a/t/t5501-fetch-push-alternates.sh
>> +++ b/t/t5501-fetch-push-alternates.sh
>> @@ -4,13 +4,11 @@ test_description='fetch/push involving alternates'
>>  . ./test-lib.sh
>>  
>>  count_objects () {
>> +	echo $(( $(
>>  		git count-objects -v |
>>  		sed -n -e 's/^count: \(.*\)/\1 +/p' \
>> +		    -e 's/^in-pack: \(.*\)/\1/p'
>> +		) ))
>>  }
>
> What does that do when there are only loose objects without packed ones?

Ahh, Ok, we always say "0", so that is not a problem.  Will squash in.

Thanks.
