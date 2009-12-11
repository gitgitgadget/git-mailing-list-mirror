From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 15:00:50 +0100
Message-ID: <200912111500.51982.jnareb@gmail.com>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com> <200912111220.40844.jnareb@gmail.com> <4B223C1E.6010403@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 14:59:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ620-0006SZ-Km
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 14:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758216AbZLKN72 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 08:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757920AbZLKN72
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 08:59:28 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:54362 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbZLKN72 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 08:59:28 -0500
Received: by fxm21 with SMTP id 21so1014870fxm.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 05:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=T3bx32uksvVmErmmJDC+hjw4rw7Ag1RV5bqQHSdaa/M=;
        b=pcmTaRH19QgbNhFTmlZu1pgplkvPyT0VRy3BliZShMhnCpMZfw8G0Nd0Ec7smJdRns
         d9bxSqewW8pa18rJj+qXFAONEwb0i9JwXNKzPPq9N7NZYikff/MdHvIJQjrbNtD2WtoT
         bLifEqqwHhqwFXO82vnqko6lCsejCnQ+qtMRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DS2wC6bHc81/5hvnz6l9h7tx++o79j7XZ6B5QQF45lW1KpcImyKnNmw0+ipRlmxGl2
         6V/8piN+phTVFIFay3XLhPcCJSJI5lTjfQcL/86EVbBbrJCz64AlJI5evVGMgvFN4vI5
         c+DIovUOdfciPB0AoH8nZ9IkQBB7/cf4DhmSM=
Received: by 10.223.164.104 with SMTP id d40mr1385837fay.98.1260539973744;
        Fri, 11 Dec 2009 05:59:33 -0800 (PST)
Received: from ?192.168.1.13? (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id c28sm2850509fka.19.2009.12.11.05.59.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 05:59:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B223C1E.6010403@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135087>

Dnia pi=B1tek 11. grudnia 2009 13:33, Michael J Gruber napisa=B3:
> Jakub Narebski venit, vidit, dixit 11.12.2009 12:20:
>> Dnia pi=B1tek 11. grudnia 2009 11:44, Michael J Gruber napisa=B3:
>>> Jakub Narebski venit, vidit, dixit 11.12.2009 02:33:
>>>> Dnia pi=B1tek 11. grudnia 2009 02:11, Junio C Hamano napisa=B3:
>>>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>>>
>>>>>>   --unresolve::
>>>>>>         Restores the 'unmerged' or 'needs updating' state of a
>>>>>>         file during a merge if it was cleared by accident.
>>>>>>
>>>>>> Unless "git add foo" not only adds current contents of foo at st=
age 0,
>>>>>> but also removes higher stages from index...
>>>>>
>>>>> By definition, adding anything at stage #0 is to remove higher st=
ages.
>>>>
>>>> Hmmm... let's test it:
>>>>
>>>>  $ git merge side-branch=20
>>>>  Auto-merging foo
>>>>  CONFLICT (content): Merge conflict in foo
>>>>  Automatic merge failed; fix conflicts and then commit the result.
>>>>  $ git ls-files --stage
>>>>  100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
>>>>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>>>>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>>>>  $ <edit foo>
>>>>  $ git add foo
>>>>  $ git ls-files --stage
>>>>  100644 a1b58d38ffa61e8e99b7cb95cdf540aedf2a96b3 0       foo
>>=20
>> I thought that "git add foo" only adds current contents of foo in st=
age 0,
>> and does not delete other stages.
>> =20
>> Unless "git add foo" does more than "git update-index foo" does here=
=2E
>=20
> Quoting Junio:
>=20
> By definition, adding anything at stage #0 is to remove higher stages=
=2E
>=20
> Could one leave 1 alone but still mark the conflict resolved?

I have thought that if there exist stage #0 in index, git simply _ignor=
es_
higher stages, so git-add simply adds stage #0 and does not delete high=
er
stages.

But I see that "git update-index --unresolve" (and its predecessor=20
"git-unresolve") simply recreate stages #2 and #3.


The documentation of "git update-index --unresolve" lacks this info,
and it doesn't tell one what it is for (see commit message for commit
ec16779 (Add git-unresolve <paths>..., 2006-04-19)).

--=20
Jakub Narebski
Poland
