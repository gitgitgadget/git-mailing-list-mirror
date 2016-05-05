From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 83/83] builtin/am: use apply api in run_apply()
Date: Thu, 5 May 2016 12:04:23 +0200
Message-ID: <CAP8UFD22kGGH9W62Mzoc2h+fbtGRP5vGofAauAhdBP8R5bja_Q@mail.gmail.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<1461505189-16234-4-git-send-email-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1604251701180.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 05 12:04:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayG8z-0006wZ-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 12:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbcEEKE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 06:04:26 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37999 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329AbcEEKEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 06:04:25 -0400
Received: by mail-wm0-f45.google.com with SMTP id g17so19065229wme.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=6NhWbit3yQ76hJKHrIJoYwQNXzimyML0CyGWMr/j70M=;
        b=yTslOdT20Lx+6DfjEfZzvMTLihhqiLYzRFW4Du53VCWKyn3THIDlQ7chkS+VdYSKPz
         WWC2UMZpgXUsJmikYBp82Yls5C/MOFK88OFrR/xArUnuRbHCdqbS7RD/kJsCKkodpWnY
         6l5QTaW2L9J7npM5mXNORksBe7vtjiVDcULhbXz5gr1cxG8J+sE08S6NHPdCkSJ2ote5
         Jm5BrAkDXYaw/sFKYgiHnPoboW6TW8fsDTuAuftYpxFEQcH9Lc4fRu+gknCLkmY5cW5C
         PyHCqsUd2fUf0qn9yhgCoyXvdSzothhtr/ZQQ2qyLbp2VODnWVKvPrjQ1jCmWebagvDa
         2g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6NhWbit3yQ76hJKHrIJoYwQNXzimyML0CyGWMr/j70M=;
        b=BZRseq25EtZFgFML92Ke9IbcgGMGwKVu8YksRqfneRMce1gaNhhrYs3+xXJqAFHg0K
         TAEzhyARLAj7oOIHMk3/WoOzKVi2BHo/hUhFuarM/CFqgFNG6pFpZJbaQmqzl8ytM133
         zJnXoDKdxfc9zN2lyVyzjLb13XbqLnSXnu0e7ejXExWydvaZ2YqMY8rn+WG9VD/onvpA
         N1poZ0hn9BGSPGKV+fb1gUQQFayZO0Cd6yIanrOPw+E8PufHp+ioUmsNFJf5tplqvjX/
         0h2hmanHdMHcIqkZxXPlU5/zSBs7igdVo20N16X9XQMyouM0M9T06CLALVWohF1s/uxq
         /KwA==
X-Gm-Message-State: AOPr4FUDVa4MblAxr+hA2Itc6LtKIUjDjD3H18Q6CakiAEecihtN3MGqCTbtvSwpa+wbKPj6bW4qXO0BRPv/6w==
X-Received: by 10.194.20.162 with SMTP id o2mr13001497wje.78.1462442663856;
 Thu, 05 May 2016 03:04:23 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Thu, 5 May 2016 03:04:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604251701180.2896@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293643>

Hi Dscho,

On Mon, Apr 25, 2016 at 5:03 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Chris,
>
> On Sun, 24 Apr 2016, Christian Couder wrote:
>
>> [...]
>>       /*
>>        * If we are allowed to fall back on 3-way merge, don't give false
>>        * errors during the initial attempt.
>>        */
>> +
>>       if (state->threeway && !index_file) {
>> -             cp.no_stdout = 1;
>> -             cp.no_stderr = 1;
>> +             save_stdout_fd = dup(1);
>> +             dup_devnull(1);
>> +             save_stderr_fd = dup(2);
>> +             dup_devnull(2);
>
> I wonder. It should be possible to teach the apply function to be quiet by
> default, yes? That would be more elegant than dup()ing back and forth.

Yes, it could be possible, but it could mean many changes not only in
the apply functions, but in possibly many other places as well. I
didn't check, but for example if an apply function calls a function
from another part of git and this function uses error(...) in case of
error, I would have to change this function too.

I could also introduce a hack like a global variable that would tell
error() to shut up, but I am not sure that would be more elegant.

Thanks,
Christian.
