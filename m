From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/4] commit test: Use test_config instead of git-config
Date: Tue, 17 Jun 2014 14:35:51 -0700
Message-ID: <xmqq38f3kymg.fsf@gitster.dls.corp.google.com>
References: <cover.1403033723.git.caleb@calebthompson.io>
	<a7aa2efcb6a2beba973c389f5c7afbce79ec9747.1403033723.git.caleb@calebthompson.io>
	<xmqq8uovkytq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:36:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx12y-0006Xv-CC
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 23:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbaFQVgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 17:36:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57511 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964852AbaFQVf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 17:35:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D33E81F88B;
	Tue, 17 Jun 2014 17:35:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0zRQP30emayreTJE3F2r1lvCTK8=; b=Nls5i7
	9Zv/NxrEM0/8XmU5APM2KBnwPucFmDcdoE/OrjbxKbRHhSKooZfHxkN5YgLkn2xJ
	W5l4tB64CKuDRAn9YGEAeFPHRTRuJT6GIiE1AesGGO6BOCxtAfKaA+7SiTMKFBRY
	b2/wEpD3BQIv7bQxTk6Taw/CkYcoe77epP8Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IB/iKbQO3QiK8MGGrGp4xQYQtmMaLC5Y
	rijTsYHbSsNTFvJ+Xmd7whmTnK7vHr8GrnK0SCR7GeFBCrTtkLZzfTRChAoEmN1O
	iBSsLQx/lrw5PDaZ3WAbQ2cRDC9q4JHngQ5DE/8Cg30kl9aE3wLAe0Apw4EmBIqW
	ydi+eQVYl1E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C87011F88A;
	Tue, 17 Jun 2014 17:35:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 782731F888;
	Tue, 17 Jun 2014 17:35:50 -0400 (EDT)
In-Reply-To: <xmqq8uovkytq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 17 Jun 2014 14:31:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5A1AEF30-F667-11E3-B227-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251955>

Junio C Hamano <gitster@pobox.com> writes:

> Caleb Thompson <caleb@calebthompson.io> writes:
>
>> Some of the tests in t/t7507-commit-verbose.sh were still using
>> git-config to set configuration. Change them to use the test_config
>> helper.
>
> "were still using" is only a half of the story, and we need to be
> more careful than that, though.

I'd rephrase it like so if I were doing this patch myself:

    Subject: t7507: use test_config instead of git-config
    
    Some of the tests in t/t7507-commit-verbose.sh uses git-config
    to set configuration, but the updated variable setting does not
    have to be used in later tests.
    
    Change them to use the test_config helper.
