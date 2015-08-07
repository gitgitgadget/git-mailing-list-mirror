From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 7 Aug 2015 13:49:30 -0700
Message-ID: <CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:49:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNoa8-0004NI-NV
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 22:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946254AbbHGUtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 16:49:32 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34923 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbbHGUtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 16:49:31 -0400
Received: by ykcq64 with SMTP id q64so93309204ykc.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pmC+GLkXl8wPTp9LPQMZbQSRXc8bbrHvQQ4hAOBz6MA=;
        b=RX/t81YcyBV11+Cpfp4650427R/06wRyU7mHdtmkxc/Xn+kG0vW7fbAv2y/3XmWbB9
         +jWSLEXThYoZozYF0FeGJFNSMI0kgiMXyhsdg0WHC7K4npODFLPUiOV+KBDKeTm2xCyr
         knRqxhCQXK4jzrjlQ762hK4teDV19fd25z/gAvDWjZIUZb+nerPGlqvu2Hq9uwG3Ux1n
         ey+fKbluXvUQND+6/Bj/6HDtoMU3v/TQWY0b4gE++o6b5Wroy5QFcvRb3U7zEvyjQvkr
         xSxmIGPjXhfqbgnPyiTz3MhFaaQIQlkxIjhYK5626wTVGNja/rZsHWTgkWQ0JFrQ4tpv
         etUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pmC+GLkXl8wPTp9LPQMZbQSRXc8bbrHvQQ4hAOBz6MA=;
        b=P1x0GZNuULYMLdnNtv3nW8il8LCC3lz9atYVkxj6TKswYIBh6TjgPWt3RL4DjhxoPu
         Zn/eaYH6/kD4sRoY5OisvOMR2Yt3ekP41s3IXrqpW9jBdwi8ckIGSJSiytOWZvAFIEtE
         5gBnH5STDAvR93t/k4/Eb9A0Df7qR4SYn2cGRkE0VCx0O8A39nRyarwvyCWmLeBl+vUE
         muX7fcb2IE1fDqGOj67tVnFzRC6qMxn2cXCwTr5X0UvJat82HvHAS+ds2sng6brVagsC
         RXK0W89sz9b38m5cQahwYfmnUFMkIxheWPKMRX5dO2RNQwbeL6hPm45mcQpJ3h3CJajG
         rZAg==
X-Gm-Message-State: ALoCoQnNxRUwQ/5mnq5hf/jq5pEQvzPT/1cyNmczCRLI2QiGjAUjO9uZPYgyd5A2SGZ4MX5M4xvi
X-Received: by 10.13.247.3 with SMTP id h3mr10111988ywf.142.1438980570438;
 Fri, 07 Aug 2015 13:49:30 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Fri, 7 Aug 2015 13:49:30 -0700 (PDT)
In-Reply-To: <xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275487>

On Fri, Aug 7, 2015 at 1:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
> This change...
>
>>> @@ -723,10 +733,8 @@ int fetch_populated_submodules(const struct argv_array *options,
>>>              if (!S_ISGITLINK(ce->ce_mode))
>>>                      continue;
>>>
>>> -            name = ce->name;
>>> -            name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
>>> -            if (name_for_path)
>>> -                    name = name_for_path->util;
>>> +            name_for_path = submodule_name_for_path(ce->name);
>>> +            name =  name_for_path ? name_for_path : ce->name;
>
> ... interacts with Heiko's cached submodule config work that seems
> to have stalled.

We can drop that hunk as it only uses the new method
`submodule_name_for_path` but doesn't change functionality.
So if you want to keep Heikos work, I'll just resend the patch
without that hunk.

>
> I can discard the stalled topic and queue this one instead, asking
> Heiko to reroll his on top once this has stabilized, or if Stefan is
> really into revamping submodule now (which I hope is the case),
> perhaps Heiko's work can be rerolled by Stefan (with help from
> others, of course) as a prerequisite and then these changes can be
> built on top of it?

I am a bit overwhelmed as I am into git submodule for a few days now
and still have not a full&good understanding of the details.
So for now my plan looks like this:

1) rewrite the helpers in C (module_list, module_name and module_clone)
   These helper functions are useful for themselves as they speed up
   git submodule operations, but I have them on the plan as they are a
   pre requisite for rewriting `git submodule update`

2) Come up with a good thread pool abstraction
   (Started as "[RFC/PATCH 0/4] parallel fetch for submodules" )
   This abstraction (if done right) will allow us to use it in different places
   easily. I started it as part of "git fetch --recurse-submodules" because
   it is submodule related and reasonably sized

3) Rewrite `git submodule update` in C
  This will start out as a literal translation and once 2 is coming
along nicely,
  I want to add that thread pool capability to the C rewrite.

This plan still is huge to me, but a lot smaller than my initial
"rewrite the whole
git-submodule.sh in C".

Once the rewrite and parallelism is done, I may want to start adding new
features to the submodules, such as different "classes". Currently I think
each submodule would have a set of these classes or features, such that
you could clone a superproject with hints on the classes:

  git clone <url-to-super-project> --submodule-flags=basis,amiga-specific,ui

each of the flags would then include a specifc set of submodules, such
that after cloning the super project you have everything you need to build
the program with ui on amiga.






>
