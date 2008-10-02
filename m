From: "Klas Lindberg" <klas.lindberg@gmail.com>
Subject: Re: How to remove a commit object?
Date: Thu, 2 Oct 2008 16:52:57 +0200
Message-ID: <33f4f4d70810020752g4738fee3p4e99ab417d97106a@mail.gmail.com>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>
	 <48D36DF4.3030607@drmicha.warpmail.net>
	 <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>
	 <m3ljx7qemk.fsf@localhost.localdomain>
	 <33f4f4d70810020726g71c6f39eq16585269fb268322@mail.gmail.com>
	 <48E4DB21.7020304@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Git Users List" <git@vger.kernel.org>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:56:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPZC-0003Ns-GC
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbYJBOxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYJBOxA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:53:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:61921 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbYJBOw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:52:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so435147nfc.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=m6syMciufiUOJZ+fnlRio4Xiq34vuKGTn1DmTevIttk=;
        b=SYITGzsuPvxgGB5aUfmGlZAIVLC7PQ4L3gc2WeUaXRKcP9rWMc13t+R9ksQhi6gcOK
         YBD49z3YkvFqhpOhwjuZlSc5Q14xszNx2D08Bb0Dh79ckeZPIu4BJN8qqUe0vmFFFNPb
         tAkgNufENVT2+xHpMO15KBKWv6zO/fvXRS14w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oxQvX7lTEOmCN0zJwWx54WCBBISrIJYEU3yU6RfZMKvPXVKixoG0P+x0Mkq1IrfUde
         yzMDw44WB6v6hbsJHjgPcRenanvr0fwNV20oX2S+NVqVNCiF0hY0hDnenCkj+Y1wzOXZ
         xhXc8GKEu4v7VxdU2xrKcL+81V4lvjmrcGsvA=
Received: by 10.86.27.9 with SMTP id a9mr8772400fga.57.1222959177102;
        Thu, 02 Oct 2008 07:52:57 -0700 (PDT)
Received: by 10.86.84.16 with HTTP; Thu, 2 Oct 2008 07:52:57 -0700 (PDT)
In-Reply-To: <48E4DB21.7020304@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97348>

What I really want is to remove files, but when filter-branch didn't
seem to do what I wanted, I turned to the idea of rewriting single
commits to not include the files in question.

This is what I tried with filter-branch: gitk --all shows about 170
commits on directory D in the repo. Of these, maybe 10 don't lead to
HEAD, but dangle off the main track. As a test, I decided to let
filter-branch create a new repo that only contained the contents of
subdirectory B. So I ran

    git-filter-branch --subdirectory-filter B -- --all

and now the resulting repo has just 14 commits. This is clearly not
what I wanted because a lot of the original history for subdirectory B
is just missing.

Actually, in this particular case I get the exact same result with

    git-filter-branch --subdirectory-filter B HEAD

BR / Klas

On Thu, Oct 2, 2008 at 4:30 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Klas Lindberg venit, vidit, dixit 02.10.2008 16:26:
>> Repo size is a problem too, actually.
>>
>> A solution to both problems seemed to be to use git-filter-branch to
>> create a new repo by filtering out all the unwanted files. The
>> astonishing result was that, for the subdirectory I tried it on, 90%
>> or so of the commits on that subdirectory just disappeared. It didn't
>> look right at all. Although I can't say for sure exactly what I did
>> with filter-branch, I would appreciate some guidance for using it. It
>
> I don't know about others, but I would appreciate more info:
> Do you want to remove commits (as stated earlier) or files (as stated here)?
> What are the boundary conditions? Rewriting history seems to be OK now.
>
>> basically seemed to do exactly what I wanted (recreate the repo, minus
>> some explicit stuff, with history intact otherwise), except the result
>> looked crazy.
>
> That may be due to the filter-branch incarnation, i.e. which refs did
> you rewrite (--all or HEAD)?
>
> Michael
>
