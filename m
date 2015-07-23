From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Feature Request: Passing a number as an option to git tags for
 displaying latest tags
Date: Thu, 23 Jul 2015 11:12:54 -0700
Message-ID: <CA+P7+xpy86GMmdtcag4kaxDrB4TrdeQYraabNS0pASdBG+P+OQ@mail.gmail.com>
References: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
 <xmqqbnf4rohs.fsf@gitster.dls.corp.google.com> <xmqq7fpsroc1.fsf@gitster.dls.corp.google.com>
 <55B0B667.6000103@drmicha.warpmail.net> <CA+P7+xpasr7gOYiSsdAyCgh6+D8nYQf9vuEhRna8k7HWMu1Rcg@mail.gmail.com>
 <xmqqd1zipxc3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?SGFsaWwgw5Z6dMO8cms=?= <halilozturk55@gmail.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 20:13:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKzh-0000La-F2
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 20:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbbGWSNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 14:13:17 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33537 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbbGWSNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 14:13:14 -0400
Received: by oige126 with SMTP id e126so97050oig.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OxQwLCvaIoipNT6N7/OamejIK8xnvUA/6cW+NJeBQ9g=;
        b=HvvYkEqJBMMyousecXwo42bg0MXvDpSLYSU2fPcZcuAhimD6sBzv59wN47iW358GxH
         wA3d4vfp0Md+JH+/uPdvCs98X0RTZdvYFQovT13FO7slsItV/xqpyef5861Em1Kjg6pf
         nCxG0sOaKeReMRh5gkC8uWnijzwirF34qz21Loe139LW9FgMJkTT97/YrNrpuhwEu6Ky
         dTJBQ3ziT4glHGqLD+4m9Jz25nYqNM36OqNJ+kT5Kz/sgCU2ZKpznxpo79w/d4al1eBo
         BcECnH2pJjFamlO74ZZNnEE7JnKMQxdPCfK9LiS5PxgCCK4Jr6oI/5NjHYK/bMIZew/6
         fezg==
X-Received: by 10.60.78.104 with SMTP id a8mr10291808oex.58.1437675194275;
 Thu, 23 Jul 2015 11:13:14 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Thu, 23 Jul 2015 11:12:54 -0700 (PDT)
In-Reply-To: <xmqqd1zipxc3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274518>

On Thu, Jul 23, 2015 at 11:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Yep, that's pretty much how a build system I've had to use does it.
>> Sadly, this is quite slow, and I'm not sure if doing it built into the
>> tag via for-each-ref would be faster?
>
> Is the description in "git for-each-ref --help" somehow unreadable?
>
>        An example directly producing formatted text. Show the most
>        recent 3 tagged commits:
>
>            #!/bin/sh
>
>            git for-each-ref --count=3 --sort='-*authordate' \
>            --format='From: %(*authorname) %(*authoremail)
>            Subject: %(*subject)
>            Date: %(*authordate)
>            Ref: %(*refname)
>
>            %(*body)
>            ' 'refs/tags'
>
> If you only need the name of the ref, you can use a lot simpler
> format string, e.g.
>
>     git for-each-ref --count=3 --sort='-*authordate' \
>       --format='%(refname:short)' refs/tags
>
>     git for-each-ref --count=3 --sort='-taggerdate' \
>       --format='%(refname:short)' refs/tags
>

That's significantly better than what this system does, but sadly the
team that owns it doesn't exactly understand git. Pretty sure they
tend to just use whatever scriptlet they got working, which happens to
be based on log...  I've tried to help them, but generally hasn't been
a successful relationship there.

Regards,
Jake
