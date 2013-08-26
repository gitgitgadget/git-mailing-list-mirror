From: Lance <lancethepants@gmail.com>
Subject: Re: Issue with compiling git 1.8.4 under uclibc with gcc 4.6.3
Date: Mon, 26 Aug 2013 14:29:12 -0600
Message-ID: <521BBA98.7010102@gmail.com>
References: <521BB643.304@gmail.com> <20130826201804.GB13130@blizzard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Mon Aug 26 22:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE3Pb-0007Iy-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 22:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab3HZU3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 16:29:15 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:53885 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3HZU3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 16:29:14 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so3927440pde.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LdURnxcDQKRuc5g5U8lLdAqLD1l42psmr22XIeioEh4=;
        b=siDizi98urffKuCK0PSLHd7x89KObqYDM1SJBmy3JgjH9hebARALnjtYW3X1wMIGYm
         FPmqnUNO/ucI0eP70fG7wukIDqMUk5YUvWJleU/YOWFxlggsruCW6qGskzE3+5bDTHHZ
         W6ZTC5t9/EByEN3yaXRFVjKxnOMOK+PQkVoRXwjdhiOfE276O+KoU4oDCDekffmR2aZ3
         TENqr8sTBdHl5luOFpmPdw1cPzw6bbY6BRHI0OpkgUix/Tk/3FIkTBdCRTsoj/sBnX3Q
         dF1xKT2fwmcHBk64ZzeeFe1aQa9yoCHeehIRCMUykM9U6xl8oNwPViSj3zbs6LHWjv6b
         BUsA==
X-Received: by 10.68.17.230 with SMTP id r6mr17178602pbd.112.1377548954553;
        Mon, 26 Aug 2013 13:29:14 -0700 (PDT)
Received: from [10.0.0.155] ([70.103.142.130])
        by mx.google.com with ESMTPSA id a5sm19909179pbw.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 13:29:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130826201804.GB13130@blizzard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233024>


On 8/26/2013 2:18 PM, Lukas Fleischer wrote:
> On Mon, Aug 26, 2013 at 02:10:43PM -0600, Lance wrote:
>> Up until the latest release, I've been able to compile git for a
>> uclibc based embedded linux. The toolchain I use is from "entware",
>> which is based off of the openwrt toolchain.
>> https://code.google.com/p/wl500g-repo/
>>
>> Somewhere between git 1.8.3.4 & 1.8.4 there seems to be some changes
>> that breaks compilation for my particular situation.  When cross
>> compiling I receive the following error.  I also receive the same
>> error when compiling natively on the uclibc based device itself.
>> Not sure if being uclibc based has anything to do with it, but is
>> noteworthy. I am not a c programmer.
>> Both the cross compiler, and embedded device's version off gcc is 4.6.3.
>> Previous versions compile fine
>>
>>      CC config.o
>> config.c: In function 'get_next_char':
>> config.c:220:14: error: expected identifier before '(' token
>> config.c:220:14: error: expected statement before ')' token
>> config.c:220:14: error: expected statement before ')' token
>> config.c:224:11: error: expected identifier before '(' token
> Does changing line 220 of config.c to
>
>      int c = (cf->fgetc)(cf);
>
> fix it?
I also had to change line 224 to the following

                 c = (cf->fgetc)(cf);

Once both places were changes, it compiled successfully.
thanks
>> Lance
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
