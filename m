From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] reset: add --stage and --work options
Date: Sun, 8 Sep 2013 17:55:24 -0500
Message-ID: <CAMP44s01CqJoDupmiD4K85Y1p9jF0PrT3v5owrS5WQkKQ-kkXA@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<1377800397-5434-1-git-send-email-felipe.contreras@gmail.com>
	<1377800397-5434-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=P0xZAk95Jmw9mRUCwPQP7NmVHsuPaWNg+D2v3wP9=-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 00:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIntC-0004tL-8V
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 00:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931Ab3IHWz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 18:55:26 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44350 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab3IHWz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 18:55:26 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so4409476lbi.15
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YotADAFiIOUW7P2mdafpFDrCafLMbnBjdzCYcxB/E6E=;
        b=KmdXCaPkRd1HjgghZJov0CxqBoVjAhf8yNwgcR6KNebpKaKrG+Mr/go/+phY449gDk
         5LCQ7eBfEqgyek6Tel6tiwuOnqvNMGTEZYfLQs1th11/6fYu0qMQJS9xJDlyqLhGH7i6
         DKQk3FyUqc/7+MZXfcBm9E1P5r20Ip7EFL6wBtgfgH1UPk+kGcUwHSOnfbYDlOjQCnAQ
         /R+XJJVBWLxifFBQmZBrH1HSwvXHIARbT3YZsKXV975RR7OhjgejMG3PzLBvqC3oFdIJ
         KCmXr+NZ3lVAfAft/sh0jZXb/QhKaPHjAmHyaaptUgsaQursXfmEqmlP9Fzff9IaEy5r
         ASvA==
X-Received: by 10.152.29.103 with SMTP id j7mr13225029lah.7.1378680924586;
 Sun, 08 Sep 2013 15:55:24 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 15:55:24 -0700 (PDT)
In-Reply-To: <CALkWK0=P0xZAk95Jmw9mRUCwPQP7NmVHsuPaWNg+D2v3wP9=-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234278>

On Sun, Sep 8, 2013 at 5:05 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>
>> @@ -290,6 +294,22 @@ int cmd_reset(int argc, const char **argv, const char
>> *prefix)
>>                 hashcpy(sha1, tree->object.sha1);
>>         }
>>
>> +       if (stage >= 0 || working_tree >= 0) {
>> +               if (reset_type != NONE)
>> +                       die(_("--{stage,work} are incompatible with
>> --{hard,mixed,soft,merge}"));
>> +
>> +               if (working_tree == 1) {
>> +                       if (stage == 0)
>> +                               die(_("--no-stage doesn't make sense with
>> --work"));
>> +                       reset_type = HARD;
>> +               } else {
>> +                       if (stage == 1)
>> +                               reset_type = NONE;
>> +                       else
>> +                               reset_type = SOFT;
>> +               }
>> +       }
>> +
>
>
> Not making sense at this point. Why does --stage set a reset_type?

Yeah, we would need another patch to cleanup the variable names, but
for now it's better to minimize the changes.

Either way it doesn't matter because Junio is determined to stand
alone versus the rest of the world in this issue.

-- 
Felipe Contreras
