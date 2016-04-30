From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 51/83] builtin/apply: make apply_patch() return -1 instead
 of die()ing
Date: Sat, 30 Apr 2016 21:41:07 +0200
Message-ID: <CAP8UFD2SzSXWSH8uB2iJ8-QpkYhXDNGbSks4Ua3TLrVH0a7Acw@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-52-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cQTx3wyk0E-ZBaBYbjsXRqHPg1f6snZKGjWkrTq=fb6Vg@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Apr 30 21:41:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awalQ-0008D0-0m
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 21:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbcD3TlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 15:41:09 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35409 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcD3TlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 15:41:08 -0400
Received: by mail-wm0-f46.google.com with SMTP id e201so64104471wme.0
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/hxgB4FIAcsrQIUbPWEods7Be7bFx7fnERbLgkjAeQY=;
        b=ubiZf0czLO+0udqBg0ZCBdob5eACyHc5gaW2CAH6OSR+UkoRW7uvgxzC+vRHCANxMh
         zcXZQwNY0nqHQQ6tSn3bpEZkrxiO6t9H4Q2Df5N8D6EGiUQBqM9lsllN8Lmllaw38DSf
         8mU2dndIanxT762ASOvEpXDqX2UmJk/69jTrsev0hd1QdgcvySg+1UNtsFhim0ar/MSM
         yhKJly9LaD/qC2EM2tIcD6+xkASH8r9Qimj8uy8I9yn5fcLTPN8uNLQryjV2zOOvnyud
         Iv8w6r80VJ62C+DPxPNBKZMQMx8Uw6TmGxCgZpCZBvsRLMWqk3SoTYthejGIiqkMxOl4
         YrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/hxgB4FIAcsrQIUbPWEods7Be7bFx7fnERbLgkjAeQY=;
        b=QxTT5TltyPOonVGOaultW63VDJQjti8BKdKnfIbb29XcL6twLx+5YZPFv0HxGaeuFX
         eSjdjr2q/htTHO+AncWNaPXvrdpjyqeGrY+BFHZr07arAf0yyS1bgRcMp502zO15gC3Y
         eINCX9Wurc8fZpEJPX2CGtZjEZjNskIqImGGqrDeuELql2ykHmGXXCNz08wesQK2PnYX
         9E4asnViHxxi808cmfUgORVPz5B82O46pW4mF4q6p3LT+/BG740TNEND6dD1C/izJf3V
         cC2KArDwDHJPCsEPxCclLJbIuNgdKsBcnJx5JbDXgvdVCwLk24ihRxRw4uPRrrWvEzk3
         nQsQ==
X-Gm-Message-State: AOPr4FWm6Dlq4NcrHvmNccEpC4UU/vF9hAoau19ar9nrzAXPtZMGu5u0jNGUj4VhNPfTpVY2+qVLK1uecqLWrA==
X-Received: by 10.28.169.11 with SMTP id s11mr11357400wme.62.1462045267126;
 Sat, 30 Apr 2016 12:41:07 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sat, 30 Apr 2016 12:41:07 -0700 (PDT)
In-Reply-To: <CAPig+cQTx3wyk0E-ZBaBYbjsXRqHPg1f6snZKGjWkrTq=fb6Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293126>

On Tue, Apr 26, 2016 at 3:20 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> To libify `git apply` functionality we have to signal errors
>> to the caller instead of die()ing.
>>
>> As a first step in this direction, let's make apply_patch() return
>> -1 in case of errors instead of dying. For now its only caller
>> apply_all_patches() will exit(1) when apply_patch() return -1.
>>
>> In a later patch, apply_all_patches() will return -1 too instead of
>> exiting.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -4522,6 +4522,14 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>>  static int apply_patch(struct apply_state *state,
>>                        int fd,
>>                        const char *filename,
>> @@ -4564,7 +4572,7 @@ static int apply_patch(struct apply_state *state,
>>         }
>>
>>         if (!list && !skipped_patch)
>> -               die(_("unrecognized input"));
>> +               return error(_("unrecognized input"));
>>
>>         if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
>>                 state->apply = 0;
>> @@ -4575,19 +4583,17 @@ static int apply_patch(struct apply_state *state,
>>                 hold_locked_index(state->lock_file, 1);
>>         }
>>
>> -       if (state->check_index) {
>> -               if (read_cache() < 0)
>> -                       die(_("unable to read index file"));
>> -       }
>> +       if (state->check_index && read_cache() < 0)
>> +               return error(_("unable to read index file"));
>>
>>         if ((state->check || state->apply) &&
>>             check_patch_list(state, list) < 0 &&
>>             !state->apply_with_reject)
>> -               exit(1);
>> +               return -1;
>>
>>         if (state->apply && write_out_results(state, list)) {
>>                 if (state->apply_with_reject)
>> -                       exit(1);
>> +                       return -1;
>>                 /* with --3way, we still need to write the index out */
>>                 return 1;
>>         }
>
> Are these new 'returns' leaking 'list', 'buf', and 'fn_table' which
> otherwise get released at the end of the function?

Yeah, you are right, I will fix that. Thanks.
