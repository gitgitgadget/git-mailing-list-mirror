From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC_PATCHv4 3/7] submodule-config: add method to check for being labeled
Date: Wed, 23 Mar 2016 14:05:58 -0700
Message-ID: <CAGZ79kYtS_TBMnNhK6FjkQcJt=r1hnFsx=TyatoENjEXBAmRug@mail.gmail.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-4-git-send-email-sbeller@google.com>
	<xmqqegb2f8nn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 22:06:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aipyh-0005M7-G2
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 22:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbcCWVGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 17:06:01 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34156 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcCWVGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 17:06:00 -0400
Received: by mail-io0-f170.google.com with SMTP id m184so65960470iof.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rO4BfO7hihKYwuDlELn1U2BHFMZkHEvQ+Cp4CFRduI4=;
        b=ia9qdn01kOc7iXQmYKCqxhPdnT03KcoKdfPwjvS4GeatinPyVRhTLl3HBjUPmlSVkS
         x7D2LIg5ojVs+CwoI9jc5kBDSL1YrwpXy1XlslYIFJ8ebgXBIgx0bDHrQ/ozuHbEqIVf
         YR49kNiiGq9XB/QWBZWNQ4q+Jr3H9koDWsnWFR/hb9uD04COJDwxduJ00P7lyl+CY4cv
         LBaDy7hgOaTLrFERlybukuO05d/xzaeko9oiT6lBP/XGZxE6u9m71zauoBdfMFvKbER2
         Idpvivp5y0z83TGGWUlHw16pbjvVnz334+S5Vl+kojMttBMM/Ku0a2q//16iCNk8lf6n
         YdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rO4BfO7hihKYwuDlELn1U2BHFMZkHEvQ+Cp4CFRduI4=;
        b=AHI4ei+sgKI/v2Rsc1AfMXrGPvNHl84iAQO0b2PAsJlyt9Wf2St1FVeKHKKGb2xGIS
         WutVB5IH85AkNOdTJBQPLwHNQ1eYLqtnq0kzgaWHZYWTi2veri7cGvAcaCtwSNFdKfmL
         C4ix9M9zuMon5btnDbO95B89N2VS77pZntXKHI39UY0AmsHO+unMo7T0hmiTn1LmR64v
         6UUzf7o6IfF+k3W2T4E9rfSdcn0Ij0wrjxkVZFROoRzgtNiUW8ZRWTy2e26jHzzrxSBC
         VILVuuSQNmfo6MXKlmbo7Eu5i2zzu7JGFyPZw/nKsVLZ0CTspV00w5MW07E0Vky5ent3
         q6Xg==
X-Gm-Message-State: AD7BkJIMGvS0EBi4SPlNbwo72AlHTYHF/HwpoCDo5FtwF7b00S1ShOucJe8XazCPA47QjcJ3Q4rssFN9VjVoN5Wx
X-Received: by 10.107.135.96 with SMTP id j93mr5838739iod.96.1458767158625;
 Wed, 23 Mar 2016 14:05:58 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 23 Mar 2016 14:05:58 -0700 (PDT)
In-Reply-To: <xmqqegb2f8nn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289682>

On Tue, Mar 22, 2016 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In later patches we need to tell if a submodule is labeled by
>> the given labels.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Hmph, I would have expected that something like this would touch the
> module_list() implementation.  Probably that would happen in future
> steps, I guess?

I would have guessed, too. And I was about to say Jens argued against that in
an earlier patch series [1]. However I miss remembered and Jens pointed at
"git submodule init --label/groups" being a bad idea, not in the helper.

So we could still have a "git submodule--helper labels_apply <submodule>"
query to expose this to shell parts. Most of the shell parts use module_list
so we could integrate that there too. ("git submodule_helper list
--labeled-only")

[1] $gmane/281670, specifically $gmane/281720


>
>>  submodule-config.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  submodule-config.h |  3 +++
>>  2 files changed, 51 insertions(+)
>>
>> diff --git a/submodule-config.c b/submodule-config.c
>> index 7b48e59..b10a773 100644
>> --- a/submodule-config.c
>> +++ b/submodule-config.c
>> @@ -493,3 +493,51 @@ void submodule_free(void)
>>       cache_free(&cache);
>>       is_cache_init = 0;
>>  }
>> +
>> +int submodule_applicable_by_labels(const struct string_list *list,
>> +                                const struct submodule *sub)
>> +{
>> +     int label_apply = 0;
>> +     struct strbuf sb = STRBUF_INIT;
>> +
>> +     if (!list)
>> +             return 1;
>> +
>> +     if (sub->labels) {
>> +             struct string_list_item *item;
>> +             for_each_string_list_item(item, sub->labels) {
>> +                     strbuf_reset(&sb);
>> +                     strbuf_addf(&sb, "*%s", item->string);
>> +                     if (string_list_has_string(list, sb.buf)) {
>> +                             label_apply = 1;
>> +                             break;
>> +                     }
>> +             }
>> +     }
>> +     if (sub->path) {
>> +             /*
>> +              * NEEDSWORK: This currently works only for
>> +              * exact paths, but we want to enable
>> +              * inexact matches such wildcards.
>> +              */
>> +             strbuf_reset(&sb);
>> +             strbuf_addf(&sb, "./%s", sub->path);
>> +             if (string_list_has_string(list, sb.buf)) {
>> +                     label_apply = 1;
>> +             }
>> +     }
>> +     if (sub->name) {
>> +             /*
>> +              * NEEDSWORK: Same as with path. Do we want to
>> +              * support wildcards or such?
>> +              */
>> +             strbuf_reset(&sb);
>> +             strbuf_addf(&sb, ":%s", sub->name);
>> +             if (string_list_has_string(list, sb.buf)) {
>> +                     label_apply = 1;
>> +             }
>> +     }
>> +     strbuf_release(&sb);
>> +
>> +     return label_apply;
>> +}
>> diff --git a/submodule-config.h b/submodule-config.h
>> index 8d61df3..d67f666 100644
>> --- a/submodule-config.h
>> +++ b/submodule-config.h
>> @@ -30,4 +30,7 @@ const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
>>               const char *path);
>>  void submodule_free(void);
>>
>> +int submodule_applicable_by_labels(const struct string_list *list,
>> +                                const struct submodule *sub);
>> +
>>  #endif /* SUBMODULE_CONFIG_H */
