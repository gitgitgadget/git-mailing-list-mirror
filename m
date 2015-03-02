From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Mon, 02 Mar 2015 12:15:39 -0800
Message-ID: <xmqqsidn9mvo.fsf@gitster.dls.corp.google.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
	<CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com>
	<CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com>
	<CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com>
	<CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com>
	<xmqqa908z44h.fsf@gitster.dls.corp.google.com>
	<CACBZZX7O77zfn75vJXsSyR58UjC_bfTu-DWwJC8n2fhemVBn2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:16:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSWl5-0000R2-4U
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 21:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbbCBUQB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2015 15:16:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754508AbbCBUQA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 15:16:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60F213D906;
	Mon,  2 Mar 2015 15:15:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jl+Oi67R0jeL
	5VVakT2Ce3cx96s=; b=IGn4BRT0xT7rT7x4fEuUpCc7URlCxxcQ1JOtoiLLVIsm
	ohjIGmxBPrEXYGhucBb5TXPFf6TV+jWCpfPoGykliw4U2WEkCNascm3piLxk8p0J
	ioszMcZgKn1M1W6Sy6LT28FX1XdqeiHoeeR4r0n0rR3PS235hcnsU44fu7lMAm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lFxXxc
	Io7+ssgjJyV0SMU483rm56/RE4fosPQBAKsiDlP1BCTzRpB0ohC3peSL+UPUEjUU
	Jz5ycB7fD6WCLryShAsiY9Vzeg747jTC/wFR5uN5D2uH1rQQiALOY73rq5TMgLXq
	cLFmvJ04j1EsriLWUH+73fJps0jWQs118BOjQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 532993D905;
	Mon,  2 Mar 2015 15:15:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54C7C3D8F6;
	Mon,  2 Mar 2015 15:15:40 -0500 (EST)
In-Reply-To: <CACBZZX7O77zfn75vJXsSyR58UjC_bfTu-DWwJC8n2fhemVBn2w@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 2 Mar
 2015 20:36:43
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E59D5AB2-C118-11E4-B679-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264619>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Feb 20, 2015 at 10:04 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I actually ran this a few times while testing it, so this is a befo=
re
>>> and after on a hot cache of linux.git with 406 tags v.s. ~140k. I r=
an
>>> the gc + repack + bitmaps for both repos noted in an earlier reply =
of
>>> mine, and took the fastest run out of 3:
>>>
>>>     $ time (git log master -100 >/dev/null)
>>>     Before: real    0m0.021s
>>>     After: real    0m2.929s
>>
>> Do you force --decorate with some config?  Or do you see similar
>> performance difference with "git rev-parse master", too?
>
> Yes, I had log.decorate=3Dshort set in my config. With --no-decorate:
>
>     $ time (git log --no-decorate -100 >/dev/null)
>     # Before: real    0m0.010s
>     # After: real    0m0.065s

There you have the answer to your earlier question, then, which was:

>> tl;dr: After some more testing it turns out the performance issues w=
e
>> have are almost entirely due to the number of refs. Some of these I
>> knew about and were obvious (e..g. git pull), but some aren't so
>> obvious (why does "git log" without "--all" slow down as a function =
of
>> the overall number of refs?).
