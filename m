X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 09:59:17 +0000
Message-ID: <200612140959.19209.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 09:59:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VcJ/XtfEHgCNO0WhWUudBA8uJpveXT/olAMhqntZiZHfNBlBvoXnLBXaLxwTzYyvR2sKXYLKTxEsmfABCUZ5bOvaB6gjgwbhRjrTHxPVDAFS6dLAbKv6YSYesIsDPVeOsUnHaOdsN0W6y7iX4jYrpYEFxUF1SlNy6CModE2GsYc=
User-Agent: KMail/1.9.5
In-Reply-To: <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34295>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GunNA-00025j-LZ for gcvg-git@gmane.org; Thu, 14 Dec
 2006 10:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932263AbWLNJ7Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 04:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWLNJ7Z
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 04:59:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:23261 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932263AbWLNJ7Y (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 04:59:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so445198uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 01:59:23 -0800 (PST)
Received: by 10.67.117.18 with SMTP id u18mr1116218ugm.1166090363554; Thu, 14
 Dec 2006 01:59:23 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id s1sm1813831uge.2006.12.14.01.59.22; Thu, 14 Dec 2006 01:59:23 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 13 23:31, Junio C Hamano wrote:

> I am moderately against making a command verbosely report when

I'm not sure "verbose" is the word for one extra line of output:

$ git commit
Revision XXXXXXXXXXXXXXXXXX successfully added.

I'd actually argue that git-commit is a particular problem because it's too 
fast.  You quit editing your commit message and bang, you're back at the 
command line.  Then you run git-log to make sure it really was committed.

> it did exactly what it was told to do, _unless_ the command is
> expected to take longer than other commands in git suite, or it
> is something the user rarely runs.

In the specific case of commit I really think the hash that was added needs to 
be printed.  I often do a series of git-commits on separate files; to find 
out the hash of one of those recent commits I then hop over to qgit to look.  
If it were right there on my terminal I wouldn't need to have qgit open all 
the time.

> >  * git-branch is not verbose enough when creating a new
> The same comment applies here.

Right back at you.  "what it was told to do", is not a clear cut thing.  Bear 
in mind that users make mistakes (I certainly do), so what I told it to do 
was not necessarily what I wanted it to do.  With no output to tell me what 
actually happened, it makes it harder to go back and see what you did wrong.

> However, perhaps you could make lack of "[user] expert = true"
> in ~/.gitconfig to trigger more verbose messages that say "yes
> sir I did what I was told to do".

I've always thought that programs that needed an expert/beginner split were 
badly designed.

I'm not sure you're characterising the messages correctly with "yes
sir I did what I was told to do".  That sort of output would truly be useless.  
However, going back to my git-commit example, I didn't say "commit and give 
this the hash XXXXXXXX", I said "commit".  git makes up the hash for me, and 
so should really tell me that hash.

> Not interested in implementing that myself at all, though.

I've gotten a far more positive response than I'd expected, so it doesn't 
surprise me.

> >  Tell them if they
> >  made a branch as well, which branch they are now on.
>
> I think you are talking about "checkout -b" not commit here;
> this might be a borderline (branch creation is less often done
> and it might warrant assuring feedback), but I think it still
> falls into the "doing exactly what it was told to do" category.

You're right, I was.  The reason I think feedback is useful is because of the 
two ways of making a new branch:
 - git-branch XYZ
   This makes a new branch but DOESN'T leave me on XYZ
 - git-commit -b XYZ
   This makes a new branch and switches to XYZ
I can't tell you the number of times I get this wrong.  It's not because I 
don't know if I stop to think, it's because I'm thinking about the project, 
not the VCS.

> No.  It either says patch is corrupt, or a hunk at this line
> does not apply.  I do not see what more would you would want to
> ask it to say.

I've been building a repository that contains every kernel release since 
v1.0.0; I did it by downloading every patch and "git-apply"ing them one at a 
time.  Along the way, I had a few occasions where the patch didn't apply.  I 
would get the "hunk didn't apply" message. (e.g. v1.1/patch54.bz2 if you're 
interested)

Now - it /should/ apply, this is a published patch; I investigated each one, 
and it was always down to a whitespace problem.  The current version didn't 
have the same whitespace as the patch was expecting; often part of a much 
larger patch which mostly applied.  git-apply could have told me...

While applying hunk #17, the following update would not apply to the file
this/that/theother.c
-#endif
+#endif

Instead I had to git-checkout HEAD; bzcat patch | git-apply --reject; 
find . -name "*.rej"; vim; git update-index; blah, blah blah.

> As long as your solution does not accidentally lose local,
> unrelated changes, changing "git-rebase --skip" to do the needed
> clean-up itself for the user would be Ok (I think we would want

Of course; never discarding data always takes precedence.

> While I agree the users need to be taught about 'prune', I do
> think immediately after running the above commands is exactly
> the wrong point to run 'prune'.  'prune' should not be run while
> you are busily munging the tip of the branch with rebase and
> reset to come up with something that you can call "oh, I am done
> with this series for now."  Otherwise even lost-found would not
> be able to help you.

Absolutely; I wasn't suggesting that the message should say "now run 
git-prune"; otherwise we might as well run git-prune ourselves.  I don't 
really know that the solution is; but I do think we need one.

> In general the principle ought to be not to say anything if the
> command does exactly what it was told to do successfully, unless
> the operation is expected to take longer than other normal
> commands in the git suite, or something that is rarely used.

git is its own worst enemy here I think.  I still have doubts that something 
actually happened when I run commands because they return so quickly.

> Perhaps under "[user] expert" control.

I think the problem with that is going to be that there will be disagreement 
about which commands should output what in which mode.  "I like git-commit to 
tell me what it committed, but don't want git-add to list files" sorts of 
thing.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
