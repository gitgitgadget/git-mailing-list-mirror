From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] i18n.pathencoding
Date: Tue, 04 Sep 2012 10:19:51 -0700
Message-ID: <7vvcftbt8o.fsf@alter.siamese.dyndns.org>
References: <201209010811.33994.tboegi@web.de>
 <CACsJy8A1GnhTeMzwXwA1C96pp0ERskxZC=SO+QE2__pfwmChow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:20:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8wnB-000638-UN
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 19:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467Ab2IDRTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Sep 2012 13:19:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab2IDRTy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 13:19:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CBF19FED;
	Tue,  4 Sep 2012 13:19:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1OqJuV+1g9ur
	MrjTSwepL27gSAQ=; b=yQifhfkSIfbAw85P+GVCrKcEUYhjZjm/H9+up0R6QhfQ
	ME+scnrxffHQ+yFQLZuLJ4N1E/pe2JHH755nyLvrS/2SABQ4h0X9Wr18ZELfYO0C
	ZDi54NOd6tXoh3UZggK1UKJHkiGZeLxjGb4wDwIyREz8VzqnJ3fO+El87CDQEG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xuqXzi
	O16THeB/YG9rRbU2L5ybBBLnXo+4DfFvOPhSTlBYYByOPF9GgQBd1pCrJ9kV3CX9
	NWR7ltH/Cgn+XT5jGhNEFozXzBoDOzW4O5ywkWnVWxKQto6DGMVsPV2uGq4XOVUz
	HNFCKw0ByoyNM/Kgnhn7WQvHrVBUgxyJ+fl4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39D669FEC;
	Tue,  4 Sep 2012 13:19:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9CDA9FEB; Tue,  4 Sep 2012
 13:19:52 -0400 (EDT)
In-Reply-To: <CACsJy8A1GnhTeMzwXwA1C96pp0ERskxZC=SO+QE2__pfwmChow@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 4 Sep 2012 19:23:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD39999A-F6B4-11E1-9378-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204753>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Sep 1, 2012 at 1:11 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
>> diff --git a/parse-options.c b/parse-options.c
>> index c1c66bd..5840c18 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -476,7 +476,7 @@ int parse_options(int argc, const char **argv, c=
onst char *prefix,
>>                 usage_with_options(usagestr, options);
>>         }
>>
>> -       precompose_argv(argc, argv);
>> +       reencode_argv(argc, argv);
>>         return parse_options_end(&ctx);
>>  }
>
> If you have to re-encode command line arguments, what about paths
> coming --stdin or a file?

That problem is inherited from the MacOS precompose topic this one
builds on.  Not that it is unimportant to fix, though.
