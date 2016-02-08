From: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Mon, 8 Feb 2016 12:11:57 +0300
Message-ID: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
	<xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
	<20160202232952.GA6503@vauxhall.crustytoothpaste.net>
	<CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
	<20160205204648.GA7403@vauxhall.crustytoothpaste.net>
	<xmqqa8nedg59.fsf@gitster.mtv.corp.google.com>
	<20160205210623.GC7403@vauxhall.crustytoothpaste.net>
	<xmqq60y2dduw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 10:12:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aShrc-0000LL-3z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 10:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbcBHJMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 04:12:01 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33532 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbcBHJL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 04:11:58 -0500
Received: by mail-ob0-f175.google.com with SMTP id is5so143746508obc.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 01:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wmWhBcfrR+V5ClpwSHP7IrqNphxhCerNhxUehOE151Y=;
        b=U9RVjBHd2wJugS0HJ1OzBLy09K0+Wy18RmJOy/DkZ4I/x2sAsPaou7zTYT7CLXPXIj
         71AR2OYKMVBsEg25qC43D7Br8uJFgtkt0qBln/ZTM5elToaTe7IbQJ0oicU4DVCztaPi
         v0/yHVGsE/8Alz1pRwittLmnGsdS/1V8JH6+Vi+3wilg4OP4XeCUsCx//P7nN9eCkUTT
         NcazfcEw9rWhtdTEK1cRXfZL+HshWZZCKEDohRqYRqPsLEtxTHQkwtVdf/O/bQxfbItw
         cAc/QTO6AgQO8gcAWRCixqPTt+B17LdddKWPxvF2hEuXziBMWMRcsTlSVosKRG5nH4VQ
         fYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wmWhBcfrR+V5ClpwSHP7IrqNphxhCerNhxUehOE151Y=;
        b=W/eWgJYxGdLEmkkKPYbeMk/eT7wOEnQ138vkldGeGsVZg2kTGvc25iPv8v67NQaTj9
         rduyGcNxmYeVJ5qyEwvzOXZqLYhyP9YfSvmX58HJ3uKOer8jEIZuFaOgBuVnVwoc4qjt
         Mu1FpEcWDpXJSLpmOZz6UtKLWA7Dw44JsEFqs9/FQ1XDzrfN5QFdw4q7A1LlfqeWqv5l
         uKl5QwGBNZMJIlT9+SWj4aanvcKyGSSdJ8iJ6x50Su+YChi22JaIXH/0iblM3HuHKxTt
         t14CGZVXI9juWCqclJ25jPfBWQBn1w7Q6VqMUzkSPlgdLE/bdcna0aiYpfIjQ0ilUuIO
         2gFw==
X-Gm-Message-State: AG10YOQq7z9yrLvhJveH73oCnZtVKeeG0c0rsQq4GtdxkHFU8qHgQiu6SWXEdEA4niZcThM3uFIuiTK4Kp5mow==
X-Received: by 10.60.162.102 with SMTP id xz6mr11638208oeb.62.1454922717935;
 Mon, 08 Feb 2016 01:11:57 -0800 (PST)
Received: by 10.76.35.162 with HTTP; Mon, 8 Feb 2016 01:11:57 -0800 (PST)
In-Reply-To: <xmqq60y2dduw.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: FUHyeW9k9jdVTERoDxBraQNsjek
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285753>

2016-02-06 0:52 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On Fri, Feb 05, 2016 at 01:02:58PM -0800, Junio C Hamano wrote:
>>> Hmph, so documenting that <emptyname>:<emptypassword>@<repository>
>>> as a supported way might be an ugly-looking solution to the original
>>> problem.  A less ugly-looking solution might be a boolean that can
>>> be set per URL (we already have urlmatch-config infrastructure to
>>> help us do so) to tell us to pass the empty credential to lubCurl,
>>> bypassing the step to ask the user for password that we do not use.
>>>
>>> The end-result of either of these solution would strictly be better
>>> than the patch we discussed in that the end user will not have to
>>> interact with the prompt at all, right?
>>
>> Yes, that's true.  I'll try to come up with a patch this weekend that
>> implements that (maybe remote.forceAuth = true or somesuch).
>
> Thanks.
>
> I think the configuration should live inside http.* namespace, as
> there are already things like http[.<url>].sslCert and friends.
>
> I do not have a good suggestion on the name of the leaf-level
> variable.  ForceAuth sounds as if you are forcing authentication
> even when the other side does not require it, though.

That would be great! Definitely it will be much better solution than
patch I've proposed.
