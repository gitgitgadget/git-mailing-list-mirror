From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: apply fallback encoding before highlight
Date: Mon, 2 May 2016 20:12:52 +0200
Message-ID: <CANQwDwfZPoNd7OTpSkEmf4amV0hh8kiuk3omwLCS0O=MZ1DB=A@mail.gmail.com>
References: <1461151948-38583-1-git-send-email-shin@kojima.org> <xmqqbn4ouz7u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shin Kojima <shin@kojima.org>, git <git@vger.kernel.org>,
	Christopher Wilson <cwilson@cdwilson.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:13:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axILi-0006sC-0F
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbcEBSNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:13:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34234 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbcEBSNd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:13:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so18297344wmn.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=53XHXEFwXiqB4bFmHTGBvDkLSYxsemKIX2jqjEQ+s6o=;
        b=Lg6eCbP45Qy78Iea8/xDWYTtuWxeqCc7VhTAridysui++o6ho2QvBp7lm5WxWtyio6
         TgEJdkKsbsUmYl1jfSrSgNTWhcU/MVR1YFQ54r0BKAUxiD7DA3On6RD/FVuOv+Em8pCG
         jLBn38/elLK7Ymc5RNpk65pUuNma7nnJ4oECi9TY1qNswQAasLfKMqLhSMME8JWIfSne
         Hof2CmeLWI5ADhaKOWQn9ArkPzcO8ZLzTdRW0yH3PHGmi7h1qStuGEHHN1DPJomasGZ8
         5miXzbIPFsG+ckMDuf6/t+LA1ugzfvG/tf90YvPupFm9RScOcQGY1dYedv2zW0KhT77I
         dzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=53XHXEFwXiqB4bFmHTGBvDkLSYxsemKIX2jqjEQ+s6o=;
        b=QkxpntOb2YKz2mqxRyPVQ82wfSYUUQInGX59yjp+rq3yj2gwJuFNMmdGxEf3Ajh9Ys
         DZX6u5YxAT4TuVrsg0bUg7bIpsIXRpodwEssIxuSPS/4Txt5XGCVBnZNYEOxOXOyPqAz
         L6siNz64b9hIuSwgD4LaRJbEwEcXHJGGqOgGLvdVpsz/hIdU59Di1ormumORoxT/+09p
         essId80gg1g7r1ilbVTKR8Ntr6CUwgDH21Fh0z/nOwzS4U8TUDAuc7vGoKf3JvSAxSyk
         K/abaarLCtXNLhQoS+72D203ynXfIwZJ31++nPg+2rm2oyi56fbyeMS/Hnp/mewMDTAJ
         CSfA==
X-Gm-Message-State: AOPr4FW1gSswV6yeM8TxvvoQT4TtOnnt20k1nOGP0sLgwd07kNQ/KvzXjMb7ES5Hglrtn/rOufOWozG5mT7+VQ==
X-Received: by 10.195.6.65 with SMTP id cs1mr35639164wjd.8.1462212812108; Mon,
 02 May 2016 11:13:32 -0700 (PDT)
Received: by 10.194.124.129 with HTTP; Mon, 2 May 2016 11:12:52 -0700 (PDT)
In-Reply-To: <xmqqbn4ouz7u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293256>

On Mon, May 2, 2016 at 7:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shin Kojima <shin@kojima.org> writes:
>
>> This patch prepare git blob objects to be encoded into UTF-8 before
>> highlighting in the manner of `to_utf8` subroutine.
>> ---
>
> The single liner Perl invoked from the script felt a bit too dense
> to my taste but other than that I have no complaints to what the
> patched code does.
>
> Jakub, does it look good to you, too?

Yes, it looks all right to me. $^X is current Perl. -CO means that
the output is utf8 (for `highlight` command), -p means read all lines
and print them (it could be replaced by "print" command in one-liner),
-s is here to pass $fallback_encoding as $fe (it could be replaced,
but it would require some fiddling with quoting $s), -e '...' means
execute one line.

> Please sign-off your patch (see Documentation/SubmittingPatches).
>
> Thanks.
>
>
>>  gitweb/gitweb.perl | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 05d7910..2fddf75 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -3935,6 +3935,9 @@ sub run_highlighter {
>>
>>       close $fd;
>>       open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>> +               quote_command($^X, '-CO', '-MEncode=decode,FB_DEFAULT', '-pse',
>> +                 '$_ = decode($fe, $_, FB_DEFAULT) if !utf8::decode($_);',
>> +                 '--', "-fe=$fallback_encoding")." | ".
>>                 quote_command($highlight_bin).
>>                 " --replace-tabs=8 --fragment --syntax $syntax |"
>>               or die_error(500, "Couldn't open file or run syntax highlighter");



-- 
Jakub Narebski
