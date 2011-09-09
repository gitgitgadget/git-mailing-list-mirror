From: Junio C Hamano <gitster@pobox.com>
Subject: Re: can Git encrypt/decrypt .gpg on push/fetch?
Date: Fri, 09 Sep 2011 12:05:00 -0700
Message-ID: <7vvct1tu3n.fsf@alter.siamese.dyndns.org>
References: <87lityxbg7.fsf@lifelogs.com>
 <CAGhXAGSw3y=cjAHXtwycDifoBPr13AkYtLHRRXejRKue0vkz7A@mail.gmail.com>
 <4E6A165D.5010703@drmicha.warpmail.net>
 <20110909184229.GE28480@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Aneesh Bhasin <contact.aneesh@gmail.com>, tzz@lifelogs.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26O3-0007Q5-JK
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759646Ab1IITFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:05:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758323Ab1IITFG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 15:05:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C07B24BB3;
	Fri,  9 Sep 2011 15:05:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CIfcdSMz1BicTfdpzwMNLKeimr4=; b=Nmo/jw
	mAem7xBoDrhTmzvNK4LJNuR9/hwUlZynFdpIefvb8u690y0EtjpCmw1qs52BbL5y
	yWH/GXokSeyacmhAzKtxAMsxR5FEALzCWByjq+DZdzi3IqOJcB7gV6PQ1xe6AKFc
	r9huqxMB6fT+jssJat0dxv2J1ZNA95nVg/ZBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ei067OUVYievEX/Y+TBf2lRVBmnniF0K
	fIwf3hsEBfvKZzdMo+Q5AgmnftyMzmsvA8IrL8d+Nvh+7nn+s7Jn7oMCayBJwmZc
	gB04HNTluU/yOoj6pQbvdTjFzKN/n2NqsQ7qbvQz/SnuqQ3cQxX5VyHHXqrgTalJ
	onwR7Yxmtsw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7BB64BB2;
	Fri,  9 Sep 2011 15:05:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA6A14BB0; Fri,  9 Sep 2011
 15:05:01 -0400 (EDT)
In-Reply-To: <20110909184229.GE28480@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 9 Sep 2011 14:42:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E99D10E-DB16-11E0-B73D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181105>

Jeff King <peff@peff.net> writes:

>> B) Keep blobs encrypted, checkout decrypted
>> - Use Use "*.gpg filter=gpg" in your attributes and
>> [filter "gpg"]
>> 	smudge = gpg -d
>> 	clean = gpg -e -r yourgpgkey
>>   in your config.
>> 
>> I use A on a regular basis. B is untested (but patterned after a similar
>> gzip filter I use). You may or may not have better results with "gpg -ea".
>
> Yeah, I think that would work but have never tried it either.

Unless "gpg -e" encrypts the same cleartext into the same cyphertext every
time, the above "clean" filter probably wouldn't be very useful.
