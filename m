From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 23:22:13 +0530
Message-ID: <CAFZEwPOMdozVafJzRYJmhhAAAAVfLJ74dSGVbsHreFFKD1Vobg@mail.gmail.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
	<010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603221552100.4690@virtualbox>
	<xmqqh9fyjy9w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:52:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQTa-0001cm-5V
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbcCVRwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:52:15 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35215 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbcCVRwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:52:14 -0400
Received: by mail-yw0-f193.google.com with SMTP id c11so2482194ywb.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=e7Mv2xYbS6RujWZ48Qjxmf8pWFcd7sHn3oxwNwBeV3Q=;
        b=AuPBVbinAy0wJy5cDEOkEAjnDDXFoqiOKHiI4iMFAp2Sl8l6QGep1IdK2QtaH+Iu8i
         rt5x3d9iVXkYcLsjWCF3pUNCuLPw16NpZBKDfw6G8uhDuXKhDdHrWuZFJcgHgkq2/HXL
         8n80ZcE3Y3Cx7EDCq/PzstS+XhNGz1ih/iwKvHFoEJsg7fnLjXzlyvK9H2/XReL7Mxew
         FzbkpsgTTQ0n/nPISYi9NUOlczLRlCpG+ODPtIob/uouMiu6IzzFHX0OzCiPzsbdGHi6
         3rmWyS0qMXedCxMgdTyqiOMJslgqhJNTh2c8HhMtEUIexIhpvZnRs2JPiTXeHGeGBAmC
         3d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=e7Mv2xYbS6RujWZ48Qjxmf8pWFcd7sHn3oxwNwBeV3Q=;
        b=NWeSupqYaBbPoM2B5JN+l4W9p10obfjVkeOIBRhyqpdS186ultL2OIecUlzh6fAqpP
         duf8bZUOi8WFE7bzDg+Ox4VmqHsaSsRb4DYLhXKqMAvMSl7LoY1h70E8v6eoGQ4vSBZs
         HwuxtKUhbIEOXMpZr+SVQlEKJnyK/r7AB9JhUqynCIqXdrYXGQ2pjl0Kd2KS4du2GUip
         hUJ+vLVuOa5CawoHbLPoXn8itNnSUvsrul0kKvdQ/cVpJF1wuWeCkI3bnblVAE7PeksX
         A7Ps5qGckKx4+h/N+FgEokEFA/vxWl0FV728pVFpBBj8Mbrx2UkuJbhiRw3N5+4Nr3dJ
         sLLQ==
X-Gm-Message-State: AD7BkJKkiVTBYJBaw91fh8Ub7vRl543alMfuJzPUuNEWibAkFUioKYnrhqFJOW0IZE6w7Xy9rZNgz5t7ZMi5ew==
X-Received: by 10.129.9.214 with SMTP id 205mr16928575ywj.53.1458669133313;
 Tue, 22 Mar 2016 10:52:13 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Tue, 22 Mar 2016 10:52:13 -0700 (PDT)
In-Reply-To: <xmqqh9fyjy9w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289532>

On Tue, Mar 22, 2016 at 9:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> static int one_of(const char *term, ...)
>> {
>>       va_list matches;
>>       const char *match;
>>
>>       va_start(matches, term);
>>       while ((match = va_arg(matches, const char *)))
>>               if (!strcmp(term, match))
>>                       return 1;
>>       va_end(matches);
>>
>>       return 0;
>> }
>
> This is a very good suggestion.  We tend to avoid explicit
> comparison to NULL and zero, but we avoid assignment in condition
> part of if/while statements even more, so
>
>         while ((match = va_arg(matches, const char *)) != NULL)
>
> would be the best compromise to make it clear and readable.
>
>>> +    if (!strcmp(term, "help") || !strcmp(term, "start") ||
>>> +            !strcmp(term, "skip") || !strcmp(term, "next") ||
>>> +            !strcmp(term, "reset") || !strcmp(term, "visualize") ||
>>> +            !strcmp(term, "replay") || !strcmp(term, "log") ||
>>> +            !strcmp(term, "run"))
>>> +            die("can't use the builtin command '%s' as a term", term);
>>
>> This would look so much nicer using the one_of() function above.
>>
>> Please also note that our coding convention (as can be seen from the
>> existing code in builtin/*.c) is to indent the condition differently than
>> the block, either using an extra tab, or by using 4 spaces instead of the
>> tab.
>
> In general, "or by using 4 spaces" is better spelled as "or by
> indenting so that the line aligns with the beginning of the inside
> of the opening parenthesis on the above line"; "if (" happens to
> take 4 display spaces and that is where "4" comes from and it would
> be different for "while (" condition ;-).

I will definitely keep this in mind henceforth.
>
> But with one_of(...) this part would change a lot, I imagine.
>>>      struct option options[] = {
>>>              OPT_BOOL(0, "next-all", &next_all,
>>>                       N_("perform 'git bisect next'")),
>>>              OPT_BOOL(0, "no-checkout", &no_checkout,
>>>                       N_("update BISECT_HEAD instead of checking out the current commit")),
>>> +            OPT_STRING(0, "check-term-format", &term, N_("term"),
>>> +                     N_("check the format of the ref")),
>>
>> Hmm. The existing code suggests to use OPT_BOOL instead.
>> ...
>> The existing convention is to make the first argument *not* a value of the
>> "option", i.e. `--check-term-format "$TERM_BAD"` without an equal sign.
>
> I think it is preferrable to keep using OPT_BOOL() for this new one
> if we are incrementally building on top of existing code.
>
> But if the convention is that the option is to specify what opration
> is invoked, using OPT_CMDMODE() to implement all of them would be a
> worthwhile cleanup to consider at some point.

OPT_CMDMODE() is actually a better option. I also noticed that it
isn't mentioned in Documentation/technical/api-parse-options.txt .
Should I send a patch to include it there just to make it easier for
someone who is new and isn't aware of the changes ?

> I agree with all the points you raised in your review.  Just wanted
> to add some clarification myself.
>
> Thanks.
