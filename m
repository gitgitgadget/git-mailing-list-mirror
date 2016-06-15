From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2 1/6] bisect--helper: `bisect_clean_state` shell
 function in C
Date: Thu, 16 Jun 2016 00:17:29 +0530
Message-ID: <CAFZEwPNtWkG54dpcLz+E=QjED8ftJqemyNKFwFKdty6HiPtNDw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-2-pranit.bauva@gmail.com>
 <CAPig+cRfYS4FX+z4Yn-He_LctWdh7Ua56JU2HJs2C2+nTi5YyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:47:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFqi-000383-35
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbcFOSrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:47:32 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34220 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570AbcFOSrb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:47:31 -0400
Received: by mail-yw0-f196.google.com with SMTP id b75so2768323ywe.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CDUEal8R19eMv/gOEjTTRYzIjZWWLzD4C5YvjXUnnW0=;
        b=yioH2XMGr36+XZ5vaAqyxmJ5wwBOzKjaV0eGFiaezRvXnhvd2nqEnDRrR/iDNjtdXy
         qziHQJI7wXPY9q6zRISV8e89v3CzmPjdrcJZvYakt3yNZPLa7ExmncIBgniw844tMjhU
         5HI1wFbKSMK60dw2CNR3TxxQHrbJny94CISKHnb8AbEdAWh381FNQS8JcrqEB7WECon3
         dUF92Me+6cLMFStl1xL8d6VP8fA6f00kMapGgIYPOtCm2o5fy6kaxXISz2OgJFjU+G4h
         s1thgmsfEaG6fpqedLSW1LqOPvARpbZq0Q8SUg4s/SSUYFgl/IqJKy1TpLPo57pza4tz
         CoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CDUEal8R19eMv/gOEjTTRYzIjZWWLzD4C5YvjXUnnW0=;
        b=nLB23yvpubrC0giysxgbAMBs9kIA43MfQAYz0t08Jtz1yfJ7/0l9vajkMoFxBuzNK4
         Hp2kiqQays0rKrK1wADBdtqM3bPZbmQGsiB15/GUjFXqjJHxEjimTC61j//O4GE1dfyg
         a9heErc/JyMW9cNmyMV364mifZKrDu/hC2o3BZ9Tshb7n/WrPm9HdxxlYgE4/hpDUImc
         gJqEmrYdQv4+hTJdzm91JbBoQE9XME1naVwu0d4FbQZtqDufMdSH/1OAH+TdGarKYb58
         H4bLVPkSLB7pfApZcpoGmY9K0w+gM0F8sCFB0E0Kdg8RBRgAnc+4Zoo+B2aqWd+KvYtc
         sDgA==
X-Gm-Message-State: ALyK8tI3qLWQLN+SPsKdD/V0fpqEM9tTdF4dqkVo1ZChI4Hcu4Vr0MiFGQvSH2beRCqsvcOReYccht0lp/SpKQ==
X-Received: by 10.37.198.133 with SMTP id k127mr114221ybf.53.1466016450384;
 Wed, 15 Jun 2016 11:47:30 -0700 (PDT)
Received: by 10.129.116.193 with HTTP; Wed, 15 Jun 2016 11:47:29 -0700 (PDT)
In-Reply-To: <CAPig+cRfYS4FX+z4Yn-He_LctWdh7Ua56JU2HJs2C2+nTi5YyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297391>

Hey Eric,

On Wed, Jun 15, 2016 at 11:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement `bisect_clean_state` shell function in C and add a
>> `bisect-clean-state` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh .
>> [...]
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> +static int mark_for_removal(const char *refname, const struct object_id *oid,
>> +                           int flag, void *cb_data)
>> +{
>> +       struct string_list *refs = cb_data;
>> +       char *ref = xstrfmt("refs/bisect/%s", refname);
>> +       string_list_append(refs, ref);
>> +       return 0;
>> +}
>> +
>> +static int bisect_clean_state(void)
>> +{
>> +       int result = 0;
>> +
>> +       /* There may be some refs packed during bisection */
>> +       struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
>> +       string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
>> +       result = delete_refs(&refs_for_removal);
>> +       string_list_clear(&refs_for_removal, 0);
>
> This is leaking all the strings added to 'refs_for_removal', isn't it?
> Either you need to loop over the items and free the strings manually,
> or (if it's not too ugly), set 'strdup_strings' before invoking
> string_list_clear().

I didn't carefully see that in the function string_list_clear() it
only free()'s the memory if strdup_strings is 1. I think changing
strdup_strings to 1 would be an easy way out but it would make the
code very ugly and non-trivial. On the other hand, I can initialize
the string as STRING_LIST_INIT_DUP which will automatically set
strdup_strings as 1 and then also free the memory of ref at that point
after the string ref was appended to the list. Personally, I will
prefer the latter one.

Regards,
Pranit Bauva
