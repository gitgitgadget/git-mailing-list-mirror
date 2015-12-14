From: Thomas Nyberg <tomnyberg@gmail.com>
Subject: Re: Corruption of branch?
Date: Mon, 14 Dec 2015 15:44:43 -0500
Message-ID: <566F2A3B.3050501@gmail.com>
References: <566EFF11.6010600@gmail.com>
 <CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
 <566F05B2.8080403@gmail.com> <1450120801.1678.13.camel@twopensource.com>
 <566F1F96.4060806@gmail.com> <1450124302.16044.1.camel@kaarsemaker.net>
 <566F277F.4070101@gmail.com> <1450125640.16044.4.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ZzG-0003R7-AB
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbbLNUoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:44:46 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34929 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbbLNUop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:44:45 -0500
Received: by qgew101 with SMTP id w101so58037004qge.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 12:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=9lsfZQqPMQJzKUfENI3eRJxj9jVBYjGJKdcr397q75c=;
        b=QZsuxN6yF1rBMewZBOq1qaRjXnVtZg1hap1OARGppux0FTRSLj7eFBXcG2dpfo8MRB
         lx64InVihnOwzyrkpy2ip5aYEqOgnD6RXB2vmNVV2BC3tR6aDR4gJz7x+ONF1/rmBOXy
         WgIY1lpBZW9IRTxa9njK3Zcbrecws7IYRTOtFgn52XWw1qg7s8Dp7ZMAtfE5ZVQYwW6C
         05H9O00+viIqL4Pzt3OaxLYuNzwbJ7lol7BB5yt86NVAi3JpkRU8uQKjKpNMtGu5ZXFN
         sspTMs4PMxuAHWiktlbOk43ToLOE16nyJU5nQ6kBdP7jlHgyIrVkENJBG8zS4oM//mz1
         j7MQ==
X-Received: by 10.140.22.41 with SMTP id 38mr45118825qgm.42.1450125884904;
        Mon, 14 Dec 2015 12:44:44 -0800 (PST)
Received: from [128.59.76.160] (dyn-128-59-76-160.dyn.columbia.edu. [128.59.76.160])
        by smtp.googlemail.com with ESMTPSA id e62sm14494936qga.47.2015.12.14.12.44.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Dec 2015 12:44:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1450125640.16044.4.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282407>

wow right on the button. yeah i have the "frus" folder in the root of my 
repository. i never knew that git checkout also searches the root of the 
repository like that. it appears i'm a fool who doesn't read 
documentation...

i learned something knew and can move this from the "bizarre index 
corruption" category to the "user error" category. thanks so much everyone!

On 12/14/2015 03:40 PM, Dennis Kaarsemaker wrote:
> On ma, 2015-12-14 at 15:33 -0500, Thomas Nyberg wrote:
>> What exactly are you looking for? Here's the results of the following
>> command:
>>
>> $ git for-each-ref | grep frus
>> 1750cba5a94b3fe6041aaf49de430a558a3b9bc8 commit
>> refs/heads/frus_body_cleaning
>> 3a1dbe48299f6eda1cc4b69cab35284c0f0355eb commit	refs/remotes/o
>> rigin/frus
>> 1750cba5a94b3fe6041aaf49de430a558a3b9bc8 commit
>> refs/remotes/origin/frus_body_cleaning
>>
>> Sorry if this isn't what you're looking for. I'm actually not very
>> familiar with these different internal git commands...
>
> This is what I was looking for. Unfortunately it doesn't show any of
> the smoking guns I had hoped for.
>
> That leaves only one option: you also have a file or directory named
> 'frus' in the root of your repository. In this case 'git checkout frus'
> does the same as 'git checkout -- frus' instead of DWIM'ing 'git
> checkout frus' to 'git checkout -b frus origin/frus'
>
