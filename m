From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sat, 12 May 2007 01:06:52 +0200
Message-ID: <200705120106.53624.jnareb@gmail.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <200705111326.35577.jnareb@gmail.com> <7v7irfcns1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 02:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmfLQ-0001CB-Na
	for gcvg-git@gmane.org; Sat, 12 May 2007 02:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbXELAUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 20:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758976AbXELAUO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 20:20:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:29411 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbXELAUM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 20:20:12 -0400
Received: by ug-out-1314.google.com with SMTP id 44so918782uga
        for <git@vger.kernel.org>; Fri, 11 May 2007 17:20:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a7soYWGQYUEEeWmtYgd7e33EtYBL0q9DMaFs05AqQJFL2pxyna+lYJasrrhDCzEolOdnQVsHBYMBSodiuEZb06NLzz61pwM/07A5NB/37uKsZkg1zN+hSxt/u2Th4SNnlhno+fAxWH9GKsTAzGH+mfgZzWCOc6HkwQemUtqfc4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W/NNaWDrnG944NraF7kQzbMZxnLnUx52Q51R8LVJhoiRBIVGDMH7SbXCY1usOcFxnNTSCEnPmE9h2T6rTwQ6hUthJHMaFHA0p29NsE2aRPBledEu7Yb3qzqd2n67aGCftCp6asSIRjJBXthaiQsG1ew7duWYQP0LX9wbdqVovkk=
Received: by 10.67.101.10 with SMTP id d10mr518959ugm.1178929211023;
        Fri, 11 May 2007 17:20:11 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id 20sm6928014uga.2007.05.11.17.20.08;
        Fri, 11 May 2007 17:20:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7irfcns1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46998>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Fri, 11 May 2007, Junio C Hamano wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>> 
>>>> In the new version of git I *think* you can use "git add -u path/"
>>> 
>>> I know you meant well, but next time could you please check the
>>> fact before speaking?
>>
>>> 		if (i < argc)
>>> 			die("-u and explicit paths are incompatible");
>>
>>> The list is getting more and more cluttered recently, perhaps
>>> which is a good sign that more new people are actually using
>>> git.  Let's try to keep the signal quality of the messages on
>>> the list high.
>>
>> I'm sorry I haven't checked this before writing, especially that
>> information in the synopsis contradict a bit the information in
>> the `-u' option description:
>> ...
>>   -u::
>>         Update all files that git already knows about. This is what
>>         "git commit -a" does in preparation for making a commit.
> 
> What does "git commit -a" do?  Does it take paths?

I was mislead by synopsis, which reads:

  'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...

It looks from it like -u is _not_ incompatibile with explicit paths;
moreover it looks like explicit path is _required_.

>> I think however that "git add -u dir/" could be quite useful; it is
>> not needed to have `-u' and explicit paths incompatibile.
> 
> I tend to agree, and I think that change should not be too
> difficult.

So do you want to accept my patch for git-add documentation for now,
or rather the replacement patch below? Well, best with the patch that
changes -u to be able to work with explicit codepath...
 
> Also it might make sense to have "git commit" use it in the
> "git-commit --only $paths" codepath.  I dunno.

Didn't you mean "git commit --include $paths" codepath? IIRC --only
codepath deals with temporary index...

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Date: Sat, 12 May 2007 01:05:01 +0200
Subject: [PATCH] Documentation: Correct synopsis for git-add command

Change SYNOPISIS section of Documentation/git-add.txt to mark it
explicitely that -u option does not need explicit paths, and that
"add --interactive does not take any parameters".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-add.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ea27018..3c6d431 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -7,7 +7,8 @@ git-add - Add file contents to the changeset to be committed next
 
 SYNOPSIS
 --------
-'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
+'git-add' [-n] [-v] [-f] (-u [[--] <file>...] | [--] <file>...)
+'git-add' (--interactive | -i)
 
 DESCRIPTION
 -----------
-- 
1.5.1.3
