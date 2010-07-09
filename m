From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Handling tags/branches after git-svn fetch during SVN to Git 
	conversion
Date: Thu, 8 Jul 2010 20:09:01 -0700
Message-ID: <AANLkTilNLjTn1FyRqqz5xmOi4rOnSIwMUy6dOb0c0sRt@mail.gmail.com>
References: <AANLkTim56UOYQJfX3M5Jpt0vXD8iTnkLuG68IjQG39Xn@mail.gmail.com> 
	<AANLkTinAhxIKD6U3u4OpPnt5kDMPGTyhDhhCRaFtU-gA@mail.gmail.com> 
	<AANLkTilnoIyrKg4PLSL71RDU-vyvIeNEtJ8STkOd9Lcq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 05:09:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX3xw-0008D4-BD
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 05:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab0GIDJX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 23:09:23 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45244 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0GIDJW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 23:09:22 -0400
Received: by qyk38 with SMTP id 38so3020079qyk.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 20:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IDVwJzE7WK04JJx/yevMJWNmaUG9KIX+npqdU+SntLk=;
        b=ciRZ8HQheVZEWIyYbc1jgS0x+swTQRiV+ZzqqpoEcNwlUfncmg82UyNYyL+cXlG/Fd
         2GeoJlpYDHdnQxi9JXtp5MPY0Crx+CqcBVmEQoiCBVe0NZbsgKCcAhWMdN870RdOOB2S
         TO1RGx4sfNI3rdWc5bOwWfu8i3ic9NsKpDC8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=t08Z4gxxlpLMKulamcYqG1Ys9vNpbgBli++aXn0GpfuFVIrPbdgw/ACBOJpnFEHEzK
         NcqSBcd11g7Ef5nawNHYGPjcA9cDcqccGY2f84D1x9qMQM1XGkZNAnYlCcp3q3RCt382
         vOvyjrop4MqWP1JiVwshuYMeVQzl7yqUSVM4c=
Received: by 10.224.35.232 with SMTP id q40mr490231qad.107.1278644961352; Thu, 
	08 Jul 2010 20:09:21 -0700 (PDT)
Received: by 10.229.25.4 with HTTP; Thu, 8 Jul 2010 20:09:01 -0700 (PDT)
In-Reply-To: <AANLkTilnoIyrKg4PLSL71RDU-vyvIeNEtJ8STkOd9Lcq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150634>

remote2 would be the name of your remote repo, yes.

origin/branch-foo would be equivalent to svn/branch-foo in your local
repo, if you did "git branch -a".  It should be the name of one of the
git-svn created branches.

refs/heads/branch-foo is telling git where to store the reference for
the branch within remote2.  It does not need to exist already, and
should not in your case.

The git-push man page has more in-depth explanations, if you're interes=
ted.

On Thu, Jul 8, 2010 at 20:01, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> In your example, does "remote2" represent the name of my remote Git
> repo? What is "origin/branch-foo" and does the path
> "refs/heads/branch-foo" need to actually exist in my .git directory?
>
> On Thu, Jul 8, 2010 at 10:54 PM, Jacob Helwig <jacob.helwig@gmail.com=
> wrote:
>> On Wed, Jul 7, 2010 at 06:36, Bradley Wagner
>> <bradley.wagner@hannonhill.com> wrote:
>>> Do I need to convert these remote tags/branches into local Git
>>> tags/branches before pushing them to my remote Git repo or is there=
 a
>>> way to push remote branches directly to my remote Git repo?
>>>
>>
>> You don't need to "convert" the branches to local ones. =C2=A0git-pu=
sh will
>> accept any ref your local repo knows about when you do a push. =C2=A0=
=46or
>> example "git push remote2 origin/branch-foo:refs/heads/branch-foo"
>> works just fine, even if you don't have a "local" branch called
>> "branch-foo", and it will push the branch-foo branch out to the
>> remote2 remote repository.
>>
>> The tags, you'll need to convert to _actual_ tags, instead of just
>> branches under a tags/ namespace. =C2=A0Unless you're fine with them
>> staying as pseudo-tags, then you can just push them out as you would
>> any other branch.
>>
>> -Jacob
>>
>
>
>
> --
> Hannon Hill - Put Us to the Test
> bradley.wagner@hannonhill.com | http://www.hannonhill.com
>
