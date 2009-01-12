From: "Chris Packham" <judge.packham@gmail.com>
Subject: Re: Removing a commit from a local branch
Date: Mon, 12 Jan 2009 13:12:32 +1300
Message-ID: <a038bef50901111612v44a18cc2v1c66dd537b07715f@mail.gmail.com>
References: <a038bef50901111441w21959397tc41922656a25027c@mail.gmail.com>
	 <a038bef50901111442y16695664y4fed7cdd9d8af27@mail.gmail.com>
	 <20090111225220.GB15533@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 12 01:14:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMARK-00053r-Qk
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 01:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbZALAMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 19:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZALAMe
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 19:12:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:30988 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbZALAMd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jan 2009 19:12:33 -0500
Received: by rv-out-0506.google.com with SMTP id k40so9974662rvb.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 16:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AdiFr7OR6E2Ss75ZjuoMiyYurii6+S4aVEchLx/Ia9w=;
        b=qNzNWgD8QmIDVb6/IbHxUKtVwJTnYj87wuRr/+/RNz9SIca1gQuNcWvEgPmucQsje0
         iVyE/X9y+GQFUB7UQy8jw6KPcDJ3kenk/dURfHMsi03viVfnsyp3BbYezHWOUAmqm6gR
         XbVF/afS6HI8RBguFOV3HUq8XXHIC2ygwbPdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tN+S5Nxr9AqQQ04A0Dj8XJa6l5arZiukhQu212OYJfchxKPse1yIXeV3VQ3zKpoejj
         oO83hw3KkSOYiuPcuMhVOPYjiKVkvh39BFy4sQYmpdl6LJrtzZQhuLMqQ5l1zCcNmVdu
         OEZ7QCeUVDafkzecJEW6amIlWfTizXFso6trU=
Received: by 10.115.110.1 with SMTP id n1mr18674547wam.99.1231719152653;
        Sun, 11 Jan 2009 16:12:32 -0800 (PST)
Received: by 10.114.109.7 with HTTP; Sun, 11 Jan 2009 16:12:32 -0800 (PST)
In-Reply-To: <20090111225220.GB15533@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105259>

Thanks thats exactly what I was after.

On Mon, Jan 12, 2009 at 11:52 AM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.=
de> wrote:
> On 2009.01.12 11:42:24 +1300, Chris Packham wrote:
>> Hi List,
>>
>> I'm part of a development team using git. We use a maintainer model
>> where developers send patches/pull requests to a maintainer who
>> applies the patches to a local branch, decides if they're good or no=
t
>> and pushes the good patches to the public repository.
>>
>> What I want to do is script the removal of a bad patch so that the
>> maintainer identifies a patch in his local branch, sends an email to
>> the author telling them why their patch is being rejected then remov=
es
>> the commit for that patch. Using git log a script can extract the
>> author email address, hash and headline of each commit. Based on tha=
t
>> information scripting the email is easy enough. Now I come to using
>> git rebase to remove the bad commit based on its hash which leads me
>> to my question - How do I refer to a commit based on the hash of its
>> parent?
>>
>> Consider the following example. The maintainer has the following bra=
nch locally
>>
>>   todeliver: A-B-C-D
>>
>> He is happy with commits A, C and D but wants to reject B. Ideally I
>> want to be able to say
>>   git rebase --onto <parent of B> <child of B> todelvier
>
> You don't want <child of B> there, just B.
>
> git rebase --onto <onto> <upstream> <branch>
>
> Rebases the commits from the range <upstream>..<branch>, and that
> _excludes_ the commit (referenced by) <upstream>.
>
> So:
> git rebase --onto B^ B todeliver
>
> Works on: B..todeliver =3D=3D todeliver --not B
> And that range contains commits C and D.
>
> Bj=F6rn
>
