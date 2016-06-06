From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 1/2] builtin/apply: add 'lock_file' pointer into
 'struct apply_state'
Date: Mon, 6 Jun 2016 12:03:56 +0200
Message-ID: <CAP8UFD3DAg02u95+227ZbsF=nQn+1jC_P7DAQUY9jaOwBoCk1w@mail.gmail.com>
References: <20160603165852.12399-1-chriscool@tuxfamily.org> <xmqq4m9ap2ub.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 12:04:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9rOC-0002L7-Al
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 12:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbcFFKD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 06:03:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36399 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbcFFKD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 06:03:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id m124so14035087wme.3
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 03:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qRnCjFshCLZuS0hZ/APi/LiRaSFqaPrx/rNwdinzCVo=;
        b=jv1y5SvT2QidgwOuJueTTuN5PaXmemdfK4oVY97cyN/lf26Po+NIyrikiWrZwL/r02
         HtT0oY6lJf4n8sI/gXgJQkvedAroyo8otMVPWYBuKdlsD61M6H7BVHS6BM6WVHGI4u3H
         07KOHqRQ/3/t17G6NQ0Ulql46CI9nNqI8ofCliMcnNSb7DBnZ7zQAFshe4oHfQI+2xOx
         rJNAo3IUqkzytjspuohWSiysRliH20yxAmDsg1q63VSNBTiY15TlVpqJrpB9sHuS1KJe
         D6mXRHsxCzRSKSpBYwUmezY7ok1k5PyAoHSG2QWklQwaUMTGV4COsBTY0XGoyfVgdA9S
         uHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qRnCjFshCLZuS0hZ/APi/LiRaSFqaPrx/rNwdinzCVo=;
        b=fANkpvSK4O28O4ScltzSuI1b6ZD5DfnkQd/PW8AyqksBxdiDjS47rd4CyhmvFHin15
         2IQNs56fBjDkUSpQ18h+3A9/VepBitXY97X8J/+Vs4EMFtgNiEE8kggZBzNHZJ8yiqP5
         UvdgHJvqyJEHOrRxPiDCxqCngoH7M3Xq467m7FaaFRzNJUiG7fCvH/UtGHdQwGPg5/D5
         ezv6iYQtNKG5tq+WSUvCvisj77kYlSfaPcaEJ/zymMM0BZmQH8CyIFtmJiEBOT8VhC+Q
         6Wqs8cDBxc0yd1pwwoT0m9otdq6hhJqfTrSp9P0AEAN91HtTYw6JgFsVzb1fIdYv+0y9
         twMQ==
X-Gm-Message-State: ALyK8tLUoSBZME34puniuDxtwnQ3cZx/N4ieHomk8ypE7Ebs8+B8/uoq4FLv0+SwO8D9h6vpL+X9ury0l3CFew==
X-Received: by 10.28.94.194 with SMTP id s185mr11786119wmb.62.1465207437414;
 Mon, 06 Jun 2016 03:03:57 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Mon, 6 Jun 2016 03:03:56 -0700 (PDT)
In-Reply-To: <xmqq4m9ap2ub.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296492>

On Fri, Jun 3, 2016 at 8:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> This is to replace:
>>
>> "[PATCH v3 48/49] builtin/apply: move 'lock_file' global into 'struct apply_state'"
>>
>> from the "libify apply and use lib in am, part 1" patch series.
>
> Thanks; will replace the tip 2 patches and requeue.
>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index 5027f1b..cc635eb 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -52,6 +52,12 @@ struct apply_state {
>>       const char *prefix;
>>       int prefix_length;
>>
>> +     /*
>> +      * Since lockfile.c keeps a linked list of all created
>> +      * lock_file structures, it isn't safe to free(lock_file).
>> +      */
>> +     struct lock_file *lock_file;
>
> Is this even an issue for this thing anymore?  It is the
> responsibilty of the API user to manage the lifetime of what
> lock_file points at.  The caller may have it on heap and let it
> leak, or it may have in BSS in which case it won't even dream about
> freeing it.
>
> If a comment were needed for this field, it should say "when
> discarding/freeing apply_state, just discard this pointer without
> touching what the pointer points at; the storage the pointer points
> at does not belong to the API implementation but belongs to the API
> user".
>
> But I do not think such a comment is needed, because the situation
> is the same as other fields like *prefix, and for the same reason we
> do not do anything to these fields in clear_apply_state().

Ok, I just resent without this comment.

I still don't understand why there is an added:

From: Christian Couder <christian.couder@gmail.com>

at the beginning of the emails.

> Other than that this looks great.

Thanks,
Christian.
