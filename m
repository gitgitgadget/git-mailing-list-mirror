From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] git-send-email.perl: Deduplicate "to:" and "cc:"
 entries with names
Date: Fri, 26 Nov 2010 10:34:36 -0800
Message-ID: <7vmxowq6gz.fsf@alter.siamese.dyndns.org>
References: <1290272809.27951.30.camel@Joe-Laptop> <m2mxp3zr88.fsf@igel.home>
 <1290286877.31117.15.camel@Joe-Laptop> <4CE84FF3.2070906@pcharlan.com>
 <1290294365.31117.40.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Harlan <pgit@pcharlan.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 19:35:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM38K-0002SB-Cw
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 19:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171Ab0KZSev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 13:34:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497Ab0KZSeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 13:34:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9287B2006;
	Fri, 26 Nov 2010 13:35:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=KjK4ztKs5knOEwoIb+5pdd3pMgs=; b=k9/v7N6djOW/zNFpSzhf4HQ
	VZj7HlLfy06buKX2omHblCnccRKXmjmjrrzzGt7mHRLPHhnTxnfx5G+z95bjQvJ6
	5T7XOeZ2PAYFkq3ubbexm4UDtJJwvct4EerE7J1pQQtTfNtvXVhPaihRQBehpdQd
	Q8+rLIv3Ka3YLoWDbKjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=m+YNVvDm+e9ttE/Ij5X0l/cqSkjqo+ceiFe1qCy8lEef5Pbus
	zqWuvHxIudLQ2Tecq+KmMqzkLfeu10X6FL7Rj+W+n36hrWNJRk8jzwZcFwGIkWNr
	CkGpEIK0waj93yk+QnXb90kM1NAp4gMiz0Q3CWL1+bBQKJgzq5o0Hp/uXw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 421D22005;
	Fri, 26 Nov 2010 13:34:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B40D42004; Fri, 26 Nov 2010
 13:34:53 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DFA465AA-F98B-11DF-820A-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162271>

Joe Perches <joe@perches.com> writes:

> If an email address in the "to:" list is in the style
> "First Last <email@domain.tld>", ie: not just a bare
> address like "email@domain.tld", and the same named
> entry style exists in the "cc:" list, the current
> logic will not remove the entry from the "cc:" list.
>
> Add logic to better deduplicate the "cc:" list by also
> matching the email address with angle brackets.

Thanks; this is an improvement from the current behaviour.  We do cull
duplicates if you have the same address listed on @cc twice, but we don't
do the similar culling between To:/Cc: headers.

I wonder if we should remove addresses from To: and Cc: if the same
address appears in @bcclist, by the way, but that is a separate topic.

Thanks.
