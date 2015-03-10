From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] help.c: use SHELL_PATH instead of hard-coded "/bin/sh"
Date: Mon, 09 Mar 2015 19:21:45 -0700
Message-ID: <xmqq7fup618m.fsf@gitster.dls.corp.google.com>
References: <38be9195b966a027cb050e5a1b47526@74d39fa044aa309eaea14b9f57fe79c>
	<0ebc0373b21c75fa88adb5aefd098e9@74d39fa044aa309eaea14b9f57fe79c>
	<xmqq61acsz7k.fsf@gitster.dls.corp.google.com>
	<C611A125-D641-46E6-A5AD-1010D70582F0@gmail.com>
	<20150309072040.GA28148@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 03:21:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV9nt-0003pd-7C
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 03:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbbCJCVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 22:21:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751138AbbCJCVs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 22:21:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75A483FD30;
	Mon,  9 Mar 2015 22:21:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MFh3YEd88OLon6m+6p3drlGPbXI=; b=P2LvDI
	sdyKmDTmICPvpwukSqj0Rc62Ije7mazgC/zeugwucnXvvc9vbuuxaNsv/PHKyrhw
	8PGkV4vslFS1vlpcU9FrCzEKf0Whwn80LrkMd/HzLswIzlEhZlaHaJWUh31wDbIf
	0DKegnFBGeHyqtw8Duxu9O7j8L3J5/GyifIkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HSUjErrUt06t3foXKKff/t5ZvOtKqHS9
	B8zdta/E1K6bxBkIR7u4ck8mHztanTaOLJfBnkNJY1N8fLUZ/XZ4k6zoykz/mwAm
	tJOWK97qIoQJtr0SRILj883RwXXil7rnXgbvd1T/ZoHPVY98Z31cUY5BAt2LSmqw
	Uvnxx+Tl4eo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C8A33FD2F;
	Mon,  9 Mar 2015 22:21:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC26C3FD2C;
	Mon,  9 Mar 2015 22:21:46 -0400 (EDT)
In-Reply-To: <20150309072040.GA28148@peff.net> (Jeff King's message of "Mon, 9
	Mar 2015 03:20:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 338D83EC-C6CC-11E4-BD42-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265206>

Jeff King <peff@peff.net> writes:

> However, that is _not_ what we currently do with run-command's
> use_shell directive. There we put SHELL_PATH as argv[0], and run:
>
>   execv(argv[0], argv);
> ...
> If we want to maintain consistency with the rest of our uses of
> run-command, it would be just your original:
>
>   execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, NULL);
>
> That makes the most sense to me, unless we are changing run-command's
> behavior, too. 

OK, then the original under discussion is fine as-is.

Thanks for sanity checking.
