From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Make --full-history consider more merges
Date: Thu, 25 Apr 2013 09:51:33 -0700
Message-ID: <7vtxmu4kq2.fsf@alter.siamese.dyndns.org>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org>
	<1366658602-12254-1-git-send-email-kevin@bracey.fi>
	<7vzjwqny64.fsf@alter.siamese.dyndns.org> <5176B854.2000707@bracey.fi>
	<7va9ona77d.fsf@alter.siamese.dyndns.org>
	<7v61zb8j5d.fsf@alter.siamese.dyndns.org> <5179505F.2000108@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Apr 25 18:51:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVPOX-0004ya-2D
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 18:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759046Ab3DYQvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 12:51:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759020Ab3DYQvg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 12:51:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C78551999E;
	Thu, 25 Apr 2013 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VObRGv7RSlCo/aPpcRF70faJ81Q=; b=aH4Is/
	bM1zsek6PkrbUsWSGfzXWod1Cu9lY22iGawElYWQFIcty3ehZ1UKPxRgvNOrQNnQ
	5VL1e2kCPvt8HTzviK0+fG5iQTW7pFN0lIQwebit5fujMinTIJ+qTgbOrW6hE5BT
	eki480C5ckO3yM2SRPXvs4ddQf8jW2LZ012qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CW4DPcjp/7Cpoeq82LbnRmYvRslUCH4S
	JQqUhWPlaWXFmRGzgNOcdM6t8ZUbV/3jOTJixRyIpy4cPlsdTpMbtIzwU7WxYlR3
	Dtz+1YHY2w2GmU3RHFl03ChhBV142hkHaNxNjgDHVb7kiLzAbYIUrJUEX2dOuh4E
	v4mjfzAHm+k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBDFE1999D;
	Thu, 25 Apr 2013 16:51:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 409961999C;
	Thu, 25 Apr 2013 16:51:35 +0000 (UTC)
In-Reply-To: <5179505F.2000108@bracey.fi> (Kevin Bracey's message of "Thu, 25
	Apr 2013 18:48:47 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63B99462-ADC8-11E2-83BF-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222394>

Kevin Bracey <kevin@bracey.fi> writes:

> On 25/04/2013 04:59, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> So, given all that, revised patch below:
>> I tried to squeeze the minimum test I sent $gmane/220919 to the test
>> suite.  I think the "do not use --parents option for this test"
>> switch needs to be cleaned up a bit more, but it fails without your
>> patch and does pass with your patch.
>>
>> I somehow was hoping that your fix to TREESAME semantics would also
>> correct the known breakage documented in that test, but it seems
>> that I was too greedy ;-)
> Thanks for the test addition. Maybe we will be able to satisfy your
> greed in this series. There could be more worth doing here, and I
> think getting TREESAME precise is key.

It is perfectly fine to do things one step at a time.  Let's get
the --full-history change into a good shape first and worry about
the more complex case after we are done.
