From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #03; Fri, 11)
Date: Wed, 16 Apr 2014 06:18:33 +0700
Message-ID: <CACsJy8C_WU_-73+VF0KV1X1BLDSWH_C35jPjMcrjR2OW3s9z-Q@mail.gmail.com>
References: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com> <534985F3.6060501@ramsay1.demon.co.uk>
 <xmqqeh0ylext.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 01:19:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaCdD-0004Rb-SP
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 01:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbaDOXTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 19:19:06 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:56807 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaDOXTE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 19:19:04 -0400
Received: by mail-qc0-f171.google.com with SMTP id c9so11164000qcz.16
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MIuovb5O4CSQcatBNBDIBi5G6MlRwp8Vk8NmxkZhQvk=;
        b=KwgPnmuYR3Xk9z8u34074c/iWfaTONXpbuuXihdK21QYsmdlTcOR7DfXFk4QG1rg9S
         7M05bm9LxNsXihZ/jVw657gYo8u0SSl1u+9sS3zwh+iGP2pKH9MAa5CZ8RpuyXcIVC2Q
         8jVQEJ8Ssz3ogpgD8JFR8f0jPKnATcQehnZCIRL2/bBLo8zosfNXNlQApOX20BpwXCK8
         +27/WbDgGx7gTZ70/gCUlOw06+p0iGF2U0TQJoLnjzeeCT093QGOd/SzDcM53O+NQWAF
         GnF9v4T7rckGaclQ9LTuxzkqm/OX4kUPW+s1mIjRK06neL5IKnIa+5TQBp9YGZbSxfg1
         VUUQ==
X-Received: by 10.224.44.17 with SMTP id y17mr1214554qae.36.1397603943726;
 Tue, 15 Apr 2014 16:19:03 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 15 Apr 2014 16:18:33 -0700 (PDT)
In-Reply-To: <xmqqeh0ylext.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246308>

On Tue, Apr 15, 2014 at 11:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> On 11/04/14 23:22, Junio C Hamano wrote:
>> [...]
>>> [New Topics]
>>>
>>> * nd/index-pack-one-fd-per-thread (2014-04-09) 1 commit
>>>  - index-pack: work around thread-unsafe pread()
>>>
>>>  Enable threaded index-pack on platforms without thread-unsafe
>>>  pread() emulation.
>>>
>>>  Will merge to 'next' and keep it there for the remainder of the cycle.
>>
>> The commit message for commit 512ebe5d ("index-pack: work around
>> thread-unsafe pread()", 25-03-2014) is a little misleading.
>
> OK.  Can we have a concrete alternative?
>
>     Multi-threaing of index-pack was disabled with c0f8654
>     (index-pack: Disable threading on cygwin - 2012-06-26), because
>     pread() implementations for Cygwin and MSYS were not thread
>     safe.  Recent Cygwin does offer usable pread() and we enabled
>     multi-threading with 103d530f (Cygwin 1.7 has thread-safe pread,
>     2013-07-19).
>
>     Work around this problem on platforms with a thread-unsafe
>     pread() emulation by opening one file handle per thread; it
>     would prevent parallel pread() on different file handles from
>     stepping on each other.
>
>     Also remove NO_THREAD_SAFE_PREAD that was introduced in c0f8654
>     because it's no longer used anywhere.
>
>     This workaround is unconditional, even for platforms with
>     thread-safe pread() because the overhead is small (a couple file
>     handles more) and not worth fragmenting the code.
>

OK to me.
-- 
Duy
