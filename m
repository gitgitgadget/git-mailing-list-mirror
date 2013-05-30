From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] wildmatch: properly fold case everywhere
Date: Thu, 30 May 2013 07:04:30 +0700
Message-ID: <CACsJy8CuaowyZJGKh7X+43qRwYAdUCDbVo8P5CpEtukBzRiReg@mail.gmail.com>
References: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com>
 <1369749497-55610-1-git-send-email-n.oxyde@gmail.com> <CACsJy8CY_T44ymUnLWv4FpF3zpL3WKSysJ1wBhfxGHNPJ6kSmg@mail.gmail.com>
 <4E816EBA-A22D-4507-BED0-0DE55D2E619C@gmail.com> <CACsJy8A61nYu9a-BhUiBhBEv-e6_CtYyZE3sG9iCiau+3EKVdw@mail.gmail.com>
 <BAB62C57-FE7D-476A-ACA7-5831BAF3E558@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Anthony Ramine <n.oxyde@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 02:05:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhqMh-0004ZY-4t
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 02:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967266Ab3E3AFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 20:05:04 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:58102 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967257Ab3E3AFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 20:05:01 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so5015843obb.28
        for <git@vger.kernel.org>; Wed, 29 May 2013 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NIqTRdNqso/ulhCkR14eV0JtO/6Kqu3Ew8ECg2Wt6A4=;
        b=MP/cprrFBe4XcGI55E/r0QaxQnNJNH4R0xHGx9Z7OydBBd3fmIBUVaU2OilSLRhmTA
         qMWg7GjCdzctw2VwkFuTotv/zLJj1SG8ER5z5zer2FJQuHwF2i0Ot/P+9zsoqkr2PpGg
         gz5LadakpnDxRagymJVJ71LPh1Wi9OlbJyaChdT6xkYqUowFiPzRqnNt7/223EUXWsma
         Rr5vk45gqWZW1Vyz2h/WUcLUO9udmBjHtQ2fMJad4X+eU8LnSn6+j1toEhK7fXNMlo/+
         qWY4eirhWOsxQuolXwMb34VqF/P9K0RMB+1g/YXDXKEM+lxbA305Lo19WZZliZZQrPUc
         hrbQ==
X-Received: by 10.182.19.168 with SMTP id g8mr3152289obe.21.1369872300946;
 Wed, 29 May 2013 17:05:00 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Wed, 29 May 2013 17:04:30 -0700 (PDT)
In-Reply-To: <BAB62C57-FE7D-476A-ACA7-5831BAF3E558@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225903>

On Thu, May 30, 2013 at 12:57 AM, Anthony Ramine <n.oxyde@gmail.com> wrote:
>>> If the range to match against is [A-_], it will become [a-_] which is an empty range, ord('a') > ord('_'). I think it is simpler to reuse toupper() after the fact as I did.
>>>
>>> Anyway maybe I should add a test for that corner case?
>>
>> Yeah I was thinking about such a case, but I saw glibc do it... I
>> guess we just found another bug, at least in compat/fnmatch.c. Yes a
>> test for it would be great, in case I change my mind 2 years from now
>> and decide to turn it the other way ;)
>
> Should I patch compat/fnmatch.c too? That would make it different from the glibc's one.

No. I plan to remove compat/fnmatch and always use wildmatch, even
ignoring system's fnmatch. That would keep the matching behavior
consistent across platforms.
--
Duy
