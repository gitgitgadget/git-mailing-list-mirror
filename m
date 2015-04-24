From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: git-completion.tcsh
Date: Fri, 24 Apr 2015 10:37:21 -0400
Message-ID: <CAFj1UpHWhjx5O_ApO8+TRMj+t2tmn45-k1wemSc4um=k9oOyNg@mail.gmail.com>
References: <20150401115519.Horde.JM0TEyhacRn5LYAEffMggQ1@webmail.informatik.kit.edu>
	<481BCBD7-457B-4AFB-B878-1417C8C5940C@gmail.com>
	<CAFj1UpHBk1JFmSv4T=wQUNiade9ZW8yiaco9z2-wGJh7yXATuA@mail.gmail.com>
	<20150424133028.Horde.fL7zuT7X5Dj99hzpmme9Hw1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Perry Rajnovic <perry.rajnovic@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 16:37:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlejP-0002PK-UN
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 16:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbbDXOhX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2015 10:37:23 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35469 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbbDXOhW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 10:37:22 -0400
Received: by widdi4 with SMTP id di4so24623093wid.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3YSQMCSiUSapg2faR2FjIPxmkQrpepIrM0JTHTxqgDQ=;
        b=FNeVu5zwl1o0uBs1zAFqkLvyNIl5e7XkvCd8ZEVuAKRBLJKm4mZPapi2j313c7NLa1
         9I9EStFyS68MRze+OVcl3iiS7WAui0p/vD8guADAnaiNEf5eaKI3FrU1qnLfZxSLM6zP
         M29E1fvkzX4tDT1EAF72i7DGI/Pkjm7EeYgso12wFBHizX5LCnsMX/uw+G+OLeglJbBt
         fkYghfhtVP+pVtHQ7ZxBZGGI1/SvrYLCz0ONe34joJA+zAZTUF25gkeQJQNCPkbm2BEf
         BdKMt9Zx3wEFhku34venqkpOgWkDGRMUOTXKP7SgmTnclrcud8c5XsPU0abehI4OS+dI
         kmoA==
X-Received: by 10.180.77.83 with SMTP id q19mr4329840wiw.89.1429886241155;
 Fri, 24 Apr 2015 07:37:21 -0700 (PDT)
Received: by 10.28.176.5 with HTTP; Fri, 24 Apr 2015 07:37:21 -0700 (PDT)
In-Reply-To: <20150424133028.Horde.fL7zuT7X5Dj99hzpmme9Hw1@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267741>

On Fri, Apr 24, 2015 at 7:30 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Hi,
>
> Quoting Marc Khouzam <marc.khouzam@gmail.com>:
>>
>> Hi,
>>
>> I did notice the problem a while ago and had traced it back to the
>> fact that the bash completion scripts no longer adds the trailing '/=
'
>> at the end of directories.
>> Tcsh needs that '/' to know not to add that annoying extra space.
>>
>> Bash 3 needed to put it that trailing '/' but bash 4 did not.  Two
>> years ago (!) changes were made in commit
>> 3ffa4df4b2a26768938fc6bf1ed0640885b2bdf1 to allow bash 3 to work
>> without the trailing '/'.  That caused
>> the problem in the tcsh script.
>>
>> The thing is that with master of today, I don't see the problem any
>> more.  I can't tell you when it started working again.
>> What is interesting is that the reason it now works is that the
>> git-completion.bash script no longer returns anything
>> for the case you mention:
>>   git add f<tab>
>> Instead, it seems to rely on file completion only.
>
>
> I can't reproduce it with git-completion.bash from current master on =
its own
> on with bash 3.1.20(4) from MSysGit, it seems to work as intended her=
e wrt
> tracked-file-aware file completion.
>
> Set up test repo with these commands:
>
>   git init
>   >tracked
>   git add tracked
>   >non-tracked
>   mkdir -p foo/bar
>   >foo/bar/somefile.c
>
> Now let's see what happens with 'git add':
>
>   $ git add <TAB>
>   foo/         non-tracked
>
> Note, that the file 'tracked' is not offered, so this is clearly not
> standard bash file completion, but our completion script.  Also note =
the
> trailing '/' in 'foo/'.
>
>   $ git add f<TAB>
>
> Just completes to 'git add foo/', no space after '/'.
> Add the file:
>
>   $ git add foo/bar/somefile.c
>
> Now let's see 'git rm':
>
>   $ git rm <TAB>
>   foo/     tracked
>
> Note, that the file 'non-tracked' is not offered, so again this comes=
 from
> our bash completion script.
>
> Did you test the bash completion script on its own, or only through t=
he tcsh
> wrapper?
> I'm on MSysGit now, so no tcsh or bash v4 at hand, and no time either=
, so
> can't dig further at the moment.
>

Thanks G=C3=A1bor, I can see the behaviour you describe now.  I was run=
ning
the new bash completion with an old git and that had an impact.
With a recent git installation I can see the problem, which includes
that with tcsh, the / at the end of foo is missing.
I had a patch for that a while ago that I can revive and post soon.

Thanks again!

Marc
