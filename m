From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix the author initials in blame for non-ASCII names
Date: Fri, 30 Aug 2013 20:08:09 +0200
Message-ID: <CANQwDwcyTWgk0jhhGUgP-UZDLQ5EGhh5oueitGD5fpgS5bLtzw@mail.gmail.com>
References: <20130829163935.GA9689@ruderich.org> <1377851821-5412-1-git-send-email-avarab@gmail.com>
 <xmqqppsvyrzj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Simon Ruderich <simon@ruderich.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 20:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFT7b-0004a9-0a
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab3H3SIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 14:08:31 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]:35834 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab3H3SIa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 14:08:30 -0400
Received: by mail-qe0-f53.google.com with SMTP id 1so1150246qee.12
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5/BGYP6e+LmHamtfY0UpCCYk+qZte4rkeH0vRzzxJBU=;
        b=QJvrl6Ms8XUitul9ZCDEQflF0jiwzucOCZfRZBarChojKzPUY8Rd086+M032gl1ZTQ
         JZyGKJmyojtphcmjFnSsmweD7npuFGVQlFHSlBPSb7Jc7qv43dvUwvcVgXATLCG2gABJ
         NONetIOyBfpauItouQPmH+RfZdProoRy2/0nJLE074RR2zWs34xmm76pzbnvVeBB2pVO
         rGvEnbX1BhiGThzVOK2ZFmWoucR5S8L1vcd/6pYCZQh/04tVXJbGwI2bf3PIb3Lo8fXU
         kild5Z7gEgZPWEkn1CT/+tTqBPxvz4TRxYITQ05WV2y4g3ds2uH5bauOrGXtMhTbUotH
         4uLw==
X-Received: by 10.224.126.196 with SMTP id d4mr13610308qas.62.1377886110036;
 Fri, 30 Aug 2013 11:08:30 -0700 (PDT)
Received: by 10.49.83.134 with HTTP; Fri, 30 Aug 2013 11:08:09 -0700 (PDT)
In-Reply-To: <xmqqppsvyrzj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233449>

On Fri, Aug 30, 2013 at 8:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>> Tested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Tested-by: Simon Ruderich <simon@ruderich.org>
>> ---
>>  gitweb/gitweb.perl | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index f429f75..ad48a5a 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -6631,6 +6631,7 @@ sub git_blame_common {
>>                       $hash_base, '--', $file_name
>>                       or die_error(500, "Open git-blame --porcelain =
failed");
>>       }
>> +     binmode $fh, ':utf8';

Should be $fd, not $fh.

> [Fri Aug 30 17:48:17 2013] gitweb.perl: Global symbol "$fh" requires
> explicit package name at /home/gitster/w/buildfarm/next/t/../gitweb/g=
itweb.perl line 6634.
> [Fri Aug 30 17:48:17 2013] gitweb.perl: Execution of /home/gitster/w/=
buildfarm/next/t/../gitweb/gitweb.perl aborted due to compilation error=
s.

I wonder how it passed =C3=86var and Simon tests. Perhaps proposal had =
$fd?

--=20
Jakub Narebski
