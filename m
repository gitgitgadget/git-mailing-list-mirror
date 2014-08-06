From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v8 8/8] add tests for `git_config_get_string_const()`
Date: Wed, 06 Aug 2014 21:14:31 +0530
Message-ID: <53E24D5F.6010104@gmail.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>	<1407336792-16962-9-git-send-email-tanayabh@gmail.com> <vpqmwbhvdkx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:44:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF3OK-00048v-MT
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbaHFPog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:44:36 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62118 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbaHFPog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:44:36 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so3492344pdb.41
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sbXz7mu4RNUHWI7MzmRnTt5YneWXpp3Ghyw0q2yFfFU=;
        b=AYzY/HVoJfxCBbpoaSQ7Gh2AGyO3k4GkzA1V0qDhbnwNlENTGGvuJwSvf+f6T8i9SJ
         sVpCh3L4QtiWhGnbTBvdQdLAt5pGZ+fB1Pc1zsrR16bEa31mttKJBj3Gg9mbrpM1jeNq
         OE3Z5cOlGQubXabi1hscyVsYp8koxE6lxgktmjpWEtmhsSHRsatrer8Ljdv37pFiDrbe
         N1flQj9JWk2u6RKPsHLlxWVZ/jojVToHHna6goee4PwlfNQBqE6gwYPififsfA3x0eBB
         Q6g5aPdFZrHAC1U0c3zMPkTlQCqprSeGCw3pPeI0EI6NiMtDkgiPilugmSlIuEX+i6dk
         Y3NA==
X-Received: by 10.69.26.134 with SMTP id iy6mr12086191pbd.115.1407339875876;
        Wed, 06 Aug 2014 08:44:35 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.214.188])
        by mx.google.com with ESMTPSA id vk5sm1651106pbc.44.2014.08.06.08.44.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:44:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqmwbhvdkx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254871>



On 8/6/2014 9:02 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> +test_expect_success 'find string value for a key' '
>> +	check_config get_string case.baz hask &&
>> +	check_config expect_code 1 get_string case.ba "Value not found for \"case.ba\""
>> +'
>> +
>> +test_expect_success 'check line error when NULL string is queried' '
>> +	test_expect_code 128 test-config get_string case.foo 2>result &&
>> +	grep "line 7.*.git/config\|.git/config.*line 7" result
>> +'
> 
> This is still dependant on the locale ("line" is translated). You need
> to use test_i18ngrep instead of grep here (see its definition and
> comment in t/test-lib.sh).
>

Oh, and I was searching t/README for a hint. Maybe we should add a line there
to hint future readers.
Thanks. :)

> I don't think you need these two alternatives OTOH.
> 
> BTW, Junio, I don't understand your remark "This test is too tight (the
> full string)" in the previous iteration. Can you elaborate?
>

I think he meant we must search for the relevant snippets instead of the whole string.
