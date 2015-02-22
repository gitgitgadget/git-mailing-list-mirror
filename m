From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [cosmetic bug?] needlessly(?) executable files
Date: Sun, 22 Feb 2015 10:44:12 -0800
Message-ID: <xmqqr3thwzur.fsf@gitster.dls.corp.google.com>
References: <1424540917.15539.24.camel@scientia.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christoph Anton Mitterer <calestyo@scientia.net>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:44:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPbVw-0003lw-UO
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 19:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbbBVSoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2015 13:44:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752041AbbBVSoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2015 13:44:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFB143891F;
	Sun, 22 Feb 2015 13:44:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kBi3CpQKZo5934brT3JyI6ojl/4=; b=jCTlS2
	i3VP4/p17MDNcU16/v4S0xO7S9k6ck4UmOgDsOTeq0QFaP+V8vfcm4aeOmjwIAxB
	x4e/CQBL+SzFQHHYi7dKolUOC5iaJ9s9Y1bIbpKrQE/9Q5FJ0K950zf2U7B3Q8iy
	5+U+NW60sj/LtJVIlumv+MLGDcxeKVehm1yLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HjjUpYqn+H/f3/kjY6p45sbh4JMluxIk
	u/vodRSteB1j4PNyKNatt35+Iz2enM38DrZBrdCmBGCqlvy6MTOQYaNSRdTTBxHR
	+jWppP2d+lqs6aBGvlQQSRzRusZ69rwDreIk0GJQAJ285iKi68pswWnVOSd1HfZc
	szTMd/CVKNU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D67AC3891E;
	Sun, 22 Feb 2015 13:44:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49F603891D;
	Sun, 22 Feb 2015 13:44:13 -0500 (EST)
In-Reply-To: <1424540917.15539.24.camel@scientia.net> (Christoph Anton
	Mitterer's message of "Sat, 21 Feb 2015 18:48:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CBC62490-BAC2-11E4-B9D1-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264235>

Christoph Anton Mitterer <calestyo@scientia.net> writes:

> Just a question about files like:
> .git/config
> .git/hooks/*.sample
>
> Is there any reason that these are created executable? Especially the
> config file?

In a new repository I just did "git init", I see this:

    $ rm -fr stupid
    $ umask 0027
    $ git init stupid
    $ ls -l stupid/.git/config | sed -e 's/ .*//'
    -rw-r-----

So no, config is not created executable.

> I know the hooks are already disabled by being named .sample,

I think that is deliberate, so that lazy people can just do:

    $ mv .git/hooks/pre-commit.sample .git/hooks/pre-commit

without one more command

    $ chmod +x .git/hooks/pre-commit

after doing so.
