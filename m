From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] glossary-content.txt: remove an obsolete paragrah
Date: Fri, 22 Nov 2013 08:36:46 +0700
Message-ID: <CACsJy8C38PUCYMSdEJ1-S5HSNdJO7S24mhkEryFrSGfwKuaU0A@mail.gmail.com>
References: <1384910801-11125-1-git-send-email-pclouds@gmail.com>
 <1385016260-9718-1-git-send-email-pclouds@gmail.com> <xmqqtxf54o83.fsf@gitster.dls.corp.google.com>
 <xmqqy54h1f9q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 02:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjfgQ-0007Ja-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 02:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab3KVBhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 20:37:20 -0500
Received: from mail-qe0-f52.google.com ([209.85.128.52]:57750 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab3KVBhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 20:37:17 -0500
Received: by mail-qe0-f52.google.com with SMTP id ne12so481207qeb.39
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 17:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PeM4eVLz1j3lvaWxQmphiZLTT7trXjAjt6HkRe7imM8=;
        b=fYZrxFD5HmGuFgxfJXy1mY4cTfJBDAaSr6YZft4IIXzE9cqS3G69M58M+hRA8HwwNc
         buwHLMD5xN4kQOuq0z999UC7nMp0Dv3EB5q04NhYJsgz1nhWnv9HGHBIoeXSVj4BsSRq
         HCVfUlrtDsmu8vfzEhsEXgrQ93BNm9j5NNx3+gSo1P6jA0hSlfc+SmbW2cap0SFRBAUw
         UfBySkfNQXvmhNgGtM7BBGjsGF0se+4Of1LMA741sRlMAoFwSrEePx/eQZ81CGLh2N0V
         lWw+DUAfkL2OZ+wx021n+a06H9SH8uTQ+QdxEXJkYxhynJi2EEkpe+hjyDsSnUZjALGm
         lPcA==
X-Received: by 10.49.24.202 with SMTP id w10mr17291094qef.12.1385084236337;
 Thu, 21 Nov 2013 17:37:16 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Thu, 21 Nov 2013 17:36:46 -0800 (PST)
In-Reply-To: <xmqqy54h1f9q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238170>

On Fri, Nov 22, 2013 at 6:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> An addendum.
>
>> As we can see in a later paragaph:
>>
>>     The "magic signature" consists of an ASCII symbol that is not
>>     alphanumeric. Currently only the slash `/` is recognized as a
>>     "magic signature"...
>>
>> the correct way to read that "a character that cannot be a magic
>> signature" is "a character that is not 'an ASCII symbol that is not
>> alphanumeric'", which means you can do:
>>
>>       :!/foo  - with magic signatures ! and /, pattern begins at 'f'
>>
>>       :/#abc  - with magic signatures # and /, pattern begins at 'a',
>>                 even if in a particular version of Git, '#' magic
>>                 signature may be invalid and produce an error
>>
>>       :/:#abc - with magic signature /, pattern is "#abc".
>>
>> but because the definition of "magic signature" syntax comes later
>> than "cannot be", it is prone to be misinterpreted as "anything that
>> is not currently defined as a magic signature (namely, '/')".
>
> ... and that misinterpretation may give a false impression that
>
>         ":/#abc"
>
> is with the magic signature '/' (i.e. match from top) for a pattern
> "#abc".
>
> Doing so would mean that a version of Git that does not support a
> magic signature '#' will allow people and scripts to use ":/#abc"
> with such a meaning, and will prevent us from using '#' as a new
> magic signature with some useful meaning in the future.  Rather, we
> need to force them to always spell it as ":/:#abc" even in the
> version of Git before the magic signature '#'.

Current version does force that.

$ git log -- ':/#aa'
fatal: Unimplemented pathspec magic '#' in ':/#aa'

Not sure if there are tests for it though. I'll add an advice to do ":/:#aa".

> And the phrasing 'if the pattern begins with a character that cannot
> be a "magic signature" and is not a colon' needs to be clarified to
> avoid that misinterpretation for that reason.
-- 
Duy
