From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 05/19] ref-filter: add parse_opt_merge_filter()
Date: Tue, 23 Jun 2015 00:30:30 +0530
Message-ID: <CAOLa=ZR9=2RUhtN=mC2u78vin0hGcmD8fL450ygAX6N9A4Yq8A@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-5-git-send-email-karthik.188@gmail.com>
 <CAPc5daUkHb5sQ_d-g0EeFwXTkFUf4=PVV=QcV-nekObKSJL27g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 21:01:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z76xv-00052z-02
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 21:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbbFVTBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 15:01:02 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33553 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbFVTBA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 15:01:00 -0400
Received: by oiyy130 with SMTP id y130so111546132oiy.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tOmalOINVK2tz+wuB9eCpvjd/baKCzjW8W0EUKZwMEw=;
        b=ZkYDbwPH+6V7Iz+TzCf2l/EKQjp8ZHF0nATDdZeESKUEPK3YEBlyNkSyQtNtxmYPD6
         Yi6a86S5HAc/hZLdgoVbvqyP7uiGUEPnuV0IimHK0VdVf2+RdJUvrnjeKl4fI6uH6JgB
         fEya6q60kVVyzgEDjzT3YOMmog7J2JC27lm5scQaQ7GeumfuUDmJsxQipWo2CsRvUZiE
         GE9/PsWDJdzkNRHW2uPXiH0D/pIZS2J0aJkRFcJz4CUAJPkY8JrWhEpDYlmbQ/TmBDwT
         r2sWMfeF8+lMEl8DSWuK8hXgz1PrFThzY0BioL35IWBg31VNPRLS7vjItTOjkI1rH58p
         nVTw==
X-Received: by 10.202.180.133 with SMTP id d127mr24789976oif.104.1434999659977;
 Mon, 22 Jun 2015 12:00:59 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 22 Jun 2015 12:00:30 -0700 (PDT)
In-Reply-To: <CAPc5daUkHb5sQ_d-g0EeFwXTkFUf4=PVV=QcV-nekObKSJL27g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272402>

On Mon, Jun 22, 2015 at 6:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Why SHOUT here?
>

Just used to typing "macros" in caps. Will change!

>> This is copied from 'builtin/branch.c' which will eventually be removed
>> when we port 'branch.c' to use ref-filter APIs.
>
> Hmph. I somehow thought Matthieu's instruction was to finish tag.c
> side first and then
> do branch (i.e. with 3 and 4 you brought things from tag to
> for-each-ref, now it is a time
> to rewrite tag by using what you wrote for for-each-ref with 3 and 4,
> before moving to
> this patch)? Was that plan scrapped or found inappropriate or something?
>

> I would call in "advice" rather than "instruction". I still think we
> should prioritize the tag.c side, but if this patch is ready, it makes
> sense to keep it in the series.

Yes, Matthieu did advice that.
But I had already started working on this. But if you guys think thats
a better option
I can do that also, as I already have tag.c ported over to use
ref-filter on my local branch.
But that'll include a lot of changes.

Also I found this more systematic as we will have a complete
ref-filter library ready and
only porting of tag.c and branch.c would be left.

>
> When does this trigger? You have lastarg-default with "HEAD", and I am
> having trouble guessing when "arg" upon entry to this function can ever
> be NULL.
>

This is redundant. will remove.

>
> Can --merged (or --no-merged) be given more than once? Is the rule
> "the last one wins"?
> Does the old value of rf->merge_commit leak (no, it does not, but I am
> just asking for
> completeness)?

Yes! currently for e.g. `git for-each-ref --merged master --merged ref_filter`
would mean that ref_filter would be considered for the --merge option.

"Does the old value of rf->merge_commit leak" From my understanding of
object.c/commit.c, It just points to an object in the obj_hash array, so when
multiple options are given the pointer just points to another part of obj_hash,
I'm sure there's more to it. This is what I gathered from an over the top view.

-- 
Regards,
Karthik Nayak
