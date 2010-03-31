From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v3 0/2] git-gui: change to display the combined diff in 
	the case of conflicts.
Date: Wed, 31 Mar 2010 23:50:02 +1200
Message-ID: <l2z2cfc40321003310450p51363facu1142c665512d6825@mail.gmail.com>
References: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>
	 <4BB2F7A0.6020702@viscovery.net>
	 <k2p2cfc40321003310412hf4c6d642n4349af3f644829ff@mail.gmail.com>
	 <4BB3346C.7070700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 31 13:50:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwwR1-0002sk-R5
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 13:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153Ab0CaLuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 07:50:05 -0400
Received: from mail-pz0-f186.google.com ([209.85.222.186]:41327 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979Ab0CaLuC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 07:50:02 -0400
Received: by pzk16 with SMTP id 16so597336pzk.22
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1BpuTpzNDV+ZwfkYK8EZDWpkQTDmybkqi1zb/5pwb0k=;
        b=UgHgkIhOi0z6ekaI/AbX/pq/c34u1MhH0qQTygP7V2TN1G2fjTBRjc3Od8b4R+CnfP
         df1x7b7Z0aTGZYcbGVwjUC6aAx/UfGVYFnwHT88AN8UUU7yI2xKHqQ3gvMTKarqFv1tQ
         tqzpazsopYhB45jE4mnTmHLRlbgfVoLceakbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DagPHg0OdwBDpeSW2TmBeCM3uPSt4MY1sdvDxiCdczXJKKOE1Ist25H8Bnh4Fu3yNL
         vR+NrL9OaVly0yu6J2hHsDntjjfTA6jDAUGFCCUhtzcK+fEHSF04tJ6d29oDtRcaLVlB
         lFl7x6vxmYveSF1WOK3hvc2FTMjEEmy9qRTvc=
Received: by 10.114.13.5 with HTTP; Wed, 31 Mar 2010 04:50:02 -0700 (PDT)
In-Reply-To: <4BB3346C.7070700@viscovery.net>
Received: by 10.115.80.1 with SMTP id h1mr3583067wal.116.1270036202283; Wed, 
	31 Mar 2010 04:50:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143664>

On Wed, Mar 31, 2010 at 11:39 PM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> Am 3/31/2010 13:12, schrieb Jon Seymour:
>>> I looked at the result, but it does not convince me. In my case, I =
have a
>>> large file that has many changes between the "maint" and "master"
>>> branches. Whenever there are conflicts after merging "maint" to "ma=
ster",
>>> I see all these changes, and really they *are* uninteresting.
>>>
>>
>> I think you may have missed the point of my patch.
>>
>> The successfully merged lines may be uninteresting from the point of
>> deciding what I should *do* but they
>> are highly relevant to the question of what I really, really should =
*not* do.
>
> How would you decide that if you cannot read the information that is
> presented to you?
>
> Can you tell without thinking for 10 seconds which of these two chang=
es is
> lost if you choose "Use local version"?
>
> @@@ ... @@@
> =C2=A0x
> =C2=A0+foo
> =C2=A0y
> @@@ ... @@@
> =C2=A0a
> - bar
> =C2=A0b
>
> Oh, it's easy for the conflicted part of the diff, which you'll see
> elsewhere as well:
>
> @@@ ... @@@
> =C2=A0r
> ++<<<<<<< HEAD
> =C2=A0+foo
> ++=3D=3D=3D=3D=3D=3D=3D
> + bar
> ++>>>>>>> some-branch
> =C2=A0s
>
> Do not forget that in a case (like mine) where the non-condensed diff=
 is
> actually huge, the conflict markers would no exactly be easy to find =
in
> the diff.

But that's exactly the point - not to make the choice easy, but to
make it obvious that the choice is *not easy*.

The problem is that as it stands the user things the only choice is
between choosing "foo" and choosing "bar".

> ++<<<<<<< HEAD
> =C2=A0+foo
> ++=3D=3D=3D=3D=3D=3D=3D
> + bar
> ++>>>>>>> some-branch

This is a false choice but it is not obviously so.

The point of using diff -c is *precisely* to help the user understand
that it isn't a choice between foo and bar, but a choice
between losing all the changes that came with foo and all the changes
that came with bar.


> And therefore I suggest to disable these options.
>

I agree that this would be a better solution than leaving the behaviour=
 as is.

> Which are those very simplest cases that you are referring to? If you=
 mean
> modify/delete conflicts, then I indeed would like to keep the options=
 for
> them.

The simplest case is when the presented diff presents the *whole*
difference between the local and remote branches.

As it stands, the gui can mislead the user into believing that the
presented diff is the whole difference and that their only
choice is between foo and bar.

Sure, users who have been bitten by this misapprehension will learn,
but it is hard lesson to learn.

>
> That said, your earlier patch that presented the diff against HEAD wa=
s not
> bad after all.

I prefer the -c version - not because the output is easy to
understand, but precisely because it gives pause.

jon.
