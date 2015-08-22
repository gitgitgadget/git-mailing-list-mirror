From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 7/8] branch.c: use 'ref-filter' APIs
Date: Sat, 22 Aug 2015 23:20:32 +0530
Message-ID: <CAOLa=ZSwU94-JgAdw-xoL5mDNVL8nsbuBCD-MhN3H+m1gFD9gQ@mail.gmail.com>
References: <1440226309-25415-1-git-send-email-Karthik.188@gmail.com>
 <1440226309-25415-8-git-send-email-Karthik.188@gmail.com> <CAP8UFD3rXJqB1DEz5LfdM8xxanzoJp6J=weED+FygeZmufG4Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 19:51:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTCwf-000738-Ai
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 19:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbbHVRvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 13:51:04 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36437 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbbHVRvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 13:51:03 -0400
Received: by oiev193 with SMTP id v193so58424605oie.3
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Iz8ioPXbTYP+7CjBT71N9KTTkpG5Fe1hEtTc2jcPH1s=;
        b=GDR80ip/Rf+o+O39MbNzExzr3Q6/EALiVgkSN/e7TANUqQt+zQ3BQeVrSoe7EdnqpM
         feUE05tDcOASdbeM9PPuGDmPDIsMdzNLlUz54y8JqK4EdM/PNZI6IX/8nXaa0K6uTpac
         biP9dWrzeRnzyC64jd87cymQSL1GX3CQk2uA6wK+IhKJQKTGz1bdDMiakIVoTP71Xwtr
         rUQiVwvsvN/iQ11Tcl3ac3C68TG5DA1gU4wpfHnOa77WC4aFgZC6sXQo66k2uJAWPC79
         xn4gSKGvl2DLq7CCFZwoim/Yo19AZWjEJBzPCjpHMFiRtMQIN1RZfnDY1lMYDWyDEgxF
         ajrQ==
X-Received: by 10.202.92.65 with SMTP id q62mr13084838oib.11.1440265861621;
 Sat, 22 Aug 2015 10:51:01 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sat, 22 Aug 2015 10:50:32 -0700 (PDT)
In-Reply-To: <CAP8UFD3rXJqB1DEz5LfdM8xxanzoJp6J=weED+FygeZmufG4Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276392>

On Sat, Aug 22, 2015 at 9:21 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Aug 22, 2015 at 8:51 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> The test t1430 'git branch shows badly named ref' has been changed to
>> check the stderr for the warning regarding the broken ref. This is
>> done as ref-filter throws a warning for broken refs rather than
>> directly printing them.
>
> [...]
>
>> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
>> index 16d0b8b..db3627e 100755
>> --- a/t/t1430-bad-ref-name.sh
>> +++ b/t/t1430-bad-ref-name.sh
>> @@ -41,7 +41,7 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
>>  test_expect_success 'git branch shows badly named ref' '
>>         cp .git/refs/heads/master .git/refs/heads/broken...ref &&
>>         test_when_finished "rm -f .git/refs/heads/broken...ref" &&
>> -       git branch >output &&
>> +       git branch 2>output &&
>>         grep -e "broken\.\.\.ref" output
>>  '
>
> Maybe the test could be renamed to 'git branch warns about badly named
> ref' and maybe you could also check that "broken\.\.\.ref" is not
> printed on stdout.
>

The name change sounds reasonable, do we really need to check for it in the
stdout?

-- 
Regards,
Karthik Nayak
