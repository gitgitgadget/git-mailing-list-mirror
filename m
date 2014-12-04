From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce git root
Date: Thu, 04 Dec 2014 11:02:37 -0800
Message-ID: <xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
	<xmqqd282m09j.fsf@gitster.dls.corp.google.com>
	<20141204092251.GC27455@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwbgK-0000rX-KB
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbaLDTDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 14:03:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932215AbaLDTDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:03:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CF9D22A36;
	Thu,  4 Dec 2014 14:03:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tPK7vBagMjQ4rnALlWCD1g9X/fs=; b=Hna3F8
	K+jVXRoDl1KmB1zEs+hmFpduzmiY4SQMrvtl1Tyv0HeA68zYR9hC/QnUg1CaP1/l
	aWc0LwN78fr1PdB6mamQyu6wrU5y4KVr+UCZsXiXql/53Mykrg0Fi/8xgOXfhgRa
	9Hra+nwJgeLobv5+HglLDbcYatt3OXgQaNnf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vAOMvSsUFTnT71rA0fg82suoU08cj3NL
	usL3lwJT58jWFqeSJJLRNzyytE1UwsQXGGbo/E8+KGZUouX9wVeGRfKGyMNWlpKu
	IOsXlnCLqFkhlamoaYgWSIE5dzlNahYejGTUXccqzcQ+Umq9WlSvlmIWwDGT4By9
	nHGbXcmBM4A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8230C22A35;
	Thu,  4 Dec 2014 14:03:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22101229F5;
	Thu,  4 Dec 2014 14:02:39 -0500 (EST)
In-Reply-To: <20141204092251.GC27455@peff.net> (Jeff King's message of "Thu, 4
	Dec 2014 04:22:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DDB8258-7BE8-11E4-B855-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260782>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 02, 2014 at 09:26:00AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > There is also "git var", which is a catch-all for printing some deduced
>> > environmental defaults. I'd be just as happy to see it go away, though.
>> > Having:
>> >
>> >   git --exec-path
>> >   git --toplevel
>> >   git --author-ident
>> >
>> > all work would make sense to me (I often get confused between "git
>> > --foo" and "git rev-parse --foo" when trying to get the exec-path and
>> > git-dir). And I don't think it's too late to move in this direction.
>> > We'd have to keep the old interfaces around, of course, but it would
>> > immediately improve discoverability and consistency.
>> 
>> Yeah, I too think the above makes sense.  I forgot about "var", but
>> it should go at the same time we move kitchen-sink options out of
>> "rev-parse".  One less command to worry about at the UI level means
>> you do not have to say "if you want to learn about X, ask 'var', if
>> you want to learn about Y, ask 'rev-parse', use 'git' itself for Z".
>
> Christian raised the issue of cluttering the "git --option" namespace,
> and I do agree that's a potential issue. 

I am not sure if that is an issue at all.  You will need the same
number of options to cover all the necessary "computables" somewhere
anyway.

"git --show-this-or-that-computable" is not more or not less
cluttering compared to "git var --show-this-or-that-computable".

If we were to move to "git var", which takes "variables" of these
forms:

	GIT_AUTHOR_IDENT
        GIT_COMMITTER_IDENT
        GIT_EDITOR
        GIT_PAGER

then scripts that currently use "git --exec-path" need to be
encouraged to instead use "git var GIT_EXEC_PATH".  If we have so
many computables that "cluttering" may become an issue, then we
would need to come up with many new GIT_$COMPUTABLE_NAME fake
variables for consistency if we were to go with "git var", no?

I understand we are not talking about removing "git --exec-path",
but the desire is to have one single command the user can go to ask
about all the computables.  If "var" is to become that single
command, then we need to keep the interface to it uniform and
consistent, and telling the users to use "git var GIT_PAGER" and
"git var --exec-path" in the same script will not fly well.  Also
these GIT_$COMPUTABLE_NAME appear as if they can be influenced by
setting environment variables of the same name, which invites
further confusion.  This is especially bad because some of then do
get affected by environment (i.e. GIT_EDITOR="vi" has effect, but
GIT_AUTHOR_IDENT="Gitster <gitster@pobox.com>" does not).

> ... My proposal was to drop "git
> var", but I'd also be OK with making "git var" the new kitchen sink.  It
> doesn't accept many options now, so it's fairly wide open for changing
> without losing backwards compatibility. AFAICT, the "-l" option is
> utterly useless, but other than that, it just takes a variable name. We
> could introduce dashed options, or just define a sane variable namespace.

If we admit that "git var" was a failed experiment that gained only
four fake variables for the past 10 years, it will not be too much
trouble and transition pain to turn the existing ones into option
form, like --author-ident etc., like your original proposal did, I
would think.

If we are going to deprecate "git var GIT_AUTHOR_IDENT" form,
i.e. the form that uses fake variable-looking strings, and uniformly
use "git var --author-ident", "git var --exec-path", etc., then I
would think it would work, too.  I still do not know what you gain
by using "git var --exec-path" over "git --exec-path", though.
