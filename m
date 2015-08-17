From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 7/7] Add a config option push.gpgSign for default signed pushes
Date: Mon, 17 Aug 2015 14:22:55 -0400
Message-ID: <CAD0k6qTnJPc+Nh6dck0_Zx9vnyn5YVMCmy3E=7vr8bTpRSppAA@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
 <1439492451-11233-8-git-send-email-dborowitz@google.com> <xmqqy4h9et2m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:23:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRP45-0007XC-2F
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 20:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbbHQSXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 14:23:16 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38378 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbHQSXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 14:23:16 -0400
Received: by igfj19 with SMTP id j19so62081348igf.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BHG21AzIkoQN2rxlAGy3ZZd0ZdEyACw0uto9Cn14lBE=;
        b=KW7155LFaz3Zxev9ftg64THWPtUKcxtzHa4MBY/Bj8VeEXJZJZiQD2JelSqVSlixN2
         KlZqoOCZl2VlGgIkL5MuzAjYMERulOnmLuswmJTrnx3np1jF7ZPz/Fu0nBhXetqdtenW
         7zZIdW5/StfCb9gN2wyBXaBvhvPaf+YjCftV9gdqfT/USZ5wXUGGydKtu5Ig8GRgQHw+
         yJ/+kRfYpATDiRdEpYq9BlTkb/v7Ay9Ia0CqNHUHxeaxOs/Sek/JUG4kTGYE9fCW+cqj
         Q005ECDuefrGpPq8LfEh+bRKOk+TMF6kk7cbku0HOR8dU6ChRK+3RHJCFGt/dZyM72rZ
         9ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=BHG21AzIkoQN2rxlAGy3ZZd0ZdEyACw0uto9Cn14lBE=;
        b=lBHMgEXdX5eopplPP+XmyktAACeKubm7KvWvGp1htFUcbXmww9OCUX2Dhwn423fIwh
         OFjNYNshZUYwOml/DfzoRr5LAL5Purta1C0o8ZZL+mdB6bqcGRDVodGh9FL49xSjJjX+
         ynsjIKu+RDVZJujsO5cblqRKzCo+nxabV3A2lkx70ZJtvn0j0Pf60I4CLvq7EnmGgeEM
         YBlSoLLjJGnlTzzNeL1RM9n+JKQQNFyfqWNqa8LAXS58GIMfvAOaXm0tQqY7IbjaOS95
         uWBZerF9sv5BEGLl/MKXVWRLOMzofy7Tcqzn7XycFe7mh3r4e45175ylI0eKNbRGyi2O
         pF9w==
X-Gm-Message-State: ALoCoQkAX9qwLvGWEX4g7vban25EvyQ9MxboEDKIyxZ1znM4liqQiqthYVjy32DuQ6F1N4ZbsVib
X-Received: by 10.50.110.72 with SMTP id hy8mr16771418igb.36.1439835795087;
 Mon, 17 Aug 2015 11:23:15 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Mon, 17 Aug 2015 11:22:55 -0700 (PDT)
In-Reply-To: <xmqqy4h9et2m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276066>

On Mon, Aug 17, 2015 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> ---
>
> Does the lack of sign-off indicate something (like "this is just a
> 'what do people think?' weatherbaloon not yet a serious submission")?
>
>> +push.gpgSign::
>> +     May be set to a boolean value, or the string 'if-possible'. A
>> +     true value causes all pushes to be GPG signed, as if '--signed'
>> +     is passed to linkgit:git-push[1]. The string 'if-possible'
>> +     causes pushes to be signed if the server supports it, as if
>> +     '--signed-if-possible' is passed to 'git push'. A false value
>> +     may override a value from a lower-priority config file. An
>> +     explicit command-line flag always overrides this config option.
>
>> diff --git a/builtin/push.c b/builtin/push.c
>> index 95a67c5..8972193 100644
>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -491,6 +491,26 @@ static int git_push_config(const char *k, const char *v, void *cb)
>>       return git_default_config(k, v, NULL);
>>  }
>>
>> +static void set_push_cert_flags_from_config(int *flags)
>> +{
>> +     const char *value;
>> +     /* Ignore config if flags were set from command line. */
>> +     if (*flags & (TRANSPORT_PUSH_CERT_ALWAYS | TRANSPORT_PUSH_CERT_IF_POSSIBLE))
>> +             return;
>
> This looks somewhat strange.  Usually we read from config first and
> then from options, so a git_config() callback shouldn't have to
> worry about what command line option parser did (because it hasn't
> happened yet).  Why isn't the addition to support this new variable
> done inside existing git_push_config() callback function?

The issue is that if both _ALWAYS and _IF_POSSIBLE are set,
git_transport_push interprets it as _ALWAYS. But, we are also supposed
to prefer explicit command-line options to config values.

Suppose we parsed config first, then options. If the user has
push.signed = always and and passes --signed-if-possible, then the end
result is (_ALWAYS | _IF_POSSIBLE), aka always, and we've violated
"prefer command line options to config values".

I guess the alternative is to have --signed just clear the
_IF_POSSIBLE bit in addition to setting the _ALWAYS bit, and vice
versa for --signed-if-possible. I am not sure what the end result
would be if the user passed a combination of various --signed and
--signed-if-possible flags on the command line; maybe that's not worth
worrying about.

>> +     if (!git_config_get_value("push.gpgsign", &value)) {
>> +             switch (git_config_maybe_bool("push.gpgsign", value)) {
>> +             case 1:
>> +                     *flags |= TRANSPORT_PUSH_CERT_ALWAYS;
>> +                     break;
>> +             default:
>> +                     if (value && !strcmp(value, "if-possible"))
>> +                             *flags |= TRANSPORT_PUSH_CERT_IF_POSSIBLE;
>> +                     else
>> +                             die(_("Invalid value for 'push.gpgsign'"));
>> +             }
>> +     }
>> +}
>> +
>
> maybe_bool() returns 0 for "false" (and its various spellings), 1
> for "true" (and its various spellings) and -1 for "that's not a
> bool".
>
> For "A false value may override a value" to be true, we'd need
>
>                 case 0:
>                         *flags &= ~TRANSPORT_PUSH_CERT_ALWAYS;
>                         break;
>
> or something?

Yes, except unsetting both flags? ~(TRANSPORT_PUSH_CERT_ALWAYS |
TRANSPORT_CERT_IF_POSSIBLE)
