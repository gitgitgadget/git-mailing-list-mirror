From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: Re* [PATCH v3 04/14] refs.c: add a new update_type field to ref_update
Date: Wed, 2 Jul 2014 11:27:25 -0700
Message-ID: <CAL=YDWngL7mhWs601zEfiCFbZrHffW7sN7pB_dUaoE8DaPedUA@mail.gmail.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
	<1403111346-18466-5-git-send-email-sahlberg@google.com>
	<xmqqfvj2hs5g.fsf@gitster.dls.corp.google.com>
	<xmqqbntpj54t.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 20:27:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2PFi-0004YW-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 20:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113AbaGBS11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 14:27:27 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:44190 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659AbaGBS10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 14:27:26 -0400
Received: by mail-ve0-f177.google.com with SMTP id i13so11509030veh.8
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6qDHzLcj/RkEkRQALxcyDCTCoPo0BMXXGTvVCjuxGBY=;
        b=C95UukObWDRiZTvWpLT5NqTIAwYAohoNeXk1YfMvLunFAOrPHxLRjNbCnNadXQeZCN
         mjjYydxu9SMnz47JFeAeU2xQr4z8xDGSRwh2niFeH5loWz1Mbb7xPhmU7rDzdKx72Nme
         T+Na/LNAO6jw7awwg2LQdF0oI0VIjYPIMChSfTtlQHThr36AMFclTt8YJv97yeHRyrX/
         ZtiI1ueecpNC9eLtL4xxWnz2HWAwT1Y7DDG0U8VQf6GG72sONH/pyvTuTijgKAKfSMSg
         2dGKas/j/2ESPjPRgdHwk/MOXAPulAIgf+doBT0JWMaIsGS0aJ8ae8mqa8do58bEv7ZD
         iz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6qDHzLcj/RkEkRQALxcyDCTCoPo0BMXXGTvVCjuxGBY=;
        b=jli7iNpM+ugIq41N92PaEv68DxiYdzPZPwKLYcbCQ9bsLtsZeJl4M/n1Fxx8QMZcai
         HZlzhZOmP+Zu7eEo8+D/+laJ3bCkJ4UghaTXw94IzyOpJGRHNb/cjPYMhCyO7FtnYyEH
         ib6FLwA0lYSHrid9bgL/gmgyQL4N2togUyTaJKWuUQwT/aukknp4NrEp6zEveTHs+dnY
         doW4TbLFWX+msAqhWCCtkRpEmgvWmUQGnpOmnu4xE6zzTf1QAP5rbUZFKTLn7UJhCQ9J
         PH9baa1/42bIiZwyBjimyvGFee+eARTcYFldtcrm0bP9o/VazUEscaBS474MqJDirtdx
         EX1w==
X-Gm-Message-State: ALoCoQmWfImbGJV0wF+bNF2C15HthcrP40mSyrtcUYAPx+QcaxhtPXV7pYv/uL2MQ8rmllMcg4Jy
X-Received: by 10.220.103.141 with SMTP id k13mr50477829vco.25.1404325645332;
 Wed, 02 Jul 2014 11:27:25 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Wed, 2 Jul 2014 11:27:25 -0700 (PDT)
In-Reply-To: <xmqqbntpj54t.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252826>

On Wed, Jun 18, 2014 at 2:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ronnie Sahlberg <sahlberg@google.com> writes:
>>
>>> Add a field that describes what type of update this refers to. For now
>>> the only type is UPDATE_SHA1 but we will soon add more types.
>>>
>>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>>> ---
>>>  refs.c | 25 +++++++++++++++++++++----
>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/refs.c b/refs.c
>>> index 4e3d4c3..4129de6 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -3374,6 +3374,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
>>>      return retval;
>>>  }
>>>
>>> +enum transaction_update_type {
>>> +       UPDATE_SHA1 = 0,
>>
>> indent with SP?
>>
>> Unlike an array initialisation, e.g.
>>
>>       int foo[] = { 1,2,3,4,5, };
>>
>> some compilers we support complain if enum definition ends with a
>> trailing comma.
>
> I do recall we had fixes to drop the comma after the last element in
> enum definition in the past, in response real compilation breakages
> on some platforms.

You are right. I think I recall this too on old c compilers on legacy
unix boxens.

I have fixed this and will resend the series.


I have also checked additional enums in the sources and found 3 more places.
I sent this as a single patch to the list with the subject :

"Subject: [PATCH] enums: remove trailing ',' after last item in enum"



>  But there is a curious thing:
>
>     git grep -A<somenumber> 'enum ' master -- \*.c
>
> tells me that builtin/clean.c would fail to compile for those folks.

Most likely.  It might be that there are less and less people on
really old c-compilers these days.


>
> Here is an off-topic "fix" that may no longer be needed.
>
>  builtin/clean.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 9a91515..27701d2 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -48,7 +48,7 @@ enum color_clean {
>         CLEAN_COLOR_PROMPT = 2,
>         CLEAN_COLOR_HEADER = 3,
>         CLEAN_COLOR_HELP = 4,
> -       CLEAN_COLOR_ERROR = 5,
> +       CLEAN_COLOR_ERROR = 5
>  };
>
>  #define MENU_OPTS_SINGLETON            01
>

Thanks
ronnie sahlberg
