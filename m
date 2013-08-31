From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] gitweb: Fix the author initials in blame for non-ASCII names
Date: Sat, 31 Aug 2013 18:29:31 +0200
Message-ID: <CACBZZX4R2PRRRa=iqXQu_NhvFsTWM5+ktt-x4=sddvB_vptpqA@mail.gmail.com>
References: <20130829163935.GA9689@ruderich.org> <1377851821-5412-1-git-send-email-avarab@gmail.com>
 <xmqqppsvyrzj.fsf@gitster.dls.corp.google.com> <xmqqhae7yrls.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Simon Ruderich <simon@ruderich.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 18:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFo3g-0005JU-GT
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 18:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab3HaQ3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 12:29:52 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:62732 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3HaQ3w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 12:29:52 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so3072877obb.9
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tIVXUuP1gIuPYnHQxL6+bpiPq0V6uh8AopB19gHKA8g=;
        b=QVDfPE5bg8jNfDccCrYD34Ar2ayp0Umbpli2Hqo0UkoWc3jZIFQwjFuS9fv0/LGIDf
         oHzFzsPA4uYlwHJpk25Cc+J+uxT6uCQNdcCE7QS+3ljcSXzNnIgvs3QM3ZIEQwaBQ17h
         Q5UVCnY6iG3g0Qf5th6198Nc5OlZ8WJWfpuw1nSq6AAziSWT4b+YYWD4JjdS3bXPYGco
         n947TwRrMCDJ1xoJgbWyiJw1OoA1ioXzLNQ1BFT3PIvnhX6zGpMsYapN1Jj2oz25kUMu
         hDnIEAnCWT+sPlmggPH1xMToF7x4zC2zyo0oRQxFtjqRVSuNudQIZfhpMwUUNBNtKTEd
         xaLw==
X-Received: by 10.60.118.41 with SMTP id kj9mr11025347oeb.31.1377966591572;
 Sat, 31 Aug 2013 09:29:51 -0700 (PDT)
Received: by 10.76.173.201 with HTTP; Sat, 31 Aug 2013 09:29:31 -0700 (PDT)
In-Reply-To: <xmqqhae7yrls.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233520>

I did. I just clumsily sent out the wrong patch. I.e. tested it
manually on another system, and then fat-fingered $fh instead of $fd.

Should I send another patch or do you want to just fix this one up?

On Fri, Aug 30, 2013 at 8:13 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
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
>>> +    binmode $fh, ':utf8';
>
>>
>> [Fri Aug 30 17:48:17 2013] gitweb.perl: Global symbol "$fh" requires
>> explicit package name at /home/gitster/w/buildfarm/next/t/../gitweb/=
gitweb.perl line 6634.
>> [Fri Aug 30 17:48:17 2013] gitweb.perl: Execution of /home/gitster/w=
/buildfarm/next/t/../gitweb/gitweb.perl aborted due to compilation erro=
rs.
>
> I think in this function the filehandle is called $fd, not $fh.  Has
> any of you really tested this???
