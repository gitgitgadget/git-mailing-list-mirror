From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Compiling on Windows
Date: Fri, 21 Oct 2011 13:41:25 +0200
Message-ID: <CABPQNSYkBg9pc15kCgzcoqhHFVom48zxYmT4N1GbyRsdLvC9iA@mail.gmail.com>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
 <4E9E811C.10205@lyx.org> <2015B7F2CEAE4B449EA4EF744F9B8FD9@PhilipOakley> <4EA094D2.7050807@lyx.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Git MsysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 13:42:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHDUJ-0006xt-Ts
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 13:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab1JULmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 07:42:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:44889 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1JULmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 07:42:05 -0400
Received: by pzk36 with SMTP id 36so9335130pzk.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jPljP6BPtVG+kNk7F7DXxnbGKnWYu89BOgyUbFN19oM=;
        b=vDQ/xk3GDJ0d0nECSlrwpTTfDJWpzcjAkxFEaWXXibr9k6tPR1pJCtfgjXgfvawehO
         vyQgQbPyQ0yI3P3cc7ncUJ0MhXl1AMsb17Hc99lt1gH2kZ9IaNaWU6jHHgZvrroLba6/
         28h0vryj6gOMtufkQHJed/MPD+qsPJa8mfLLM=
Received: by 10.68.17.197 with SMTP id q5mr18147118pbd.25.1319197325031; Fri,
 21 Oct 2011 04:42:05 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Fri, 21 Oct 2011 04:41:25 -0700 (PDT)
In-Reply-To: <4EA094D2.7050807@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184054>

On Thu, Oct 20, 2011 at 11:38 PM, Vincent van Ravesteijn <vfr@lyx.org> wrote:
>
>>> I once wrote a little step-by-step tutorial on how to compile the native
>>> Windows Git with MSVC (Express).
>>>
>>> http://blog.vfrconsultancy.nl/#post0
>>
>> The blog post filled in a few gaps in the Msysgit README instructions
>> about where to place the various downloads described.
>
> I updated the post a little so that it actually works again. I somehow like
> to have a real native Windows compilation of Git.

Git for Windows is a "real native Windows compilation of Git". You
don't need a MSVC-compiled binary for that.

> To successfully compile Git, we also need to change
>>
>> #include <sys/resource.h>
>
> into
>>
>> #include <io.h>
>
> I have seen some communication about this in the past, but nobody cared
> enough to fix this.
>

There's been some patches dealing with this recently on the msysgit
mailing list. Look for the patches prefixed with "MSVC" in Karsten
Blees' Unicode series. They will be kicked out of the next iteration
of the Unicode series, but if you want to pick them up, clean up the
issues pointed out and re-submit them, that'd be very welcome.

> Shall I sent a patch that adds a file "compat/win32/sys/resource.h" which
> just includes "io.h" ? Or is there another more prefered way to fix this ?

I would prefer <io.h> to be included from compat/msvc.h instead,
because <io.h> isn't a <sys/resource.h> replacement.

As for the missing <sys/resource.h>, I'm not so sure. We don't have
<sys/resource.h> in msysGit either, and I personally don't like the
whole adding-stub-headers approach too much, but it does seem to be
the precedence set for the MSVC-build...

In general I'd say that no-one have worked the MSVC-support in a
while, patches would be welcome :)
