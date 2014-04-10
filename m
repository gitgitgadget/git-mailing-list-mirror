From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/9] Introduce publish tracking branch
Date: Thu, 10 Apr 2014 14:21:52 -0700
Message-ID: <xmqq38hkx4lr.fsf@gitster.dls.corp.google.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 23:22:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYMQ9-0003pS-P7
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 23:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935787AbaDJVV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 17:21:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935780AbaDJVV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 17:21:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B38C7B619;
	Thu, 10 Apr 2014 17:21:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Kr56t658K1Gv2OdCWbgY2uBWvMo=; b=b9ZSBE8ZMC57X2P0GK4d
	6t2aIcosvaoIIv6+05wcEppr6FfTTID+YOP754PVobeQvYXvasBxglY6G+EMUBNL
	Sct3ubN+MkRg+BxPOK0r4d8U5qst8wfnAWBM+/q6vmk2nukaWZFWNA+8TDwk12AN
	FxleU1oF0tIw691XbfnVUwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VGExHe1Rj+7eM81Fm69ohZLhKNZtI8mju+zKdzXDbcehkJ
	R4ZgkTYNkdETPpGmUq9e8lXQqNmVyhJhl2ys5XGDFsxj/AqXFw0Y0ZlTa8cogxqr
	okD+PtevKDfeXxfi6KuRfLPMlKAoqxVaWd4jNfS7BEj+xUaA12blY0F/St6fA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4854D7B618;
	Thu, 10 Apr 2014 17:21:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBEAA7B611;
	Thu, 10 Apr 2014 17:21:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 235E3804-C0F6-11E3-921F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246054>

A handful of minimum tweaks [*1*] here and there were necessary in
order to queue the series on 'pu', but to me, the feature looked
like quite a straight-forward addition.

I'd be dropping the jk/branch-at-publish-rebased from 'pu', at least
tentatively, as that one was primarily Peff giving Ram a base to
build on top to achieve essentially the same thing as this series
does.  I didn't bother to check if this series could have reused
some from that series (primarily because I was short of time, had to
take the work laptop to service, etc. etc.) before doing so.

I didn't think too deeply about the workflow ramifications of this
series brings in, either---that is left for the reviewers Cc'ed on
the patches.


[Footnote]

*1* Things like these:

 - the context in builtin/push.c has already changed at the tip of
   'master' (we already pretend to be Git 2.0) and the patch text
   needed to be adjusted.

 - an instance of cast to "(char*)" fixed to "(char *)". 

 - t/t5529 is already used by other topics, renaming the new test to
   t/t5534-push-publish.sh.

 - !prefixcmp() is already removed for Git 2.0, replacing its use
   with starts_with().
