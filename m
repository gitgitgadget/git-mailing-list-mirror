From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git fails: segfault at 0 ip 00000000004076d5 sp 00007fff7806ebc0
Date: Fri, 12 Oct 2012 18:34:30 +0200
Message-ID: <CABPQNSbRYq43rADP6BaQ_Q2SB+M76rHdX3hOSpGQk2c5UNR5hg@mail.gmail.com>
References: <CAJa+X0OkzAX9E2SnDmU=on0yzzVZ9OMa2dJZgKMK=gQu2Rhf_Q@mail.gmail.com>
 <CAJa+X0MefHXTu_D7-SN8itQVO4sMyc4O7=bK=-sUP+W4GHOu9g@mail.gmail.com> <CABPQNSYyh-gk8aD9SKLzo0MDBkGECthdGZiT1mB1pA0ajdB8Cw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Brad Hein <linuxbrad@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 18:35:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMiCs-0007di-AN
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 18:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759792Ab2JLQfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 12:35:13 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37388 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759586Ab2JLQfM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 12:35:12 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3198543vbb.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=20MSqGmxKRZ8tZXCXTfthSptf4eY/l17aaxYOON3k9A=;
        b=K/eKKfMxhRrSy0JUXHQLr70sb4c07Hyp+tM8XZz/ethi/r2jdjsT87QX/8HLqXDJV1
         KHTIDeJt/Hh6TG9F1WPId/88a+if83lzVSmnJ6tkOsfieHDyJ3NiEcTx8u68t4l6ivC/
         98mtZnxqCqb6olgl6HOTneJJYkpxYiTvFRmJmthlJ4ANoPYscglmO+pLRbJxV1au3tnB
         2Qn6/J0kcGcmsmci8Ied7wNUyNadO+Y3r32io088CQ2QxQEuGHg+fQsFdK7lIgZyToAC
         VH0WI/bvNV+FNU2fx4u9R1guPD+uS+5h9s8MZRo/Hi4DiLXR6pzmZPgd5hMKZuFS2Twr
         qKIQ==
Received: by 10.52.26.81 with SMTP id j17mr2350388vdg.63.1350059711373; Fri,
 12 Oct 2012 09:35:11 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 12 Oct 2012 09:34:30 -0700 (PDT)
In-Reply-To: <CABPQNSYyh-gk8aD9SKLzo0MDBkGECthdGZiT1mB1pA0ajdB8Cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207553>

On Fri, Oct 12, 2012 at 6:29 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Fri, Oct 12, 2012 at 6:58 AM, Brad Hein <linuxbrad@gmail.com> wrote:
>> In Fedora 17
>> With git-1.7.11.7-1.fc17.x86_64 (rpm)
>>
>> I try to clone a particular repository but git just returns, having
>> not cloned the repo. Seems like a bug. Details follow:
>>   $ git clone http://gnuradio.org/git/gnuradio.git
>>
>> While the command fails a message is logged to syslog. Repeated
>> attempts to clone the repo yield the same result:
>>   Oct 11 21:38:25 localhost kernel: [662703.442645]
>> git-remote-http[25796]: segfault at 0 ip 00000000004076d5 sp
>> 00007fff7806ebc0 error 4 in git-remote-http[400000+96000]
>>   Oct 11 21:39:00 localhost kernel: [662737.899829]
>> git-remote-http[25837]: segfault at 0 ip 00000000004076d5 sp
>> 00007fff37c5ef20 error 4 in git-remote-http[400000+96000]
>>   Oct 11 21:39:25 localhost kernel: [662763.341248]
>> git-remote-http[25873]: segfault at 0 ip 00000000004076d5 sp
>> 00007fff6310d470 error 4 in git-remote-http[400000+96000]
>>
>> A tcpdump reveals that the last thing the client does is requests a
>> file that doesn't exist on the server (404). Details are in my post on
>> FedoraForums: http://forums.fedoraforum.org/showthread.php?p=1607891&posted=1#post1607891
>>
>> Problem mitigated by downgrade to "git-1.7.10.1-1.fc17.x86_64" or
>> "git-1.7.11.4-3.fc17.x86_64" or try to clone a different repository.
>
> Thanks for reporting. I gave it a quick go, and the issue seems to
> also be present in the current 'master'.
>
> The problem is a NULL-pointer dereferencing introduced in 8809703
> ("http: factor out http error code handling"), where the code assume
> that slot->results still points to http_request::results. This
> assumption seems to be wrong.
>
> This seems to step around the issue, but I don't know if
> http_request::results should be set to NULL in the first place. Jeff?

OK, it seems I jumped the gun, and Jeff already sent out a patch for
it. Nevermind me, then :)
