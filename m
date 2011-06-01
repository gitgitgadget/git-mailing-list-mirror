From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Tests for some submodule corner cases.
Date: Wed, 01 Jun 2011 10:44:45 -0700
Message-ID: <7vboyhh2eq.fsf@alter.siamese.dyndns.org>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com>
 <4DE541EC.7010202@web.de> <4DE55857.3090706@xiplink.com>
 <4DE55D0F.1020905@web.de> <4DE664A1.5060206@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 19:45:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRpTZ-0007S1-Sl
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 19:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759012Ab1FARo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 13:44:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab1FARoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 13:44:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37EAB455A;
	Wed,  1 Jun 2011 13:47:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0GxhNQeTAH30g/sQaMO9WLEeAkk=; b=IAHueX
	zNvMtm+OVMVh8FmNwfDX5ulnN+dtDfb5d6Y8gGdNittmQkK3nUZou1nQBIAHKGTf
	ZuTwNMjD8LSrZpzL1E9RR8X+eyDNydwrNkuB1vSZkCo/54bfQfcncQGNwf6K2k1g
	2GSCHXGwf+6HtFyGinKfu0nrLE4OZX2gd8rnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qj5vGmhnViXDWcrXF7xbAa2tVNtSbV86
	5IvrVXZeL0RkJM9tqx2m94cjpqgvkBtAsuefEOmj7V2EK2f9LEmEN62KyoaYoxh9
	MUCh6/ECEBWT+Xj1UFjN9ad1jg5/R/FNiHI7JBEt89a5jZoMOncf/4oQe5GSTDwB
	RXcYWRnWVG0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E971E4559;
	Wed,  1 Jun 2011 13:47:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B5C794558; Wed,  1 Jun 2011
 13:46:55 -0400 (EDT)
In-Reply-To: <4DE664A1.5060206@xiplink.com> (Marc Branchaud's message of
 "Wed, 01 Jun 2011 12:11:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 273EE9AC-8C77-11E0-9263-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174887>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Note that my automated builds don't really care about possibly-modified files
> or anything like that.  They just want the exact tree that corresponds to the
> commit ID recorded in the superproject.  (Previous builds might've left some
> cruft lying around, and the automated build wants to be sure that's eliminated.)
>
> Maybe I should just forego the status-checking altogether, and do "git
> submodule update path/to/sub && (cd path/to/sub; git reset --hard HEAD; git
> clean -dx)".

It really depends on what you really care about. If the working tree is
shared between your build-bot and a human user, the build-bot may want to
make sure it does not overwrite and lose work by a human, but otherwise,
instead of checking if something is stale (and having to design what to do
when it actually finds something is stale), actively causing the state it
wants to see appear in the working tree sounds like a simpler, more robust
and much saner thing to do.
