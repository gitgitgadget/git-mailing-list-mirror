From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain]
Date: Tue, 9 Sep 2008 17:50:47 -0400
Message-ID: <e06498070809091450y3bb7ba1cs8b86ea31b4e37bd8@mail.gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
	 <200809091538.13961.jnareb@gmail.com>
	 <5d46db230809090937k44fc569ct7eda35b9ee86cb22@mail.gmail.com>
	 <e06498070809091029j1e450c43i276c5a69376da3ab@mail.gmail.com>
	 <51419b2c0809091319j2f29b6e1n752cba305c7c1cf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Govind Salinas" <govind@sophiasuchtig.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:51:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdB7u-0005UY-4P
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbYIIVuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbYIIVuu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:50:50 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:54996 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYIIVut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:50:49 -0400
Received: by yw-out-2324.google.com with SMTP id 9so320194ywe.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=q0VVvJgtge3NqeIs7L44ZKm4QX+u61ynazTi38pttsM=;
        b=Be8xtTnNGauuM3FmXcUg9NGcMtdbt3s6/zLrurO3Y6dHtUUBgM+XMSv/Sr6+cXIRyo
         u2jEEG5c82vPYB7wKtRZ6YYyMNUW60yvFH3DOc4y6hTB+CzoBVQR2+TitWpURT3Po0ws
         srbDqZnaAhlpnpHU9SI1dpRikMiy0abbS9Mzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Dn8ICfTGxq9Ax+iImO/+E8mhVuQubo4Rc9L8mIiWMTV/noVP7tGHJN7QrMsGHrdLVE
         SzHwxw3hk2Lj/q30gRmWjO8U3GYeEPQWyXQLbugqi6JtPDpNFLPGQmkFE3yqIs6rEE3l
         Qi1VID5wbsV9vuAzaGhAXUti4N4lH+/Ng72jA=
Received: by 10.90.100.17 with SMTP id x17mr305498agb.89.1220997047788;
        Tue, 09 Sep 2008 14:50:47 -0700 (PDT)
Received: by 10.90.25.17 with HTTP; Tue, 9 Sep 2008 14:50:47 -0700 (PDT)
In-Reply-To: <51419b2c0809091319j2f29b6e1n752cba305c7c1cf6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95445>

On Tue, Sep 9, 2008 at 4:19 PM, Elijah Newren <newren@gmail.com> wrote:
>> I tend to dislike "DWIM" in interfaces, because the computer cannot
>> read your mind, and can therefore never know with certainty what I
>> mean.  Especially in cases where the computer thinks I intend to
>> perform an irreversible operation, I want the computer to ask first.
>> Not only that, but I think having one command that does 10 different
>> things is as confusing as 10 commands that each do one thing.  My
>
> How are these things really different, though?  People occasionally
> want to "revert changes".  Now, this may be the changes between 32 and
> 29 revisions ago, it might be all changes since the last commit, it
> could be the changes since 3 commits ago, or it could be just one
> specific commit.  The user may want to subset such reversions to just
> specific files, but it all boils down to "reverting changes" in the
> end.  Now, eg can't yet handle a range like between 32 and 29
> revisions ago (because I wasn't sure what syntax I'd want to use for
> it), but it's fairly straightforward to say any of:
>
>  eg revert --since HEAD~3  # Undo all changes since HEAD~3
>  eg revert --in HEAD~8     # much like git revert HEAD~8, but no
> commit by default
>  eg revert --since HEAD foo.py  # Undo changes to foo.py since last commit
>  eg revert foo.py               # Same as above
>  eg revert --in trial~7 bar.c baz.  # Undo changes made in trial~7 to bar.[ch]
[...]
> Are these kinds of "reverting data" really so different that there
> should need to be different commands, or that some of these operations
> shouldn't be supported by the simple revert command?  Sure, most users
> most of the time will probably use the "eg revert FILE1 FILE2..."
> form, but I didn't see the harm in supporting the extra capabilities.

The harm I see in trying to support every possible use case is that it
makes it exponentially more difficult to fully understand the tool.
Using yap as an example, I think it should be easy enough for a user
to read the help blurb for every command and understand what it does
and when to use it (this is easy for me to say as the author, but I
think it would hold true for a "typical SCM user.")   Having a mode
the seems to act like another SCM (revert --since) seems great at
first blush.  The user will see that and think, "Wonderful, this will
work just like svn and I don't have to think about it."  As I mention
in another email, that's all well and good until the user runs "git
diff" and makes a liar of you.  In svn, there would be no diff,
because the files all match their respective upstream versions.  In
git, you would see changes because the file no longer matches the last
commit.  Now your user is confused because his mental model was
violated.

Obviously, there is a trade-off here between power and usability.  As
shown by the Hole Hawg[1], there is a limit to the amount of power it
is useful for the average user to have.  The git community has already
admitted this by dividing the git command set into two classes:
plumbing, and porcelain.  "The plumbing," you say, "is very powerful,
but you shouldn't have to use it."  My contention is that there is a
class of users that is not well served by the current definition of
porcelain.  It is that class of users that I have tried to target with
yap.

[1] http://www.cryptonomicon.com/beginning.html
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
