From: tarmigan <tarmigan+lists@gmail.com>
Subject: Re: unpack a single object
Date: Tue, 11 Aug 2009 22:34:39 -0700
Message-ID: <905315640908112234y18463675ja35a5b5798793052@mail.gmail.com>
References: <905315640908111315j459b81f2jc414f2a09c6b830e@mail.gmail.com> 
	<3e8340490908111348o5df64aa1md1ad8901e857ecb6@mail.gmail.com> 
	<3e8340490908111349j323812dbmf2211e4cf454b8f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6UO-0005dc-Gy
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbZHLFe7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 01:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbZHLFe7
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:34:59 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:47876 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbZHLFe6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 01:34:58 -0400
Received: by yxe5 with SMTP id 5so5390301yxe.33
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=3gAIABOuuRPdUo8YY3t2rihYP4pwaqoJgQ3Oaz6jWjA=;
        b=EUOEZPv/+eaTwb3eqCOxEj58lsTRVaUgHVgebCoY7WJcJ5+yf5ziTM87dI5YesxN/B
         AUCHfEAlQC7evyEcqgw1u4Ef3W25R/DWnuPyKY2LZb+iK4mRNtRF3Hj0FG61AakHeVc5
         4ilxW2CYBfc5Tu3hpt4BTGSN/NBUYNJLLCD/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=SRwktXMUPMF6ejDMEB9ZImv3X3e526Y1gza1wrHX2URDLhmKZwV81bcwMPKt/vIuHT
         5gmARy0YKT6KIqaf8UEFK202a3BYg/mo/hxz5KuA/NO5LZuEVG64X3LiBO9twTIwftgK
         2D3fs1VUYA80ADMKDtL308mRr104sQsGrUJpY=
Received: by 10.100.5.12 with SMTP id 12mr6358962ane.69.1250055299068; Tue, 11 
	Aug 2009 22:34:59 -0700 (PDT)
In-Reply-To: <3e8340490908111349j323812dbmf2211e4cf454b8f1@mail.gmail.com>
X-Google-Sender-Auth: dd8f56e5553a13cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125670>

On Tue, Aug 11, 2009 at 1:49 PM, Bryan Donlan<bdonlan@gmail.com> wrote:
> On Tue, Aug 11, 2009 at 4:48 PM, Bryan Donlan<bdonlan@gmail.com> wrot=
e:
>> On Tue, Aug 11, 2009 at 4:15 PM, tarmigan<tarmigan+lists@gmail.com> =
wrote:
>>> I would rather not copy the whole good repo back to the one that ra=
n
>>> out of space because it's multiple gigs. =A0My plan is to just expl=
ode
>>> the bad pack on of the corrupted repo, explode good pack and then,
>>> copy the corrupted object back. =A0So my question is how do I tell =
which
>>> pack contains that object? =A0(I would rather not explode all the p=
acks
>>> because of the repo size.) =A0Is there a way to extract a single ob=
ject
>>> from a pack without exploding the whole pack?
>>
>> You should be able to just extract the single object in question:
>>
>> goodrepo$ git cat-file commit 3d4c2b0225e7605a7e2a38ffc44dcb888589f4=
ce
>> =A0> ~/commit.dat
>> goodrepo$ cd ~/badrepo
>> badrepo$ git read-file -t commit ~/commit.dat
>> (should output 3d4c2b0225e7605a7e2a38ffc44dcb888589f4ce)
>>
>> At this point your repo should be repaired.
>>
>
> Err, that should read git hash-object, not git read-file.
>

Thanks, and thanks to Junio who also responded with something similar
off-list.  I was vaguely familiar with cat-file and hash-object before
but didn't realize how they could be used to do what I wanted, so
thanks for the lesson.

As Junio suspected, I after the next fsck, I also had problems with
the tree associated with that commit and also the commits behind that
one.  Each fsck takes around 12 minutes, so replacing one commit at a
time seemed not very productive.  So now I am doing another svn clone
from scratch and letting it run for a few hours (it was a straight
mirror, so nothing is lost).  It seems somewhat wasteful, but I guess
better a few hours of cpu time than a few hours of my time.

Thanks,
Tarmigan
