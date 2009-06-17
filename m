From: John Tapsell <johnflux@gmail.com>
Subject: Re: git rebase --interactive squash/squish/fold/rollup
Date: Wed, 17 Jun 2009 17:40:06 +0100
Message-ID: <43d8ce650906170940m17942793xe0cd88ae372ff8f2@mail.gmail.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	 <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	 <7vvdmurfao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 18:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGyBY-0004nS-0T
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 18:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbZFQQkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2009 12:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbZFQQkF
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 12:40:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:40583 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbZFQQkE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 12:40:04 -0400
Received: by yw-out-2324.google.com with SMTP id 5so237792ywb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=MrnvHTjo8rM++inmPY8jeVY8zp/ctWOg/dPrd/acrNU=;
        b=nfEzi89R+bPCQYQosyAjm2B5HDegqh0boWXLFcElFLpN+hw3O750Y7MW3Y3sPLV0LZ
         nvTtgCk1B69Q8z1kr8X53DgXV7wysLohlBo3hyki8F6EZjYdC3gMrm2wHKljJ7jPUy+i
         40JJEhd4LESM5qSzIP+CkDH7F7okYAvqkkJxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ACuy4JN8HXLqXB7VTjXeFoY0fQKia+2CQHKF8ctY6m2xxTGTj+Og7QlnsRGgGlOdXa
         DPAI3bzXmzhD0nlTlGo12Iomw3saDGvr48UxK3zIIfRt5SIoUEjKpjhePrfpBN3jI7GK
         oaUM95o8dMRzHXtiVt0rq66UhV4Ezw8tQDB2w=
Received: by 10.151.125.6 with SMTP id c6mr1548226ybn.144.1245256806397; Wed, 
	17 Jun 2009 09:40:06 -0700 (PDT)
In-Reply-To: <7vvdmurfao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121758>

2009/6/17 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
>
>>> branch, hack, commit.
>>> hack, commit, hack, commit
>>
>> What if you used =C2=A0commit --append =C2=A0instead?
>>
>> The trouble though of squashing all the commits into one is that it
>> makes it impossible to bisect later. =C2=A0Are you really sure that =
your
>> final commit cannot be broken into small commits? =C2=A0Ideally each=
 commit
>> is small but self contained. =C2=A0Squashing should be done only to =
fix
>> cases where you introduced a bug then fixed it, or to fix a partial
>> implementation etc.
>
> I think you meant --amend, but it often happens to me that after prep=
aring
> a three-patch series:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[1/3] Clean up the surrounding code I will=
 touch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[2/3] Lay the groundwork
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[3/3] Implement a cool new feature
>
> I find that there are more clean-up that should have been done in [1/=
3].
> The way "rebase -i" expects me to work is:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ edit ;# more clean-ups
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git commit -a -m 'squash to "clean up"'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git rebase -i HEAD~5
>
> which will give me
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick 1/3 Clean up ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick 2/3 Lay the groundwork
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick 3/3 Implement
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick 4/3 squash to "clean up"
>
> that I'll change to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick 1/3 Clean up ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0squash 4/3 squash to "clean up"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick 2/3 Lay the groundwork
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick 3/3 Implement

Yeah.  It would be nice to have a 'crush' or something here.
It's similar to the arguments to have a command to just edit the
commit message in a single go, rather than the rather long way of
using edit.
