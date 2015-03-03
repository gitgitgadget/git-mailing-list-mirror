From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: allow "-" short hand for previous commit
Date: Tue, 03 Mar 2015 15:17:53 -0800
Message-ID: <xmqq1tl5acwu.fsf@gitster.dls.corp.google.com>
References: <1425415911-496-1-git-send-email-sudshekhar02@gmail.com>
	<vpq4mq13f69.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sudhanshu Shekhar <sudshekhar02@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:18:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSw4f-0005Hn-1T
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbbCCXR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:17:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755819AbbCCXR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:17:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B28BA3E00D;
	Tue,  3 Mar 2015 18:17:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZDjLOkICVU8H3DAm71ShVGSnQHs=; b=sxqRiz
	uTR35abpFYIHFEl/gp4rSdeYLN1OeGzaT/+YbvDNAj2HboTUuSXaHk4V7EVNjFuo
	Oms86bnN2idLlPXRW4mSr3kINTfdFMwnfOJpNeSh0cxt8DZaTdy/afY2n/F8nkIo
	cfY6SmeJUwxJxseM9r7yaYFWCwTBA45C8FDRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ObBS2o93Xp4aw6Q9vRAap1rxTXXMiMro
	InSKCuzwUujhG/vZfcoAyyF+wNXOufoOtZOtZ4BpjX8ETPRfA44YAYFTOMYMBY9q
	1qV2LTBMy0Shp6wV8Hsy/8d8M885V3GBqzdMLDHtCHC7N8juqYXPixJsZn4XjSvn
	3wPuDdoai8A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA26B3E00C;
	Tue,  3 Mar 2015 18:17:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D3923E00A;
	Tue,  3 Mar 2015 18:17:55 -0500 (EST)
In-Reply-To: <vpq4mq13f69.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	03 Mar 2015 23:10:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 85B3A8E8-C1FB-11E4-9B1A-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264707>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:
>
>> From: SudShekhar <sudshekhar02@gmail.com>
>
> Please, set your configuration to have the same identity for commit and
> send-email. It seems your commiter ID (user.name) does not contain your
> last name.

Actually, the token does not match either of the two names; it looks
like two names smashed together into a single nickname token.

>> builtin/reset.c | 2 ++
>
> Doesn't this deserve a test?
>
> +		if(!strcmp(argv[0],"-"))
> +			argv[0]="@{-1}";
>
> Wrong spacing (around = and after ,).

What should worry us even more is what the user would get when @{-1}
does not resolve to something the command can use.  It would be bad
if we give an error message with @{-1} in it that the user never
typed (and may not even understand what it means).
