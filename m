From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Mon, 09 Sep 2013 10:59:37 -0700
Message-ID: <xmqqa9jl5112.fsf@gitster.dls.corp.google.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
	<CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
	<20130904122020.GA25538@gmail.com>
	<CAPig+cRt9o=6Amhx6qTkzfk5R9aQfRZ=357BOVELm_hPsWE3WQ@mail.gmail.com>
	<CAEY4ZpNEae1UprRcpC8XUPP4XBQ89bDXP1A7yVcFdW405HZr0w@mail.gmail.com>
	<CAPig+cTNeqNhGwD-EZ3uszh5vJ4JeJ6L0RXdTsveb1FgXE5t3Q@mail.gmail.com>
	<20130909134743.GA11335@gmail.com>
	<xmqqtxhu3qil.fsf@gitster.dls.corp.google.com>
	<CAPig+cQEor+dBU6Xww25A4Sc-mgEOq1SDmBX-9xM6pKuMqu-NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nazri Ramliy <ayiehere@gmail.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 19:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ5kc-00047R-AA
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 19:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab3IIR7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 13:59:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab3IIR7p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 13:59:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40EB840616;
	Mon,  9 Sep 2013 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5hChSFoEVzY3Vw5qMyaYJOAeryw=; b=oWG0Y4
	Hno4xAHuly2IEXEXwxJ/occsmEbLvYD1+wmEJnCnqXSsCQfRj1qkIpNFZe4HH8p6
	F72kqiFOYcKLQKDlSFfuwIjTENw+JQRcSYtTjU7qj0A4z3Hq//rTu4EzppGVQQij
	ELkuTwXTVkLyKEfx+Vvo/wKO3tuuZyL2Vll9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k8SJ84wuh6TF37lCXt/ZhGCexPCPg+aG
	VnK5A/rLRmFo1eESNdN+6Zk3kCITuiQcRFdSF1JZsgmTjqf2apQT6dvb4CUw+JiN
	/pUVPx0/cG0X0ImJjmAmRpsz5KU4g53NpNQjO15bdxThEM+djvDCXs5TNHbeDK87
	o4Nvmct6s+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B6D640615;
	Mon,  9 Sep 2013 17:59:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 859D640610;
	Mon,  9 Sep 2013 17:59:41 +0000 (UTC)
In-Reply-To: <CAPig+cQEor+dBU6Xww25A4Sc-mgEOq1SDmBX-9xM6pKuMqu-NQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 9 Sep 2013 13:42:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99FAC5D8-1979-11E3-BE73-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234353>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Sep 9, 2013 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nazri Ramliy <ayiehere@gmail.com> writes:
>>
>>> Subject: git: run in a directory given with -C option
>>>
>>> +-C <path>::
>>> +     Run as if git was started in '<path>' instead of the current working
>>> +     directory.  When multiple '-C' options are given, each subsequent
>>
>> I think this should be `-C` to typeset it as "typed literally".
>>
>>> +     non-absolute `-C <path>` is interpreted relative to the preceding `-C
>>> +     <path>`.
>>> ++
>>> +This option affects options that expect path name like '--git-dir' and
>>> +'--work-tree' in that their interpretations of the path names would be
>>
>> Likewise for `--git-dir` and `--work-tree`.
>>
>>> +made relative to the working directory caused by the '-C' option. For
>>
>> and here.
>
> I agree with all of the above, however, the unfortunate typesetting in
> these cases was chosen deliberately to be consistent with the
> immediately surrounding text. A separate typesetting normalization
> patch, either before or after this patch, would not be unwelcome. (I
> forgot to make such a suggestion in [1].)
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/233719/focus=234234

OK, thanks for clarification.
