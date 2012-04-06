From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 06 Apr 2012 15:46:48 -0700
Message-ID: <7vk41szdev.fsf@alter.siamese.dyndns.org>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
 <20120406201926.GA1677@sigill.intra.peff.net>
 <CAMP44s0n+dyp-QNOPtiKtGX1VNOsM8GJOLLCksqwPArR+FS8ng@mail.gmail.com>
 <20120406213448.GA5436@sigill.intra.peff.net>
 <CAMP44s0VWWuM6eeij_nys9OAqu6Jr87Wv4K56mbbqhuMbVXKaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 00:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGHvk-0007hm-LT
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 00:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257Ab2DFWqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 18:46:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658Ab2DFWqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 18:46:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291047339;
	Fri,  6 Apr 2012 18:46:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tPDfFtAIsTXJrV6qG1Fww5KUbL0=; b=ahs5lY
	Rc3pqXmdotVgRb1XBcGciIsOI79qchjX6rHhFLqePWvQBFpTZBpuEcE0crDK/06l
	E6f2gW+od/vDsuQ+/j0J4zmW07SE+g8ASdcy/M/6+3P+omiwSralWfryXgfI+XW4
	c8LtMhfzgSWNbyaFfunlbEDngVTBXOD03lf20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fkGPWLOEE7bhtKZW+abIpa1+sV9RoHFU
	N2NEFXr+WnzmmejRf7pO9YSIV784zOtL6gNnT4QHzk3/Aon/Lp3/KnH3U/fVQnmD
	+UK+pkrw2T39Sqqr3VqHI5bCq41R0afRtLc2E/Z0XhmVzDaPpCqBtIPJBVDWJ4Dw
	xhnzOIrdRVI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C7B7338;
	Fri,  6 Apr 2012 18:46:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F2427337; Fri,  6 Apr 2012
 18:46:49 -0400 (EDT)
In-Reply-To: <CAMP44s0VWWuM6eeij_nys9OAqu6Jr87Wv4K56mbbqhuMbVXKaQ@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 7 Apr 2012 01:05:51 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 656DB6F6-803A-11E1-88F0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194920>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sat, Apr 7, 2012 at 12:34 AM, Jeff King <peff@peff.net> wrote:
>
>> But my point still stands that you cannot assume that you are running
>> bash, and you need to either find bash, or gracefully exit the test
>> script if it is not available. Anything else will cause "make test" to
>> fail on some systems (and indeed, applying and running your test, it
>> breaks "make test" on my debian box with dash as /bin/sh).
>
> So? 'make test' fails on my Arch Linux box which doesn't have
> /usr/bin/python, which is presumably why there is NO_PYTHON.

If you "git grep NO_PYTHON", you would notice that t/test-lib.sh does have
a provision to set PYTHON prerequisite, so fixing it presumably is just
the matter of marking appropriate tests with the prerequisite, no?  Which
ones are broken for you?  Complaining about it in a thread that does not
directly related to that "on a box without python some tests are broken"
issue is a very good way to leave it unfixed.

> Instead
> of doing some nasty hacks such as 'bash <<\END_OF_BASH_SCRIPT', it
> would be much easier to have a NO_BASH option. And in fact, when zsh
> completion tests are available, NO_ZSH (probably on by default).

"The box does not have bash" and "The builder does not wish to let the
scripts run with bash" are two separate things.  SHELL_PATH is often set
to /bin/dash even on a box that has /bin/bash because it is much faster to
run scripted Porcelains with, but the end user of the resulting build may
still want to use bash in her interactive session.

For this "the rest of the script is all meant to test stuff written for
bash" test, I think the right approach is to explicitly detect the
presense of bash (i.e. "Can the end user run bash for her interactive
session?  Otherwise we cannot test and there is no point testing"), and
feed these tests explicitly to bash.  Perhaps by putting your bash
specific test in t/t9902/bash-completion-test.bash and calling it from the
t9902-completionl.sh script that is meant to be run with $SHELL_PATH, like
this:

== t/t9902-completion.sh ==
#!/bin/sh

. ./test-lib.sh

if bash is available ;# do *not* check if we are running under bash!!
then
	bash "$TEST_DIRECTORY/t9902/bash-comletion-test.bash"
fi

if zsh is available ;# do *not* check if we are running under zsh!!
then
	zsh "$TEST_DIRECTORY/t9902/zsh-comletion-test.zsh"
fi

test_done
