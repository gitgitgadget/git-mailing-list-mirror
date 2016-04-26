From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5b 00/17] port branch.c to use ref-filter's printing options
Date: Tue, 26 Apr 2016 23:51:03 +0530
Message-ID: <CAOLa=ZRUBi3Vo0Qqx8rY53rJD599XpWJjz2YpUE3Xkn1wH=Jqg@mail.gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com> <xmqq4mapjr7y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:22:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7cT-0002O9-Sq
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbcDZSVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:21:36 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35750 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbcDZSVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:21:33 -0400
Received: by mail-qk0-f181.google.com with SMTP id q76so8093782qke.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w5kNeVe4tvpzFvaLitVoYZqLC9uSxOFAD8j8gCVHCN4=;
        b=GZurwH+QsRXXDC1zuZer7/8s9ABbqmIeBstYTl4yJJMUbwNuGK7B2e/hHAihGvGmun
         QcMN3Ea3+zw5y8XmAdBT+2xYyCjlBNiNezoosEJUWO59yk6e9Xq7hXthqfyHBV2gqDvy
         5DJ3xm9g8rJW6Ya3fGTA+rHwO6mDLidFHB9/7kXf4JHDRJQDMECoT+Pa3x321Yuv6Z+8
         FdpitJEIPDhKZtm0iESFdP6EN1J1hk94bTd43nHcTIt65en969dMmAR51RaVl+AMc4MU
         AuAT1NsEtLFiV9DZVI8smNoR6TgcMa9lrHDboSpvKQaeHHEVJABpfRBp4RQCadK92nrI
         A+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w5kNeVe4tvpzFvaLitVoYZqLC9uSxOFAD8j8gCVHCN4=;
        b=ZsOKTS+BMJ0B8FwakNqwXhCSqjVS+6ca68bBbP0sN1L5FDwe8Xe6t4EXrm1lBOhx2k
         WBSBu6c+NFuXCmIp8udcQptjsq59eNONnAvlNJKZrcLzM6wHAFrTX+Zly6uBSut/gUBy
         j/QkBpxVUDO2FXZKgK07KWDtwqvC+vkUJl8wDD3rQlG9IKTb92OSXwnEEknr5yprV4U5
         s3ZZ/r2EPQHGW4ZZCq0yF+i6ZqSSL3u68UWaPGoGkqASFdiU2HT7wTsuwFlpGLU63Ue7
         7mSbfqsd6Vu2yzc1TGpzwlikwxF4LrqdR1nw1zkI8leSISVYpZtGCt6bByd1WfudWrDL
         MnPQ==
X-Gm-Message-State: AOPr4FWzcO0bTKqvWwv0ooFFU0w4xFQi7PaSMO8x0/LVDWZw8mwP84jqbfQpzm1OUeNw/Bid8T5fVYs8Z3LeTA==
X-Received: by 10.55.79.207 with SMTP id d198mr3975665qkb.49.1461694892951;
 Tue, 26 Apr 2016 11:21:32 -0700 (PDT)
Received: by 10.140.92.178 with HTTP; Tue, 26 Apr 2016 11:21:03 -0700 (PDT)
In-Reply-To: <xmqq4mapjr7y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292641>

On Tue, Apr 26, 2016 at 3:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This is part of unification of the commands 'git tag -l, git branch -l
>> and git for-each-ref'. This ports over branch.c to use ref-filter's
>> printing options.
>>
>> Initially posted here: $(gmane/279226). It was decided that this series
>> would follow up after refactoring ref-filter parsing mechanism, which
>> is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).
>>
>> v1 can be found here: $(gmane/288342)
>> v2 can be found here: $(gmane/288863)
>> v3 can be found here: $(gmane/290299)
>> v4 can be found here: $(gmane/291106)
>>
>> Changes in this version (v5b):
>> 1. Added the first patch of the series which was missing in v5.
>
> 2. Rebased on top of 'master', which includes
>    jk/branch-shortening-funny-symrefs.
>
>> Interdiff:
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index c9a2e5b..6847ac3 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -288,9 +288,11 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
>>
>>                 skip_prefix(it->refname, "refs/heads/", &desc);
>>                 skip_prefix(it->refname, "refs/remotes/", &desc);
>> -               if (it->kind == FILTER_REFS_DETACHED_HEAD)
>> -                       w = strlen(get_head_description());
>> -               else
>> +               if (it->kind == FILTER_REFS_DETACHED_HEAD) {
>> +                       char *head_desc = get_head_description();
>> +                       w = strlen(head_desc);
>> +                       free(head_desc);
>> +               } else
>>                         w = utf8_strwidth(desc);
>
> Presumably w is computed here to be used later for some kind of
> alignment?  It is curious why we can assume that head_desc does not
> need utf8_strwidth() here.

Seems to be a bug, `get_head_description()`  is susceptible to be changed
due to translation and hence `utf8_strwidth()` would be a better candidate here
rather than `strlen()`.

Thanks.

-- 
Regards,
Karthik Nayak
