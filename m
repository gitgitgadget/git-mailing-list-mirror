From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 23:16:46 +0530
Message-ID: <CAFZEwPOV1oE=5uyyooM1kYKxbuY0Jn=ccxYwsc5sxi0e9cgS6A@mail.gmail.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
	<010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603221552100.4690@virtualbox>
	<alpine.DEB.2.20.1603221610370.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:46:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQOJ-0005r1-T5
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbcCVRqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:46:49 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33304 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbcCVRqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:46:47 -0400
Received: by mail-yw0-f193.google.com with SMTP id a140so13633591ywe.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=MKw0naaXcihWxVwJehVFzO1mvycOXXG7wdcI22+3cxw=;
        b=wv41Qfw5uFy3swpUo9S7ZAjOsI+v6MqVm/rcExhuI7uADp0mT846vl4rfv7oKBRhBq
         BEe8TTxUzldtxN6qFpCL0OiBSh3Pt2F3SZH4t1zrYMkJ/UNgMMos3TtWHWzJ/Zh++ZID
         n7A7WA7P4/WzMTskyFRvRQIhFc7o6vgzedp/i+9RjPSjGV8XIrQvyYSQWJ3x8Oic4icJ
         vPI3iskHEr7WV/ucR8jCrTRel92nimyouyDdxr8DluMFtOnYvrORPpj8DQKSVXTJMZY/
         7bZMWrUYA5imY4aC1jVbtOZqL21G8I9gcIOH/1oiaCySh9ZfO+PvAgiLDY0blJqspmnj
         cukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=MKw0naaXcihWxVwJehVFzO1mvycOXXG7wdcI22+3cxw=;
        b=N/Qrg7tnzrl6Nv3BBiaxh7ImVbjXq2Xb+a+pqLm+33VViyJFy2QtN8r/syFCduG+6M
         NCKN0WXSjRXmpktqwo6d6LiFwYzee4Z11K1kdR3v2+ED1u/c/ZnJCzpAwxXfRNgdd9Dn
         NfRDXFtbZ6BbgZWIZ27QvcUISA1ffpVAxfSBEGePeOFvEHgfQGBfAz/ZwYayR6zPpZkx
         z16LKzkuvrni459QjWvO8fZx0d/NMeg7fAf/rY+IT70jkoiWDvBbvOPSfA70amfEgGnX
         qjd7c8gIl+wfwfd21wzRtwgINnnCpggYBXd1gymufCx2KYdo0r8E9w7JAUUWB8NAWHuF
         68fA==
X-Gm-Message-State: AD7BkJKdNhWC5qiQpavA/nnMuivkWX9VeyI5BFB2iAKasBK73Qoe4Blt6a7HFsiSLlHLzV2i+CbW5v+NgTjNcQ==
X-Received: by 10.129.91.6 with SMTP id p6mr16607886ywb.325.1458668806821;
 Tue, 22 Mar 2016 10:46:46 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Tue, 22 Mar 2016 10:46:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603221610370.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289530>

On Tue, Mar 22, 2016 at 8:41 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 22 Mar 2016, Johannes Schindelin wrote:
>
>> On Tue, 22 Mar 2016, Pranit Bauva wrote:
>>
>> > +   if (!strcmp(term, "bad") || !strcmp(term, "new"))
>> > +           if(strcmp(revision, "bad"))
>> > +                   die("can't change the meaning of term '%s'", term);
>> > +
>> > +   if (!strcmp(term, "good") || !strcmp(term, "old"))
>> > +           if (strcmp(revision, "good"))
>> > +                   die("can't change the meaning of term '%s'", term);
>>
>> These two can be combined. Actually, these *four* can easily be combined:
>>
>>       if ((one_of(term, "bad", "new", NULL) && strcmp(orig, "bad")) ||
>>           (one_of(term, "good", "old", NULL) && strcmp(orig, "good")))
>>               die("can't change the meaning of term '%s'", term);
>
> Completely forgot to mention: This conversion skipped the comment
>
>         # In theory, nothing prevents swapping
>         # completely good and bad, but this situation
>         # could be confusing and hasn't been tested
>         # enough. Forbid it for now.
>
> Let's port that comment over, too?

Sure! Adding a comment won't harm anyone. We can remove it when its
thoroughly tested.
>
> Ciao,
> Johannes
