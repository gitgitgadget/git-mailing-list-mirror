From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Sun, 29 Jul 2012 14:59:26 -0700
Message-ID: <7vfw8aut35.fsf@alter.siamese.dyndns.org>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
 <7vwr1ozxz5.fsf@alter.siamese.dyndns.org>
 <CAHOQ7J_jYAe7r1q6Cg9OJb8f+79UfS=JfRk9NrS4R4a+oLM8LA@mail.gmail.com>
 <7vk3xoyeex.fsf@alter.siamese.dyndns.org>
 <20120728105159.GB13370@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jul 29 23:59:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvbWQ-0007Gb-Jy
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 23:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab2G2V7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 17:59:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753691Ab2G2V73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 17:59:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2264A8FA1;
	Sun, 29 Jul 2012 17:59:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hL2NWC/kMX/WvGH52dJyIhDZCYc=; b=xy/giO
	DAnQnCvH7yka5Mj5Lwa2vjxZMd2YmOOTn/N2imcrHmRNjEBa3+gQFaTnmYHy/7tV
	hZl/EtNyKaag/OhtjJVaQUU+3ZZVBOQalQK479kEXYmla77pfg/D74NCAcDH7qWi
	lTrge3YYW8m0CN03/VW1B65m/44sIfp5qyBQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gTi6Mo7QO6IuGkr0zIyuiPTG+hr6+35a
	genGiV8AJDur9XZuY1PsXKZZL61Z6tTMZY4jmQHchoqfNboLphViPirE2+MKKam/
	ESfdOZMbL6VszzIamfvRTcIY5UefMHjvFBPiYw5zHmYq0CnKvMGz46JdiR+G1bv0
	14ivcPuzUyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10BAB8FA0;
	Sun, 29 Jul 2012 17:59:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 821788F9D; Sun, 29 Jul 2012
 17:59:28 -0400 (EDT)
In-Reply-To: <20120728105159.GB13370@book.hvoigt.net> (Heiko Voigt's message
 of "Sat, 28 Jul 2012 12:52:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB1E51FA-D9C8-11E1-AD76-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202503>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Fri, Jul 27, 2012 at 04:25:58PM -0700, Junio C Hamano wrote:
> ...
>> Of course, any set of rules have exceptions ;-) There are a few
>> things to which we say "Even though it is not in POSIX, everybody
>> who matters supports it, and without taking advantage of it, what we
>> want to achieve will become too cumbersome to express".
>
> I was about to write that since this is limited to a given --jobs
> options the majority platforms should be enough as a start and others
> could add a parallelism mechanism later. Its only a matter of efficiency
> and not features.

As long as "git submodule --jobs 9" on a platform without GNU
enhanced xargs does not error out and gracefully degrade to non
parallel execution, I do not have any problem with it.  As posted,
the patch has not yet achieved that doneness yet.
