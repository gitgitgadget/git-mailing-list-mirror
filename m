From: Keith McGuigan <kmcguigan@twopensource.com>
Subject: Re: [PATCH v2 1/1] Don't free remote->name after fetch
Date: Tue, 14 Jun 2016 14:54:38 -0400
Message-ID: <CALnYDJObFtrKFBRbbaA2KV257j8L8gcKcGk-Pkhsyvbk7+oTjQ@mail.gmail.com>
References: <1465928936-68866-1-git-send-email-kmcguigan@twopensource.com>
	<xmqqvb1b8v2w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 20:54:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCtUC-0000sa-KK
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 20:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbcFNSym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 14:54:42 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35660 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250AbcFNSyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 14:54:39 -0400
Received: by mail-io0-f174.google.com with SMTP id o127so2846964iod.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 11:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=T/oDt4Y/cO+Ez2lIKzQThG/U5kpuIeGbjChZO8EvXb8=;
        b=cIT0fbDW81SuBBy6ELBcf5B73pCTaoqoV1EF9UFbfk8aLdDfJ8Z7RYRK2FEvHib/bP
         zp+sDYaDsgVcAR3+a244NJdubnfR6Nw7FeuURu5RafOD1XbuJiBxliU7XBFES2nOH8kO
         bE4X9dv2THe7z36xvGQjVRk8jKk9L4Mxfyn47Cok/Qe8ts3L9Zl8r7VkMw04lhh8WtPi
         OCbxnqaw8kLRjBMH/0JxSgl5wtaqdndezTe7OBG14XUtvLzWt6p066YtVPNvsKvuOocB
         vJwO+T93c2ul5UfY3DTei8WiosXumGRsharjZWuIaWNUgpX8KDEE7mdgm+fnu526gplv
         HCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=T/oDt4Y/cO+Ez2lIKzQThG/U5kpuIeGbjChZO8EvXb8=;
        b=CZ2UHecyler/8ZBExPPaOZtAfgSu5t706ZmhFRqDZHAasrStmZv2SixyQ1pJ2M2cgg
         hXWb9qDjz0DWZ8AMAwoW0YkMcMmTSQJSe7FZhQv9ahX3vzfHNWBOP8Xmo8TrsFo3IxJT
         6TXDUJuPCVmMMFG4rFKYO7IYyHmajqIbWEuPEo3+1RIZzEDNPdkt227ju5queWe4zy45
         Pk+lIrkWjv1sCkRzINL/KBM2tfv/s3tZ5/8yuuB1U+P0XyBtwZSMyGELf42CE0yebUQN
         aWUQWXWTryzWANMz7ujmrGBkFO73Dna4nozntfBBv9fecm/8aagkwP40N1SiW+kr2mNu
         MtTA==
X-Gm-Message-State: ALyK8tJZ3bqjTSI+7Lu6UH+SabIiwQlXeHbHS9+wADKPqITi6vX7Fsd9X/P8sts4rAcf8tgc1L9D/gDl9NKn1A==
X-Received: by 10.107.3.84 with SMTP id 81mr28537526iod.156.1465930479005;
 Tue, 14 Jun 2016 11:54:39 -0700 (PDT)
Received: by 10.50.152.67 with HTTP; Tue, 14 Jun 2016 11:54:38 -0700 (PDT)
In-Reply-To: <xmqqvb1b8v2w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297320>

Yeah that was the only place I found where it was doing the strdup
already (and in that situation, it has to).  All the other places just
grabbed remote->name.

Yes, sorry, I can sign off on this.  Do you want me to resend with the
header in place, or is this confirmation good enough?

--
- Keith

On Tue, Jun 14, 2016 at 2:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> kmcguigan@twopensource.com writes:
>
>> From: Keith McGuigan <kmcguigan@twopensource.com>
>>
>> Make fetch's string_list of remote names owns all of its string items
>> (strdup'ing when necessary) so that it can deallocate them safely when
>> clearing.
>>
>> ---
>
> OK.
>
> When I pointed out the call to string_list_append() in
> get_remote_group() as one example, I did not check if there are
> others that need similar adjustment.  I just skimmed through the
> file again and it seems there is none, so this change looks good.
>
> I assume you meant to sign this off, too?
>
>>  builtin/fetch.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 630ae6a1bb78..1b4e924bd222 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1071,7 +1071,7 @@ static int get_remote_group(const char *key, const char *value, void *priv)
>>                       size_t wordlen = strcspn(value, " \t\n");
>>
>>                       if (wordlen >= 1)
>> -                             string_list_append(g->list,
>> +                             string_list_append_nodup(g->list,
>>                                                  xstrndup(value, wordlen));
>>                       value += wordlen + (value[wordlen] != '\0');
>>               }
>> @@ -1261,7 +1261,7 @@ done:
>>  int cmd_fetch(int argc, const char **argv, const char *prefix)
>>  {
>>       int i;
>> -     struct string_list list = STRING_LIST_INIT_NODUP;
>> +     struct string_list list = STRING_LIST_INIT_DUP;
>>       struct remote *remote;
>>       int result = 0;
>>       struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
>> @@ -1347,8 +1347,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>               argv_array_clear(&options);
>>       }
>>
>> -     /* All names were strdup()ed or strndup()ed */
>> -     list.strdup_strings = 1;
>>       string_list_clear(&list, 0);
>>
>>       close_all_packs();
