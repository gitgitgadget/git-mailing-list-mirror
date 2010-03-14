From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git status: ignoring untracked files must apply to
 submodules too
Date: Sat, 13 Mar 2010 16:07:45 -0800
Message-ID: <7vaaubzrxq.fsf@alter.siamese.dyndns.org>
References: <4B9C0AFB.1050306@web.de>
 <7vhboj6et9.fsf@alter.siamese.dyndns.org> <4B9C1AEC.2070605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sergio Callegari <sergio.callegari@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 14 01:08:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqbND-0008AQ-FJ
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 01:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759442Ab0CNAH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 19:07:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759431Ab0CNAH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 19:07:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66743A1054;
	Sat, 13 Mar 2010 19:07:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kl9lYChUTEn5jAA2k72orgkyIsI=; b=ABQqu4
	MglGe9iE6F1BkWInvmed+87r1MLJrGWz8ZnjmqZFrNP/gwlp+ezCkt+keKH8qbHW
	rmAqYxg1Z9CSU0ECXuYgeomCSSAxovdR6sbIVF4iFpMeVvHKQPDU1P4e6WQuGPwf
	em6Vh2NAjTFN8nYvfWQDOJqF78hYaZQPOjyUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rs9ono7f7MsoVQczUMaVhuDGOHihFuld
	yie4ywqUz6XqBzvTskrLAvUady3W43zxsNg3QKGKxpgGk89HK8yWOSIOlwVWFZkb
	JBpLdX5s1+6z9n7REoFw9l2dvvkyADRxdnu2hlE+JjEN05xC77/VQJxalkk1G9G7
	eIDJTSLWk6U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 374E1A1050;
	Sat, 13 Mar 2010 19:07:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94B62A104E; Sat, 13 Mar
 2010 19:07:46 -0500 (EST)
In-Reply-To: <4B9C1AEC.2070605@web.de> (Jens Lehmann's message of "Sun\, 14
 Mar 2010 00\:08\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0B132C8-2EFD-11DF-974B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142124>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> First: When called from "git status" run_diff_files() calls
> wt_status_collect_changed_cb() for every file it considers changed, so

This reminds me of another thing, perhaps independent, perhaps related.
Why aren't we collecting the submodule status in wt_status_collect() to
begin with?  It examines the submodule status in wt_status_print(), but
that feels quite against the way how the whole "struct wt_status" was
designed to be used in the first place, I think.  Would restuctuing the
code that way make this easier to handle?
