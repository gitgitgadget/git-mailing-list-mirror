From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Tue, 26 Aug 2014 13:59:52 +0100
Message-ID: <53FC84C8.1020300@ramsay1.demon.co.uk>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com> <53FA0054.5060808@gmail.com> <CAPc5daWheSH8E-PycSUq2Coqp19t_+_6TuBEOKhK4QwsEtzkkA@mail.gmail.com> <20140825130732.GD17288@peff.net> <xmqq8umcl0al.fsf@gitster.dls.corp.google.com> <20140826110303.GA25736@peff.net> <53FC7621.7090102@ramsay1.demon.co.uk> <20140826121359.GA29180@peff.net> <53FC7F98.5070204@ramsay1.demon.co.uk> <20140826124344.GF29180@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWk=?= =?UTF-8?B?IE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 15:00:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMGM4-0006TT-H7
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 15:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023AbaHZM77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 08:59:59 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:39309 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755091AbaHZM75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 08:59:57 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 5094FAC40BE;
	Tue, 26 Aug 2014 13:59:55 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 0AACDAC40B7;
	Tue, 26 Aug 2014 13:59:55 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Tue, 26 Aug 2014 13:59:54 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140826124344.GF29180@peff.net>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255899>

On 26/08/14 13:43, Jeff King wrote:
> On Tue, Aug 26, 2014 at 01:37:44PM +0100, Ramsay Jones wrote:
> 
>>> On my 64-bit system using gcc, sizeof() returns 16; it has to pad the
>>> whole thing to 64-bit alignment in case I put two of them in an array.
>>> But offsetof(name) is 12, since the array of char does not need the same
>>> alignment; it can go right after the type and make use of the padding
>>> bits.
>>
>> Hmm, interesting. I must re-read the standard. I was convinced that the
>> standard *requires* any alignment padding to come *before* the name field.
>> (how would you put a, non-trivial, variable data structure into an array?)
> 
> I think you don't. How would you compute a[1] if a[0] has a variable
> size?
> 
> You can put a flex-array structure into an array, but then each element
> has the flex member as zero-size (and you should not access it, of
> course).

Exactly. ;-)

ATB,
Ramsay Jones
