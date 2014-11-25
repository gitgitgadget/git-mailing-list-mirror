From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-am: add --message-id/--no-message-id options
Date: Tue, 25 Nov 2014 12:05:59 -0800
Message-ID: <xmqqoarvrqoo.fsf@gitster.dls.corp.google.com>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
	<xmqqwq6jruyd.fsf@gitster.dls.corp.google.com>
	<5474D582.9060604@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 21:06:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtMNG-0007mr-UB
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 21:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbaKYUGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 15:06:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750812AbaKYUGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 15:06:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DE881E0BF;
	Tue, 25 Nov 2014 15:06:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b+d/F3Piu5WtJ3kNaHeZpZHGNgw=; b=R1/6Ej
	Czd5BlrYdipFgRpgufkFotP5t9JMH8+DjQsxs8tUHzgS89CKM2UcYMibPFHzRuvk
	R1bE6b7JMVk6rbQ9pmTxkE0bDZ17PypjUPSrr5fWov3Cn/0jZqIR5zM+CxfWFnBp
	625KygMVqnupSawxx267L9LrztEXinSubo0dY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q+7SlAT+nw75ExtNxx3nmZj1sDm5HiVx
	yiwZ6P+TUZxaiHv1XPAauKQuZmUanxTuaIxGFhc0Vwze9zRmNkbq76DevCE+R8Yi
	Sz4kjnc/LsgMV92j1CPg03HIt7fioRBUynLL9bAQC8Bjsa89WOaWhpwpfLUYVXN+
	OZdtvT69xtY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 100291E0BD;
	Tue, 25 Nov 2014 15:06:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 724071E0BA;
	Tue, 25 Nov 2014 15:06:01 -0500 (EST)
In-Reply-To: <5474D582.9060604@gnu.org> (Paolo Bonzini's message of "Tue, 25
	Nov 2014 20:16:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A823EF4-74DE-11E4-ADD9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260238>

Paolo Bonzini <bonzini@gnu.org> writes:

> On 25/11/2014 19:33, Junio C Hamano wrote:
>>> > If both --message-id and -s are specified, the Signed-off-by goes
>>> > last.  This is coming out more or less naturally out of the git-am
>>> > implementation, but is also tested in t4150-am.sh.
>> Nice.  So if you apply a message whose last sign-off is yourself
>> with both of these options, what would we see?
>> 
>>     1. S-o-b: you and then M-id: and then another S-o-b: you?
>>     2. M-id: and then S-o-b: you?
>>     3. S-o-b: you and then M-id:?
>> 
>> I do not offhand know which one of the above possibilities to favor
>> more over others myself.  Just asking to find out more about the
>> thinking behind the design.
>
> You currently get (1), which is arguably the most precise but definitely
> the ugliest.
>
> In this case (posting as maintainer), I would probably not use "git am
> --message-id"; instead I would use an alias to add the Message-Id (with
> git interpret-trailers!) after posting to the mailing list, resulting in
> either (2) or (3).
>
> I think (but I am not sure) that git-am could use a hook to rewrite (1)
> into (2) or (3).

I actually do not think (1) is more (or less for that matter) ugly
compared to either of the others.

Thanks.  Let's queue these two series for the next cycle.
