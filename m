From: Eugene Sajine <euguess@gmail.com>
Subject: Re: origin/branchname and tracking branch pointing to different 
	commits?
Date: Tue, 8 Jun 2010 12:27:14 -0400
Message-ID: <AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
	<201001071813.01187.trast@student.ethz.ch>
	<76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
	<76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
	<7v7hrtzbau.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:33:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1ji-000834-Av
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab0FHQdF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 12:33:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39512 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab0FHQdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 12:33:04 -0400
Received: by pvg16 with SMTP id 16so1992536pvg.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XANS8MYkRbfaN1+xHOkexXG/QBCjXLiet6JjQ7VswPM=;
        b=QbmUIWNHo/UTTUtqWvzAsYBmqWrS58/iARjG3Wmqu0UAcma5mFK2jYJvqayUh2ZPAi
         Pp14MSXU8hQdjGRHJHrOQRDDETQC4qWijVzcRFc1s3fn/jnpw9TA6X2vwkRZ0IonDY06
         QkbtoqXvp+NktstkkQ27MvLIRaEaDviEXCs+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DU0OG81Tnz0fHWaH943bl0lGqDAqiu2Er57g5rnKBG+mj+FBkPunnyNMOUn7P3pHSf
         AybNUfUH/ttura/KtXRJcLlxKKZQmLNMnDfGE6uAEPKpqD3M5ubi7hPsy//p/OsAO0Oz
         HaMO9duH5o37K08J/AVG3F5WzJ4tGqd3PWknw=
Received: by 10.229.215.204 with SMTP id hf12mr3687374qcb.264.1276014434264; 
	Tue, 08 Jun 2010 09:27:14 -0700 (PDT)
Received: by 10.229.239.210 with HTTP; Tue, 8 Jun 2010 09:27:14 -0700 (PDT)
In-Reply-To: <7v7hrtzbau.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148690>

On Thu, Jan 7, 2010 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> $ git fetch origin branchname
>>
>> are both causing the output like this:
>>
>> From git://....
>> * branch =C2=A0 =C2=A0 =C2=A0branchname =C2=A0 =C2=A0-> FETCH_HEAD
>> ...
>>
>> but "git fetch" says:
>>
>> From git://....
>> * branch =C2=A0 =C2=A0 =C2=A0branchname =C2=A0 =C2=A0-> origin/branc=
hname
>>
>> Is this inconsistent behavior necessary by design?
>
> It is by design; it is debatable if it still makes sense, though.
>
> Back when "git fetch" was invented, there weren't separate refs/remot=
es/
> hierarchy, the distinction between what's local and what's remote wer=
e
> only in user's head. =C2=A0It made quite a lot of sense to have an ex=
plicit way
> to prevent "fetch" from overwriting all the branches that track branc=
hes
> from remote. =C2=A0Suppose you have already spend considerable time i=
nspecting
> 'origin/branch' and decided that has a suitable commit to build your
> changes on, but you needed to work on something else first. =C2=A0If =
"git fetch
> origin other", an explicit request about "other" branch, updated an
> unrelated "origin/branch" at the same time, you couldn't recover from=
 it
> by using "origin/branch@{1}", because reflog is a fairly recent inven=
tion.
>
> An explicit "git fetch origin other" is a way to prevent such an upda=
te
> from happening. =C2=A0It does not update anything in refs/ hierarchy,=
 even when
> you have configured to make an implicit 'git fetch $there' make a cop=
y of
> $this_ref somewhere in your refs/remotes/$there/ hierarchy in .git/co=
nfig
> (back then the same information came from .git/remotes).
>
> Because we have reflogs on by default, and refs/remotes/ is a separat=
e
> hierarchy that is read-only from the local user's point of view, I th=
ink
> the 'explicit fetch' syntax, as a way to stop tracking branches from
> getting updated, ceased to be useful these days.
>
>

I'm coming back to this topic as i see some confusion growing about
such behavior. Every now and then users come across this problem and
they expect pull to *really* behave as fetch and merge so it will
cause the update of remote/branchname branch. And it is kind of
difficult to justify why they have to do git fetch after pull...

Can somebody, please, take a look?

Thanks,
Eugene
