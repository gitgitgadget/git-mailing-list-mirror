From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] help: always suggest common-cmds if prefix of cmd
Date: Mon, 29 Nov 2010 09:44:41 -0800
Message-ID: <7vvd3g58ja.fsf@alter.siamese.dyndns.org>
References: <AANLkTinKDqykfuV5=oHav9PRehDtJZct_q=zm7p8PAeo@mail.gmail.com>
 <1290787239-4508-1-git-send-email-kusmabite@gmail.com>
 <7voc9bpqj2.fsf@alter.siamese.dyndns.org>
 <AANLkTin34AfYnFY5e9B1cuyckfLXU2=qXFciFaaNGt9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ziade.tarek@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 29 18:45:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN7n4-0000LR-Tm
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 18:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608Ab0K2Ro4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 12:44:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab0K2Roy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 12:44:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07A713F00;
	Mon, 29 Nov 2010 12:45:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jy/lkdUFN65TGS7MXsDmZ+NIK8Q=; b=HeEUd2
	yJW7vuy1UlJyxhgZk9Juj7IrmndM0khB/9JC/cRmPQwNxCc1N+QlxtvQ8T9sLrKp
	hks/txBBrztawV3q5WkieG+Rjj/wrYqq3NPqVtgch3WljXwwRm8eplk4k/EHw8T2
	PiWyXMPP+V/gEd9mhxy7T2XX/Dl3nfhHi6x+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b272LyEehqKdnBQIOG7qUg5D4RVHP6Mp
	RuHH4GuaiNErdk+ObbB9mk8lagy4A3gtTjg+1oNNWbd1mdbN3VTwnTm8AzDnnKmq
	ko/1fiYqMvdrXQiZPM/Tore6B3wtIoZXA3hvUjE5Hm3tfUWQRGqMgOa2Uy0ogjn3
	clLULYXFoVk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC3313EFD;
	Mon, 29 Nov 2010 12:45:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 27B5A3EFC; Mon, 29 Nov 2010
 12:45:01 -0500 (EST)
In-Reply-To: <AANLkTin34AfYnFY5e9B1cuyckfLXU2=qXFciFaaNGt9f@mail.gmail.com>
 (Erik Faye-Lund's message of "Mon\, 29 Nov 2010 12\:20\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67153EB4-FBE0-11DF-BF42-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162409>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> For this code-path to trigger we would have to be able to prefix-match
> every common command AND every "main command" must be included in
> common commands. At the same time. The only possible way to
> prefix-match all commands is if they all start with the same letter.
> Do you really think this is a situation we could ever end up in? Every
> git command being a common-command, starting with the same letter?
>
> This is basically unreachable code. Perhaps it'd be even clearer just to die:
>
> if (main_cmds.cnt <= n)
> 	die("Prefix-matched everyting, what's going on?");

Well, the same letter can be an empty string:

	$ git ''

Didn't I already suggest BUG() there?  Also, saying "too ambiguous" would
make the codepath give "... See 'git --help'" message, I think.
