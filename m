From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 4/6] add a test for semantic errors in config files
Date: Mon, 28 Jul 2014 16:57:05 +0530
Message-ID: <53D63389.5090205@gmail.com>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>	<1406543635-19281-5-git-send-email-tanayabh@gmail.com> <vpqmwbtu3rh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:27:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBj5I-00055a-Ex
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 13:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbaG1L1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 07:27:12 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50550 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbaG1L1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 07:27:11 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so10420054pad.27
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LF4NHZoTmrs56tqfe+/TctyOkfkma7031fkIFtj0QFE=;
        b=BpfdkXdlGrSxw7/iDGkZBkpLWRbmbcNcG0mhfr73rYURJbSXdz0N7D+vbClBqvtQtO
         YR/9BRI+8ZVAeiOkwz1MbQEZaZTN21MUnTXCgrUmG6IywiVDiyWVTiFGmhVvV9CYSJSU
         ApYBEY/yyGUnyxjdefbRUQiPSOc+EL7Y0UtsFa/DwX3rtYjBPxMNDTddiAl0t38Q2zmw
         flfcJOyk6+0hSPUrNs6Hlg8t+b8Fdv5YtjFeDPtdkryD9lV5mkTXVYkm0nNonTGl9rKU
         ZogRxiBVwcoMfgaw0FS12nNChV43V0w23oQgPwv/qRIQHheCm6UZIXlcQ+KASXqjruK5
         zyOA==
X-Received: by 10.67.4.234 with SMTP id ch10mr37690186pad.3.1406546831372;
        Mon, 28 Jul 2014 04:27:11 -0700 (PDT)
Received: from [127.0.0.1] ([106.211.56.253])
        by mx.google.com with ESMTPSA id z5sm17354659pbt.81.2014.07.28.04.27.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 04:27:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqmwbtu3rh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254311>



On 7/28/2014 4:52 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> +test_expect_success 'check line errors for malformed values' '
>> +	mv .git/config .git/config.old &&
>> +	test_when_finished "mv .git/config.old .git/config" &&
>> +	cat >.git/config <<-\EOF &&
>> +	[alias]
>> +		br
>> +	EOF
>> +	test_expect_code 128 git br 2>result &&
>> +	grep "fatal: bad config file line 2 in .git/config" result
>> +'
> 
> This is PATCH 4, and it tests a bug fixed in PATCH 1. It would have
> eased review to group both patches, either
> 
> PATCH 1: introduce test_expect_failure test to demonstrate the failure

Didn't Junio comment that he wouldn't recommend inserting a test_expect_failure
for new tests and then flipping them after in the series.

> PATCH 2: fix the bug and change test_expect_failure to test_expect_success
> 
> Or putting both in the same patch.
>

Much better, thanks for the advice.

> I think the series is OK like this, my comment is just to be read as
> "next time, here's how to do better".
> 
