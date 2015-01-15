From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init-db: remove unused #includes
Date: Thu, 15 Jan 2015 15:40:04 -0800
Message-ID: <xmqqlhl34nqj.fsf@gitster.dls.corp.google.com>
References: <1421258367-8483-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq61c99o25.fsf@gitster.dls.corp.google.com>
	<xmqqwq4p86i6.fsf@gitster.dls.corp.google.com>
	<CANCZXo5UY80327pvjzYkJXroH_WZdW36LhSANK0O7GGVQLF=AA@mail.gmail.com>
	<20150115105558.GA13536@peff.net>
	<xmqqsifb6atr.fsf@gitster.dls.corp.google.com>
	<20150115223112.GB19021@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:40:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBu1R-0007ZR-KW
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 00:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbbAOXkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 18:40:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753968AbbAOXkK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 18:40:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25C313095B;
	Thu, 15 Jan 2015 18:40:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=noqFaoKbIjE0rtqOdGcS751Uz3s=; b=U7syFE
	aNCpPupzab09d7FnUUTt0HYfRcTzzAY3Onpa+dyd2qN1T/S0uwBcSi0eEjv0GKlJ
	/1QLeZwETAwcga2avcvaPWJKa3YH7ttgHIAWMzGiwVC3xKAYVS5mLw0o4VorTjow
	t2zmAOfpHeYJ0a8UKet1XS5JqAHNSpqQiP0B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UE1bvPi5SFTYc+YOd9Bd0qqegEOa2rJo
	S8/Vl+HYL9lZViodVZHukNQv50GCC6PqTH7uCjzeIcRdR0lH32PZSBBHkcqLBEiF
	48Cu8sMfSGIUBDrPMuRpMQw9NiZ3Corlo6dOECbnxpvS6FS9uXBeQ+p10TgJLKBW
	/G1Dr1tykmc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C50E3095A;
	Thu, 15 Jan 2015 18:40:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA38030954;
	Thu, 15 Jan 2015 18:40:05 -0500 (EST)
In-Reply-To: <20150115223112.GB19021@peff.net> (Jeff King's message of "Thu,
	15 Jan 2015 17:31:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D55DBF98-9D0F-11E4-B72E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262524>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 15, 2015 at 12:36:00PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > FWIW, the full set of CFLAGS I use (which I specify in config.mak) is:
>> >
>> >     CFLAGS += -Wall -Werror
>> >     CFLAGS += -Wno-format-zero-length
>> >     CFLAGS += -Wdeclaration-after-statement
>> >     CFLAGS += -Wpointer-arith
>> >     CFLAGS += -Wstrict-prototypes
>> >     CFLAGS += -Wold-style-declaration
>> 
>> I think I have no-pointer-to-int-cast, old-style-definition and vla
>> in addition to the above.
>
> Thanks, I added the latter two to my setup. But what is the purpose of
> turning off pointer-to-int warnings? It seems like those are a good
> indication of a sloppy construct (and AFAICT, we do not have any code
> which triggers on it).

It probably a remnant from olden days; perhaps we used to have a
code that stuffs a pointer value to an int field used as a hash key
or something.  As you said, there is no need for disabling that
check in today's code.

Thanks for catching.
