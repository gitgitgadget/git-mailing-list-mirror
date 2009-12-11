From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 12:20:40 +0100
Message-ID: <200912111220.40844.jnareb@gmail.com>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com> <200912110233.18756.jnareb@gmail.com> <4B222289.6000004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 12:19:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ3Wy-00042d-GV
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 12:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980AbZLKLTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 06:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757302AbZLKLTN
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 06:19:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:8841 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970AbZLKLTM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 06:19:12 -0500
Received: by fg-out-1718.google.com with SMTP id 19so450259fgg.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 03:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Unnadeppg1w1lvtfI4tF+N89LGNUaTMVZLLisb2OWsQ=;
        b=Jd1QbyQhKcMovWdJ25jZ4vqNRQ7TRmrkncyLvEhPI0lZya91u6BEFWWRAvp08yqWzn
         EOOz5Y8EN2nHCe/gzMGGv/spPXMDZzojIDnYsDe2QqLqa67J8RL2JpiT2gDxmb+rylFc
         l5ECWjgshRc1Y+kOLrJOiJ2k13xjv8SD/tkSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oiM+W8UWSz06D6A1E47iHBwxZfUdE/mj9XySYCcSXlPs//3bsiuehvF7X7qZyDUCIo
         KoZ/WWIrkg3iG11A7mQ63OGBz/76rM1Z9fhrSHh/PnckVMIGeiub9YAvtNLVHzrsppF3
         F3H4X6Nh4VGB3aLOyZOy7jQhIlmp45Ziua7+o=
Received: by 10.103.84.15 with SMTP id m15mr473153mul.105.1260530357900;
        Fri, 11 Dec 2009 03:19:17 -0800 (PST)
Received: from ?192.168.1.13? (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id i5sm4621077mue.57.2009.12.11.03.19.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 03:19:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B222289.6000004@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135080>

Dnia pi=B1tek 11. grudnia 2009 11:44, Michael J Gruber napisa=B3:
> Jakub Narebski venit, vidit, dixit 11.12.2009 02:33:
>> Dnia pi=B1tek 11. grudnia 2009 02:11, Junio C Hamano napisa=B3:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>>>   --unresolve::
>>>>         Restores the 'unmerged' or 'needs updating' state of a
>>>>         file during a merge if it was cleared by accident.
>>>>
>>>> Unless "git add foo" not only adds current contents of foo at stag=
e 0,
>>>> but also removes higher stages from index...
>>>
>>> By definition, adding anything at stage #0 is to remove higher stag=
es.
>>=20
>> Hmmm... let's test it:
>>=20
>>  $ git merge side-branch=20
>>  Auto-merging foo
>>  CONFLICT (content): Merge conflict in foo
>>  Automatic merge failed; fix conflicts and then commit the result.
>>  $ git ls-files --stage
>>  100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
>>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>>  $ <edit foo>
>>  $ git add foo
>>  $ git ls-files --stage
>>  100644 a1b58d38ffa61e8e99b7cb95cdf540aedf2a96b3 0       foo

I thought that "git add foo" only adds current contents of foo in stage=
 0,
and does not delete other stages.
=20
Unless "git add foo" does more than "git update-index foo" does here.

>> Now let's test '--unresolve' option of git-update-index:
>>=20
>>  $ git update-index --unresolve foo
>>  $ git ls-files --stage foo
>>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>>=20
>> WTF? What happened to stage 1 (ancestor)?
>=20
> 2 and 3 are easy (cheap) to recreate from HEAD and MERGE_HEAD, 1 is n=
ot.
> I guess that's why --unresolve doesn't even attempt to do anything wi=
th 1.

But then "git update-index --unresolve <file>" is next to useless.

>>=20
>>  $ git checkout --conflict=3Dmerge foo
>>  error: path 'foo' does not have all three versions
>>=20
>> Let's recover it by hand:
>>=20
>>  $ echo -e "100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1\tfoo" =
|=20
>>    git update-index --index-info
>>  $ git ls-files --stage foo
>>  100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
>>  100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
>>  100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
>>  $ git checkout --conflict=3Dmerge foo
>=20
> Yeah, if we knew that sha1...

Isn't it:

  $ git ls-tree $(git merge-base HEAD MERGE_HEAD) -- foo

or

  $ git rev-parse "$(git merge-base HEAD MERGE_HEAD):foo"

--=20
Jakub Narebski
Poland
