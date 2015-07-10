From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/10] ref-filter: support printing N lines from tag annotation
Date: Fri, 10 Jul 2015 16:08:33 +0530
Message-ID: <CAOLa=ZTTLHZ_C_9m1ctHkjazhC+6r4U_u6j2xkjsCAXtBDr1RQ@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <1436437671-25600-3-git-send-email-karthik.188@gmail.com>
 <vpqpp417a4i.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 10 12:39:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDVi1-0002T5-1l
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 12:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbbGJKjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 06:39:05 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35389 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbGJKjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 06:39:03 -0400
Received: by oihr66 with SMTP id r66so152499863oih.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/pjGzmaOW37O8tEMDhz+LQA82JY20FZcx30TTRObT2E=;
        b=OyZhBPjC64fAkpawbrKgNEDPDDU58dMHEvdMgU4B0SU3EpoAIt12iNMErJGwSgw/7r
         G9EE3JDJIi7fnS0oLvGDUL4OZyIf2m0KFtBoT5PxaW3mlUrpm4j/PJSD/zYYZDCYtlou
         AsEFwpr2WMgkkdCki8Lkx1ZdzFCYszpBuE4YapnjJJlPKx8vJoI2erCBKwpfZayVCKHY
         D/YhaG6Yq3Us++Oq52vJOGJEkxLv0O+BiaP+Fnmk6VhYxqa2DoB62IlM8qxbPCkoX+3Z
         qHDVva4GFZHjw/jKa3Qup5EjI+IQ3hgKe3uHuNkEerZQAnt67IQFge2CY32ihYdYlPf/
         QDQQ==
X-Received: by 10.202.92.6 with SMTP id q6mr17755849oib.11.1436524742671; Fri,
 10 Jul 2015 03:39:02 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 10 Jul 2015 03:38:33 -0700 (PDT)
In-Reply-To: <vpqpp417a4i.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273812>

On Thu, Jul 9, 2015 at 6:37 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> In 'tag.c' we can print N lines from the annotation of the tag
>> using the '-n<num>' option.
>
> Not only annotation of the tag, but also from the commit message for
> lightweight tags.

will do.

>
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -185,6 +185,10 @@ static enum contains_result contains(struct commit *candidate,
>>       return contains_test(candidate, want);
>>  }
>>
>> +/*
>> + * Currently dupplicated in ref-filter, will eventually be removed as
>
> dupplicated -> duplicated.
>

Thanks :)

>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -55,6 +55,7 @@ struct ref_filter {
>>       struct commit *merge_commit;
>>
>>       unsigned int with_commit_tag_algo : 1;
>> +     unsigned int lines;
>>  };
>>
>>  struct ref_filter_cbdata {
>> @@ -87,7 +88,7 @@ int verify_ref_format(const char *format);
>>  /*  Sort the given ref_array as per the ref_sorting provided */
>>  void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
>>  /*  Print the ref using the given format and quote_style */
>> -void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
>> +void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style, unsigned int lines);
>
> I would add "If lines > 0, prints the first 'lines' no of lines of the
> object pointed to" or so to the docstring.
>

Will do, thanks.

-- 
Regards,
Karthik Nayak
