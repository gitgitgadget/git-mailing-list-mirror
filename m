From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Detailed diagnosis when parsing an object name fails.
Date: Sun, 06 Dec 2009 16:30:16 -0800
Message-ID: <7vtyw3bp7r.fsf@alter.siamese.dyndns.org>
References: <1259784061-25143-1-git-send-email-y>
 <7vljhj4wv0.fsf@alter.siamese.dyndns.org> <vpqhbs4dkjr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 07 01:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHRVz-0004Cy-7O
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 01:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934509AbZLGAai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 19:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934518AbZLGAaW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 19:30:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934424AbZLGAaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 19:30:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8311A856C3;
	Sun,  6 Dec 2009 19:30:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=4vvzIQWH7rIOkNJwKhSGGsrIwDs=; b=rWWH1SLeuYqVHMJR6FG6o7V
	RkPSMbE/QpKRgvY8Y2pl1lGi+DxIwP99VBABOtnGT43y2A1O3BB/llF1jm6fxnbt
	wdvMWeRmbe8iKkqAqDcGb89FNfQ6/d3yw4rGk8XBkLy55i9+hGpg8BmvrllmVibu
	Qp/6xklecxIt1baIjUDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Mc5HcacQNEe1/SZn/m77z7Q636mzLtxp52wmZDbBuegGSVkau
	g+U1AjnWnTyqMtlzd3JjyLxAMN6owuXLYlYaxD1mH9D2elPc7taOW5y0yO3Y13ys
	gE7FRpaUTvJAJsrWfK3obA91bESwx+gGGfy0VVGXYPJtZuzc13DR69yYpM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6205F856C2;
	Sun,  6 Dec 2009 19:30:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0182856BA; Sun,  6 Dec
 2009 19:30:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B363045A-E2C7-11DE-8488-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134702>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> +extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int fatal, const char *prefix);
>>
>> Do I understand correctly that "fatal" here is the same as "!gently"
>> elsewhere in the API?
>
> It seems it is. I renamed it.

This was a pure question, not a suggestion to change it (we do name a
function do_foo_gently() when there is do_foo() that does the same but
reports errors more noisily, though).  I found the name "fatal" a bit
confusing as I at first couldn't tell if the caller was telling the
function that it already detected a "fatal" error (and telling the
function to report the fatalness) and didn't realize that the caller is
instead saying "if you find an error, treat it as a fatal one" until I
read it again.

I am Ok with the new "gently" name with the negative semantics as well (I
see no need to change it back to "error_is_fatal").

Thanks.
