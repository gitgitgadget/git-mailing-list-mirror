From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] The design of new pathspec features
Date: Tue, 29 Jan 2013 08:20:45 -0800
Message-ID: <7vk3qwrmea.fsf@alter.siamese.dyndns.org>
References: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal>
 <CACsJy8A5VJ4EchbeFEC5ikLYgHze47_xyLTtgH=kqVpP15Hogw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 17:21:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Dvq-0003Ul-K3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 17:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab3A2QUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 11:20:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56479 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073Ab3A2QUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 11:20:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A162ECF80;
	Tue, 29 Jan 2013 11:20:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X8/uDPWTwkDJp2meazwCf++d6Oo=; b=Fsnk5a
	KgsStMsMLmCZizIRbyXkuZkMpU8jcr4KWJYMUc7x5Vb8JUVT6S/QcHroby4YBhXn
	hUPZm4owYTXK63CStpvBwy16uLUk2Puq5XBdgmXtizvnmYNVsMgudIhrqo6TG3AG
	FjYC5N9M3gv/iZSiVwAwGkeY2NMYb7/Jat7YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KRIABraQitH99jllwMM0AFKlUmdcCjnv
	CtuYy3WIR1Y0AuohhbesuWDPnAz5TzT2AWhLf7snX5flCKb5oZ5b+/Yhpr+iDh9Z
	GEqKVXxmEENTwzYl955KUs+c4+zb3pv7zEsOmK72/dIamEnnnJk3LJA0XJNPN8Ut
	nbnAZaHmBDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95CBACF7E;
	Tue, 29 Jan 2013 11:20:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14D35CF7D; Tue, 29 Jan 2013
 11:20:46 -0500 (EST)
In-Reply-To: <CACsJy8A5VJ4EchbeFEC5ikLYgHze47_xyLTtgH=kqVpP15Hogw@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 29 Jan 2013 19:17:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6998B0E-6A2F-11E2-AD6F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214945>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jan 29, 2013 at 11:35 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> :(glob) magic
>> =============
>>
>> This magic is for people who want globbing. However, it does _not_ use
>> the same matching mechanism the non-magic pathspec does today. It uses
>> wildmatch(WM_PATHNAME), which basically means '*' does not match
>> slashes and "**" does.
>>
>> Global option --glob-pathspecs is added to add :(glob) to all
>> pathspec. :(literal) magic overrides this global option.
>
> I forgot one thing. The current pathspec behavior, the pattern "[a-z]"
> would match a file named "[a-z]" (iow, wildcards are also considered
> literal characters).

That sounds like a blatant bug to me (unless you are talking about
"literal" case).  We should fix it before we include it in any
released version, I think.
