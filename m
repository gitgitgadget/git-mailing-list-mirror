From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Sat, 18 Apr 2015 14:01:58 +0530
Message-ID: <5532167E.5000206@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117143-4882-1-git-send-email-karthik.188@gmail.com> <xmqqmw29jg78.fsf@gitster.dls.corp.google.com> <20150415221824.GB27566@peff.net> <20150417142310.GA12479@peff.net> <553154C8.5090001@gmail.com> <20150417184939.GA32578@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 18 10:32:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjOAd-0000qy-5M
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 10:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbbDRIcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 04:32:06 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35624 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbDRIcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 04:32:03 -0400
Received: by pdbqd1 with SMTP id qd1so152097227pdb.2
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1tP/To78r0dFkqbeZ8A5hUd5rLJrhl0pWpYp2GXfsm8=;
        b=c93tWCrUp8pwmV57fRM1V+EetqIGJJH3p0OYz3z82z7O9oVRr9QRXJN9yDdpEwY5TC
         6+PH1QtitfdsWQU07jgy2IYxOMBGUCpxPqGJXHcKa7OWnV4VEcKG5o/jUVpwMXqK8WSk
         xB70HxiyLWu4VET28zrl3L6eOf2LiPjGPsgMaj8OqIA3h5Pa79Vg6zDt5OtGcAqcHcek
         9zXBiL/OrDJpFikNGngHnTwSRq6/wXFCFmd5h++7Y0cAr4CNtjzh8soUvihJyWYrMDDI
         0BWfkX+3/qDJ7Y6M6wWXqUAZ6ZwRhn65vc+pcyoOb/m6iGE/PliWxNuNfvnlrdlruOeC
         RrcA==
X-Received: by 10.67.16.110 with SMTP id fv14mr12028456pad.39.1429345923333;
        Sat, 18 Apr 2015 01:32:03 -0700 (PDT)
Received: from [192.168.0.100] ([103.227.98.178])
        by mx.google.com with ESMTPSA id i9sm12273448pdj.27.2015.04.18.01.32.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2015 01:32:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150417184939.GA32578@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267409>



On 04/18/2015 12:19 AM, Jeff King wrote:
> On Sat, Apr 18, 2015 at 12:15:28AM +0530, karthik nayak wrote:
>
>>> But now we use type_from_string_gently, which can accept a length[1]. So
>>> we could just count the bytes to the first space and pass the original
>>> buffer along with that length, no?
>>
>> Yes, we could, that would eliminate  "struct strbuf typename =
>> STRBUF_INIT".
>>
>> Something like this perhaps :
>
> Yeah, this is exactly what I had in mind.
>
>>    {
>> -       char type[10];
>> -       int i;
>> +       const char *buf = hdr;
>>           unsigned long size;
>> +       int type, len = 0;
>
> Maybe switch the names of "buf" and "len" to "type_buf" and "type_len"
> to make their purpose more clear?
>
> -Peff
>

Yes, will change the names.
