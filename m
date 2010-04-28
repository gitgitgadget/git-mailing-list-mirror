From: Eugene Sajine <euguess@gmail.com>
Subject: Re: how to fix the problem correctly?
Date: Wed, 28 Apr 2010 14:55:01 -0400
Message-ID: <t2h76c5b8581004281155ta77ad992xc36b5d87824ec9cf@mail.gmail.com>
References: <w2t76c5b8581004280954r436c1be1g8d6e415bf3596f4d@mail.gmail.com>
	 <s2v32541b131004281130m1c79ff4dp8c02afc8b70bbde5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 20:55:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7CPh-0004Tz-Dz
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 20:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab0D1SzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 14:55:05 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:48868 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab0D1SzC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 14:55:02 -0400
Received: by qyk9 with SMTP id 9so21705261qyk.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=07rxIMwzIq6HRZBUyOWKeN+mmhrRbP7nz6BmDBTEsyY=;
        b=hmnHJSha+KL3fxkpYDeGM/IK2NCcmUUyNoZ7+a5u3xoRwuRqG1B3Yv3Fr7ymdL5XFZ
         +PcxkKQEAQfZtmplgCGfG499nrjVZH4fkIoiQ2fUXRok5Dc8Nd269KSt9b+PoBubic0Q
         nCkyV8m/f8iaB7Tgg7JvdCD06Kg9L69aRipI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k2iAzdtNwIeoTuDL6ds/uc/Owqe9d2w3QCPhreITKbrnoZAhN1UDP5/klUeeZoOq3w
         2DLbrUWbR19eFRRKl63krCzcmHgNl2VOtiRfzvnGcqBTPhiJJDCARrEcJC5G33kaghVY
         RtQx7wPx6DRGgGU/On1Kau4jpcLU9eaWY9+5c=
Received: by 10.229.186.211 with SMTP id ct19mr671360qcb.16.1272480901487; 
	Wed, 28 Apr 2010 11:55:01 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Wed, 28 Apr 2010 11:55:01 -0700 (PDT)
In-Reply-To: <s2v32541b131004281130m1c79ff4dp8c02afc8b70bbde5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146004>

>
> Virtually any way that works is "correct." =C2=A0It depends a bit on =
your goals.
>
> Step 1 is certainly the easiest place to start. =C2=A0If you're then
> concerned about making sure your history never showed the mistake
> (which is a lofty goal, though rarely very important), you could use
> git rebase to 'squash' this new commit into C. =C2=A0But rewriting hi=
story
> in git has well-documented dangers, so you should be careful and read
> the docs first.

Good idea to clean up with rebase after step 1. I didn't think about
that, thanks! And yes I know about the restrictions;)

>
>> PS interesting enough =E2=80=93 CVS keywords helped us to notice the=
 problem
>> as master state was imported from CVS.
>> In commit A file 1.txt had version ID 1.5 in commit B it was 1.6 ,
>> commit C was changing the line back to 1.5
>> Is there a way for git to help me to recognize this kind of issue if
>> there are no keywords?
>
> Sadly, git doesn't have any magic features for detecting when someone
> checks in something stupid :) =C2=A0 But 'git bisect' can be very hel=
pful
> in isolating which commit caused a particular problem. =C2=A0Once you=
 know
> you have a problem, it's pretty easy to narrow it down that way.

yes, it is very hard to be fool-proof. I just got an idea:
In this particular case some script scanning for pairs of commits
where blob SHA-1 changes
are like below (for the same path) and warns about such occurrences.

commit 1111
=2E.. blobaaaaaa... blobbbbbbb... path

commit 3333

=2E.. blobbbbbbb... blobaaaaaaa... path

Unless the commit 3333 is a real revert, this might be suspicious, isn'=
t it?

I don't know if it has any real sense or use, but i will try to create
such thing at least as an exercise...

Thanks,
Eugene
