From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 22/83] builtin/apply: move 'unsafe_paths' global into
 'struct apply_state'
Date: Wed, 27 Apr 2016 14:14:40 +0200
Message-ID: <CAP8UFD0Xx4d=751yhaHpRKUgDQ1G2FkuCEziwdZpVMiJbjyaMg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-23-git-send-email-chriscool@tuxfamily.org>
	<xmqq37q8f748.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:14:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avOMg-0006gl-1f
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 14:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbcD0MOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 08:14:42 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36494 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcD0MOl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 08:14:41 -0400
Received: by mail-wm0-f47.google.com with SMTP id n129so24477493wmn.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7doM0Es4NSPSFEA1rkOrQcyiIiffyLA775JSAQPC2Uo=;
        b=QvUsRc4N1cmfF/e9hiKcio9rrCuh8aFhmDGOm4BqJRRodDKDM2iYtmwFcnbdl7Gr/U
         SOu1D2LfyV45teYpY3mo+de+YUThlF3UivVsPRlnp+u6w55bAc/s8nDOvyWTMJGAeBHW
         ItsoS8Wx/uzO8Y5jfAn8aTSMDXAKOQMaD5Krw4f8TVAzuYhokfeJG92ihTEDyCYt5i/1
         Bw8hOj+hNgAAGP1DFN9JKfIDUuS5FYEK0wfsKs0CNufj1qatUe48zJLMCkD6tKl+k3R7
         MIL331jWoenoCVZ42YrIErXRHgeKGdH0M3A/7qm2zJUo78chO7dOIX4r9dPKy4twyTjX
         +7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7doM0Es4NSPSFEA1rkOrQcyiIiffyLA775JSAQPC2Uo=;
        b=SRM00rUcvArmQlvyv8tufDfK0jxzLUUfVhAltp+UDdc+typC3F8+L8dqphJncRjhod
         g0CO+lLuA17J18T04YSU37OeNGM2JxKM9ZmO2l/l5LMNM8kBHQEP0VtAqfUmmkx/djVt
         uRZuuy1rMWwH0wYJl/WlgpQM076MdqwZKGUYQBZZ/n6nsnSPuyBisipk+mmvvJWqXk8Q
         p8sOe5G0BaZnj1oe1CHod0rDqESq6K506bye09xoBAmxh0J0OoOReh90Mu76XrX75Uiy
         /HO52chv8X2SXk69d97PWXjtZgR6Y/K5fR922m1YSbpLI8is9Q5Y7FJy5quNJwhchWZT
         k33A==
X-Gm-Message-State: AOPr4FUqM+BrUj5AdFzz1VxHPP9fi2x11W+UCkaOyzCW5ZYhyNjYXuRTviyibxvmPx8QMeHzLGoB3T8FQMF6IA==
X-Received: by 10.194.235.39 with SMTP id uj7mr8748461wjc.78.1461759280162;
 Wed, 27 Apr 2016 05:14:40 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 27 Apr 2016 05:14:40 -0700 (PDT)
In-Reply-To: <xmqq37q8f748.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292720>

On Tue, Apr 26, 2016 at 10:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/apply.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index 506357c..c45e481 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -57,6 +57,8 @@ struct apply_state {
>>       int unidiff_zero;
>>
>>       int update_index;
>> +
>> +     int unsafe_paths;
>>  };
>
> Having said
>
>     I like the way this series moves only a few variables at a time to
>     limit the scope of each step.
>
> it gets irritating to see all these unnecessary blank lines in the
> structure definition added by each step, which would mean all of
> these patches need to fix them in the next reroll.

The reason I added some blank lines is that I moved comments that were
all in one block at the top.
I moved each comment near the related variables and sometimes a
comment is related to 2 variables, like in the extract below the
comment that starts with "For "diff-stat" like behaviour,...":

------------------------------------------------------

    /* --index updates the cache as well. */
    int check_index;

    int unidiff_zero;

    int update_index;

    int unsafe_paths;

    int line_termination;

    /*
     * For "diff-stat" like behaviour, we keep track of the biggest change
     * we've seen, and the longest filename. That allows us to do simple
     * scaling.
     */
    int max_change;
    int max_len;

    /*
     * Various "current state", notably line numbers and what
     * file (and how) we're patching right now.. The "is_xxxx"
     * things are flags, where -1 means "don't know yet".
     */
    int linenr;

------------------------------------------------------

If I remove all the blank lines, I think it will make it harder to
understand which comment belong to which variable(s).

Maybe a compromise would be to just remove blank lines between the
variables that don't have any related comment like "unidiff_zero",
"update_index", "unsafe_paths" and "line_termination" above.
