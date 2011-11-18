From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] Compile fix for MSVC: Move poll.h out of sys-folder
Date: Fri, 18 Nov 2011 17:47:29 +0100
Message-ID: <4EC68C21.7030902@lyx.org>
References: <1321624070-4246-1-git-send-email-vfr@lyx.org> <CABPQNSa+ZjAMSxpBTqGW7P=v-tJTW_jdx3MO=vCpzc-z_XdHTg@mail.gmail.com> <CABPQNSaV-TyznoOsRNQPYEWZCz553cuPOdRsyRQSpzU8QngBZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, msysgit@googlegroups.com,
	j.sixt@viscovery.net
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 18 17:47:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRRbP-0007eK-RM
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 17:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758187Ab1KRQrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 11:47:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63930 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757975Ab1KRQrf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 11:47:35 -0500
Received: by eye27 with SMTP id 27so3547171eye.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 08:47:34 -0800 (PST)
Received: by 10.213.32.200 with SMTP id e8mr639341ebd.46.1321634853986;
        Fri, 18 Nov 2011 08:47:33 -0800 (PST)
Received: from [192.168.1.5] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id 49sm4122252eec.1.2011.11.18.08.47.32
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 08:47:33 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CABPQNSaV-TyznoOsRNQPYEWZCz553cuPOdRsyRQSpzU8QngBZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185669>

Op 18-11-2011 15:28, Erik Faye-Lund schreef:
> On Fri, Nov 18, 2011 at 3:09 PM, Erik Faye-Lund<kusmabite@gmail.com>  wrote:
>> On Fri, Nov 18, 2011 at 2:47 PM, Vincent van Ravesteijn<vfr@lyx.org>  wrote:
>>> In v1.7.7.1-432-g0f77dea (Oct 24 2011; Erik Faye-Lund; mingw: move
>>> poll out of sys-folder) poll.h was moved out of the compat/win32/sys
>>> folder. As the change in the Makefile also affects the MSVC build,
>>> the same must be done for poll.h in compat/vcbuild/include/sys/poll.h.
>>>
>>> Signed-off-by: Vincent van Ravesteijn<vfr@lyx.org>
>>> ---
>>>   compat/vcbuild/include/poll.h     |    1 +
>>>   compat/vcbuild/include/sys/poll.h |    1 -
>>>   2 files changed, 1 insertions(+), 1 deletions(-)
>>>   create mode 100644 compat/vcbuild/include/poll.h
>>>   delete mode 100644 compat/vcbuild/include/sys/poll.h
>>>
>> This looks strange to me. vcbuild/include/poll.h will only prevent the
>> correct header from being included, while compiling an linking against
>> compat/win32/poll.[co]... That seems dangerous to me, because the
>> interface might be declared differently.
>>
>> Instead, I think compat/vcbuild/include/poll.h should be removed, and
>> _WIN32_WINNT set to a value below 0x600. That way the poll-stuff
>> doesn't get pulled in by winsock2.h (as it's Vista and above only).
>>
>> This was already discussed in your "[PATCHv2] Compile fix for MSVC" thread:
>> http://mid.gmane.org/CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com
>>
>> Here's the patch that fixes it.
> Johannes Schindelin was nice enough to create a commit based on my
> e-mail, feel free to pick it up and submit it:
>
> https://github.com/msysgit/git/commit/9ca803910f3625bf686699f6b0bf71a8c68bccae

I resended a patch series including this one.

Vincent
