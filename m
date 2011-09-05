From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable
 variable expansion
Date: Mon, 05 Sep 2011 00:15:44 -0700
Message-ID: <7v7h5nxxwf.fsf@alter.siamese.dyndns.org>
References: <8762l73758.fsf@elisp.net> <4E647442.9000005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 09:15:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0TPN-0001k2-JB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 09:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009Ab1IEHPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 03:15:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844Ab1IEHPq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 03:15:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8572F5FCD;
	Mon,  5 Sep 2011 03:15:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OD1GmMNa+PMCmxk2ZyO6DCF2qeQ=; b=QkvatS
	NMo+pApfuS4ONMUH7KcAKZWp99W8Fna3JxrHy4X9IyuF5khiEeSFztK7Jie/EaQk
	u62FwDLEsxhlcFRQO4RQcmV1JunK5xSFz4tmBMllAnT2sYQzdsmB1L8MxWZNqrwn
	/wvi//6rCPlcfrXv09VCNdHmc562SqG923exA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=veClWPey8fvbBRJ4M9lrHn7Dic2GryvC
	Uc3sKCCPRJej2Qlg8CuLUBFviseHp6Lioz4H9PcIab2rzC/o3tzOAUms87ZWc9DX
	canh0Dp79HoD3X1wnV+2o9D/BYxrN0PixYvIncaf9HjgMQclLLkVyu3HZXg10zVZ
	oV3JuHrRM6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CDCF5FCC;
	Mon,  5 Sep 2011 03:15:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 118E35FCB; Mon,  5 Sep 2011
 03:15:45 -0400 (EDT)
In-Reply-To: <4E647442.9000005@viscovery.net> (Johannes Sixt's message of
 "Mon, 05 Sep 2011 09:03:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFC77680-D78E-11E0-B29A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180721>

Johannes Sixt <j.sixt@viscovery.net> writes:

>>  run_backend() {
>>  	echo "$2" |
>> -	QUERY_STRING="${1#*\?}" \
>> -	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*}" \
>
> What happens if you write these as
>
> 	QUERY_STRING=${1#*\?} \
> 	PATH_TRANSLATED=$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*} \
>
> i.e., drop the double-quotes?

Interesting. Your conjecture is that the shell may be dropping the
backslash inside dq context when it does not understand what follows the
backslash, i.e. "\?"  -> "?", losing the quote. I find it very plausible.

If that is the case, either the above or my [?] would work it around, I
would think.

Thanks.
