From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Wed, 9 Feb 2011 20:15:20 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102092005300.20937@debian>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com> <AANLkTi=Uqkzv+ucBzww6R1V+0ujmfH-dED8XJhyRvWQF@mail.gmail.com> <alpine.DEB.2.00.1102081320350.4475@debian> <20110208220505.GA17981@elie> <alpine.DEB.2.00.1102081916330.9042@debian>
 <alpine.DEB.2.00.1102081959210.14152@debian> <20110209041737.GD24346@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 02:15:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnL8C-0003GJ-Hy
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 02:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab1BJBP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 20:15:29 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61804 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab1BJBP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 20:15:28 -0500
Received: by vxb37 with SMTP id 37so410301vxb.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=QXuP0leitCjy2FUc+w7iItvdTK56c/b7AjlfiixStrE=;
        b=Wus4qV7/2O4DZtsuXyNMPdrKamOu4/MeQPNzcTKS1eoVBAP75E72DxfgGtTS9x+pti
         iIhlXr3Ia8IVy3mijpVzniSeQyB5+Rj9CZeFmLaMKWlT4nFrqg0IgWFmKS6nxnxjHc9/
         CE9Ned+XNzGWmBY4fshTjdGqb2LfgRfSXs0Co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=QTruRlXlfUUYw26Tuu436ZOpJZfo3+Avwwzfw6ch7suuBMe17mSOeXJkg7zwy6GjY7
         3sW8WyI27wXj7KeZHvZi1fmThFd9ve4MWdNXA4/G+yDJCUKqwMiPUdRPb56yMcFQTlRP
         6BA2fAXicNLo6kI61KdZMxFfLNzTwFk3HpjCs=
Received: by 10.220.202.73 with SMTP id fd9mr5450081vcb.8.1297300527098;
        Wed, 09 Feb 2011 17:15:27 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u4sm376938vch.36.2011.02.09.17.15.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 17:15:25 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20110209041737.GD24346@elie>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166461>

On Tue, 8 Feb 2011, Jonathan Nieder wrote:

> Martin von Zweigbergk wrote:
> 
> > Changes to the text compared to before:
> >
> >  * "remote branch" became "upstream branch", even for git pull
> 
> Sensible for pull --rebase.  I'm not so sure about plain pull --- what
> if I am upstream and pulling from downstream?
> 
> >  * "You asked me to pull" became "You asked me to merge" or "You asked
> >    me to rebase", even for git pull
> 
> "To pull" would be clearer if the reader is new and unfamiliar with
> the details.
> 
> >  * Now printed to stderr, because I simply didn't think about it. Good
> >    or bad?
> 
> If this were a new message, I'd say stderr is better.
> 
> As is, the change to stderr seems relatively harmless, though I haven't
> thought about it deeply.  But a part of me likes to see functional
> changes isolated in separate commits to make tracking down bugs a
> little easier.

The patch below should address all of the above. See how you like the
new wording. The patch applies on top of the previous one to make the
changes clear. I will send a re-roll with all three patches squashed
soon as well.

Note that this patch makes the test cases introduced in the original
patch fail because of the error messages from 'git rebase' are now
written to stdout. I will of course fix that in the re-roll.

Thanks for reviewing.

/Martin


-- 8< --

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index ff58d5b..be17ecb 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -101,25 +101,25 @@ get_remote_merge_branch () {
 }
 
 error_on_missing_default_upstream () {
-	op_type="$1"
-	op_prep="$2"
-	example="$3"
-	documentation="$4"
+	cmd="$1"
+	op_type="$2"
+	op_prep="$3"
+	example="$4"
 	branch_name=$(git symbolic-ref -q HEAD)
 	if test -z "$branch_name"
 	then
-		die "You are not currently on a branch, so I cannot use any
+		echo "You are not currently on a branch, so I cannot use any
 'branch.<branchname>.merge' in your configuration file.
-Please specify which upstream branch you want to use on the command
+Please specify which branch you want to $op_type $op_prep on the command
 line and try again (e.g. '$example').
-See $documentation for details."
+See git-${cmd}(1) for details."
 	else
-		echo &2> "You asked me to $op_type without telling me which branch you
+		echo "You asked me to $cmd without telling me which branch you
 want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.merge' in
 your configuration file does not tell me, either. Please
 specify which branch you want to use on the command line and
 try again (e.g. '$example').
-See $documentation for details.
+See git-${cmd}(1) for details.
 
 If you often $op_type $op_prep the same branch, you may want to
 use something like the following in your configuration file:
@@ -127,12 +127,13 @@ use something like the following in your configuration file:
     remote = <nickname>
     merge = <remote-ref>"
 		test rebase = "$op_type" &&
-		echo &2> "    rebase = true"
-		die "
+		echo "    rebase = true"
+		echo "
     [remote \"<nickname>\"]
     url = <url>
     fetch = <refspec>
 
 See git-config(1) for details."
 	fi
+	exit 1
 }
diff --git a/git-pull.sh b/git-pull.sh
index 8ec1d3d..2cdea26 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -165,8 +165,8 @@ error_on_no_merge_candidates () {
 		echo "for your current branch, you must specify a branch on the command line."
 	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
 		. git-parse-remote
-		error_on_missing_default_upstream $op_type $op_prep \
-			"git pull <repository> <refspec>" "git-pull(1)"
+		error_on_missing_default_upstream "pull" $op_type $op_prep \
+			"git pull <repository> <refspec>"
 	else
 		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
 		echo "from the remote, but no such ref was fetched."
diff --git a/git-rebase.sh b/git-rebase.sh
index 8b39cab..cff7aaa 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -366,8 +366,8 @@ then
 			--verify -q @{upstream})
 		then
 			. git-parse-remote
-			error_on_missing_default_upstream "rebase" "against" \
-				"git rebase <upstream branch>" "git-rebase(1)"
+			error_on_missing_default_upstream "rebase" "rebase" \
+				"against" "git rebase <upstream branch>"
 		fi
 		;;
 	*)	upstream_name="$1"
