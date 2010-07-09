From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Thu, 08 Jul 2010 17:06:49 -0700
Message-ID: <7vlj9lo6w6.fsf@alter.siamese.dyndns.org>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de>
 <7vy6dx90uk.fsf@alter.siamese.dyndns.org> <4C2AE04E.9090901@viscovery.net>
 <7v1vbn417d.fsf@alter.siamese.dyndns.org> <4C2D7DF7.8030408@viscovery.net>
 <7vmxu923up.fsf@alter.siamese.dyndns.org> <4C31757A.1000207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 02:07:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX17Z-0006Dn-CV
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 02:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758959Ab0GIAHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 20:07:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759217Ab0GIAHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 20:07:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 354A5C27A0;
	Thu,  8 Jul 2010 20:06:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3C11zZQ0dd+QQZ2/yDiXxdXQ60M=; b=aEmzNL
	RezxqKHPVR0TTzhZQxDyKCshawHsNOsND0zDSDvpeLNUdKZauWfF4/gEMkoZXkon
	JLycgDWThMSqAMESb6849CMiLl367BFK43KNUPmR7zZUjHanAyIbgQJ08deRthnr
	im3+rKBrCJpa1tFeJNkJ6aHJxZYRJWjQshN/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xwdmjP++0Abn8+9LCLH63EBPBJn4gcWj
	gaWqZt0D/lfJ1/NCkeVOhoOextznrE2TRfZ83KhllT6bPP7m1o2ZT3NEkufqfQYK
	1QDLxXYmSM3tvIaKERyRikDUp8SQE2tj16eP9LkCUrF+EJe5ZfsRvd1ab1HooEDb
	VyMlOph1uX0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F11AAC279D;
	Thu,  8 Jul 2010 20:06:54 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38A98C2799; Thu,  8 Jul
 2010 20:06:51 -0400 (EDT)
In-Reply-To: <4C31757A.1000207@viscovery.net> (Johannes Sixt's message of
 "Mon\, 05 Jul 2010 08\:02\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E218D094-8AED-11DF-8B3A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150622>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 7/2/2010 19:25, schrieb Junio C Hamano:
>
>> I'd rather see "preimage"
>> timestamp to keep track of the time when we _first_ encountered the
>> particular conflict, and "postimage" used for recording the time when we
>> saw the conflict most recently.
>
> That would be fine, too.

Ok, then let's make it so ;-)
