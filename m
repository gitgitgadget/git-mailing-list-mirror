From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Fri, 21 Sep 2012 21:52:44 -0700
Message-ID: <7vwqzm3bhf.fsf@alter.siamese.dyndns.org>
References: <505CCA55.6030609@gmail.com>
 <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net>
 <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net>
 <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
 <m2k3vn9gyu.fsf@igel.home> <7vhaqr3t6j.fsf@alter.siamese.dyndns.org>
 <CALkWK0kxmD_HJtnV0ShSdpgSjoLQHtv0=b4s=utG52zFLb2Bjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 06:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHi3-0006ID-LV
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280Ab2IVEwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 00:52:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab2IVEwq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:52:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D2849DCB;
	Sat, 22 Sep 2012 00:52:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P6wB0frt6K5LmemwodAgKXXIDtg=; b=XxuiBT
	La3RM2jD83SyewjpFN4NxItx7ELT3Ng5n6XNLN+MXP4ZwczVIA/0sOXMQbeWR7mL
	3HIzxyCBzPTnqAeNwPpw0lfkPD1BvAfSMlRwJZvrfy8fklo4uxFe/FBLSvvYUFBT
	h2ecAIgKfDM/cy7Z5SFDdpsnsgv9AFej8wB9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IiJVHWmNBuSlADNt4/yWvtlti/7OzGQG
	R1Zf15uaSp8ixE+OwpBGYg29SMu96Bq617g8D8nyzl8iDx9EogCodVsYns2oPooJ
	wWLcBgTJ0VUY3s4HEOf5uJ6a1Z6zmuXjJqB07P3ffxGmDKimQ5ezcGpFO2FVQuG2
	RAaJxD9HoPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C24D9DCA;
	Sat, 22 Sep 2012 00:52:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFFA79DC9; Sat, 22 Sep 2012
 00:52:45 -0400 (EDT)
In-Reply-To: <CALkWK0kxmD_HJtnV0ShSdpgSjoLQHtv0=b4s=utG52zFLb2Bjg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 22 Sep 2012 09:56:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59BD6FE8-0471-11E2-9DDB-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206190>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> The reference to ${SHELL-/bin/sh} in the test need to be updated to
>> SHELL_PATH as Peff suggested in the other subthread.
>
> For that, the entire block needs to be moved down to come after `.
> GIT_BUILD_DIR="$TEST_DIRECTORY"/..`.  Is this okay?

Have you tested it with --tee (or valgrind) and does that work?
