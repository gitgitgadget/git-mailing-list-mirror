From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 12:39:54 -0500
Message-ID: <509FE2EA.3020407@gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>	<20121108200919.GP15560@sigill.intra.peff.net>	<509CCCBC.8010102@drmicha.warpmail.net>	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>	<509E8EB2.7040509@drmicha.warpmail.net>	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>	<509EAA45.8020005@gmail.com>	<CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>	<509FD9BC.7050204@gmail.com> <CAMP44s1pWm_n-SwB5Bi8UxM-oRG=4dGXq7jVKx_E1rcoRaXaHw@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:40:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXbW4-0005E8-FC
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab2KKRj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:39:57 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:52953 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab2KKRj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:39:56 -0500
Received: by mail-yh0-f46.google.com with SMTP id m54so1069305yhm.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=D9XBmp2rPE+0GJeEVqlkSGFgohLk2nyLQOpo0FeQfO4=;
        b=r0UCRfxMfhtSIzFz4L5xTgJ2JrbrIhONLkf2IEmaLzP2HlSkt+WADGZQRnavkhJkG1
         bemk3+hZlI0NbzOojv03mb8jAM8/iXkWyQS9ZUTDYRfuXLrSDS0FugN6IqQpGlzsi4R/
         sCOy2mp2zgWaizx3lOb9cuJcaWWvXJUZs1tMvHuojbph9bJCDeLIqb1ehjKTj/9/3jnO
         PSUPYEez6eeMoKfPbyKDEeC/WDAGXTi2jd9M4gK8Py8/sF8yOAcKADopTnalfWN79yPd
         y27ky8zt8XlfyVIfjqWLZfNX0FbGwjRrHSTSHDiYVHrEWDZW8eXr1zXi79WBnSNEEUh/
         t5Tg==
Received: by 10.236.92.15 with SMTP id i15mr17190794yhf.85.1352655596036;
        Sun, 11 Nov 2012 09:39:56 -0800 (PST)
Received: from [10.0.1.132] ([97.104.180.2])
        by mx.google.com with ESMTPS id z11sm3930129anj.13.2012.11.11.09.39.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 09:39:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
In-Reply-To: <CAMP44s1pWm_n-SwB5Bi8UxM-oRG=4dGXq7jVKx_E1rcoRaXaHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209425>

On 11/11/2012 12:16 PM, Felipe Contreras wrote:
> On Sun, Nov 11, 2012 at 6:00 PM, A Large Angry SCM<gitzilla@gmail.com>  wrote:
>> On 11/11/2012 07:41 AM, Felipe Contreras wrote:
>
>>> Such a filter would probably be quite complicated, and would decrease
>>> performance.
>>
>> Really?
>>
>> The fast import stream protocol is pretty simple. All the filter really
>> needs to do is pass through everything that isn't a 'commit' command. And
>> for the 'commit' command, it only needs to do something with the 'author'
>> and 'committer' lines; passing through everything else.
>
> And how do you propose to find the commit commands without parsing all
> the other commands? If you randomly look for lines that begin with
> 'commit /refs' you might end up in the middle of a commit message or
> the contents of a file.

I didn't say you didn't have to parse the protocol. I said that the 
protocol is pretty simple.

>
>> I agree that an additional filter _may_ decrease performance somewhat if you
>> are already CPU constrained. But I suspect that the effect would be
>> negligible compared to the all of the SHA-1 calculations.
>
> Well. If it's so easy surely you can write one quickly, and I can measure it.

Not my itch; You care, you do it.
