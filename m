From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: Git hangs on clone
Date: Sat, 11 Aug 2012 18:08:57 +0200
Message-ID: <CA+EOSBkD_R5-5JGX-VZ82dz=8Vp-TvyU3eurBzrapD3DoQcEJQ@mail.gmail.com>
References: <CAL8jUGVZFott2Tp0mYTjGAG-4jCw_pgf70ZkYJ3XYOF9DZqVNQ@mail.gmail.com>
	<CAL8jUGUUkK-82BzJZ1iLVZ00_KbzsLhzAub26P8mddXipVoAng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Paul Alesius <paul@unnservice.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 18:09:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0EFO-0003bu-GG
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 18:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab2HKQI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 12:08:59 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37328 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab2HKQI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 12:08:58 -0400
Received: by ggdk6 with SMTP id k6so2424747ggd.19
        for <git@vger.kernel.org>; Sat, 11 Aug 2012 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=P+LaXbPovWNqX5+xoJsS216J7bmxCdZDe6w+v8YczFg=;
        b=tllzC8XvAheMwk3iCRcXufNSOAUJ2QUTp02gk93xui40BEm4bEKtZlryeP3u0o+YGf
         BERjVOf7DjFCi3SvPkaX6Rx+QIIgnEOoKSllU/1S4aJ0Q9LWQAsER4F73PMkgh3Kqqh3
         HOFdKuHSvRR20B6mIREB6NAozomKTru2V0HYHArNsXPJX9iPeJmN6CAHXYsbERLxztHb
         eMzXLH1w7OujYzxv0h8FeUen30Gm1qDFMfO4zOluJOBjuNsoDrtgaXwQGZOwE5XzkjJG
         vwFHsTe4O44x4EaW2uvX3ON4pCkLxLMPEsj2RGxQWXyMOndGqwHYirujpxRy9h5jeu6H
         REJQ==
Received: by 10.50.88.168 with SMTP id bh8mr1357223igb.3.1344701337947; Sat,
 11 Aug 2012 09:08:57 -0700 (PDT)
Received: by 10.64.104.66 with HTTP; Sat, 11 Aug 2012 09:08:57 -0700 (PDT)
In-Reply-To: <CAL8jUGUUkK-82BzJZ1iLVZ00_KbzsLhzAub26P8mddXipVoAng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203287>

Difficult that it is a git problem. It is better to trace the network
communication, a wireshark trace for example. But it is probably a
firewall or UTM, if you have, issue.

Best

