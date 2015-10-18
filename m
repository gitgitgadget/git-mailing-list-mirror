From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: git tag --contains now takes a long time
Date: Sun, 18 Oct 2015 15:34:42 +0530
Message-ID: <CAOLa=ZQNL1YUFzWYCiYhRf4ESmeCTtZEXzbbf39d7DqSkbj66g@mail.gmail.com>
References: <20151016220739.GF17700@cantor.redhat.com> <CAOLa=ZTDd3MSmqXArtNz8i5n=uj2NEB6UPk2jSnEhUsAqbr7nQ@mail.gmail.com>
 <xmqq1tctchgz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 12:05:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znkq8-0005Yx-R3
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 12:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbbJRKFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 06:05:15 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34847 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbJRKFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 06:05:13 -0400
Received: by vkfw189 with SMTP id w189so6056247vkf.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dmRNMcWxMshetla5SAcFP1JtMDwr0FrNYTHUKCknQhY=;
        b=IO5X4CLg1iaJ3HjtY12lEQrzOR6mWoGvLQfTUaagDApi8wgDfdzWTVkeZosE+dRs/x
         a1x4CnnQBktMVhYEg7H7KGdqnP87z+iknlZJ7/L4dlxrPe6LrlutjmTVFP+CnPB+CwGQ
         3oMJd9LcVFOq6VIlpUhojE2rVxuX+4q0ABdmW8HTCkiJ30hzclJuVfmgHOozPgjp92Pd
         8sDpLALV6nEzCHtpMba1ySNhXeJUwFGwfhhM3yhqPzxKa4pBVGHfeQT9COr8dFgiCL4k
         SkbmwjzLmjKHtYD+h2MdCAneBL/UfJ+ov0HBOn3Nl5rUWH5fGhT6TIJ9W2/Edkby0bDQ
         N2vg==
X-Received: by 10.31.47.5 with SMTP id v5mr14525497vkv.146.1445162711888; Sun,
 18 Oct 2015 03:05:11 -0700 (PDT)
Received: by 10.103.0.7 with HTTP; Sun, 18 Oct 2015 03:04:42 -0700 (PDT)
In-Reply-To: <xmqq1tctchgz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279803>

On Sun, Oct 18, 2015 at 2:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> So I did poke around a little. I think I missed this out on the
>> original commit (b7cc53e92c806b73e14b03f60c17b7c29e52b4a4).
>>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index 977a18c..2c5a9f1 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -49,6 +49,7 @@ static int list_tags(struct ref_filter *filter,
>> struct ref_sorting *sorting)
>>                 format = "%(refname:short)";
>>
>>         verify_ref_format(format);
>> +       filter->with_commit_tag_algo = 1;
>>         filter_refs(&array, filter, FILTER_REFS_TAGS);
>>         ref_array_sort(sorting, &array);
>> ...
>>
>> Could you Squash that in, Junio?
>
> Do we have two implementations that are supposed to compute the same
> thing, and with the bit set to 1, the faster of these two is used?
> Is there a reason somebody may want to use the slower one?  What
> difference other than performance does the choice of this bit makes,
> and why?
>
> I think the answers to the above questions deserve to be in the log
> message (no, I do not think I can "squash it in", rewriting the
> commit that has already been merged to 'next' and 'master').
>
> Thanks.

I'll resend the patch then with the changed commit message.

Thanks.

-- 
Regards,
Karthik Nayak
