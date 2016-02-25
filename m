From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Rebase performance
Date: Thu, 25 Feb 2016 10:14:02 +0700
Message-ID: <CACsJy8DMyD9oo2_3+BdM-M=0eYAi1ip77WTuYt42tBn9DuD+kw@mail.gmail.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
 <CACsJy8DZOv2Z2hiUmRKHr_GCjsyVz9kQEE8a1F=h6Ku0Dr9g_w@mail.gmail.com> <xmqqvb5dpk5z.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 04:14:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmO1-0006Yn-3C
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547AbcBYDOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:14:35 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34080 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbcBYDOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:14:33 -0500
Received: by mail-lb0-f169.google.com with SMTP id of3so21539444lbc.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+N/z3AdDS4CJXKF9aIcEaF0EcS3Z5ATdlZqX6RpOL30=;
        b=XnNwHErvcewV7BR8Xe7NqU0J1EtR55tjmtCoEkQnv9cSylw23t633M8NET8F13HL6h
         6qRiUOEFDCt40SvKHbken+bfGrYDK3J+RdmITkfpSSj1HIzt8IQ3CJ8W6HpJeLl0hlzz
         tjcgzD9fhDBmvUqQd5j++HwLZhqfjkBj6Q56gjNwpZl3DrlPJ3Jy3m+FwEtvLVXuebpP
         gu8fHvroDR1MUXkHq1nMc64d0DPwdEGD1/HpbnYhDekJs4/TaL2R3vJVdrGSWjTrDW/v
         zMRjh0bfY0DdceUNSLz7YkMKbOz6boLHPx/izoWPJoVJdPVaewPHB7pdEvFEkTR7GQAg
         ofeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+N/z3AdDS4CJXKF9aIcEaF0EcS3Z5ATdlZqX6RpOL30=;
        b=TOdlULxul7PHT71ht4IVhDAmL+wkVc6E4lwlAY6JmK/06FOUj3mjmFuobMksrv4rab
         /ZxGY+hONwSBgK/2jvxQ4zHBUAQJkdlVnSMz15wyoKkFstedknDew28w7o7q9yyWiBPr
         5fx60my4rFx2oGFyjZXrIenOOnOdfkTb84HkKrm0L3Jc1J7lPoOzUrTn/l9IRuAUeZQQ
         hbd4fCrynVqeqxuD3FS9kd9s//eFgQBvX7g5XGp5fgl62ArxWO93ud9VI7CGoiLTn/B8
         GTjqJ4W3nWg0lP8/PLKQaU/qCPBoxdwXX3fQfAeeL//kvgCf0OnujDmpM6XdHRYZa6ig
         cLWw==
X-Gm-Message-State: AG10YOTkVNk1jvcoErJNnRZKSGtEpSmBUN+dhLf1vuB1MK5c3ONeAu7zSe+TtDdoFVJYJ/pB70B1BCt1TaYVVQ==
X-Received: by 10.112.140.129 with SMTP id rg1mr5567295lbb.80.1456370071904;
 Wed, 24 Feb 2016 19:14:31 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 24 Feb 2016 19:14:02 -0800 (PST)
In-Reply-To: <xmqqvb5dpk5z.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287328>

On Thu, Feb 25, 2016 at 10:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, Feb 25, 2016 at 5:09 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> Another possibility would be to libify the "git apply" functionality
>>> and then to use the libified "git apply" in run_apply() instead of
>>> launching a separate "git apply" process. One benefit from this is
>>> that we could probably get rid of the read_cache_from() call at the
>>> end of run_apply() and this would likely further speed up things. Also
>>> avoiding to launch separate processes might be a win especially on
>>> Windows.
>>
>> The amount of global variables in apply.c is just scary. Libification
>> will need some cleanup first (i'm not against it though).
>
> The global variables do not scare me.  You can just throw them into
> a single "apply_state" structure and pass it around the callchain
> just fine--the helper functions in the file all take only a small
> number of parameters, and a new parameter that is a pointer to the
> state structure that consistently comes at the beginning would not
> make things harder to read or maintain.

There are a bunch of shadow variables in this file. If you are not
careful, it's easy to mistake local var "x" with global "x" and
replace it with global_state->x.

> What does scare me (and what you should be scared) more is the way
> the current code handles erroneous input.  It was one of the
> programs written in early days with "just do one thing well and
> exit, the larger program structure will be scripted around us"
> mentality and liberally die() without cleaning things up.  I do
> agree with others that libification of it is a very good thing, but
> the second step (the first step is the easier "global to state
> structure" one, which should be more or less mechanical) towards it
> is to design how the errors are handled and resources are released.

Yeah.. thorough study of apply code may be needed before anybody does
any surgery in this code
-- 
Duy