2012/8/11, Paul Alesius <paul@unnservice.com>:
> I should add to the facts that:
>
>
> - git version: git version 1.7.11.2
> - Happens only when using protocols git:// and have seen it with
> https:// too, but never with http://
> - Saw a similar issue here:
> http://code.google.com/p/msysgit/issues/detail?id=361
>
>
> On 11 August 2012 04:48, Paul Alesius <paul@unnservice.com> wrote:
>> 80 out of 100 times git will hang indefinitely during a clone operation.
>> Here's the state of things during the hangs:
>>
>>
>> ----------------------- scenario 1:
>> remote: Counting objects: 306395, done.
>> remote: Compressing objects: 100% (47753/47753), done.
>> remote: Total 306395 (delta 259044), reused 305469 (delta 258264)
>> Receiving objects: 100% (306395/306395), 207.20 MiB | 5.80 MiB/s, done.
>> Resolving deltas: 100% (259044/259044), done.
>> ----------------------- ps aux | grep git:
>> build    28122  0.1  0.0 126032  2092 pts/1    Sl+  04:19   0:00 git
>> clone
>> git://git.gnome.org/gtk+
>> ---------------------- backtrace for scenario 1:
>> (gdb) bt
>> #0  0x0000003c9ee08e60 in pthread_join (threadid=47144800229120,
>> thread_return=thread_return@entry=0x7fff19edc928) at pthread_join.c:93
>> #1  0x00000000004cb6ab in finish_async (async=async@entry=0x7fff19edca00)
>> at
>> run-command.c:739
>> #2  0x0000000000428318 in get_pack (pack_lockfile=0x121df80,
>> xd=0x121dfc0)
>> at builtin/fetch-pack.c:773
>> #3  do_fetch_pack (pack_lockfile=0x121df80, match=0x125e0a0,
>> nr_match=544,
>> orig_ref=<optimized out>, fd=0x121dfc0) at builtin/fetch-pack.c:835
>> #4  fetch_pack (my_args=my_args@entry=0x7fff19edd1b0,
>> fd=fd@entry=0x121dfc0,
>> conn=<optimized out>, ref=<optimized out>, dest=dest@entry=0x1217e70
>> "git://git.gnome.org/gtk+",
>>     nr_heads=nr_heads@entry=544, heads=heads@entry=0x125e0a0,
>> pack_lockfile=pack_lockfile@entry=0x121df80) at builtin/fetch-pack.c:1090
>> #5  0x00000000004de08e in fetch_refs_via_pack (transport=0x121df20,
>> nr_heads=544, to_fetch=0x125c880) at transport.c:549
>> #6  0x00000000004e0472 in transport_fetch_refs
>> (transport=transport@entry=0x121df20, refs=refs@entry=0x123d3c0) at
>> transport.c:1167
>> #7  0x000000000041cbce in cmd_clone (argc=<optimized out>,
>> argv=<optimized
>> out>, prefix=<optimized out>) at builtin/clone.c:859
>> #8  0x00000000004057d8 in run_builtin (argv=0x7fff19edd900, argc=2,
>> p=0x74a040) at git.c:308
>> #9  handle_internal_command (argc=2, argv=0x7fff19edd900) at git.c:468
>> #10 0x0000000000404be2 in run_argv (argv=0x7fff19edd790,
>> argcp=0x7fff19edd79c) at git.c:514
>> #11 main (argc=2, argv=0x7fff19edd900) at git.c:589
>> ----------------------
>>
>>
>>
>>
>> ---------------------- scenario 2:
>> remote: Counting objects: 306395, done.
>> remote: Compressing objects: 100% (47753/47753), done.
>> Receiving objects:  99% (303332/306395), 205.18 MiB | 452 KiB/s
>> ----------------------- ps aux | grep git:
>> build    28247  0.5  0.0 126032  2088 pts/1    Sl+  04:30   0:00 git
>> clone
>> git://git.gnome.org/gtk+
>> build    28249  8.4  0.3 144908 30480 pts/1    S+   04:30   0:12 git
>> index-pack --stdin -v --fix-thin --keep=fetch-pack 28247 on mydomain
>> ---------------------- backtrace for scenario 1:
>> #0  0x0000003c9ee0e0ad in read () at
>> ../sysdeps/unix/syscall-template.S:82
>> #1  0x00000000004ea29f in read (__nbytes=46, __buf=0x7fffeb4d8cc0,
>> __fd=7)
>> at /usr/include/bits/unistd.h:45
>> #2  xread (fd=fd@entry=7, buf=buf@entry=0x7fffeb4d8cc0, len=len@entry=46)
>> at
>> wrapper.c:142
>> #3  0x00000000004ea38b in read_in_full (fd=7,
>> buf=buf@entry=0x7fffeb4d8cc0,
>> count=count@entry=46) at wrapper.c:171
>> #4  0x00000000004ad78c in index_pack_lockfile (ip_out=<optimized out>) at
>> pack-write.c:298
>> #5  0x00000000004285d4 in get_pack (pack_lockfile=0x1928f80,
>> xd=0x1928fc0)
>> at builtin/fetch-pack.c:767
>> #6  do_fetch_pack (pack_lockfile=0x1928f80, match=0x19690a0,
>> nr_match=544,
>> orig_ref=<optimized out>, fd=0x1928fc0) at builtin/fetch-pack.c:835
>> #7  fetch_pack (my_args=my_args@entry=0x7fffeb4da580,
>> fd=fd@entry=0x1928fc0,
>> conn=<optimized out>, ref=<optimized out>, dest=dest@entry=0x1922e70
>> "git://git.gnome.org/gtk+",
>>     nr_heads=nr_heads@entry=544, heads=heads@entry=0x19690a0,
>> pack_lockfile=pack_lockfile@entry=0x1928f80) at builtin/fetch-pack.c:1090
>> #8  0x00000000004de08e in fetch_refs_via_pack (transport=0x1928f20,
>> nr_heads=544, to_fetch=0x1967880) at transport.c:549
>> #9  0x00000000004e0472 in transport_fetch_refs
>> (transport=transport@entry=0x1928f20, refs=refs@entry=0x19483c0) at
>> transport.c:1167
>> #10 0x000000000041cbce in cmd_clone (argc=<optimized out>,
>> argv=<optimized
>> out>, prefix=<optimized out>) at builtin/clone.c:859
>> #11 0x00000000004057d8 in run_builtin (argv=0x7fffeb4dacd0, argc=2,
>> p=0x74a040) at git.c:308
>> #12 handle_internal_command (argc=2, argv=0x7fffeb4dacd0) at git.c:468
>> #13 0x0000000000404be2 in run_argv (argv=0x7fffeb4dab60,
>> argcp=0x7fffeb4dab6c) at git.c:514
>> #14 main (argc=2, argv=0x7fffeb4dacd0) at git.c:589
>> ----------------------
>>
>>
>>
>> ---------------------- facts:
>> - Happens on multiple machines on this LAN, which made me believe it's
>> the
>> NAT router.
>> - Happens when using any repository.
>> - There's nothing filtering egress ports (Other than the NAT)
>> - Kernel 3(?) to 3.5 which I run currently
>> - I often see it hang at __read_nocancel too in the backtrace, which is
>> part
>> of the read()
>> - I have to abort the clone operation and retry indefinitely until it
>> works,
>> which may be never.
>>
>>
>>
>>
>> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Inviato dal mio dispositivo mobile
