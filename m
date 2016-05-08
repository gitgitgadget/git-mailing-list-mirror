From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v5 0/2] bisect--helper: rewrite of check-term-format()
Date: Sun, 8 May 2016 11:53:53 +0530
Message-ID: <CAFZEwPML8MCAL2quAN3ExMFXrhjS07g3KEC-WuSfYAXc2WQKuQ@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<xmqqtwia25qc.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOA9c8eQAacnuB1n=juOhN1zsMdzcupS3ijqwYFPRrW4A@mail.gmail.com>
	<xmqq60up1e24.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 08:24:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azI8M-0000eq-85
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 08:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbcEHGXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 02:23:55 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35559 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbcEHGXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 02:23:54 -0400
Received: by mail-yw0-f196.google.com with SMTP id v81so20991346ywa.2
        for <git@vger.kernel.org>; Sat, 07 May 2016 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3pg6NuuTkRSty126kq0U+DuMUOSZVZAZPjsEX5kQNq8=;
        b=ll9K/Z+/vxU+CrQZT8CuhSiPxMTiUhenla5PfSvbB1QRnOetwlWA4RbN2Yesar51HY
         wZceUNWWWgQr8fNNwdiSu8s+A6TWHnIJ/WWcLBtU7Ld6G2HsqaNRTY/dCsldGIrM5h8z
         DYw1VftkjG7VJjhqr+oneYNT0ZGkZAZzz1rxI3K3YxAdc6yTOeHb6tVupwm6UdqJ+RTE
         51hu/De0xjLismDWwp2pgzU76zdflXMWLf+mikZ1UAmtsG1yx0mUvsV0Zal/kleTsGAH
         uGdz2x70b1jt3qQcAL2ZE9hTJAswQoeUTAMEksN3lGAJd80K0f2kj3wUTM/k6dyP3V8Q
         49bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3pg6NuuTkRSty126kq0U+DuMUOSZVZAZPjsEX5kQNq8=;
        b=WdVEE4jzYeN/EC/ZtWA4wrVEUVsYB0UMICMw/JB9/JDbuOuhvVISlln25NEjw30oID
         zHUnf2M+RHT3644GyA/300pzHvCUgGhZe1qxg8LBiUKVy0ONKNepYFY36S9LyIx0xnsj
         +7TLYHr03q97q49cO5CYtF/ndSYTshMsBj8uRgvPgCjslWWNpaS+WGwl1wzzZhBJcyrH
         pYFnDuJJSjnQdBzdkUUT7xqd9KgLkIv/D/10UFVTJrHw98XxXNffmlzbs7C5dnS6CtDV
         dVdH4jQHQ7+HiDfOz98DFGSjI4qHYSfOYVE9zIkte14usMTSMt9ETreCCxTC2o2ZOfi6
         SEbQ==
X-Gm-Message-State: AOPr4FXY5MXMzxxZoiRnvnV98yS9M+vnNEpMfMGwfr6Bxg5p1SiTO+hoUGSpUNXQtjmyOxFbDkXlBos0zVXBSA==
X-Received: by 10.129.41.8 with SMTP id p8mr16323873ywp.154.1462688633433;
 Sat, 07 May 2016 23:23:53 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sat, 7 May 2016 23:23:53 -0700 (PDT)
In-Reply-To: <xmqq60up1e24.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293909>

On Sun, May 8, 2016 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> I completely missed your point and you want me to go the Eric Sunshine's way?
>
> I am neutral.
>
> When I read your response to Eric's "top down" suggestion, I didn't
> quite get much more than "I started going this way, and I do not
> want to change to the other direction.", which was what I had the
> most trouble with.  If your justification for the approach to start
> from building a tiny bottom layer that will need to be dismantled
> soon and repeat that (which sounds somewhat wasteful) were more
> convincing, I may have felt differently.

Sorry if it seemed that "I have done quite some work and I don't want
to scrape it off and redo everything". This isn't a case for me. I
think of this as just a small part in the process of learning and my
efforts would be completely wasted as I can still reuse the methods I
wrote. This is still open for a "philosophical" discussion. I am
assuming 1e1ea69fa4e is how Eric is suggesting.

Why I think its better to go the subcommand way:
 * I can test **C implementation** of the function to verify whether
it was done in a proper way. By using a "top down" approach, I can
make the test suite passing by running the code from git-bisect.sh not
the re-written C code.
 * I have made a very few minor mistakes in conversion of
check_term_format() which just messed up my head (I actually spent 3
days before Christian pointed out that '!' was missing). Imagine
debugging the complete git-bisect.sh to find a very small error after
a complete implementation.
 * Using subcommands, I can easily verify whether I have done it the
right way or not.
 * It makes the review process very simple. The reviewers/testers can
verify that my method is working correctly and well computers can
detect errors better than humans.
 * I can convert small functions which can be reviewed easily rather
than dumping a big series.

What I think is that the bottom up approach will make life easier for
the me and for reviewer. Yes, it does make the code "unclean" for the
time being and if it is between releases then all the more painful.
Well, the latter part can be avoided by keeping it in next.

Please point out if I am mistaken about anything.

Regards,
Pranit Bauva
