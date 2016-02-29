From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v5 1/3] sumodule--helper: fix submodule--helper clone
 usage and check argc count
Date: Mon, 29 Feb 2016 11:34:32 -0800
Message-ID: <CA+P7+xryNo=n0fFn9HNrj78z4XtWwoF=j67+Qy8TbO7reBTO-Q@mail.gmail.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
 <1456532000-22971-2-git-send-email-jacob.e.keller@intel.com> <xmqqr3fvcsoy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:34:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTar-0008Nx-CO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbcB2Tex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:34:53 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36426 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbcB2Tew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:34:52 -0500
Received: by mail-ig0-f176.google.com with SMTP id xg9so2322477igb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j0HgOjADRcORdEH7umwFsJeyYl1484nMg1Aj87VIZCo=;
        b=Ca3WrKsuT8gUrm2KN+9UChLM9t2DYrpZIJlxHx5qUvZlK7PK+MUX60JwKRxFKw5J2v
         m1EbiK72RwvY3YVXA4SpfmxaOXWFpxFLSVCZ5QidtLAHZs4PV8tm2sG/jVIIDoe1mUzR
         EcduDtmHEsqu6GFuH8gtKwvsNVZbMU0pjr4G/AyT56PltV0T1BF9J5WluJ2qsDBaA0Ju
         thvCYJbEt8Vl5gzUlSlnm0RTOrsaDlQaK58ufr2rrRD9Gx9synXB7+jUKXIhBfIdTHzH
         Qr05o5a57RFsCb+g7s/J927MJOXoCFQlw1dUTjS/ec+0fryYqDxQB3oHvHqrhEXPcjJC
         p7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j0HgOjADRcORdEH7umwFsJeyYl1484nMg1Aj87VIZCo=;
        b=mqzf/mybMoBoYeIujy4YiE3OY+/ORO/SdiUBf6tGl7u6oFfBtIGpQ7qOecGGbUaojY
         HrQ+S1iplHx/OPtreaBs9AIScW4HKHlWYOjEJpRPbreKBSbPETioTPr1fbb+5Pf+vUWD
         zk9wJES5a8zzTDJXrATR9+f8ZUhOV4NjGIEbkAXr+a7DgAXImCVxfu1gXA76Pfuac+oj
         Et6IEfyV4YRxpVm3LcBaOWUVkiMczgQCnV5yMP+MiQXb17dqa07GUr/NNbfGnDO52BE6
         piD+NoEpdvf/UCiNFHUt/RYLE+0OAgnGKKIZCfXbzN5K+aVKR6JHy8B7nRYww6bXJGkO
         6Ufw==
X-Gm-Message-State: AD7BkJJkIOJW2QzwTKsokuyF1/kZC6G157Fmcj1tRc1eGm/oCjAzZc7VvtS+7Su/rgDkvFK+QJ80tlfgNcMwkg==
X-Received: by 10.50.137.35 with SMTP id qf3mr11763449igb.92.1456774491452;
 Mon, 29 Feb 2016 11:34:51 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Mon, 29 Feb 2016 11:34:32 -0800 (PST)
In-Reply-To: <xmqqr3fvcsoy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287890>

On Mon, Feb 29, 2016 at 9:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>> Fix the usage description to match implementation. Add an argc check to
>> enforce no extra arguments.
>
> The above sounds very sensible.
>

Right.

>> Fix a bug in the argument passing in
>> git-submodule.sh which would pass --reference and --depth as empty
>> strings when they were unused, resulting in extra argc after parsing
>> options.
>
> This does make sense but it is an unrelated fix.  Perhaps split this
> patch into two?
>

That actually is required because otherwise adding a check for argc
would break the things. I could split them and do this first and then
check for argc if you really prefer?

>> +     if (argc)
>> +             usage(*git_submodule_helper_usage);
>> +
>
> That asterisk looks very unusual and wanting to be future-proofed
> (i.e. who says that only the first entry matters?).  Should't this
> be calling usage_with_options()?
>

I... didn't know usage_with_options was a thing! Hah. I can fix these up.

Thanks,
Jake\
