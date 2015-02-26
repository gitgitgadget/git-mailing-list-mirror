From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 15:29:47 -0800
Message-ID: <xmqqtwy8jlp0.fsf@gitster.dls.corp.google.com>
References: <xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
	<20150226030416.GA6121@peff.net>
	<xmqqmw40l777.fsf@gitster.dls.corp.google.com>
	<20150226213356.GA14464@peff.net>
	<xmqqa900l57y.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbUOhbs2DpM3CK=f+Gwj3v-q44Q7beiVgDHPPwm+rhEng@mail.gmail.com>
	<20150226220609.GA24663@peff.net> <20150226220759.GB24663@peff.net>
	<CAGZ79kar4Uf-mCwXpexPvNztwd_vfjdCoT_dDXULkOrCqUhG=A@mail.gmail.com>
	<20150226223603.GA27946@peff.net> <20150226224558.GA10311@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Yi EungJun <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 00:29:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR7sR-0008WL-ST
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 00:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbbBZX3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 18:29:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752106AbbBZX3t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 18:29:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB6D73B5A3;
	Thu, 26 Feb 2015 18:29:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XMJ8t0J0n9P3tZ/xiJhHhphRhhs=; b=SozobF
	nFNgMosLNyMd3WAPmC8JVWXcsZ//TILBkwnSdK1NWzXFzGBnYHAcheb0eL8GbqYx
	TtKpPr6gPcm1YGs88jWiEtWVHu02VCWU0/D8jSg8QN+56/Q0BYkrlddZYj9fQU28
	aiHJZ2YUwvXq5rEX3KLTwGyPks8p38V/n0inU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MZGb4JaRXc11e0vm+Lg3jjZzwsspR/Pv
	V5HbxJFJMvI2sglVeK/Kiumqh7AYT1x+KlTMXThnJwEZj5UKU3Cyf5ReMAX5Bbq/
	ihmdc7xalCrb5mot6NA8XJ9eRRsc1VrBcV6bJEMS8r9f+pjtq0BbL0KGnGTsGyTA
	J/19/sppoQI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E47453B5A2;
	Thu, 26 Feb 2015 18:29:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 570A33B5A1;
	Thu, 26 Feb 2015 18:29:48 -0500 (EST)
In-Reply-To: <20150226224558.GA10311@peff.net> (Jeff King's message of "Thu,
	26 Feb 2015 17:45:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5AC1C4CA-BE0F-11E4-B082-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264479>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 26, 2015 at 05:36:03PM -0500, Jeff King wrote:
>
>> > [-Wstrict-prototypes]
>> >  const char *get_preferred_languages();
>> >  ^
>> 
>> Hmph. The compiler is right that it should be:
>> 
>>  const char *get_preferred_languages(void);
>> 
>> but my gcc (4.9.2, with -Wstrict_prototypes) does not seem to notice it!
>> Weird.
>
> Ugh. I have a snippet in my config.mak that relaxes the warnings on older
> versions of git, and it was accidentally triggering due to a typo. :(
>
> So that explains that. Junio, do you mind squashing in:

Yup, I already did when I got the first one.

Thanks.

>
> diff --git a/gettext.h b/gettext.h
> index 5d8d2df..33696a4 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -89,6 +89,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
>  #define N_(msgid) (msgid)
>  #endif
>  
> -const char *get_preferred_languages();
> +const char *get_preferred_languages(void);
>  
>  #endif
