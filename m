From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] attr.c: respect core.ignorecase when matching
 attribute patterns
Date: Wed, 12 Oct 2011 13:24:49 -0700
Message-ID: <7vaa967yb2.fsf@alter.siamese.dyndns.org>
References: <4E93BBA8.6080403@alum.mit.edu>
 <xdU4uj1WkogEVU_JDz3kmxkX_eFz1cDWrEbnJirB8aZT-27u7JCY41omRSEEBC62anWl8YRgN2o@cipher.nrlssc.navy.mil> <7v8vorh3kg.fsf@alter.siamese.dyndns.org> <y0zSE7mQNTqQ3B_hRG_UvK2pQCTYIP8jr_bGkjb8qdCqyfJ544ZQhQCmwkL-_MxlparVZWmDgqL7VO68y3trgjciKw2QRAK_j7KNVcXXJW0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Oct 12 22:24:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE5MH-0001HY-LD
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 22:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab1JLUYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 16:24:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44942 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405Ab1JLUYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 16:24:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6D43644A;
	Wed, 12 Oct 2011 16:24:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a/K0DD5P9Kk6nOePgFcYWohqyFk=; b=RpnzEI
	Pp713W3gjY3t4hwbQI3SRjyXG8MhumPLK43DiCUG6Pue7ejWvXL1TJo+585k2eXe
	+uSbvkCTN4sYbfLeIc5r7rzxzQjw9MbSJMeTMQVKZ8sTt3uDnNV0CYMwG9Vh0eed
	OD0u9vGbyMsVTcSisfZoN9uM5MYbsNi7oY0CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HzaWExHo/2YMoTvYU14wFdn03RUG5b5d
	LGegQuarHBSAEv1r9ww63iw8i02iPRtRd3gLx1C5+7IRO5Et4b+5nvBYSIIx6YMX
	HBCXKUSAYtT2e7+Fl39rP71vTBGR7odcWgu+MPbb01TqWS5mnl4Peynl9OWc1Wa0
	wDTurVqAgmM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE70B6449;
	Wed, 12 Oct 2011 16:24:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6402B6448; Wed, 12 Oct 2011
 16:24:51 -0400 (EDT)
In-Reply-To: <y0zSE7mQNTqQ3B_hRG_UvK2pQCTYIP8jr_bGkjb8qdCqyfJ544ZQhQCmwkL-_MxlparVZWmDgqL7VO68y3trgjciKw2QRAK_j7KNVcXXJW0@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 12 Oct 2011 15:18:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D156484-F510-11E0-BE89-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183412>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> On 10/11/2011 11:54 AM, Junio C Hamano wrote:
> ...
> Maybe that last paragraph in the commit message should just be dropped.
> I think the preceding paragraph explains the purpose of the tests, and
> this last one doesn't really add any value.

I wasn't saying the description was wrong per-se. It only makes difference
for "git check-attr" users, but it still _does_ make difference for them,
I think. So I kept the paragraph in the end.

> Do you want me to resubmit or can you fix it up?  I ask not because I
> am too lazy to do 'commit --amend' myself, but because you may prefer
> to receive one less patch in your inbox if you can easily apply the
> change yourself.

It doesn't make much difference to me, as long as I don't forget a simple
and no-brainer amend I am supposed to do myself ;-).

Thanks.
