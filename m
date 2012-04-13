From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 12:48:49 -0700
Message-ID: <7v62d32z1a.fsf@alter.siamese.dyndns.org>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
 <20120413091236.GC2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 13 21:49:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SImUL-00058D-HV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 21:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab2DMTsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 15:48:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756025Ab2DMTsv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 15:48:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A42B7FAC;
	Fri, 13 Apr 2012 15:48:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vHHGaQJ0nJ0p
	12Y7WnoC87frhls=; b=ZKqLzcjowphGIU20YJa3FlIJbFnevwVNUCfPQ2nlm9+Q
	0+i8AdDt7cdgrVwFUMAfYZ0kJvuYu7crZiA3/8XtUIgsGCkQHmoBQcU4Bu4KX2fu
	wwFU1GpsxPQAOgeefZK+/cYuLLW0IPYBZuo82dsxaq3pBOa8Gin3rS3NlK88+L4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qLjQ8k
	w14QARiW+91BxbQBmibc75KP632vx6+dj8NnomIfKwsoUR4kmu6Rd22WjrdfjI8v
	mfkWkacq9cdE76WQTL/iRCQvpO/XpYLRsfylZjnHkk8wUjyU2NIN3A/FiPgTd30W
	NQUVtYVZRfUyzBhrMFxt72OaNZ7onZYoQ9B7o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1837FAB;
	Fri, 13 Apr 2012 15:48:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEAC67FAA; Fri, 13 Apr 2012
 15:48:50 -0400 (EDT)
In-Reply-To: <20120413091236.GC2164@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of "Fri, 13 Apr 2012 11:12:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B158FCBC-85A1-11E1-A6E4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195440>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> +_get_comp_words_by_ref ()
>> +{
>> +	while [ $# -gt 0 ]; do
>> +		case "$1" in
>> +		cur)
>> +			cur=3D${_words[_cword]}
>> +			;;
>> +		prev)
>> +			prev=3D${_words[_cword-1]}
>> +			;;
>> +		words)
>> +			words=3D("${_words[@]}")
>> +			;;
>> +		cword)
>> +			cword=3D$_cword
>> +			;;
>> +		esac
>> +		shift
>> +	done
>> +}
>
> Git's completion script already implements this function.  Why
> override it here?

It is not "already implements" that I am worried about, but it implemen=
ts
it differently without explaining why, which is worrying.  I agree it
needs to be explained before the function.
>> +	# plumbing
>> +	! grep -q "^ls-files \$" out
>
> The && is missing here at the end of the line.

True.

>> +	run_completion "git f" &&
>> +	! grep -q -v "^f" out
>
> grep is not a git command, so I'm not sure, but shouldn't these use
> 'test_must_fail grep' instead of '! grep'?

"! grep" is fine.  We are not trying to catch the case where we break t=
he
implementation of "grep" to cause it to segfault.
