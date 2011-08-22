From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: highlight: strip non-printable characters via
 col(1)
Date: Mon, 22 Aug 2011 16:21:44 -0700
Message-ID: <7vmxf1t4l3.fsf@alter.siamese.dyndns.org>
References: <1314053923-13122-1-git-send-email-cfuhrman@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, cwilson@cdwilson.us,
	sylvain@abstraction.fr
To: "Christopher M. Fuhrman" <cfuhrman@panix.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 01:21:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvdoX-0005mH-3j
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 01:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab1HVXVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 19:21:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab1HVXVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 19:21:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 350564CC2;
	Mon, 22 Aug 2011 19:21:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PBQaduiEv3fZYX/xPJzCkGOTxKI=; b=euXWn3
	Zt6yMdxUAJ4/5UZFtKKATsnxurVn4qm2gBFk+qbZCCX5+8JRTQSRqepSSFBnnnGt
	gW90sLolAMGeRZGmWL7Z9yrFEWAUudtFizPNEMCBlfKaXiC5crLpRFRKwXi/iZw9
	Ep9/OK/FUA+e7gXWNXFeI/cgV+QNdXJe0x/i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mNk4sGi7vndaO1IxzXlgPuk2vfiOYRTH
	wChqKjSNhUCGM7WCM0aloeYf12TSMM2r4Va2xpDXgwLuAT9qnWBwZMRXVTvdMdAa
	kzYOJyjZnaBuRBZhBsg3ZFySSozIOfOLBbilRypWzmdQAE3NLqX+MyqEmXbh3JwY
	g7tHjyRjGoE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B74E4CC1;
	Mon, 22 Aug 2011 19:21:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3E9E4CC0; Mon, 22 Aug 2011
 19:21:45 -0400 (EDT)
In-Reply-To: <1314053923-13122-1-git-send-email-cfuhrman@panix.com>
 (Christopher M. Fuhrman's message of "Mon, 22 Aug 2011 15:58:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80A5FA06-CD15-11E0-9156-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179903>

"Christopher M. Fuhrman" <cfuhrman@panix.com> writes:

> Strip non-printable control-characters by piping the output produced
> by git-cat-file(1) to col(1) as follows:
>
>   git cat-file blob deadbeef314159 | col -bx | highlight <args>
>
> Note usage of the '-x' option which tells col(1) to output multiple
> spaces instead of tabs.

Are all implementations of col known to correctly handle bytes with their
highest bit on, without mistaking them with unknown control sequences?
Has the code updated by your patch been tested with non-ASCII payload, at
least with UTF-8 outside US-ASCII?

In what locale does the code updated by your patch run under, and would
the use of "col" affected by the choice of the locale in a negative way?

For example, here is what I get on my box:

    $ LANG=C LC_ALL=C col -bx <t/t3902-quoted.sh ; echo $?
    col: Invalid or incomplete multibyte or wide character
    1

that makes me ask you these questions.

> I haven't gotten any responses to my patch for a while, so I am now
> submitting this for general inclusion into git.

Unfortunately, no news is not good news around here, and that is why I
am asking you the above questions.

Thanks.
