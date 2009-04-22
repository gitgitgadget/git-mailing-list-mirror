From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: A system administration use case for git
Date: Wed, 22 Apr 2009 20:18:26 +1000
Message-ID: <2cfc40320904220318ra5e8fcbh863f9a4bf9c82443@mail.gmail.com>
References: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com>
	 <46a038f90904220148i23f1a75n7036d9726870d5f5@mail.gmail.com>
	 <2cfc40320904220208g5acc2200w6144668ba2da5a09@mail.gmail.com>
	 <2cfc40320904220222ub9b95f8o35afcddb0390fe1b@mail.gmail.com>
	 <46a038f90904220307h2ac16881qe29c77c5a0334160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 12:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwZYh-0006eM-PS
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 12:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbZDVKS3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 06:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbZDVKS3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 06:18:29 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:22355 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbZDVKS2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 06:18:28 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1401033yxj.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iYVq7ROXpfiktZgmGQzXeNcBb1tE8/F6XQgOY5V37mQ=;
        b=TLOz1RK1RXZB2dDFpJOh6QLYyhqGPlZpr+o3Yg3hhmcHseJAlt3Py/Ukw+y2aO3SXs
         gdY4VCW2dwgPr88CLPw9S9HZw9qLC59xvpNbWjJbTaFoR94hG/Kt6Fq0iBex2qAdaJDl
         PNHunqLPdi8DKJVkHJcrEThM8B9PHLIk2kb/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LDZ3S0wlwo2bb/BefDRXMaCA/U9ueaNaQ6SRbTNMApg7L6I/LfOtmxJ+CxHow++357
         5Gc4MPsqE3CSdy3r93qPdzM2bYeDucqLiZe9FM7PdOPbSksUa/8vAzE0RwOBTWMRLPao
         6JZ8f+H5342Q8EYOBc8kwwxpPBlJNWDE0RxGA=
Received: by 10.150.177.20 with SMTP id z20mr10319370ybe.213.1240395506141; 
	Wed, 22 Apr 2009 03:18:26 -0700 (PDT)
In-Reply-To: <46a038f90904220307h2ac16881qe29c77c5a0334160@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117188>

Martin,

Thanks for the info about hard-linked trees...they may well do exactly
what I need - thank you!

jon.

On Wed, Apr 22, 2009 at 8:07 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Wed, Apr 22, 2009 at 11:22 AM, Jon Seymour <jon.seymour@gmail.com>=
 wrote:
>> One disadvantage of that approach is if the file system is very larg=
e
>> and only has a few deltas, then I effectively have to have two copie=
s
>> of the reference file system - one in the GIT repo and one that I ca=
n
>
> You could minimise the on-disk footprint -- and protect it from
> concurrent access (concurrent change) by using a hardlinked tree on
> the destination side. rsync knows to break hardlinks, etc.
>
> Currently, you can't "rsync into git" which would save you that step.
> It's a ton of work to do that -- if anyone is planning on working on
> something like that, perhaps writing directly into the fast-import
> protocol is a good shortcut.
>
> I'd like to have something like that for my OLPC School Server, which
> could benefit from using git as the backup backend -- it currently
> uses hardlinked directories.
>
>> In an ideal world, storage requirements at the other place would be
>> those of the reference file system + those of the various deltas, bu=
t
>> no more.
>
> rsync + hardlinked trees + git gets you quite close to that.
>
> cheers,
>
>
>
> m
> --
> =A0martin.langhoff@gmail.com
> =A0martin@laptop.org -- School Server Architect
> =A0- ask interesting questions
> =A0- don't get distracted with shiny stuff =A0- working code first
> =A0- http://wiki.laptop.org/go/User:Martinlanghoff
>
