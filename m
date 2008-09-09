From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain]
Date: Tue, 9 Sep 2008 13:29:10 -0400
Message-ID: <e06498070809091029j1e450c43i276c5a69376da3ab@mail.gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
	 <200809091538.13961.jnareb@gmail.com>
	 <5d46db230809090937k44fc569ct7eda35b9ee86cb22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Elijah Newren" <newren@gmail.com>, git@vger.kernel.org
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:30:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd732-000650-0R
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 19:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbYIIR3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 13:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbYIIR3N
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 13:29:13 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:38787 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYIIR3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 13:29:12 -0400
Received: by gxk9 with SMTP id 9so11166995gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iD+/f5Y/9B+2iVZ3tE9Av6XLkBeMCOLTNwtI7ErsQ+c=;
        b=Qk5kN4U9ytXswp2aZAlCA7EVdulNKTEnGNDBoylnOP/5nBMz7NgcCmqdgQScmkVg+b
         BJYXRIx73cFH5Xgu9P90tSa6MaLjS7znecGIXMczLH8Io4gRlYYfeF+CgPmWb0LS3mMq
         7moHQOkHNWqPdm0TWkaR4mJZtAsHUPJnIrLoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Iu/5TSJBN6ukYToNWK8lO9ihyk2oo//UQ7epQfraDTTjtxATbAuez0vj8t6nYJ1U6u
         VjZk6Qy3lyLxfUkOG27uVh/3tJprYoHTz7kKLYMRP5JXRyXbVmVzkT/zkpKTQLFS0465
         LG0jSh+57seu02wacvEcpm8/24uebMAdfo8LU=
Received: by 10.90.114.19 with SMTP id m19mr21311014agc.61.1220981350593;
        Tue, 09 Sep 2008 10:29:10 -0700 (PDT)
Received: by 10.90.25.17 with HTTP; Tue, 9 Sep 2008 10:29:10 -0700 (PDT)
In-Reply-To: <5d46db230809090937k44fc569ct7eda35b9ee86cb22@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95407>

On Tue, Sep 9, 2008 at 12:37 PM, Govind Salinas
<govind@sophiasuchtig.com> wrote:
> My take on this comes from my own personal experience with "revert"
> commands, the fact that "how do i undo my working dir changes" is
> the most common question I see on the list and that I have heard
> others with the same complaint.
>
> I will concede that revert usually means both "discard current working
> dir changes" and "undo a previous change" in different circumstances.
> However, the number of times that "how do i discard my working
> dir changes" comes up on the list leads me to believe that you get
> the most out of using revert for this, since it is something that should
> be familiar to a user and undoing a previous commit is more rare.
>
> Of course, this is where I would use a DWIM-ism.
> "pyt revert -r commitish" would generate a reverse patch but
> "pyt revert <paths>..." would checkout from HEAD.  "pyt revert" would
> just "git reset --hard".

In yap, "revert" is used to discard working copy changes.  "revert -a"
reverts all changes; just "revert" replies "nothing to do."  Having
"pyt revert" = "git reset --hard" makes me queasy; especially in
Dvorak it's all too easy to hit Enter when reaching for '/'; seems
like a catastrophe waiting to happen.

I tend to dislike "DWIM" in interfaces, because the computer cannot
read your mind, and can therefore never know with certainty what I
mean.  Especially in cases where the computer thinks I intend to
perform an irreversible operation, I want the computer to ask first.
Not only that, but I think having one command that does 10 different
things is as confusing as 10 commands that each do one thing.  My
philosophy has been to identify frequent operations and give them
sensible commands, rather than overloading a handful of operations or
requiring multiple commands for common tasks.  My philosophy has also
been not to wrap every command.  If a user were to ask me, "I want to
bisect a changeset," my response would be "okay, use git bisect."  If
the user wants such a specialized command as that, then they shouldn't
have trouble with dealing directly with git for that operation.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
