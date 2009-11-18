From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unset GREP_OPTIONS in test-lib.sh
Date: Wed, 18 Nov 2009 14:05:53 -0800
Message-ID: <7v1vjvebem.fsf@alter.siamese.dyndns.org>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 23:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAsfC-0007yO-M9
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 23:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757081AbZKRWFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 17:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756813AbZKRWFz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 17:05:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690AbZKRWFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 17:05:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 48FB79F844;
	Wed, 18 Nov 2009 17:06:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=peWpolEUHNZ5LkBOxpX5WkqT2dQ=; b=KtxM1P
	if2S0AMSsgGRsXW7UudcUuXc02fA2xbFrbnD1mwo9F2FTDDqzxs//3a/ZabM1Ok4
	nrWIwLACoE5ahJXIXK7+2ZXVnAyTg9WWg7+jsl1ipSBsWFY7kMFKJyQeDcCZwxh7
	dhrD4BXwAQHmsvAXX2U17VtzU5c74nFy0npE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UCYCheaubMDyIWIlyhpjMvxGekjn0C0c
	ND0//SaGZU5Y7ZcbDGhc5f88Bbzg/fvmne0frLzhbHpO1Gqne1wyYJPhhUXv75F2
	OH85nPaz6J0Vb9AJ2ePzLGdF0GH8vg6m6HmxBG6HbnzL24kiK1MZnP0QOA1hCBC+
	zaekpI6Qqek=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 28A399F842;
	Wed, 18 Nov 2009 17:05:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B1C99F83E; Wed, 18 Nov 2009
 17:05:54 -0500 (EST)
In-Reply-To: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Wed\, 18 Nov 2009 17\:15\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8CD9EB1A-D48E-11DE-A39D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133202>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> I used to set GREP_OPTIONS to exclude *.orig and *.rej files. But with this
> the test t4252-am-options.sh fails because it calls grep with a .rej file:

Yuck.  Will apply.

That actually makes me worried about a different issue.

Do we kill that environment variable when we call out to external grep in
grep.c?  If not, we should.  An alternative is to teach our internal one
to also honor it, but I personally do not find it too attractive to mimic
the design mistake of GREP_OPTIONS myself.
