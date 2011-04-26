From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Implemented return value for rev-list --quiet
Date: Tue, 26 Apr 2011 16:47:46 -0700
Message-ID: <7vpqo8bmn1.fsf@alter.siamese.dyndns.org>
References: <4DB748F5.4050300@boolsoft.org>
 <7vwrigbor6.fsf@alter.siamese.dyndns.org> <4DB755D2.10303@boolsoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Gehring <jonas.gehring@boolsoft.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:48:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QErz7-000419-JY
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 01:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab1DZXr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 19:47:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab1DZXr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 19:47:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CFAC5DE3;
	Tue, 26 Apr 2011 19:49:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wD5cedgQMrnSiAx7ENsirOtuqpI=; b=W2Z9Jr
	ILI5XMvl7AIgtQItBCsWFVEn2lSOSpPqVsmOQlQGhkmu7zBLmnOIGq/corr/xLiW
	37i6ZAIQaurktSZC7xMvovyB1unVoMMvmuAQ+Wr3+DpEJkXed0Cc945VPRSQlwqY
	gduQnOxU8ZodlntIUTwXvUtvN2TMCWX6RNGK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UtbTcaL6K0mPOiF120AwDHd1u8ANUzNY
	HGY/xDRWwppHiodj70th8j/x/PkQDSwRQXOnRXMSsvl47zsCNSYkn5SPLZJLhgf/
	dv6e72X6IAJt+xHUio0t3jvK2JvJODIaPEYfz0C9D5main5Gust1sxEa4xLubTUd
	GeQv88jBeDM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C43F5DE2;
	Tue, 26 Apr 2011 19:49:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5D6C65DE1; Tue, 26 Apr 2011
 19:49:51 -0400 (EDT)
In-Reply-To: <4DB755D2.10303@boolsoft.org> (Jonas Gehring's message of "Wed,
 27 Apr 2011 01:31:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E246E2E2-705F-11E0-BD00-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172136>

Jonas Gehring <jonas.gehring@boolsoft.org> writes:

> Thank you for this explanation, this really cleared up the intended
> ... I wanted to use it for ancestry testing of two
> commits,...
>
> After some additional digging, I realized that git-merge-base is the
> right tool for my task.

Either

	test "$(git merge-base A B)" = "$(git rev-parse A)"

or

	test -z "$(git rev-list -1 A..B)"

would be valid ways to see if A is an ancestor of B.
