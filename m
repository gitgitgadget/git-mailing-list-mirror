From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Doing a git add '' will add more files then expected
Date: Mon, 17 Nov 2014 11:08:26 -0800
Message-ID: <xmqqh9xxy79x.fsf@gitster.dls.corp.google.com>
References: <CAMDzUtyhNKdzHQK2zLEutJRcRUibhO-U6Zh0yJhrx-YxBqP5cQ@mail.gmail.com>
	<87lhn91ynu.fsf@igel.home> <vpqa93p8y9n.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Guilherme <guibufolo@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 17 20:10:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqRhG-0007fs-F0
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 20:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbaKQTKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 14:10:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752859AbaKQTIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 14:08:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D8581F405;
	Mon, 17 Nov 2014 14:08:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yls1fl+/Yg8B3SgXSzEc0puVGyA=; b=ICp+Es
	fl+qcaiwNHE0fj18u88dRKiQgttHM6XUxJpvF9N70Ypprzac9YPXwC3YjXph/zEi
	xYL82gBMhDVAhcoatFLUoKWe41r2tKAgbxs8iAQ7F8rzOSVBiXbfAU4o0I+DqpyX
	5U8WtQKk8Xwz6LEKI4fenTfc+DyAH2R7bIyd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=guHs8uRJLt7cqgTBqNLbKA8TzuWIykGk
	zkGDZ5OQyu7EIxQ1S+vRFlVnbckb6zYBAbvfUSnqfSrxer+P9qYS0xHUIq1hHx1k
	P4j8/yFd77h8E00LA9r97R5N8Q8PJMGIbwa8pCbdWdRgVH2oA5IXQT7+xELepaxo
	WKpAJiY2L84=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54D631F404;
	Mon, 17 Nov 2014 14:08:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 075581F401;
	Mon, 17 Nov 2014 14:08:29 -0500 (EST)
In-Reply-To: <vpqa93p8y9n.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	17 Nov 2014 19:42:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DFB16BC-6E8D-11E4-9D58-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> The argument to git add is a pathspec, and the empty pathspec matches
>> all files.
>
> Err, why does the empty pathspec match all files? Isn't that a bug?

That is debatable.

    cd Documentation
    git add "a"

would be equivalent to typing

    git add Documentation/"a"

so

    cd Documentation
    git add ""

would be equivalent to typing

    git add Documentation/""

And doing the same from the top-level of the working tree can be
argued to be a natural extension.
