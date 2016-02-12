From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of for-each-ref
Date: Fri, 12 Feb 2016 12:26:24 -0800
Message-ID: <xmqqoablu13j.fsf@gitster.mtv.corp.google.com>
References: <56B32953.2010908@gmail.com>
	<20160204111307.GA30495@sigill.intra.peff.net>
	<xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
	<20160212201002.GA21598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, tr@thomasrast.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 12 21:26:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUKIR-0001ch-OL
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 21:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbcBLU03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 15:26:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751239AbcBLU01 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 15:26:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6035240B25;
	Fri, 12 Feb 2016 15:26:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=48HQqdgH3AUwJd5zKaBtOXUo23o=; b=W9Q1kv
	wWYNt7zx1+314LtkteZ3Jw5RAtsFBC5vvvYj75s2jBGllfcMwYdGJ4bv/OgN/Y0g
	Yl/tXuSKBPLEL/flp4qu2XkP6iPk6R9Qy8dTvTr0dE+OhaMqL0stdsHfPfc6SDuZ
	P9F6B6Izo6Ttaf2/N9VtUDVtG6uCFfrVIV2tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ocfpcW+BUsVHb+T7HD/J5Tmc/93pTkNR
	721hX+mrM4mR0WvuELuorMvv+iwC6TT/sAfAM7QXM8RfEaytRP2nNurw1n2zoHdL
	yFhBWbRKL94feWKWsMf9Zzy71p8zczAajGbECrZiV4Nm6CjszK3YXCm8LJCrX9cm
	v4k6JQqqy6k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5751140B23;
	Fri, 12 Feb 2016 15:26:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF9B840B22;
	Fri, 12 Feb 2016 15:26:25 -0500 (EST)
In-Reply-To: <20160212201002.GA21598@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 12 Feb 2016 15:10:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3A0CC0C-D1C6-11E5-8BC3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286076>

Jeff King <peff@peff.net> writes:

> I agree it's a lot more pleasant, assuming there are no cases where we
> would want to pass through an error. But I really cannot think of one.
> Even explosive "woah, your git repo is totally corrupted" messages
> probably should be suppressed in the prompt.
>
>> @@ -320,7 +320,7 @@ __git_heads ()
>>  			refs/heads
>>  		return
>>  	fi
>> -}
>> +} 2>/dev/null
>
> Today I learned about yet another fun corner of POSIX shell.

I may have learned about this soon after I started learning bash,
but I admit that this was the first time I found a practical use
case for it ;-).
