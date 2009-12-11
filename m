From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 13:33:34 +0100
Message-ID: <4B223C1E.6010403@drmicha.warpmail.net>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com> <200912110233.18756.jnareb@gmail.com> <4B222289.6000004@drmicha.warpmail.net> <200912111220.40844.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 13:35:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ4i6-0003dk-F1
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 13:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbZLKMeu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 07:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbZLKMeu
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 07:34:50 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35566 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751435AbZLKMet (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2009 07:34:49 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 18D8CC5524;
	Fri, 11 Dec 2009 07:34:56 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 11 Dec 2009 07:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fU4GxKO+VHXC30jpvbV5gAn8wwk=; b=MSzsta6Isx7a8XrN+jDOJnjlks1a6RQVq+A/yiMj/+BY2+9HatDfLuqdNwVuQCrD6izCvsTYgKpThlQwpbEWUIQivSE9oJF0N1sEnJ40xDSPXBbXkYhNUrJNGQ6mppuk4pUAi4krE7sA1M1hlIbZ907jxv+QFztN2O0CKyz6sX0=
X-Sasl-enc: Cn6tQ1HLXIpKf5DcUfVlIaM0SiVn3bbF5MLJXwBfJI+w 1260534895
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 104B24ABCBD;
	Fri, 11 Dec 2009 07:34:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <200912111220.40844.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135082>

Jakub Narebski venit, vidit, dixit 11.12.2009 12:20:
> Dnia pi=B1tek 11. grudnia 2009 11:44, Michael J Gruber napisa=B3:
>> Jakub Narebski venit, vidit, dixit 11.12.2009 02:33:
>>> Dnia pi=B1tek 11. grudnia 2009 02:11, Junio C Hamano napisa=B3:
>>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>>
>>>>>   --unresolve::
>>>>>         Restores the 'unmerged' or 'needs updating' state of a
>>>>>         file during a merge if it was cleared by accident.
>>>>>
>>>>> Unless "git add foo" not only adds current contents of foo at sta=
ge 0,
>>>>> but also removes higher stages from index...
>>>>
>>>> By definition, adding anything at stage #0 is to remove higher sta=
ges.
>>>
>>> Hmmm... let's test it:
>>>
>>>  $ git merge side-branch=20
>>>  Auto-merging foo
>>>  CONFLICT (content): Merge conflict in foo
>>>  Automatic merge failed; fix conflicts and then commit the result.
>>>  $ git ls-files --stage
>>>  100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
>>>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>>>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>>>  $ <edit foo>
>>>  $ git add foo
>>>  $ git ls-files --stage
>>>  100644 a1b58d38ffa61e8e99b7cb95cdf540aedf2a96b3 0       foo
>=20
> I thought that "git add foo" only adds current contents of foo in sta=
ge 0,
> and does not delete other stages.
> =20
> Unless "git add foo" does more than "git update-index foo" does here.

Quoting Junio:

By definition, adding anything at stage #0 is to remove higher stages.

Could one leave 1 alone but still mark the conflict resolved?

>>> Now let's test '--unresolve' option of git-update-index:
>>>
>>>  $ git update-index --unresolve foo
>>>  $ git ls-files --stage foo
>>>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>>>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>>>
>>> WTF? What happened to stage 1 (ancestor)?
>>
>> 2 and 3 are easy (cheap) to recreate from HEAD and MERGE_HEAD, 1 is =
not.
>> I guess that's why --unresolve doesn't even attempt to do anything w=
ith 1.
>=20
> But then "git update-index --unresolve <file>" is next to useless.

Well, I'm not defending current behaviour, just describing its
implementation.

>=20
>>>
>>>  $ git checkout --conflict=3Dmerge foo
>>>  error: path 'foo' does not have all three versions
>>>
>>> Let's recover it by hand:
>>>
>>>  $ echo -e "100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1\tfoo"=
 |=20
>>>    git update-index --index-info
>>>  $ git ls-files --stage foo
>>>  100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
>>>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>>>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>>>  $ git checkout --conflict=3Dmerge foo
>>
>> Yeah, if we knew that sha1...
>=20
> Isn't it:
>=20
>   $ git ls-tree $(git merge-base HEAD MERGE_HEAD) -- foo
>=20
> or
>=20
>   $ git rev-parse "$(git merge-base HEAD MERGE_HEAD):foo"

Yes, sure. That's why I wrote "cheap": --unresolve simply reads HEAD an=
d
MERGE_HEAD. Resetting 1 requires (re)calculation of the merge base.

Michael
