From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Thu, 16 Oct 2008 07:54:40 +0200
Message-ID: <4ac8254d0810152254i615bca9dye0aedd8689c946e7@mail.gmail.com>
References: <1223934148-13942-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7vzll887ps.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0810131529l37d67b61q3589f15700d38261@mail.gmail.com>
	 <4ac8254d0810151047p7e12e8efk6fea666d2ac85f0f@mail.gmail.com>
	 <7vy70p3cga.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0810151220l48b81325yf3aca48cda49ef3a@mail.gmail.com>
	 <7vprm1pfmd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 07:55:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqLpy-0001ao-T1
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 07:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbYJPFym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 01:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbYJPFym
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 01:54:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:57401 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYJPFyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 01:54:41 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3274434rvb.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 22:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=L384fXX8lORjJ8KY9X0Y0QsndALULz8ttIei2/z5Aoc=;
        b=pd07GBrElP9Ax7zmBtTZpbM/YJudXObMIi462um3C+Bz/GVX4nCcw/cSRUmR1RPc+T
         ITJnwUJG8qpGlmnKlRXPx7t865V/ZnhQHS9NRO9q3JvMJnq0poSiXO4tycLDfFTDBD9d
         6gVuR9kgP6LuJdQ3KjO3N4josrQ4kzLTLBphc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vsJTPUIruBTEG1yWSvqrbCKLhulE7jWJB0FB8KqNDi3iOptUCvOmADpHl2b/bYFZRT
         nV15wRTD/Zzv+AgXT7n8MNx7DL8MwmU4A3I8L3AJVNomiIFCfb8REM0ZnHzvahMG6iQh
         ttjEgZTN5mjXzzYMID4EQorhn+Cz1vsk602H4=
Received: by 10.140.201.4 with SMTP id y4mr1291122rvf.86.1224136480905;
        Wed, 15 Oct 2008 22:54:40 -0700 (PDT)
Received: by 10.140.134.3 with HTTP; Wed, 15 Oct 2008 22:54:40 -0700 (PDT)
In-Reply-To: <7vprm1pfmd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98345>

On Thu, Oct 16, 2008 at 2:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>
>> On Wed, Oct 15, 2008 at 9:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>>>
>>>> Junio, what's the status here? Do you want me to rework it
>>>> all with a new verbose/quiet log infrastructure or
>>>
>>> Not really.
>>
>> OK, when do you expect to cut 1.6.0.3? It's so simple
>> that I'd like to have it included in that revision.
>
> Hmm, I did not think this was a breakage that needs to be fixed on the
> maintenance track.  git-pull does not know -q nor -v and teaching these
> new options to the command would be a feature enhancement, which by
> definition won't be in 1.6.0.3.

It's no breakage as the options did not exist before :-), yes.

>>> Using two variables to keep track of what is conceptually a tristate
>>> (quiet, normal and verbose) is insane, and I'd like to see that insanity
>>> fixed first in the patch, regardless of an elaborate "log infrastructure"
>>> you mentioned.
>>
>> I see what you mean. What about all other modules
>> with quiet/verbose doing it with two variables?
>
> Are they broken?  If not, let's not touch them.  On the other hand, let's
> avoid adding more.

Not really. After I fixed -q in clone/fetch Miklos Vajna came up
with --verbose for clone. I just thought if we come up with a
new way to handle this we should fix it everywhere -v and
-q are available and make it consistent.

>> I guess doing it with a single variable in pull first
>> as an example is what you're after, right?
>
> I did not actually mind the ones in 'git-pull' that much, as eventually
> the script will be rewritten in C by somebody anyway.  The patch to
> builtin-fetch.c/builtin-merge.c is different, as the repetition of
> (verbose || !quiet) was quite noticeable.

I've added -v as it was added to clone in "[PATCH] Implement
git clone -v" and I wanted to be fair to the IDE developers.

Would you prefer to leave -v out?

> Why have we gone off-list, by the way?

I was not sure this is of interest to everybody.
We are now on-list again :-).
