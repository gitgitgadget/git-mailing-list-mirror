From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/12] t9150-svk-mergetickets.sh: use the $( ... ) construct for command substitution
Date: Tue, 12 Jan 2016 11:59:45 -0800
Message-ID: <xmqq8u3utvpq.fsf@gitster.mtv.corp.google.com>
References: <1452599378-47882-1-git-send-email-gitter.spiros@gmail.com>
	<1452599378-47882-9-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ56f-00044g-7V
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 20:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbcALT7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 14:59:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751107AbcALT7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 14:59:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E54939005;
	Tue, 12 Jan 2016 14:59:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GMf0HxQBBRf4HOf5XhZ6d6Y1ryU=; b=HeeXxg
	DlHyIhcJg4qUGW3TELP1NLjF/Iz5c2Q9hgHU1yUkHcDouQEtAn57n5PLAIGwA/eI
	/rlMfSvXa6aUSZyuz/9GhMy8bQIUt1TTx7DdktWqVcMeHb6KAbl9fO1YuEnl2wpJ
	a+aU7otLbBO3V7MPaVWWTb4UWaxVD4EhZit4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K8fYmRVIhfPbC869VHYD3jFPNlENDr+G
	kmL7+CJMoBbuciSDzxh4bqwBdGhUqhg7R32zi26PSs8GHYQp0Oc7I1nV1i69Immn
	HHKOPxiszTKRi1Lu7A3ZSP0fl6TLRIyj9Kr8z0k5lZbyyektah3/U7DCNfANZrfS
	Fqgzaa5FDjo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EA3539003;
	Tue, 12 Jan 2016 14:59:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 10C5539002;
	Tue, 12 Jan 2016 14:59:46 -0500 (EST)
In-Reply-To: <1452599378-47882-9-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 12 Jan 2016 11:49:34 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07F33CDE-B967-11E5-A9A3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283841>

Elia Pinto <gitter.spiros@gmail.com> writes:

>  test_expect_success 'svk merges were represented coming in' "
> -	[ `git cat-file commit HEAD | grep parent | wc -l` -eq 2 ]
> +	[ $(git cat-file commit HEAD | grep parent | wc -l) -eq 2 ]
>  	"

Entirely outside of the theme of this topic, but this should be
corrected to use "test".

More importantly, the outer quote should become single quote.  As it
currently is written, "git cat-file" runs outside the protection of
test_expect_success when the command line of the test_expect_success
is formulated, which defeats the whole purpose of test helper macros
to run everything "git" inside them.
