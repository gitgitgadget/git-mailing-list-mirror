From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Thu, 17 Dec 2015 12:51:08 -0800
Message-ID: <CAGZ79kYHjH7QgChn6_GU9iLrtyouFQFuMAZKADZofgHjBS73-A@mail.gmail.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
	<1450224252-16833-3-git-send-email-sbeller@google.com>
	<56731715.9000509@web.de>
	<CAGZ79kZD_vrwHyd2WZzx-9FF3D6CVVi6X=Cx1=HAgr1gqNKyaA@mail.gmail.com>
	<56731E19.7050504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 17 21:51:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9fW6-0006Or-QZ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 21:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbbLQUvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2015 15:51:10 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:33111 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbLQUvJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 15:51:09 -0500
Received: by mail-io0-f172.google.com with SMTP id 186so69510341iow.0
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 12:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UVkBve0rbVtegR3Hd+k89nKTBROwwiZ9Azko2rcUiGo=;
        b=Kzg1N3jNwD0UYObU0dkTQ8of2ceaIUuGUk0se6rUIx701g6LoedA/gFCSayEWaiPrF
         aEfwnmyb3uBtJIjfNe6Rr1uphQ0KzX3dIKsCIinZik33BOoKxkycJTbbNDU1Q4q013Ek
         PAwhg1xpmCgKridvs5V7FvXSjG3fd0Z6rymTKS/ytSrKYitl8Nqhd2AgkUKB+djOZodJ
         D51gJ2WyaTE0kRyZGxSA3Tzz8Ho2GsG6AluK61ZkLUdUoIU+J5qNxVUzMZCOXpoU+Iee
         puNdMypqsIiVaN/pt6anj9x0nO73xdKs56WelINB80KzgHWRW5dxFz7lycqswmZtvt/2
         1d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UVkBve0rbVtegR3Hd+k89nKTBROwwiZ9Azko2rcUiGo=;
        b=XISf8/3kao9hBAupg98hVKfTAR34FHDDwo/TIWq6Z7ZH74s7Ib++ODjrEOI0p3EX+l
         YLS/WzJdO93lz/OJMIEgaXce5X1hy90m43byH7B7uQTAg87CPOPAyIbewSjmFOQK8jMz
         E392I6Kl6tRNZgn9E3k1JCZlg3RrO5JqHefvSQ9942GlnVlAQiIlyc4Q2kLnoe8zE5W2
         E0Zcd/z80gIZuQptasu1E8x+yZGQ3HzRUY07bDOBf/DnMIKKvWYWoH4I0GfCe0KptkBZ
         KaDuiV+I8Y51ia8dlNHYahiFBYiZLIIvPNtEiAUE+e8NGf7Mtk4pVwep0/mQEYxbXy8b
         +FRQ==
X-Gm-Message-State: ALoCoQk0o0s9k3HzCPgN7xBab4p96wKrz1veeKyWLOPRCblFomgX82IVFlGo6+XLKHJYyb8C7Uay7kSjbJHdjF2uPUML23XuHkkK9Dn/4ufHmiLF8nAP7pM=
X-Received: by 10.107.152.142 with SMTP id a136mr579127ioe.110.1450385468696;
 Thu, 17 Dec 2015 12:51:08 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 17 Dec 2015 12:51:08 -0800 (PST)
In-Reply-To: <56731E19.7050504@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282676>

On Thu, Dec 17, 2015 at 12:42 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 17.12.15 21:22, Stefan Beller wrote:
>> On Thu, Dec 17, 2015 at 12:12 PM, Torsten B=C3=B6gershausen <tboegi@=
web.de> wrote:
>>> On 16.12.15 01:04, Stefan Beller wrote:
>>>> The man page of read(2) says:
>>>>
>>>>   EAGAIN The file descriptor fd refers to a file other than a sock=
et
>>>>        and has been marked nonblocking (O_NONBLOCK), and the read
>>>>        would block.
>>>>
>>>>   EAGAIN or EWOULDBLOCK
>>>>        The file descriptor fd refers to a socket and has been mark=
ed
>>>>        nonblocking (O_NONBLOCK), and the read would block.  POSIX.=
1-2001
>>>>        allows either error to be returned for this case, and does =
not
>>>>        require these constants to have the same value, so a portab=
le
>>>>        application should check for both possibilities.
>>>>
>>>> If we get an EAGAIN or EWOULDBLOCK the fd must have set O_NONBLOCK=
=2E
>>>> As the intent of xread is to read as much as possible either until=
 the
