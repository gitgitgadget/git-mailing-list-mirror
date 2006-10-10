From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [RFC/PATCH] merge: loosen overcautious "working file will be lost" check.
Date: Mon, 9 Oct 2006 17:59:15 -0700 (PDT)
Message-ID: <20061010005915.30066.qmail@web31813.mail.mud.yahoo.com>
References: <7vd5919g55.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 03:03:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX5xo-0004nL-Rr
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 02:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWJJA7R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 20:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWJJA7R
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 20:59:17 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:50108 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964887AbWJJA7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 20:59:16 -0400
Received: (qmail 30068 invoked by uid 60001); 10 Oct 2006 00:59:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=yuJhdPwW+krLGPqMlP2cuO2A/PxGnQiNaHJjzQy9WkAbnhcumsoj99v9FaY9pTxsv4hw42qGVvhETSYSVDXR62dUk+nu8n2tXDNqjkqYubGz3ny6Hmrjek8MrVdYbnFIduSUMbggPhKB/MeZWzAGzeFbLIlKS3ZQ20COn0W6UIs=  ;
Received: from [64.215.88.90] by web31813.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 17:59:15 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5919g55.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28589>

--- Junio C Hamano <junkio@cox.net> wrote:
> Ah, I misunderstood.  But then I do not understand why you see
> all 0 anywhere.  Merge base has the path, branch B has it, and
> trunk has it too; wouldn't it result in regular 3-way merge?
> 
> I understand you do _not_ even want a regular 3-way merge in
> this case, but that is a separate issue.  You could write a new
> merge strategy to traverse ancestry chain between the merge base
> and each heads you are merging and notice disappearance and
> reappearance of the path, but that would slow things down
> tremendously for normal case and I do not think it is worth it.
> 
> You would also have exactly the same issue if you do not remove
> and then add the file, but if your work on the branch involves a
> significant rewrite.  Depending on how good the rewrite is,
> bugfixes that happened on the trunk based on an ancient code may
> not even be needed (in other words, it would not apply cleanly
> anyway, but it does not matter -- the branch work is much better
> or has different set of problems that the trunk fix is
> irrelevant).
> 
> At that point, M1 would involve significant merge conflicts (and
> not all-0 which I am still puzzled about), but I suspect that
> the situation is obvious enough to the human (inspect git log
> branch...trunk output and the log somewhere had better indicate
> that the are unrelated), and the solution very much is different
> case-by-case (most likely the person who pulls branch into trunk
> would say "keep ours" for the path which would mean running "git
> cat-file :2:$path >$path", or say "we are not really ready to merge
> yet" and abort the entire merge; somebody on the trunk pulling
> from that branch might say "I want other smaller fixes but this
> total rewrite is not ready yet -- keep ours", or "now we know
> this is total rewrite and the small updates on the trunk does
> not matter -- take theirs and from now on we will improve on the
> work done on the branch").
> 
> So in short, I do not think there is a clear-cut improvement we
> can do to the tools to solve this.

Yes, I agree.

   Luben
