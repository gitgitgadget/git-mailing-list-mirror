From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 7/8] branch.c: use 'ref-filter' APIs
Date: Mon, 24 Aug 2015 23:40:37 +0530
Message-ID: <CAOLa=ZQzV5NB78593r+qXMvS249OBOkRK+ofU30AFzcf97+hsw@mail.gmail.com>
References: <1440226309-25415-1-git-send-email-Karthik.188@gmail.com>
 <1440226309-25415-8-git-send-email-Karthik.188@gmail.com> <CAP8UFD3rXJqB1DEz5LfdM8xxanzoJp6J=weED+FygeZmufG4Sw@mail.gmail.com>
 <CAOLa=ZSwU94-JgAdw-xoL5mDNVL8nsbuBCD-MhN3H+m1gFD9gQ@mail.gmail.com> <xmqqtwro4mpu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:11:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTwDB-0000IO-9U
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 20:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbbHXSLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 14:11:08 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36581 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbbHXSLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 14:11:07 -0400
Received: by obkg7 with SMTP id g7so120594100obk.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=njYmqcO8IsTWW+VfEtrX4RzljZ6q9HwFtOWultqQQ1E=;
        b=aU+KFbcP8zfpTX+9qei8wa87U2I8Hfr67zXDWzgzQkBmwu8AvHQZo0aOOTkdW/zUTI
         wrlIVLHUvV2SfVPpWI0ldz0xN8PsKdmYRpa0KpUj4iPYwuLhrK/KDHXZNTzeF+PEnsV6
         G4dJmt5iGHr9mJETbn+BoNC65zTEdDQ5NqDM3qOpLq5q7prA8os08eJj2ZkDwTDFkGHT
         hsWwpPtKPyzPvccEntST3cljayebYcyJDjJrFbdLhjef7GpmNJN9bGRUMvQNx5N6ZgI7
         WG14EMH2REGoQJjmAbOuBmMnVKTuGLQxHxGrtCRGs6D2ImCKbDdur28Th96BZkYE84im
         eBTg==
X-Received: by 10.60.50.169 with SMTP id d9mr20306001oeo.9.1440439866570; Mon,
 24 Aug 2015 11:11:06 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 24 Aug 2015 11:10:37 -0700 (PDT)
In-Reply-To: <xmqqtwro4mpu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276473>

On Mon, Aug 24, 2015 at 11:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>>  test_expect_success 'git branch shows badly named ref' '
>>>>         cp .git/refs/heads/master .git/refs/heads/broken...ref &&
>>>>         test_when_finished "rm -f .git/refs/heads/broken...ref" &&
>>>> -       git branch >output &&
>>>> +       git branch 2>output &&
>>>>         grep -e "broken\.\.\.ref" output
>>>>  '
>>>
>>> Maybe the test could be renamed to 'git branch warns about badly named
>>> ref' and maybe you could also check that "broken\.\.\.ref" is not
>>> printed on stdout.
>>
>> The name change sounds reasonable, do we really need to check for it in the
>> stdout?
>
> I think Christian meant "we should check in both", i.e.
>
>         git branch >output 2>error &&
>         grep "broken\.\.\.ref" error &&
>         ! grep "broken\.\.\.ref" output
>
> or something like that.  That way, you are effectively specifying in
> the test that badly named refs must not be included in the output,
> so somebody who changes that in the future needs to justify why
> including them in the output is a good idea when updating the test.
>

Ah! okay, I get what you're saying. Should I reroll it? Or a squash in?

-- 
Regards,
Karthik Nayak
