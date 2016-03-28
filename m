From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 1/3] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Mon, 28 Mar 2016 15:03:07 -0400
Message-ID: <CAPig+cR63D2L8dXJe9Gx-zFXr4-gNaFC6GdfWNPnt4d=Ds8tWg@mail.gmail.com>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
	<1458815593-11060-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPP5Hq0fM3Fhg+JV-aY6bWozjL6m_bNpb=JhjkUjDJu2sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:03:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akcRX-00084k-FC
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 21:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbcC1TDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 15:03:10 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35874 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbcC1TDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 15:03:09 -0400
Received: by mail-vk0-f68.google.com with SMTP id z68so16391198vkg.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=r8SSrZgDJ28/DHPGYctv+JnN2DQeEiE0VFvilCe8cY4=;
        b=sNHVsfZ5lYfe9vVAuNZJQHthx3+AupjewAuYjb+vWyKGsIP4qE38bMF0nd6g9gLNTQ
         V2pisdyHBoYirr0AjnIh6erhsy93plwDQ+24QhLkB+A+Mgda8rjcrUgD1IoRrY21FQbx
         g1GclRQD3JAzq/bzbQvFhH0PAuzZxGbajKGoLBIx1sareR6zNuwbcgEsU/T1dk04k7Ka
         av5MWcIQQmis19wzFmPJbGrV8Ivwq1aXpDcFsE0tJw6tpVWDpkZD5ahdHb2v4hzfurik
         ySOmbaoiL4TzbaxGPqzf0txc5/qDNZXXWrPm2L8HDJ8r3jC+09XF9I38NXHbHp4jDAVe
         h+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=r8SSrZgDJ28/DHPGYctv+JnN2DQeEiE0VFvilCe8cY4=;
        b=M3/TBCcOTmbY6hXGx079TjNyoUjN1Jbwl4SHLWZBXmhLm0gEfErbghqwWjdwh/bK06
         rXW9N1V+Y4izMqjfLDqspKp65Wv2eaSh+8Fm0CUk/c4andxwjwBDmHEbTKnjobRxdYl9
         Hg4uCSbVi9dzyVmnHQho3EKfMTi5VblQhWmoluxveIXySNeOma6Rzxml2TVrXkn6OpUe
         Xr1o+/4gFyzOW9GKC+LuY1iK+Kby49LdIMnr8o8q/S5Mmni5bsAOM7kbFbJM7nLvWshI
         TMTmLWnT3ziQGMt8LAo5E/w6Nkn60LmMBdztCciLrtWYubWEwRreYQm0dSxkp0mjEANI
         uqjA==
X-Gm-Message-State: AD7BkJKNNTaYoY5DASDS1WuEnTtMagOEF6sAYb5Jo6Rc0M0kSqIfhaFFQden1IFe22NU38faLgzW3H2gfN5APA==
X-Received: by 10.159.36.172 with SMTP id 41mr4252783uar.123.1459191787863;
 Mon, 28 Mar 2016 12:03:07 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 28 Mar 2016 12:03:07 -0700 (PDT)
In-Reply-To: <CAFZEwPP5Hq0fM3Fhg+JV-aY6bWozjL6m_bNpb=JhjkUjDJu2sw@mail.gmail.com>
X-Google-Sender-Auth: 5E3gVjdGTx35itPgtabhKn49U2M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290056>

On Mon, Mar 28, 2016 at 2:42 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> A couple of new tests to t0040-parse-options.sh would be great to
>> ensure that starting from a negative value works as advertised, i.e.
>> at least that '--option' jumps to 1 and '--no-option' resets to 0.
>
> I think adding tests to t0040-parse-options.sh cannot reflect the
> behavior introduced by this patch.
> This is because setting the initial value of the variable (which is
> going to be modified by the argument) is set in test-parse-options.c .
> A possible solution will be to modify the test-parse-options.c and
> initialize the required variable (verbose or quiet) to "unspecified"
> value. But then this will leave one part of the untested ie. when the
> initial value of the variable is 0. I could do one thing to test these
> both behaviors which is to set verbose initially to -1 and leave quiet
> = 0. Since verbose and quiet are both consumers of OPT_COUNTUP, this
> can test both the behaviors.
>
> I tried searching for alternatives but could not find any. Is there
> something else which you had thought before that would test this
> behavior?
>
> If not, then we are left with 2 options, either modify
> test-parse-options.c or just hand test it whenever there seems to be a
> problematic case.

Modifying test-parse-options.c, if needed, was implied by SZEDER's
suggestion to add tests for this new behavior. test-parse-options.c
exists strictly for testing option parsing, so don't feel constrained
about modifying or extending it in order to test the new count-up
behavior if the existing implementation doesn't directly support what
you want it to do.
