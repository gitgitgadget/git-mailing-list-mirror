From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 14:45:54 +0200
Message-ID: <201106091445.55601.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <201106091148.35114.jnareb@gmail.com> <BANLkTimir5nQYJk+GuNQOzmTWMEXb2kWqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Thu Jun 09 14:46:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUecn-0001NN-K1
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 14:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757556Ab1FIMqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 08:46:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61489 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873Ab1FIMqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 08:46:05 -0400
Received: by fxm17 with SMTP id 17so948706fxm.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=gU4CMUiC9NN9zpmgJ+6/N1PDmjxCHqeVpTliJe2Hq34=;
        b=nkfEyt8Ocl17lKP1D4y2/klWJbbYhNM1PHZE1YLy1bWFPKwJ+R7vGyX1CMzIhp/FsD
         PC1Co+C/2x8Ptf5PudSKylESds64WvRJ8e3uWBm67/fN1dc1sXisC3VuCONmSrLWLcmp
         s4jcKWmXycMLUSQF2r9f9v8ByzfQPV6En13WY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KFXwTkkt5IV+ymVYVhfuHx+IUGYh3RrpE+T1WYwuJFCeOG4ai081KfcxIKorcW9zSr
         ooGHkG00YAeN4u78vHPhGMW11X4jNDdtGqUsc8GCsP92m5I42ketsJVpGPHz1zlit6XR
         WnucyQlZGvR/YedLg1xp/OWRbwpur3et1nN9k=
Received: by 10.223.13.10 with SMTP id z10mr752887faz.69.1307623564259;
        Thu, 09 Jun 2011 05:46:04 -0700 (PDT)
Received: from [192.168.1.15] (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id h1sm642570fag.35.2011.06.09.05.46.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 05:46:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTimir5nQYJk+GuNQOzmTWMEXb2kWqQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175519>

On Thu, Jun 9, 2011, Michael Nahas wrote:
> On Thu, Jun 9, 2011 at 5:48 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> On Wed, 8 June 2011, Michael Nahas wrote:
>>> On Wed, Jun 8, 2011 at 11:05 AM, Jeff King <peff@peff.net> wrote:

>>>> Isn't this going to be behavior change, since your NEXT is not qui=
te the
>>>> same as the index?

[...]
>>> I propose that during a
>>> conflicted merge, that NEXT be computed as HEAD plus the resolved
>>> files, that is, the files in stage 0 of the index.
>>
>> Why _HEAD_?
>=20
> Because we merged changed from another branch into HEAD.
> Or we pull changes from a remote branch into HEAD.
>=20
> When a commit is written, it will be part of the branch referenced
> by HEAD.=20

And by selecting HEAD for diff's NEXT you would have problems with reba=
se,
where you also can have conflicts, where 'ours' and 'theirs' are switch=
ed
around (at least from one point of view).
=20
>>> "git diff HEAD NEXT" would print the resolved changes.
>>> "git diff NEXT WTREE" would print the unresolved changes
>>> "git diff HEAD WTREE" would print all changes.
>>>
>>> I believe that is the same behaviour as "git diff", "git diff
>>> --cached" and "git diff HEAD" during a conflicted merge.
>>
>> "git diff NEXT WTREE" would not behave (with your proposal) like
>> "git diff", but like "git diff --ours".
>=20
> OURS and HEAD are the same thing, so I doubt a command that does not
> involve "HEAD" would behave like "--ours"

OURS and HEAD are not the same thing.  In OURS you have _conflicted_
chunks replaced with HEAD ('ours') version, but chunks that can be
resolved sutomatically are resolved; sometimes to 'theirs' version.

"git diff" in case of conflict prints 3-way combined diff between
'ours', 'theirs' and working area version.  As "git diff NEXT WTREE"
doesn't print 3-way combined diff, it would be different for conflicts
from "git diff".

"git diff --ours" for nonconflicted entry (stage 0 in index) would
print ordinary diff between index and working area, just like
"git diff NEXT WTREE".  What I just realized that at least from what
you wrote (corner case!) in case of conflicts it would be different
from "git diff NEXT WTREE", as ours !=3D HEAD.

[...]
>>> I do not know how "n-way" merge works. =A0I saw somewhere that indi=
cated
>>> that it was a series of N-1 two-way merges.
>>
>> Where this "n-way merge" came from? =A0Peff wrote about "n-way combi=
ned
>> diff", which is something different.
>=20
> N-way merge exists.  It would be bad to say that I was answering a
> question about conflicted merges if I didn't produce an answer for
> N-way merges.  Unfortunately, I don't have enough information about
> N-way merges to answer the question so I decided it was best to
> acknowledge my ignorance and that I was giving an incomplete answer.

Actually while git can do n-way merge (so called "octopus" merge), it
either resolves it cleanly, or refuses merge; it does not try to resolv=
e
conflict and present conflicts in the index.  So it is always "3-way
combined diff".

But you didn't answer about _combined diff_...

--=20
Jakub Narebski
Poland
