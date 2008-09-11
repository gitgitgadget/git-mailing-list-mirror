From: "Changsheng Jiang" <jiangzuoyan@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Thu, 11 Sep 2008 14:05:49 +0800
Message-ID: <eafc0afe0809102305u6de85ef3ib2c08004dea8d6f9@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
	 <279b37b20809101946k309ad113neb7d051f1c6c410e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 08:07:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdfKW-000497-4s
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 08:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbYIKGFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 02:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbYIKGFw
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 02:05:52 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:31861 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbYIKGFv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 02:05:51 -0400
Received: by ti-out-0910.google.com with SMTP id b6so127599tic.23
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 23:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vdtqRx0p/myak2wVlFtBvjLdepZGSXPSgiHZFuI5tJI=;
        b=Ga1ChTU91pqojlyRfAv5Dxpzav/eABdCh7UfAeOjeyN+jXcSg+eOpgj8ShQltgrGtX
         7u7xgSyQNuS/vZZ77XGhYaW2TCatBZPYZnfbtzzRjyQo83J1JfYm4RMauJAXgfhgtylg
         kwzybF9Z2Fj4PF3ASgDwTo1lBE/aqyaW6YKBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uuN02yfM4hU1H4biAbHlwN8qI0qKR/ZXFRyGY1TRA2DTK+gv3LDy2PJri61eJpPi6z
         DCUDsiaZG0/K/PMAAWpty/LF6Ohg0bTl8MH1qQ7OxPO1qd175C0xiZ7GiNFHEtko/+2y
         mfTIYxA2hK73s1dw43eLoeGdRIy7wjye1wRuw=
Received: by 10.110.28.15 with SMTP id b15mr2865432tib.26.1221113149281;
        Wed, 10 Sep 2008 23:05:49 -0700 (PDT)
Received: by 10.110.37.16 with HTTP; Wed, 10 Sep 2008 23:05:49 -0700 (PDT)
In-Reply-To: <279b37b20809101946k309ad113neb7d051f1c6c410e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95582>

I don't know what version of you git, my git with version 1.5.4.5
doesn't delete the file file42 after git-reset.

BTW, if you added the file42 to .gitignore, why git-status still
reported "new file" file42"?

Yours sincerely,
Changsheng Jiang
pubkey: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x40C37374



On Thu, Sep 11, 2008 at 10:46, Eric Raible <raible@gmail.com> wrote:
> On Wed, Sep 10, 2008 at 7:12 PM, Changsheng Jiang <jiangzuoyan@gmail.com> wrote:
>> I think the current behavior is better than you described. If you want to
>> ignore some files, you can added it to the exclude file. All files not
>> excluded in the repo directory is maintained by git.
>
> That doesn't really address the problem.  This is an
> updated example that specifically ignores the file:
>
> # Create a single commit in a new repo (so that we have a HEAD)
> mkdir xx
> cd xx
> git init
> git commit --allow-empty -m"initial"
> # Add an important file
> echo "Important stuff" > file42
> git add file42
> echo file42 > .gitignore
> git status # -> new file:   file42
> ls # -> file42, or course
> git reset --hard
> ls # -> nothing
>
> So not only was file42 never actually tracked by git
> (IMHO - I realize that this is debatable) but it was also
> specifically ignored, and it is _still_ deleted w/out a trace!
>
> I realize that "git reset" will simply unstage the new file
> in either case (w or w/out .gitignore), but the consequences
> of an accidental "git reset --hard" are pretty severe in this
> case.  This behavior seems definitely contrary to Linus's
> explanation:
>
>   And "git reset" won't be deleting files it doesn't track (it had _better_
>   not touch them), even more so when it has been told to ignore them, so it
>   makes total sense to _not_ delete them when doing that reset.
>
> - Eric
>
