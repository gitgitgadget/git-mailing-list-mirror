From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Makefile: suppress false positive warnings of empty format
 string.
Date: Sun, 29 Sep 2013 16:23:54 +0100
Message-ID: <5248460A.40005@ramsay1.demon.co.uk>
References: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org>	<1380456534-7582-1-git-send-email-stefanbeller@googlemail.com> <CAMP44s069BUJiv1K3a2nkwT1A8fo=Vn0+8WFePHqBg_PBx_17g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 17:24:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQIqo-0006Mn-Ph
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 17:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab3I2PX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 11:23:59 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:51956 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753472Ab3I2PX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 11:23:58 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 38E02A64E99;
	Sun, 29 Sep 2013 16:23:56 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 052DDA64E95;
	Sun, 29 Sep 2013 16:23:56 +0100 (BST)
Received: from [192.168.254.2] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Sun, 29 Sep 2013 16:23:55 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CAMP44s069BUJiv1K3a2nkwT1A8fo=Vn0+8WFePHqBg_PBx_17g@mail.gmail.com>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235600>

On 29/09/13 16:07, Felipe Contreras wrote:
> On Sun, Sep 29, 2013 at 7:08 AM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index de3d72c..60afa51 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -349,7 +349,7 @@ GIT-VERSION-FILE: FORCE
>>
>>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>>
>> -CFLAGS = -g -O2 -Wall
>> +CFLAGS = -g -O2 -Wall -Wno-format-zero-length
> 
> Oh yes please.
> 
> However, somebody mentioned that this might break compilers other than
> gcc, but perhaps we can do what Linux does:

I simply added:

    CFLAGS+=-Wno-format-zero-length

to my config.mak file. I had originally intended to do so conditionally,
depending on the compiler being gcc, but I found that clang and tcc just
ignored it ...

> cc-disable-warning = $(call try-run,\
> $(CC) $(CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
> 
> CFLAGS = -g -O2 -Wall $(call cc-disable-warning,format-zero-length,)

ATB,
Ramsay Jones
