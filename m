From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 53/83] builtin/apply: make find_header() return -1 instead
 of die()ing
Date: Sun, 1 May 2016 18:45:02 +0200
Message-ID: <CAP8UFD0Sv4T57Qt5HnWRisAir==Urs2yr=gzTEvGDvkCpdrNng@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-54-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cRw7_6hbLZ7HfvCHwy7UcujnfOTToMSXaRbx30WTXvaQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 01 18:45:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awuUZ-0005Xe-1w
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 18:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbcEAQpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 12:45:05 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34581 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbcEAQpE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 12:45:04 -0400
Received: by mail-wm0-f46.google.com with SMTP id v200so18522075wmv.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=V2xQ/17T+dmxiZEBIhP1cSE3pNIYvXaxQfCfrRdDCb8=;
        b=v3K7OLsqAmxbeI3GFHpbUYC7FbA7uVgit0fQfu3oQ1hZATfRko3TG6ZIuKvZKRqQm9
         u//u9Du1eWD1TBYawDjM4eb8eGpd01hv1RUHL6nbmWBRGu25dcMsr05pcqCAnduqpayX
         seaRBk7XcGyb6IWsfOaEpYX3OJHT2aUXWXZ1dAhl0EokOll3oHSzUnXu/cMo4cavW6/6
         rwdHcWgixgqf8iGK42bXe+rZLYj4nKmXu28XH/U1w0X9RWaxvFTVZs+hgSmjJ8mXw8QL
         z7PuRvpuo4XboDQHewwiY4GPytWE+owb+/VoS5Q5O18hUfbQlqMEiXCzCxaj98Mmfawm
         dXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=V2xQ/17T+dmxiZEBIhP1cSE3pNIYvXaxQfCfrRdDCb8=;
        b=ADht9uyrSZirsmGs5i5Zeo72QZ2re0Nu6XP0MObqR9cEufbswmE18gelfHsBSxIBCu
         MOPeuYFUU+3TgKQLgQ9S4dJ09UdzlJ8w5q1BiC9pnuRYi2FVnnR5OooFCNf7fwwJHSIT
         Vi+w+2P8yY8dkPB9MrK4dCPoON6dXr8PpPlS13IgkWIGcMZVVPUUQohFh6b/A9yH0SvO
         /ywhV7K3zU7xyNllvpcrpXwSjLpuIjWLwOK/5HM5wChzMTwy1IsNqY3McstEfrAzrt8W
         dXjMBeTBCsDEBdPnWvO/Dx4OXuGprJZ225bZ56LH0zBggT3XxehxJG80+5OWjz6uNXPv
         2znA==
X-Gm-Message-State: AOPr4FWf3DVHrRPkSIILqHiRR/oSpP9IBLqvyZlybLX/SGXy/CDiikxKpqS5gdJN2yzMHdL9CJ0aF62efdVWzA==
X-Received: by 10.28.129.22 with SMTP id c22mr15295533wmd.89.1462121102466;
 Sun, 01 May 2016 09:45:02 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 1 May 2016 09:45:02 -0700 (PDT)
In-Reply-To: <CAPig+cRw7_6hbLZ7HfvCHwy7UcujnfOTToMSXaRbx30WTXvaQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293196>

On Wed, Apr 27, 2016 at 8:08 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> To be compatible with the rest of the error handling in builtin/apply.c,
>> find_header() should return -1 instead of calling die().
>>
>> Unfortunately find_header() already returns -1 when no header is found,
>> so let's make it return -2 instead in this case.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -1588,18 +1596,18 @@ static int find_header(struct apply_state *state,
>>                                 continue;
>>                         if (!patch->old_name && !patch->new_name) {
>>                                 if (!patch->def_name)
>> -                                       die(Q_("git diff header lacks filename information when removing "
>> -                                              "%d leading pathname component (line %d)",
>> -                                              "git diff header lacks filename information when removing "
>> -                                              "%d leading pathname components (line %d)",
>> -                                              state->p_value),
>> -                                           state->p_value, state->linenr);
>> +                                       return error(Q_("git diff header lacks filename information when removing "
>> +                                                       "%d leading pathname component (line %d)",
>> +                                                       "git diff header lacks filename information when removing "
>> +                                                       "%d leading pathname components (line %d)",
>> +                                                       state->p_value),
>> +                                                    state->p_value, state->linenr);
>>                                 patch->old_name = xstrdup(patch->def_name);
>>                                 patch->new_name = xstrdup(patch->def_name);
>>                         }
>>                         if (!patch->is_delete && !patch->new_name)
>> -                               die("git diff header lacks filename information "
>> -                                   "(line %d)", state->linenr);
>> +                               return error("git diff header lacks filename information "
>> +                                            "(line %d)", state->linenr);
>
> I realize that the caller in this patch currently just die()'s, and I
> haven't looked at subsequent patches yet, but is this new 'return'
> going to cause the caller to start leaking patch->old_name and
> patch->new_name which are xstrdup()'d just above?

I think it is ok because find_header() is called only from
parse_chunk() which is only called by apply_patch() and apply_patch()
calls "free_patch(patch)" when parse_chunk() returns a negative
integer.
And free_patch() frees old_name and new_name.
