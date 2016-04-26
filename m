From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 18/83] builtin/apply: move 'numstat' global into 'struct apply_state'
Date: Tue, 26 Apr 2016 18:35:52 +0200
Message-ID: <CAP8UFD09oT=FtP2sig9htR=C_36jWiH=t4nSD7VrWh_gkKbkDg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-19-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kaCqfwgwngcqG5W0fe=SNOsp7nqtvWw=-xhZ60FBPpg+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:36:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av5y0-0008B1-B5
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbcDZQfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 12:35:54 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37436 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbcDZQfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 12:35:53 -0400
Received: by mail-wm0-f41.google.com with SMTP id n3so13846023wmn.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Q06WBgKuV7N+JKYzepEHJaNeGft6KCxob/REjENo/Zo=;
        b=IZNG2XD/ZqJRm8fY4EuzaEzaKF6oppHecF/sxjqLmQsmpUP+DQoRvOc0fX15CmKZ09
         j29LOl/rWBRIAawgkc9furXeGfVCPvVnSr4s656FhJmhTGK46wpauMtKmXTSm8V6YFMB
         Uhj2rHsMdeHRjgn/tDnoGUBpbR9TBlwQEXRFT3v0xUngy9yIEp6EHpYTdbc+MhKWx/GB
         WqShxx15OTsDwixcqjeJM5F0X6GEtTIOnRHWDts7dDx646VwQb0V8tzYwzvbC98itFQu
         MmADTUT9Tc9mZgi+rt6u9/wk/Sszpw7NJVPkXqGM/nNRaMAyCcCV6p4YiWv2ir3G07/a
         ouQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Q06WBgKuV7N+JKYzepEHJaNeGft6KCxob/REjENo/Zo=;
        b=m/Vu+cA9e/Y5zkxvnXauZ4l6iN5LKXN/daYBhC7jQFJvaf7vyt9l+9KLvjHEuK16kd
         7dA1a/myo0rdzJawvSA3l2aDDNeWCMAtFheUvwEHOmIfEpYUGZfaDY3JAXgZ7Tpp0AbW
         /As6He/ZxJdUjSBWEwnfo6G8jDHPzNoTRk6F1wShpgPIpazP9NDoXBqfCBk+bicAl0RV
         2KqTJjyROOq+mb5AardBNqvxYPT+9HbE1U0jA+KU4KH6/jTLNuIGA2VV7Hgyeyi71rMX
         R+KxkYhq4XKmbfGR/488Er/3QHewJuQ0PXmcDzYqJAwu0MrG4izaPn/AHYinobxmL1Vu
         XZ+g==
X-Gm-Message-State: AOPr4FXEj4RVt7gdS1Tud3yB/MRQC4UfRJR7K4MNOs4/RQVcHTt4AP3SuHuyG9WEp6rrMm2M86hARyJ1k16dzA==
X-Received: by 10.194.117.70 with SMTP id kc6mr4626294wjb.94.1461688552461;
 Tue, 26 Apr 2016 09:35:52 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Tue, 26 Apr 2016 09:35:52 -0700 (PDT)
In-Reply-To: <CAGZ79kaCqfwgwngcqG5W0fe=SNOsp7nqtvWw=-xhZ60FBPpg+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292615>

On Mon, Apr 25, 2016 at 11:40 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Apr 24, 2016 at 6:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/apply.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index d90948a..16d78f9 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -36,6 +36,9 @@ struct apply_state {
>>         /* --stat does just a diffstat, and doesn't actually apply */
>>         int diffstat;
>>
>> +       /* --numstat does numeric diffstat, and doesn't actually apply */
>> +       int numstat;
>> +
>>         /*
>>          *  --check turns on checking that the working tree matches the
>>          *    files that are being modified, but doesn't apply the patch
>> @@ -51,14 +54,12 @@ struct apply_state {
>>  };
>>
>>  /*
>> - *  --numstat does numeric diffstat, and doesn't actually apply
>>   *  --index-info shows the old and new index info for paths if available.
>>   */
>>  static int newfd = -1;
>>
>>  static int state_p_value = 1;
>>  static int p_value_known;
>> -static int numstat;
>>  static int summary;
>>  static int apply = 1;
>>  static int no_add;
>> @@ -4500,7 +4501,7 @@ static int apply_patch(struct apply_state *state,
>>         if (state->diffstat)
>>                 stat_patch_list(list);
>>
>> -       if (numstat)
>> +       if (state->numstat)
>>                 numstat_patch_list(list);
>>
>>         if (summary)
>> @@ -4598,7 +4599,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>>                         N_("instead of applying the patch, output diffstat for the input")),
>>                 OPT_NOOP_NOARG(0, "allow-binary-replacement"),
>>                 OPT_NOOP_NOARG(0, "binary"),
>> -               OPT_BOOL(0, "numstat", &numstat,
>> +               OPT_BOOL(0, "numstat", &state.numstat,
>>                         N_("show number of added and deleted lines in decimal notation")),
>>                 OPT_BOOL(0, "summary", &summary,
>>                         N_("instead of applying the patch, output a summary for the input")),
>> @@ -4675,7 +4676,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>>         }
>>         if (state.apply_with_reject)
>>                 apply = state.apply_verbosely = 1;
>> -       if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
>> +       if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))
>
> Mental note: This patch is just doing a mechanical conversion, so it
> is fine to check for many "state.FOOs" here.
>
> However later we may want to move this out to a static oneliner like:
>
>     static int really_apply(state *s) {
>       return s->diffstat || s->numstat || ...;
>     }
>
> (with a better name obviously)

Yeah, this is another cleanup that could be done.
I added it to a list and will try to take care of it later.
