From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 03/25] transport-helper.c: do not send null option to
 remote helper
Date: Sat, 6 Feb 2016 16:38:15 +0700
Message-ID: <CACsJy8Az9rx_D0V+p2fEdNi64YJb2g_o0npUk2=wqCL2_moBPQ@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
 <1454576641-29615-4-git-send-email-pclouds@gmail.com> <xmqqh9hof4bx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 10:39:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRzKu-0007fZ-SB
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 10:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbcBFJit convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2016 04:38:49 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34675 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbcBFJir convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2016 04:38:47 -0500
Received: by mail-lf0-f68.google.com with SMTP id 78so3616109lfy.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=b1ZEceigp8rOmNMXO1QAdLlW9TNbux7WhfoMMk5Wptk=;
        b=LUnA3tpwWGowKa0iUmEk5h6nSIexbKQqmaSUcVj/+i+iJAYg/AD4iLM4hLmKwrhCu9
         99KpxkgzlQUV2SD6UTyuUQMbKLT5QnbcVEJkATPMs5+LH9Pika4eB3vKvTVgRAdzN4sF
         WHp8+ZsIE6zzNEEhYvLPonWT5guHAD2ctyHj2vw4Soy3ASmVG2WqbcLUBSdjVTj71x15
         gzaLI5TyYFtyjkH17n63LF6gQYu31sWOxgvT2Qb9IRIheqbgsq0Cemi5AhCkiemM3jDy
         VhBK38VBjCxjmTXysLGUVM45/nB+vPSBzC9oQtghRZilhUNZzSpvWDGUvvJHn74C6c5a
         pRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=b1ZEceigp8rOmNMXO1QAdLlW9TNbux7WhfoMMk5Wptk=;
        b=dkOE2n6TopQjfjKV2rIOoh+TMJC50gLsCp/gosMPf8YRu0UeveOGrD1s9s+RcD9PlP
         0hQQQ+WX834xaZRuzUBETsL8u7ulnqxEbWKwpfCVEWyccMUgZ4ZTTwRmgFBkm5coYB/x
         6Ukw3YylesdtL7chfmDNov/T2xEawXcEGtVky49xHG+PFYAGSwzKk8WhJAB/flBo82cp
         WIm48gXARlhBBeTf8lJ49MkiAFC6RVyAUui7He0GwE5SoI3PLMp235LuSQ6WfHO6ilxp
         sR0kKgxFLXjamufcSwT5r3eJ85Cr+TuPRZ7T/VJRUewnmE+4orwQSN/jS59pdcZbv3q/
         gTjw==
X-Gm-Message-State: AG10YOQdmU1QMBO7k/sxG1ph7iqorkHOjq4JdQG1vZ9GJL/t6aWSfGs6fVJ5DAoXqAXveLsHgjBMf8wjHnWaXQ==
X-Received: by 10.25.212.11 with SMTP id l11mr7745268lfg.118.1454751526056;
 Sat, 06 Feb 2016 01:38:46 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sat, 6 Feb 2016 01:38:15 -0800 (PST)
In-Reply-To: <xmqqh9hof4bx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285685>

On Fri, Feb 5, 2016 at 6:22 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> This is even more strange.  Are the current callers broken and some
> sends value=3D=3DNULL for an option that is not is_bool, resulting in
> a call to quote_c_style() with NULL?  I somehow find it hard to
> believe as that would lead to an immediate segfault.
>
> Assuming that no current caller passes NULL to value when is_bool is
> not in effect, there needs an explanation why future new callers may
> need to do so.  An alternative for a valueless option could be to
> send "option name\n" instead of the usual "option name value\n", but
> without such an explanation, readers cannot tell why not sending
> anything about "name", which is what this patch chooses to implement,
> is a better idea.

The source is backfill_tags() which, in future, resets some transport
options back to defaults. The current set_option() in there only deals
with booleans or number (depth). But in future it resets deepen-since,
which is a string.

I think the main reason is, we do not have a way to reset (or unset) a
transport option. Should I keep this commit and explain about this, or
have a new transport API to reset option?
--=20
Duy
