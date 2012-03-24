From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Sat, 24 Mar 2012 15:58:46 +0700
Message-ID: <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
 <87aa3aw5z8.fsf@thomas.inf.ethz.ch> <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
 <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
 <CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
 <CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
 <CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com> <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 09:59:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBMon-0005AB-4d
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 09:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab2CXI7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 04:59:19 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:65056 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab2CXI7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 04:59:18 -0400
Received: by wibhq7 with SMTP id hq7so2778104wib.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 01:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=R9IfxrlB6cCHfV3MgXB7QsQiKMlwKS+GUpDNfoz3TL8=;
        b=VLyqIV/jhM4tw1xtsaxMHSU6ObSD4demoRdBxgahjtoWVdjxsnA0oEW6zeNtfRdJNe
         7ZuMcjSENXwpWvpH8eUwvlfHWHvsjjSLf/wQfFbL0sv+4mANIntV7uxEnI0dO/A2UmY5
         uiWLLDOYDmqFlL9r0NegAQ2icOyF9oE32HB/OWdBftP63QQF3GgFSOlaRxKMEq6iY95E
         NsOpibNzh6s8X+75wLi3zN3ALjt4QX6PVKVMycyPi3QZGb+0qjrjaIKpsmZB9B31yr9Z
         ryBFoAZtpMzCvY5BodL5kmQblMMHqqM0h0RWtxaeOORO4sWH1glq2A/blQHuK0KgjpM3
         NfHA==
Received: by 10.216.135.225 with SMTP id u75mr8010468wei.97.1332579557059;
 Sat, 24 Mar 2012 01:59:17 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Sat, 24 Mar 2012 01:58:46 -0700 (PDT)
In-Reply-To: <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193822>

On Sat, Mar 24, 2012 at 2:50 PM, elton sky <eltonsky9404@gmail.com> wrote:
> Thanks again Nguyen,
>
>> Which reminds me, we cannot abandon current index format. Users should
>> be allowed to choose which format to use. It may be hard to keep the
>> code support two formats while still taking advantage of the new one.
>> Maybe you could internally convert old format to new one in memory so
>> that git code only has to deal with one format, but that adds more
>> cost on using old format. I don't know..
>
> I understand we should allow user to switch between old & new format.
> But I guess that should only happens when user init a working dir,
> isn't it? Otherwise I have to transform them back n forth. If a user
> chooses to use old format, I assume their repository is not large, so
> there should not be big delay for new format.

Users may choose to stick with old format because other git tools rely
on that (or they want to use older git versions at the same time).
Note that current index works "fine" with ~50k files in working
directory. Not huge, but not small either. Overhead on old format
should be reasonable.
-- 
Duy
