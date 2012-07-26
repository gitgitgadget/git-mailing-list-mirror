From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 3/3] difftool: Disable --symlinks on cygwin
Date: Thu, 26 Jul 2012 10:39:28 -0700
Message-ID: <CAJDDKr4z_ddwe7s8dY80dZJMNP=75VK6NjOV0WCqFL_LDuMpBA@mail.gmail.com>
References: <1343186064-49350-1-git-send-email-davvid@gmail.com>
	<1343186064-49350-4-git-send-email-davvid@gmail.com>
	<CABPQNSZ=yWxVivadJfh9BMPtqiiGyyEL0vZu+fvsu_Zzhd7yhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 26 19:39:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuS2B-0006yY-6p
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab2GZRja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:39:30 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54687 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab2GZRj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 13:39:29 -0400
Received: by vbbff1 with SMTP id ff1so1900091vbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OAdlNZqm7ZpviJOm/IcWjbQmuSzOilWH1ZKL/kY5ePM=;
        b=J6WWr6eQSNUR8rKShuIb7G78n060b84x4QeTueVwmX+9FXqslLLNqzNkuXKfTewKHB
         V/t0wr1mDsvkC0INddFjdpvfHs9NgH3udmjhJYL/i0UhucEu+vLye4BVbBfKv7KMKTuX
         WDX7pTB51EAtC0ctYyrxG/S7BxVbsC0yHn9XxRm1svDh4Gmz8GBAIT6QCtaOEWnEqE07
         1YqYW+of/8KSs3of9SOJzvzEin+HM5d/70dXlCIiALI0yhapXcCTH5I61/XNK6c9T9/L
         90WdTdRivs1vQN0OK2/MRAqLTWI4lKRr/ng9ZxRmngkdmGfDIcRK85bZ5iPhVqV1dnGu
         RAdA==
Received: by 10.52.90.144 with SMTP id bw16mr19758305vdb.129.1343324369001;
 Thu, 26 Jul 2012 10:39:29 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Thu, 26 Jul 2012 10:39:28 -0700 (PDT)
In-Reply-To: <CABPQNSZ=yWxVivadJfh9BMPtqiiGyyEL0vZu+fvsu_Zzhd7yhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202283>

On Thu, Jul 26, 2012 at 4:31 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Wed, Jul 25, 2012 at 5:14 AM, David Aguilar <davvid@gmail.com> wrote:
>> Symlinks are not ubiquitous on Windows so make --no-symlinks the default.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> I don't have cygwin so I can't verify this one myself.
>> Is 'cygwin' really the value of $^O there?
>>
>>  git-difftool.perl | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-difftool.perl b/git-difftool.perl
>> index 591ee75..10d3d97 100755
>> --- a/git-difftool.perl
>> +++ b/git-difftool.perl
>> @@ -291,7 +291,8 @@ sub main
>>                 gui => undef,
>>                 help => undef,
>>                 prompt => undef,
>> -               symlinks => $^O ne 'MSWin32' && $^O ne 'msys',
>> +               symlinks => $^O ne 'cygwin' &&
>> +                               $^O ne 'MSWin32' && $^O ne 'msys',
>
> I thought Cygwin supported (their own version of) symlinks? What's the
> rationale for not using it by default there?

I am not a Cygwin user so I cannot verify whether it is a good or bad idea.

I have a few questions regarding symlinks on Cygwin:

Do the symlinks work consistently with the Perl symlink() function?
Can we always rely on this capability being available?
Do all win32 filesystems support it?
Do all builds of cygwin perl support it?

If any of these answers are "no" or "maybe", then an improvement
beyond this patch would be to perhaps support a `difftool.symlinks`
configuration variable so that the user can tell us what to use as the
default.
-- 
David
