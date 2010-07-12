From: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: skipping commits via commit-msg contents
Date: Mon, 12 Jul 2010 13:56:20 -0600
Message-ID: <AANLkTikVNpFPBMO_SDIfn-5np42ALI-qGAHTOvlmONxo@mail.gmail.com>
References: <AANLkTikYcODU96J-cVYCIad1yrd5zGklVj2OV4UT2PxC@mail.gmail.com>
	<20100712190203.GA9365@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 21:56:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYP78-00021k-Vn
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 21:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235Ab0GLT4Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 15:56:24 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52199 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab0GLT4X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 15:56:23 -0400
Received: by eya25 with SMTP id 25so641896eya.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QAUvcWw0kAgDRcmZQnRPUqyw1ZC8f8clRW819M7nXyM=;
        b=oE9qNdVejkUlEyp2DEYVVZuItpZhyYW8yq7dJ8BfB6IdO85P8PGZa9lEC0mwDbVXvb
         zp39GJWLFEZaiwnPVNOCV1ctjM8waOnY312OJGyQzJA0UOBe1gjAH86SxW3SD+LE4b+P
         57m2V8wxm7i13uFktGwyxkKLMsOEMU0m8omKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YprVvxXZ0bhXpkKlLLMouJj8Aiidxduuo+9xl3p3Pa+M8M+3Xa2xU/8EGRN3ZVAdma
         yUQlE7NWYLpZK4DKdLRiOTQ3IC0PmhQtm4I8uLoaRSeY3K+RHCYiHmONONXjBLKQ/Hoj
         QaJiyZg9qsqFDzo21oPxXntcwmeICIOboeV+I=
Received: by 10.213.15.212 with SMTP id l20mr1847123eba.49.1278964580564; Mon, 
	12 Jul 2010 12:56:20 -0700 (PDT)
Received: by 10.14.45.79 with HTTP; Mon, 12 Jul 2010 12:56:20 -0700 (PDT)
In-Reply-To: <20100712190203.GA9365@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150844>

thanks guys,

Ram, not what I want, but good to know..

Jonathan, replace feels like a big hammer for a newbie..
I havent published these, since they need bisection amongst other reaso=
ns :-O
and the BUGS also require more -fu to understand than I possess


On Mon, Jul 12, 2010 at 1:02 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Jim,
>
> Jim Cromie wrote:
>
>> if git bisect were to recognize =A0--skip-bisect =A0in the subject l=
ine
>> (or in commit-message somewhere, say top or bottom),
>> then bisection could proceed silently past such commits.
>
> In addition to Ram=92s suggestion, you might want to look into
> =91git replace=92[1]. =A0It can be useful when the broken commits
> have already been published. =A0It works like this:
>
> =A0git replace <bad commit> <bad commit>^
>
> and then =91git bisect=92 and lower-level commands like git show and
> checkout will silently substitute the parent of the broken commit
> when ever you refer to it.
>
> You can publish the resulting =93replace refs=94 in the refs/replace/=
*
> namespace and anyone who explicitly chooses to fetch them will be
> able to see the same effect.
>
> Two problems:
>
> =A0- bisect skip is a bit more sophisticated (read: better) than just
> =A0 substituting a parent, especially when the commit to be skipped
> =A0 is a merge. =A0So it might still make sense to teach bisect to
> =A0 respect a refs/notes/skip-bisect note that requests for it
> =A0 to skip a specific ref.

This sounds nice.
Notionally, extending it further would be cool -

[jimc@groucho perl-git]$ git notes show 2de9db42d3e578becacbd237bf4f59b=
432cc82f0
good make test

with this note, Ive told myself that it passes (good), and what it
passes (make test)

I could imagine bisect knowing enough to take that as an implicit start=
,
unless overridden on a command line, or by a similar note on a later co=
mmit.

a note like:
skip-bisect until <tag|commit|branch>
could be cool too, though there may be deeper problems with skipping
entire subranges.

thanks again,
Jim
