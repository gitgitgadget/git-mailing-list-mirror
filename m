From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 15:57:04 +0100
Message-ID: <4B225DC0.4020603@drmicha.warpmail.net>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com> <200912111220.40844.jnareb@gmail.com> <4B223C1E.6010403@drmicha.warpmail.net> <200912111500.51982.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 15:58:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ6wy-0002AT-0I
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 15:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758608AbZLKO6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 09:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758591AbZLKO6U
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 09:58:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48958 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758581AbZLKO6T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2009 09:58:19 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1B597C4505;
	Fri, 11 Dec 2009 09:58:26 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 11 Dec 2009 09:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3j9KZSYQWCGR/psh8e9lBfehba8=; b=Zw0Yjzpr6/Lhz3WkHGJK7k4tQ3WDH246ULDBGxbzlPCwP362SUwxNO1P7LJ0wKOQPSmH+LuTL1BDo1en75jUBMZTiIu8k67M4CP3fMaQu41SSl5nM2XunwsWQiRJA2U+1tuTdgsB4AjOkEaFSRathBzPEBxB4/GAd15P7UiqIHI=
X-Sasl-enc: vIgzliNq3XT2OSTloa2AJgyRTNZeYn0QhakCJ+GBCrNS 1260543505
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4D6EA112A2;
	Fri, 11 Dec 2009 09:58:24 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <200912111500.51982.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135090>

Jakub Narebski venit, vidit, dixit 11.12.2009 15:00:
> Dnia pi=B1tek 11. grudnia 2009 13:33, Michael J Gruber napisa=B3:
>> Jakub Narebski venit, vidit, dixit 11.12.2009 12:20:
>>> Dnia pi=B1tek 11. grudnia 2009 11:44, Michael J Gruber napisa=B3:
>>>> Jakub Narebski venit, vidit, dixit 11.12.2009 02:33:
>>>>> Dnia pi=B1tek 11. grudnia 2009 02:11, Junio C Hamano napisa=B3:
>>>>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>>>>
>>>>>>>   --unresolve::
>>>>>>>         Restores the 'unmerged' or 'needs updating' state of a
>>>>>>>         file during a merge if it was cleared by accident.
>>>>>>>
>>>>>>> Unless "git add foo" not only adds current contents of foo at s=
tage 0,
>>>>>>> but also removes higher stages from index...
>>>>>>
>>>>>> By definition, adding anything at stage #0 is to remove higher s=
tages.
>>>>>
>>>>> Hmmm... let's test it:
>>>>>
>>>>>  $ git merge side-branch=20
>>>>>  Auto-merging foo
>>>>>  CONFLICT (content): Merge conflict in foo
>>>>>  Automatic merge failed; fix conflicts and then commit the result=
=2E
>>>>>  $ git ls-files --stage
>>>>>  100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
>>>>>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>>>>>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>>>>>  $ <edit foo>
>>>>>  $ git add foo
>>>>>  $ git ls-files --stage
>>>>>  100644 a1b58d38ffa61e8e99b7cb95cdf540aedf2a96b3 0       foo
>>>
>>> I thought that "git add foo" only adds current contents of foo in s=
tage 0,
>>> and does not delete other stages.
>>> =20
>>> Unless "git add foo" does more than "git update-index foo" does her=
e.
>>
>> Quoting Junio:
>>
>> By definition, adding anything at stage #0 is to remove higher stage=
s.
>>
>> Could one leave 1 alone but still mark the conflict resolved?
>=20
> I have thought that if there exist stage #0 in index, git simply _ign=
ores_
> higher stages, so git-add simply adds stage #0 and does not delete hi=
gher
> stages.
>=20
> But I see that "git update-index --unresolve" (and its predecessor=20
> "git-unresolve") simply recreate stages #2 and #3.
>=20
>=20
> The documentation of "git update-index --unresolve" lacks this info,
> and it doesn't tell one what it is for (see commit message for commit
> ec16779 (Add git-unresolve <paths>..., 2006-04-19)).
>=20

Oh yes, one should always read the classics ;) [Really nice commit
message, that is.]

Michael
