From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/17] revert: Introduce --continue to continue the operation
Date: Tue, 19 Jul 2011 01:30:37 +0530
Message-ID: <CALkWK0mfRR4M_VRQbpXzM97i4-fjF9=S+xPpCuwL-EQmaA9jfw@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-18-git-send-email-artagnon@gmail.com> <20110712204650.GG14909@elie>
 <CALkWK0==A1a-kzqXuEkjS+FMR1CAzJox8MBdkQGMLukoU15L9w@mail.gmail.com> <20110717183219.GB27787@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 22:01:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiu03-0001aY-Bj
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 22:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab1GRUBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 16:01:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57957 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1GRUA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 16:00:59 -0400
Received: by wwe5 with SMTP id 5so3512204wwe.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GudD3NCdaHKHqmZ+SdGzXtXVc0Q/975mzuINqXYBlyI=;
        b=YKahIpVuhX3vY9TPE3NkCcvGwG4VJf+aLKDZCV9gureKJHi+ceZUtmWkaTuqjaFHCo
         OpFP000p21HPgX+xOL13n6+zF7P/1jWGXvLoKO16BNJil5rTAZUmLdAjl9CYrLVU2l6y
         ipkqoVyYJ0kHTD8GPRpDSuweQFuiRaK2Htscg=
Received: by 10.216.155.134 with SMTP id j6mr6103121wek.81.1311019258200; Mon,
 18 Jul 2011 13:00:58 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Mon, 18 Jul 2011 13:00:37 -0700 (PDT)
In-Reply-To: <20110717183219.GB27787@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177402>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder writes:
>>> The -s thing doesn't have much to do with this change. =C2=A0But is=
 it a
>>> bug or not? =C2=A0If it's not a bug, then this is not so much a gli=
tch to
>>> note as an important feature to ensure people don't sign off on a
>>> conflict resolution without thinking about it. =C2=A0(I guess I thi=
nk it's
>>> a bug. =C2=A0It's hard to decide.)
>>
>> Bug, definitely. =C2=A0It happens because unlike "-x" where the
>> cherry-picking machinery appends to the commit message, "-s" is
>> handled at commit-time (when it spawns `git commit`). =C2=A0Ofcourse=
, if I
>> were never to write the sequencing features, this would never been
>> seen as a bug -- hence the term "glitch"; an implementation detail
>> that doesn't suit our future plans (namely, this series) very well.
>
> Hmm, I thought I remembered this coming up previously and Junio
> mentioning that it was intentional (maybe in the context of
> CHERRY_HEAD?), but I haven't been able to find the relevant message.

Hm, not automatically signing off on a commit resolution.  I'm not
sure I understand why.  What does it mean to signoff? It proof of
origin, more than anything else -- it means that you didn't pick up
the code from some random place, right? Why would you want to signoff
on commits you're picking from another branch? A topic branch that you
want to merge into 'master' -- all the commits in the topic branch are
yours (or you atleast know where the code came from), but there are
probably commits from other developers in 'master'.  So what happens
when you resolve a conflict?
1. You modify some of your own code to fit into the code in 'master'.
Auto-signoff is alright here.
2. You modify someone else's code to accommodate your code in
'master'.  Here, your commit contains hunks which either modify or
remove someone else's code, but how is this sort of thing different
from a normal patch? Intent is different- I would've never made that
change unless I tried accommodating this topic branch in 'master', but
it has no effect on the origin of the code.  Are you saying that
auto-signoff is not alright here? Why?

Wait.  There's another explanation.  You resolved the conflict and got
everything into 'master' successfully, but some bugs crept into the
program (that aren't present in the topic branch) because you resolved
the conflict in a hurry.  Still, what does all this have to do with
certificate of origin?

Thanks.

-- Ram
