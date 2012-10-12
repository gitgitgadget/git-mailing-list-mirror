From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: build deps
Date: Fri, 12 Oct 2012 01:08:16 -0300
Message-ID: <CACnwZYfmz1BTo6okzFh8jXbw+0MAV0sEanYXNzAnV7L4p7nY_g@mail.gmail.com>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
	<5072FAD1.1000807@gmail.com>
	<CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
	<50735939.10604@gmail.com>
	<CACnwZYf56XkqW085HoWhAN2EnjCJd=VYHGAD8fZCCe6_FNhO2A@mail.gmail.com>
	<50776D0D.9090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Andrew Wong <andrew.kw.w.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 06:08:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMWY1-0000Ac-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 06:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab2JLEIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 00:08:18 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40726 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab2JLEIR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 00:08:17 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1800247lbo.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ssYBIvxCIaxS5DvaHeo5HCB9SaebP4/XSQq6M3yJ0oM=;
        b=q/QExvFUUC09maOwASMPT4XW8IWLXmYrzM1zz67A3y8ZIMWZ73MphWw0buPkP5g9fQ
         GfjJxy017WnOUy1rEpo2zpJT99HskPfhtyxpvu10D2u88j5jQzxQBLvdQAUqN37b0eeY
         kzgB4StNkqJoZ0PTqsUjIkcJnhCaqEGNntr3IbqqfZWTWs3i2V+rANJpId0xSJ2cd3uK
         dOZllGglqWnUwkRGl8TwHOlEhdTX1YQHTPYiFr0l9fAbWQGAS5sMxIA2ChgNIWdZnYmS
         CeEHikJkwoY/ewEHPRvH27oOHSb3v1IkonIOpQGIelrp5fHXbc1oj44CnD7DBtmlKORH
         jnJg==
Received: by 10.112.24.74 with SMTP id s10mr1152211lbf.122.1350014896150; Thu,
 11 Oct 2012 21:08:16 -0700 (PDT)
Received: by 10.112.24.10 with HTTP; Thu, 11 Oct 2012 21:08:16 -0700 (PDT)
In-Reply-To: <50776D0D.9090306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207527>

On Thu, Oct 11, 2012 at 10:06 PM, Andrew Wong
<andrew.kw.w.lists@gmail.com> wrote:
> On 10/11/12 16:54, Thiago Farina wrote:
>> Just setting CC to gcc works for me. But still, I'd like to be able to
>> build with clang (may be as you noted is just something with the + in
>> my PATH).
> Oh, I just realized you were using "sudo". The PATH environment was
> probably not inherited when you use sudo to run "make". So the
> subsequent shells statred by "make' were not able to find "clang".

Interesting, thank you for your observation.

This worked for me now:

$ git clone  https://github.com/gitster/git
$ cd git
$ make configure
$ ./configure
$ make
$ ./git version
git version 1.8.0.rc2

clang reported this:
combine-diff.c:1006:19: warning: adding 'int' to a string does not
append to the string [-Wstring-plus-int]
                prefix = COLONS + offset;
                         ~~~~~~~^~~~~~~~
combine-diff.c:1006:19: note: use array indexing to silence this
warning
                prefix = COLONS + offset;
                                ^
                         &      [       ]
1 warning generated.

grep.c:451:16: warning: comparison of unsigned enum expression < 0 is
always false [-Wtautological-compare]
                if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
                    ~~~~~~~~ ^ ~
1 warning generated.