>>>> fd is EOF or an actual error occurs, we can ease the feeder of the=
 fd
>>>> by not spinning the whole time, but rather wait for it politely by=
 not
>>>> busy waiting.
>>>>
>>>> We should not care if the call to poll failed, as we're in an infi=
nite
>>>> loop and can only get out with the correct read().
>>> I'm not sure if this is valid under all circumstances:
>>> This is what "man poll" says under Linux:
>>> []
>>>  ENOMEM There was no space to allocate file descriptor tables.
>>> []
>>> And this is from Mac OS, ("BSD System Calls Manual")
>>> ERRORS
>>>      Poll() will fail if:
>>>
>>>      [EAGAIN]           Allocation of internal data structures fail=
s.  A sub-
>>>                         sequent request may succeed.
>>> And this is opengroup:
>>> http://pubs.opengroup.org/onlinepubs/9699919799//functions/poll.htm=
l:
>>> [EAGAIN]
>>>     The allocation of internal data structures failed but a subsequ=
ent request may succeed.
>>>
>>> read() may return EAGAIN, but poll() may fail to allocate memory, a=
nd fail.
>>> Is it always guaranteed that the loop is terminated?
>>
>> In case poll fails (assume a no op for it), the logic should not hav=
e
>> changed by this patch?
>>
>> Looking closely:
>>
>>>>       while (1) {
>>>>               nr =3D read(fd, buf, len);
>>>> -             if ((nr < 0) && (errno =3D=3D EAGAIN || errno =3D=3D=
 EINTR))
>>>> -                     continue;
>>>> +             if (nr < 0) {
>>>> +                     if (errno =3D=3D EINTR)
>>>> +                             continue;
>>>> +                     if (errno =3D=3D EAGAIN || errno =3D=3D EWOU=
LDBLOCK) {
>>>> +                             struct pollfd pfd;
>>>> +                             pfd.events =3D POLLIN;
>>>> +                             pfd.fd =3D fd;
>>>> +                             /*
>>>> +                              * it is OK if this poll() failed; w=
e
>>>> +                              * want to leave this infinite loop
>>>> +                              * only when read() returns with
>>>> +                              * success, or an expected failure,
>>>> +                              * which would be checked by the nex=
t
>>>> +                              * call to read(2).
>>>> +                              */
>>>> +                             poll(&pfd, 1, -1);
>>
>> Or do you mean to insert another continue in here?
> I was thinking that we run into similar loop as before:
> read() returns -1; errno =3D EAGAIN  /* No data to read */

which is expected for non blocking fds,

> poll() returns -1; errno =3D EAGAIN /* poll failed. If the fd was OK,=
 the failure may be temporaly,
>                                     as much as poll() can see.
>                                     But most probably we run out ouf =
memory */

Before this patch we would not have asked poll, but had just a continue=
 here,
so I think we need to have it here again no matter of the return code
of the poll.

If poll determines it is low on memory, this should not make this funct=
ion fail,
we can still do as good as we did before by just asking read
repeatedly again, though?

So I'd be convinced now we'd want to have:

    poll(&pfd, 1, -1); /* this is only buying time
                        for the fd to deliver data, in case it fails
                        we don't care but just fall back to old
                        behavior before this patch with busy spinning*/
    continue;


>
> So the code would look like this:
>
>    if (!poll(&pfd, 1, -1))
>       return -1;
>
>
>>
>
>>>> +                     }
>>>> +             }
>>>>               return nr;
>>>>       }
>>>>  }
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
