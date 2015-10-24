From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Sat, 24 Oct 2015 17:47:03 -0400
Message-ID: <CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	<xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
	<CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 23:47:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq6ed-0000Oj-JB
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 23:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbbJXVrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 17:47:06 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33692 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbbJXVrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 17:47:04 -0400
Received: by wijp11 with SMTP id p11so119046734wij.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MTicjZJCg5K3NouiKLOgRXPsGe9PzsJFfiRGCMEKUE0=;
        b=n3LN8HXuqkBP7nF6bCeRh+ndUst3vdTTcTkL+R5zhoHWQqWQLMdc/BNYXOY797PxuI
         oz62SdjZLvHpdSPCRwY+/HF+lsUPnLUr38XWTSZ5JEzBn8XRexL+hJiBNqjPh0E3eHHo
         +BAk2tlFg/uOurlTKZTm6r8SMT4FFxDXtcwTW+TO1/5WZQYMDDDEEkwZLwZNrgISxdel
         a5AiJX6NTDzFZcteIZaeKHk2CXtJnQ7ET5NFkNb2t3E45CYthatFkZ1vXBFTjKgYNiBx
         o0Wk2iTUvcQeqCHpLfIdJdLV5gJ65FnkvFlFqxw9w1WMtch8qajRRYdQBVybvKRWHCp3
         3KTA==
X-Received: by 10.194.57.8 with SMTP id e8mr14018043wjq.32.1445723223480; Sat,
 24 Oct 2015 14:47:03 -0700 (PDT)
Received: by 10.28.29.87 with HTTP; Sat, 24 Oct 2015 14:47:03 -0700 (PDT)
In-Reply-To: <CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
X-Google-Sender-Auth: -b4ir36o9d0iuTlEZpA5BGIuV3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280133>

On Tue, Oct 20, 2015 at 10:35 PM, Noam Postavsky
<npostavs@users.sourceforge.net> wrote:
> On Sun, Oct 18, 2015 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I cannot speak for the person who was primarily responsible for
>> designing this behaviour, but I happen to agree with the current
>> behaviour in the situation where it was designed to be used.  Upon
>> the first use in your session, the "daemon" is auto-spawned, you can
>> keep talking with that same instance during your session, and you do
>> not have to do anything special to shut it down when you log out.
>> Isn't that what happens here?
>
> After looking at this some more, I've discovered this is NOT what
> actually happens here. If I "git push" from a shell and then log out
> and log in again, another "git push" does NOT ask me for a password.
> In other words, the daemon is NOT shut down automatically when I log
> out. Given that, does it make sense to change the daemon to ignore
> SIGHUP, or is there some way to change it so that it does exit on
> logout?

ping?
