From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 17:00:34 -0500
Message-ID: <CAMP44s1LJg9kcBVMb8YxJDTEpKerJoN5td7276=JB7ZY6APpZw@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
	<87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
	<20130430150430.GA13398@lanh>
	<7vehdsf19m.fsf@alter.siamese.dyndns.org>
	<CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
	<CAMP44s0=5KniGDnVtKPg5sp=G8M-mPcq+Mu1nXqODfhT-MaNyg@mail.gmail.com>
	<CALkWK0kLZ9WLVcPBWuQZCjOku4A+WQ7=YeooPmKGpk9HuGYQnw@mail.gmail.com>
	<7vwqrjdh6v.fsf@alter.siamese.dyndns.org>
	<CALkWK0kcuaXTKbafmC72C3H+UZN6oeEY140T21LJUHveO=UBvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:00:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIbI-0004ay-P9
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642Ab3D3WAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:00:37 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:62960 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab3D3WAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:00:35 -0400
Received: by mail-lb0-f181.google.com with SMTP id 13so988383lba.40
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Lrp4xJ8ykJpc2WYtuo0ZeByxbD6TFLUTGL7lwFvKpKQ=;
        b=BH+lS6uXSCyu1UXBVgWNM7DJIUINc+yX+C4Rm+jO0f5pGBOTZyKf/Sk+VA3EU2lfw8
         WyQ164OskKvwdQslD6xHi2NNY4ZRVD19A9xSaGrgC3xspLMakD/f3eaz7QWATcIWs3wY
         WTMuaAMmo2k9uID/VQSAnempy+HhrzJFcfgBVR1avO/TYtOHXNJ41zz/NVJ8tCiDHMJl
         EcvfKWOGHpiLLXL/2keqEwMGSOF1xuAukBE2GA+HifSoRGWZyD5rGqwfIAaPyu/7+iOs
         S7L5FNr3JdRjf5XGkj2I8VM1U3KdBhisCi/4vsxqrbr6jlGNkrstIj5DljALd+b0Nw3y
         T+Ug==
X-Received: by 10.112.22.198 with SMTP id g6mr257272lbf.135.1367359234124;
 Tue, 30 Apr 2013 15:00:34 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 15:00:34 -0700 (PDT)
In-Reply-To: <CALkWK0kcuaXTKbafmC72C3H+UZN6oeEY140T21LJUHveO=UBvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223020>

On Tue, Apr 30, 2013 at 1:22 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>> @{-1}@{0} does.  That means @{0} is a revision and not a ref, but @{-1}
>> is.
>
> Right.  I missed that.
>
>> '"@" given alone' has to be a ref if we want @@{5.minutes.ago} to
>> resolve.
>
> Yeah, I just realized that it's a bug in the @{u} implementation.

I don't think so. You probably need to modify branch_get(), because it
has a special case for "HEAD", and who knows if it's hard-coded in
other places. It's not just the @{u} implementation.

If we do the magic at the rev-parsing phase, all these details become
irrelevant.

FTR. @@{upstream} and @@{now} works just fine in v2 of my patch series.

-- 
Felipe Contreras
