From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Wed, 26 Jan 2011 10:44:04 +0100
Message-ID: <AANLkTi=T+oapfn1CTu_smU1P+JEraihE4BUKJcB=uBHw@mail.gmail.com>
References: <4D3CDDF9.6080405@intel.com>
	<AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>
	<4D3D54D3.7040801@intel.com>
	<AANLkTin1rS-ZBDx4j-UNFH4z9tnTiv5LBodLO-G2U2UF@mail.gmail.com>
	<4D3FCBB3.2090508@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"apenwarr@gmail.com" <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Shuang He <shuang.he@intel.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 10:44:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi1vA-0001c7-MR
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 10:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab1AZJoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 04:44:09 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41407 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab1AZJoF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 04:44:05 -0500
Received: by wyb28 with SMTP id 28so728798wyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 01:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rmu0TfTBvmZ3nh0atLQc/Wuq4sIGBqCCJ0WK4U7fGFY=;
        b=atkbqnjDkFr7k8V3n06QJC20XcQ/PQSer4AM3fe8z39KYkMsWikIICv/6DMERr9kpT
         1uIvth8PQ0KrDwP1e7LW5shbmnmkag7MRuo4CrOE6sUBoG2BRB4dhpUquxGiaVFDDZQ8
         94PxlmRVng85SF7tEJmNz9VV33Thim5ypJgJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UDYBKHKIAfT8eHBvJOmcxfjnCgwGVm5sGMVgg7ca1/dXwPMsi9gNGzgJShbQB6JyPf
         WfWot3m2M6Gf6WpdeMuO4aU377sFgDcu/5tzIS1kK3i48u2vDeq0c22fjmu6ehWRI+Sh
         F8dO6T+rgOxnJ1MiNqro+eH5RbbSId02/O6Qs=
Received: by 10.216.144.205 with SMTP id n55mr4831964wej.5.1296035044074; Wed,
 26 Jan 2011 01:44:04 -0800 (PST)
Received: by 10.216.30.65 with HTTP; Wed, 26 Jan 2011 01:44:04 -0800 (PST)
In-Reply-To: <4D3FCBB3.2090508@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165510>

On Wed, Jan 26, 2011 at 8:22 AM, Shuang He <shuang.he@intel.com> wrote:
> On 2011/1/25 17:20, Christian Couder wrote:
>>
>>>
>>> Yeah, I agree that the issue I addressed above will not be a proble=
m if
>>> all
>>> those branches are maintained very well.
>>> Actually we've implemented a automated bisect system for Intel Linu=
x
>>> Graphics Driver Project, and so we'd like the system
>>> helps us to locate issue in an more automatic way when branches are=
 not
>>> maintained as good as expected.
>>
>> I think there is always a price to pay when you bisect if the branch=
es
>> are not well maintained.
>> Maybe your algorithm could help in some cases, but my opinion is tha=
t
>> there will probably still be many problems and a human will often ha=
ve
>> to take a look.
>>
>
> Yes, I agree. What we trying to do is just make the machine to do mor=
e help
> for human.

Yeah, this is the way to go. And by the way I am happy to know that
you have implemented an automated bisect system. That's great and I
hope it already helps.

>>>> - the name "bisectbadbranchfirst" seems wrong to me, because git
>>>> branches are just some special tags; "firstparentsonly" would be a
>>>> better name,
>>>
>>> It's recursively applying bad branch first algorithm, not just cons=
tantly
>>> stick to first parent.
>>> Given this condition:
>>> =A0 =A0A -> =A0B -> =A0C -> =A0D -> =A0E -> =A0F -> =A0G -> =A0H =A0=
 (master)
>>> =A0 =A0 =A0 =A0 \ a =A0-> =A0b -> =A0c -> =A0d -> =A0e / =A0(featur=
e 1)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0\ x -> =A0y -> =A0z/ =A0 =A0 =A0(feature=
 2)
>>> start with H as bad commit, and A as good commit, if y is the targe=
t bad
>>> commit. bad-branch-first algorithm will do it like this:
>>> =A0 =A01. In first round stick to master branch, so it will locate =
G as first
>>> bad commit
>>> =A0 =A02. In second round stick to feature1 branch, then it will lo=
cate d as
>>> first bad commit
>>> =A0 =A03. In third round stick to feature2 branch, then it will fin=
ally
>>> locate y
>>> as first bad commit
>>> So you could see, it's always sticking to branch where current bad =
commit
>>> sit
>>
>> I see. It is interesting, but why not develop a "firstparentsonly"
>> algorithm first?
>>
>> As Avery explains in his email, it is already interesting to have a
>> "firstparentsonly" algorithm because some people are only interested
>> to know from which branch the bug comes from.
>> When they know that, they can just contact the relevant people and b=
e
>> done with it.
>>
>> And when we have a "firstparentsonly" algorithm, then your algorithm
>> could be just a script that repeatedly uses git bisect with the
>> "firstparentsonly" algorithm. And this script might be integrated in
>> the "contrib" directory if it not considered important to be
>> integrated as an algorithm into git bisect.
>
> Sorry to reply so late, since I was on a long journey home for Chines=
e New
> Year vacation ;)

No problem. I am not in a hurry at all. In fact I don't have much time
these days so I reply very late too.

> I agree that's also an good option.
> Is it acceptable to add option to git-bisect stuff, so user could cho=
ose
> which algorithm to use at every step at will.

Are you sure it is needed to be able to change the algorithm at every s=
tep?

This means that you would like a new "git bisect strategy <strategy>"
subcommand ?

=46irst I thought that we could just add a "--strategy <strategy>"
option to "git bisect start".
But anyway, I think it should be easy to add afterward, and it can be
done in a separated patch that can be discussed on its own.

> And we have tested previous attached patch with t6002-rev-list-bisect=
=2Esh and
> t6030-bisect-porcelain.sh, and we get:
> =A0 =A0with bad-branch-first disabled (which is the default setting):
> =A0 =A0 =A0 =A0t6002-rev-list-bisect.sh: # passed all 45 test(s)
> =A0 =A0 =A0 =A0t6030-bisect-porcelain.sh: # passed all 40 test(s)
> =A0 =A0and with bad-branch-first enabled:
> =A0 =A0 =A0 =A0t6002-rev-list-bisect.sh: # passed all 45 test(s)
> =A0 =A0 =A0 =A0t6030-bisect-porcelain.sh: # failed 5 among 40 test(s)=
, and I have
> spent some time digging into those failures ,and it seems they're all=
 false
> negative since they're using hard-coded bisect path to validate speci=
fic
> case

Yes, there are some hard coded commits that depend on the algorithm.
Anyway I did not look in depth at your patch yet, and as I said it
would be better if you could split it into a patch series where a
"firstparentsonly" algorithm is implemented first.
This way it will be easier to review, and we can start to integrate
some non controversial features, and then discuss the other ones on
their own merit.

Thanks in advance,
Christian.
