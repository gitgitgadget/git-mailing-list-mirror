From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 06/11] ref-filter: implement '--merged' and
 '--no-merged' options
Date: Thu, 18 Jun 2015 01:19:22 +0530
Message-ID: <CAOLa=ZR1GgWDK71bjmNmgQwEr-nMCFpRmD6yXSijq6z=VXxwow@mail.gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com> <1434464457-10749-6-git-send-email-karthik.188@gmail.com>
 <vpqoakezq51.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:50:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JLU-0001pH-4T
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbbFQTty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:49:54 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33093 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbbFQTtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:49:53 -0400
Received: by oiyy130 with SMTP id y130so25161952oiy.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2iiTBf48Qw0S6kXAkIVtisvxxNsSXGWK3kCoRY/JM1Y=;
        b=ONOXWzl+osLJyQx+PZFH5udQTxu2eCPh+o9JSvvTpZEuHn2ZXoy+Ozr3AtEvidcIpr
         V5FOhptb1zyHswTL0DnJipIeSyPLUNl4tBmOOk2zcDbM1l+emKt5xuCn1k+bNZ0ONrkL
         0gMOz9FDE7zHSK/ooc5b7HRkRBp973vkdqlj4QJEdJgDjpg8nU3B6pWQBOA3CCD+iZ0U
         PvVZR4HnYHRryHi55UzpQccNfZLhkv2JMjdCJ9cNuZ8XfxYpYh/U9aabksv1uLPVSOh/
         qA6H4F93ZoJ3yutxwBopd4pjOoyHd4jJiyNt8DwvX7J0CZznFYouaJHZTEo9ZrUQnCJm
         Qqdw==
X-Received: by 10.60.62.105 with SMTP id x9mr5982773oer.1.1434570592890; Wed,
 17 Jun 2015 12:49:52 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Wed, 17 Jun 2015 12:49:22 -0700 (PDT)
In-Reply-To: <vpqoakezq51.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271897>

On Wed, Jun 17, 2015 at 2:08 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -901,12 +903,19 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>>       if (!match_points_at(&filter->points_at, oid->hash, refname))
>>               return 0;
>>
>> +     if (filter->merge_commit) {
>> +             commit = lookup_commit_reference_gently(oid->hash, 1);
>> +             if (!commit)
>> +                     return 0;
>> +     }
>
> I'd appreciate a comment here. If I understand correctly, the comment
> could be along the lines of
>
> /*
>  * A merge filter implies that we're looking at refs pointing to
>  * commits => discard non-commits early. The actual filtering is done
>  * later.
>  */
>
> (perhaps something more concise)
>

Will do add a comment, Thanks!

-- 
Regards,
Karthik Nayak
