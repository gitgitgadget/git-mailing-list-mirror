From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/14] Add git-check-ignore sub-command
Date: Tue, 25 Sep 2012 16:25:52 -0700
Message-ID: <7vk3vhvg5b.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
 <1348170383-15751-15-git-send-email-git@adamspiers.org>
 <505BFED7.5030203@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:26:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGeVx-0006fi-EE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 01:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab2IYXZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 19:25:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732Ab2IYXZz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 19:25:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF1468171;
	Tue, 25 Sep 2012 19:25:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jw+TV33jh3qUUO36B7PwNtvWyNg=; b=G4f2fI
	88KkDlh9zOv46hDnKhY1Rj0ZdpMPZP/PXn0iAQ4teVyO9sctTy7X8kr7h7/t+6ON
	lDVJtI6hsxaxH/Dop/AfF807GUZQgULBJ22gKfMb+hRwqS6WAXGhVFXAGRunhPkM
	aoemmjDPGy6uq6sha9+771BR9TxGuz6xtQKdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hxqaKUUwGcNSI8UHZtcvOhNDQhcpx3CD
	TCRGHTu7K4s1J1MSkIYCFk3IR8uZSfEd5SViO4OtlYUBlwdJxAuy4htMLUmHu5bN
	3a12LY9Hf8PwE0IaxYmQzq1mi9lukjYcWjck6aOM/fgPHcSn9BjM/l5d/7t/8Pdn
	h6TK7aR0xl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9900C816C;
	Tue, 25 Sep 2012 19:25:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0066A8166; Tue, 25 Sep 2012
 19:25:53 -0400 (EDT)
In-Reply-To: <505BFED7.5030203@viscovery.net> (Johannes Sixt's message of
 "Fri, 21 Sep 2012 07:44:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59DBE258-0768-11E2-BE63-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206384>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 9/20/2012 21:46, schrieb Adam Spiers:
>>  test_expect_success 'general options plus command' '
>> -	test_completion "git --version check" "checkout " &&
>> -	test_completion "git --paginate check" "checkout " &&
>> -	test_completion "git --git-dir=foo check" "checkout " &&
>> -	test_completion "git --bare check" "checkout " &&
>> +	test_completion "git --version checko" "checkout " &&
>> +	test_completion "git --paginate checko" "checkout " &&
>> +	test_completion "git --git-dir=foo checko" "checkout " &&
>> +	test_completion "git --bare checko" "checkout " &&
>> ...
>
> I find this worrysome. Is check-ignore, being a debugging aid, so
> important that it must be autocompleted?

The shell function __git_list_porcelain_commands in contrib/completion/
starts from "git help -a" and filters plumbing commands and helpers
via a blacklist.  At least, check-ignore needs to be added there.

These days, we do not add random subcommands willy-nilly (I still
doubt if check-ignore needs to be a separate debugging command, or a
new mode of operation of ls-files or something), so the approach to
use a blacklist makes more sense.  "help -a" is designed to show
whatever the users throw in their ~/bin (assuming that is on $PATH)
under git-whatever name, and we _do_ want to complete "git wh<TAB>"
to that custom command, so a whitelist-based solution is unwieldy to
construct.
