From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 78/83] Move libified code from builtin/apply.c to apply.{c,h}
Date: Sun, 8 May 2016 22:11:41 +0200
Message-ID: <CAP8UFD1UMJXkPx1zHMK4sJrueMeXE=5uT+oPp1D31+dsU55AFw@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-79-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8Cb20L=y_=J6S5=rngvH1n0aWvtf5eJrXP-df0aoiJyrQ@mail.gmail.com>
	<CAP8UFD3o_u48rRHP7ZOWnVH7X0O5wwM-Gk-VpH5PP_kFx19ZpQ@mail.gmail.com>
	<CACsJy8AtEv9HHOJUDVKmO=qLkWctvS2zoGdo03jtQwyy2kKzRQ@mail.gmail.com>
	<CAP8UFD0Ku_q56JMvyh9UncJ2D+QsOcB4Svyr5ZWj+KqAaHORMw@mail.gmail.com>
	<CAP8UFD0ktQyk3SHFbq=fjK8++UArNmy+3p3CCgHaDBT5WRwU6Q@mail.gmail.com>
	<xmqq4maa3nfm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 22:11:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azV3M-0002HE-6V
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 22:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbcEHULn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 16:11:43 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35029 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcEHULm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 16:11:42 -0400
Received: by mail-wm0-f41.google.com with SMTP id e201so113750312wme.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ahesSgWpbFYBCFc3csAdwOe3xQp6M4qRg46oLrSOv+o=;
        b=FXJ+jvP8mRSPFL0IL1w4F5s2o50x15O4VBLISIVBVuniAS+P+TH+d1jlFYOZ/xIMFw
         0LrXkuNLxTqupYATB9uJEpZJ9UEW0yME/LlChxBJ1bMn4GbLqna3QorHgiQA/RtTIq66
         H4jBACip46V+ZtPYq9pLE0suGtWhHeX87otdWcrfnNFRmiD0R50E18C4tP/F3VGkXxO/
         OpDRGzW/VpbWKvDnGy+0caCxK4Y4+8gJKjmbFzBMgZcRDya2O9/aJQzWdBp/jU8sRrYd
         jRoLqAl+A/NJFUVzDH3x1U+S0BW6Ms7Hr4JuYLrtvpYphAgXnAS4TrFu7mmdBktLybNk
         edng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ahesSgWpbFYBCFc3csAdwOe3xQp6M4qRg46oLrSOv+o=;
        b=AmCWfy8IfiXcZKgIPy4bGqqUvD62s2xttPXn2Q1go4fLyzlc1kjKlLO9gmI1JMHdXB
         GI6PeyGmrf4VuaUQN0pI65Powgn5RFZ0jF5dRz6yqPC4aIQl7PT42WGIaGmeKf82DsXl
         KsBNmfigYDfo0XmO/TwdbiFdlAln1W+SYksMpNFYwvmkRS54JhLDIR1ZB7Jew/bYPeLO
         CrRDAfHkXB7KuNi8lQE5/Du9d3n1D65zrWWKBtfDjnW5k/jedHl89HUdkFWLnEbvPaG1
         fbeG6AiyVVK7G9cihfiQ6+RtJu4A/ntkYRwn9OwgMcUtO1we4sg2BetE4TAQdstGk+M+
         Wjbg==
X-Gm-Message-State: AOPr4FXVvzzjiTIYBmFpXC3Q4yaHL+Lm9K04Z2lbbe/twbW8yhKUkp5KpZJiHSEbMIjeILFTL0eByTrDT3zQ+A==
X-Received: by 10.28.169.11 with SMTP id s11mr7983447wme.62.1462738301380;
 Sun, 08 May 2016 13:11:41 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 8 May 2016 13:11:41 -0700 (PDT)
In-Reply-To: <xmqq4maa3nfm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293978>

On Fri, May 6, 2016 at 11:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> By the way does someone know how such a patch can be applied?
>
> I think in mid Feb 2015 I sent out a message that says "'diff -B -M'
> gives a broken result, do not use it".
> I do not have time to dig the mail archive right now.
>
> Perhaps this one?
>
>     http://thread.gmane.org/gmane.linux.kernel/1879635

I get something strange with only -B:

$ git reset --keep 20f1d27~
$ git format-patch -B -1  -o ../../patches/test-libify-apply-use-in-am/ 20f1d27
../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
$ wc ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
  5264  23426 147127
../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch

I get a conflict with `git am`:

$ git am --3way
../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
Applying: Move libified code from builtin/apply.c to apply.{c,h}
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging apply.c
CONFLICT (add/add): Merge conflict in apply.c
error: Failed to merge in the changes.
Patch failed at 0001 Move libified code from builtin/apply.c to apply.{c,h}
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

But it works using `git apply --3way`:

$ git reset --hard HEAD
HEAD is now at 557f659 apply: rename and move opt constants to apply.h
$ git apply --3way
../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
Falling back to three-way merge...
Applied patch to 'apply.c' cleanly.
$ git am --continue
Applying: Move libified code from builtin/apply.c to apply.{c,h}
