From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: Duplicating a branch
Date: Tue, 2 Jun 2009 17:50:09 +0100
Message-ID: <70411981D37A4F2ABF5D0A9CF24E6884@HPLAPTOP>
References: <BAF61FDE71D344FDB9F1415B5E2AFD75@HPLAPTOP> <7voct6fy1e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 18:50:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBXBx-0008AT-PI
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 18:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbZFBQuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 12:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbZFBQuP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 12:50:15 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:32949 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbZFBQuN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 12:50:13 -0400
Received: by fxm12 with SMTP id 12so6656333fxm.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:references
         :subject:date:mime-version:content-type:content-transfer-encoding
         :x-priority:x-msmail-priority:x-mailer:x-mimeole;
        bh=PR/CUI0s7t48mq/BNjsP5RTQWbZmQo+oYPY9mJL1e0g=;
        b=gvZDXhy2DL4UOJPvdyYM9soaX218BPio+Mq2HJ22opkCWzF1aAVNGpKob3b3DjNRsH
         ivcGnKMnOcCCIxIKfpQ0xhn1wfzVfoDgfvut912j8q20F8Raq0a7L7Ug9YlL835Gplqr
         OnOVEz86TuuLvUOixhGwb5t2iD6y0epaj/qao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=gGpKO9an6cDSBwl8nJb9ZWWNGPV5+/ZuxbqvtGBV4ggAED5l0X0+pMuKdkVFN4/hzR
         R3MA6GS+0i+Krf0uDj2a/na+fV1jTLpW3OrhurPmeIVZYP5mV4m8YNH52KzcyJVKBIrY
         90TxkVtp5DphKj4tneyARQ/bRSoNRML3Porho=
Received: by 10.86.59.18 with SMTP id h18mr8016681fga.71.1243961414087;
        Tue, 02 Jun 2009 09:50:14 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id e20sm11943697fga.25.2009.06.02.09.50.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 09:50:13 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120528>

Nice expanation and mini tutoial Junio !

Thanks ever so much, very useful.

Aaron

> "Aaron Gray" <aaronngray.lists@googlemail.com> writes:
>
>> How do I go about duplicating a branch within a repository, so I can
>> make test mods ?
>
> Run
>
>    $ git checkout -b experiment master
>
> to make a new "experiment" branch that points at the same comit as
> "master" (or whatever other branch), hack away (including committing which
> would grow the history of "experiment" branch without touching "master").
>
> After you are done, and if you want to discard it, simply:
>
>    $ git checkout master
>    $ git branch -D experiment
>
> or if you want to keep all of it:
>
>    $ git checkout master
>    $ git merge experiment
>
> *BUT* if your "experiment" was truly exploratory in the sense that your
> history is full of "let's try this, commit to snapshot, test, oops, it did
> not work, let's try that, commit to snapshot, test, ok, I made some
> progress, let's continue" crufts, you would most likely want to clean-up
> your history before the latter "checkout master and merge experiment into
> it" steps with something like:
>
>    $ git rebase -i master experiment
>
> If you in advance know that what you are going to do is truly "throw-away
> experiment", you do not even need to use an "experiment" branch.  You can
> do your exploration while on a detached HEAD:
>
>    $ git checkout master^0
>
> and hack away, including making commits (but you will discard them in
> the end), and then finally:
>
>    $ git reset --hard ;# if you have local changes you do not want to
>   take back to master
>    $ git checkout master
>
>
>
> 
