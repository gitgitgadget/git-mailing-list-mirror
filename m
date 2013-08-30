From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] gitweb: Fix the author initials in blame for non-ASCII names
Date: Fri, 30 Aug 2013 14:39:53 -0700
Message-ID: <74435A51-B404-4EC8-8CF8-6289F49E6DBD@gmail.com>
References: <20130829163935.GA9689@ruderich.org> <1377851821-5412-1-git-send-email-avarab@gmail.com> <xmqqppsvyrzj.fsf@gitster.dls.corp.google.com> <xmqqhae7yrls.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Simon Ruderich <simon@ruderich.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 23:40:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFWQD-0003sx-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 23:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab3H3Vj6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 17:39:58 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:51609 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab3H3Vj5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 17:39:57 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so2357553pbb.41
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=FMkNwHK1gQQU1D/+2hXI6/Bmc3qQJ4yEpM0+0O8WaEA=;
        b=aeRmTfkKjNX4EdnWoc5RQJ9jF4YIaQ+L99uxDeTxqnP00h38pe5LQLXIGp3Pub0f5A
         sX2XXP69VL0CVvI86ONG7RCoq0XQ1GauGKRnDePjfGcUQOVjfdOnm9E0U7anNu9lVsy6
         eR/g+OUqyv8qkw9/qI4Wp8t2NtTVGu/8ilM0P5p9SMdIZ2OhH2EXDEtpxU1CQUznfP+B
         SUTyMRjAW8mYE8upObchMZcYX5c2PAS1MXOxnRrnn2Cn6R+5jmmzXDY5uOpxZdCcum9b
         DZz7fM4t2y64Mk4wpgWw/RU6IQYh87aui7pxlAByXsLZU+u3f0PHWrOTEkqIZNDs4YkQ
         oIoA==
X-Received: by 10.66.241.34 with SMTP id wf2mr12795193pac.111.1377898796718;
        Fri, 30 Aug 2013 14:39:56 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id xn12sm220601pac.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 14:39:55 -0700 (PDT)
In-Reply-To: <xmqqhae7yrls.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233471>

On Aug 30, 2013, at 11:13, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>>> Tested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>>> Tested-by: Simon Ruderich <simon@ruderich.org>
>>> ---
>>> +++ b/gitweb/gitweb.perl
>>> @@ -6631,6 +6631,7 @@ sub git_blame_common {
>>> ...
>>> +	binmode $fh, ':utf8';
>
>>
>> [Fri Aug 30 17:48:17 2013] gitweb.perl: Global symbol "$fh" requires
>> explicit package name at /home/gitster/w/buildfarm/next/t/../gitweb/=
=20
>> gitweb.perl line 6634.
>> [Fri Aug 30 17:48:17 2013] gitweb.perl: Execution of /home/gitster/=20
>> w/buildfarm/next/t/../gitweb/gitweb.perl aborted due to compilation =
=20
>> errors.
>
> I think in this function the filehandle is called $fd, not $fh.  Has
> any of you really tested this???

What happens if the author name is written in ISO-8859-1 instead of =20
UTF-8 in the actual commit object itself?

I'm pretty sure I've seen this where older commits have a ISO-8859-1 =20
author name and then newer commits have a UTF-8 version of the same =20
author's name.

In fact, in the git repository itself, look at commit 0cb3f80d (UTF-8) =
=20
and commit 7eb93c89 (ISO-8859-1) to see this in action.