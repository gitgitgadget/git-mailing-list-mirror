From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/2] strbuf: create strbuf_humanize() to show byte sizes
Date: Wed, 10 Apr 2013 22:00:25 +0200
Message-ID: <CALWbr2zciCO2Gzr_Hkg3oftYLtDkrPFrazP4HgRyPv=vYH5sXg@mail.gmail.com>
References: <7vli8svgyo.fsf@alter.siamese.dyndns.org>
	<1365620604-17851-1-git-send-email-apelisse@gmail.com>
	<20130410194307.GA27070@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:00:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1C2-0002BQ-9m
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936003Ab3DJUA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:00:26 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:50292 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934822Ab3DJUAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:00:25 -0400
Received: by mail-qe0-f49.google.com with SMTP id 6so487013qeb.8
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=fAWUlTsaaXsLXFKfxWO+x3oRfrRf+Fr6JY/rVsCaRQI=;
        b=ajp8mufz8MjTT0SCJq505l7pEO1+xkIsrsdW2qNTz0q7SMztx1mcsmkm8hnzTn5Zt2
         RxCWrhtuDqXvk6aDuFsQX5qNgnYqq0i5mrNKQTXUCawg1bnojZO1ZED+tmhN28KgBhHW
         RijyZqQZudEK2Gf0qTKIGpXuYbnjIkYO6+c+pDwRrFeuu+VHQlqn2DFjnYilgRMH3bCT
         7tVNLEins+sBlaqTTkdSPTne8DTsfT2g7hzUemgmzjtboxyKQEz9WuE7kaHo6Vk1XLmE
         HSHb3knzjIp+4hh1VC1ntLHE69T8shjH6SJzTLkyHj3sOGbfepF9aOML2XH3pXsCZpiY
         YpVA==
X-Received: by 10.49.95.163 with SMTP id dl3mr4363155qeb.38.1365624025110;
 Wed, 10 Apr 2013 13:00:25 -0700 (PDT)
Received: by 10.49.118.42 with HTTP; Wed, 10 Apr 2013 13:00:25 -0700 (PDT)
In-Reply-To: <20130410194307.GA27070@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220742>

On Wed, Apr 10, 2013 at 9:43 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Antoine Pelisse wrote:
>>                    One of the drawbacks is that speed will now look like
>> this when download is stalled: "0 bytes/s" instead of "0 KiB/s".
>
> At first glance that is neither obviously a benefit nor obviously a
> drawback.  Can you spell this out more?

The drawback to me is that it changes the user experience with no reason.
But that's really a minor change, I agree. (maybe I should have put it
as a comment/question after ---)

>> --- a/Documentation/technical/api-strbuf.txt
>> +++ b/Documentation/technical/api-strbuf.txt
>> @@ -230,6 +230,11 @@ which can be used by the programmer of the callback as she sees fit.
>>       destination. This is useful for literal data to be fed to either
>>       strbuf_expand or to the *printf family of functions.
>>
>> +`strbuf_humanize`::
>> +
>> +     Append the given byte size as a human-readable string (i.e. 12.23 KiB,
>> +     3.50 MiB).
>
> Based on the function name alone, it is not easy to guess what it will
> do (e.g., maybe it will paraphrase 3 to "three" and 10000000 to
> "enormous").  How about something like strbuf_filesize?

I think the suggestion from Junio makes more sense, as it can be used
for download speed.

> If I understand the code correctly, this jumps units each time it
> exceeds 1.0 of the next unit (bytes, KiB, MiB, GiB), which sounds like
> a fine behavior.

The code has simply been extracted from the former function and kept unmodified.

Thanks for the help !
Antoine,
