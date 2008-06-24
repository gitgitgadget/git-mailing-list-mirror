From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git-fetch remote tag to local branch fails
Date: Tue, 24 Jun 2008 15:38:12 +0200
Message-ID: <8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com>
References: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Klas Lindberg" <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 15:39:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB8kM-0008G2-T3
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 15:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759222AbYFXNiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 09:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759343AbYFXNit
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 09:38:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:35667 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759332AbYFXNiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 09:38:14 -0400
Received: by ug-out-1314.google.com with SMTP id h2so717023ugf.16
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SuHPjutFAgSYO54hQp7LPR5pBMRtG9moYVCnJii+G0Y=;
        b=beMGLveKmyHplaXgK6KQINf64M+vnxayWa4OwltCE5QFCXKiy7VMZ9MTy3HksiCj2S
         N1S8Kip4Zs73rbYOmdeJnWJX6LDdl1CiM8U8aSGyG25dXzdlq/fugcT6FzpHtChCYzn1
         rJWK4dr7GIdq/WkAn9z3U2Zua9zhAnNAUG3pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ePgs6h5l9KnI6bLlqdo7AUqDLpp7/knx2/TKf/0Oe9xmWG7JCNJMaUGWIjLqlSOPC9
         OTSjl/ryCir4E5UEVv1aBBDe1gqHzcZt5u93SwINbaRjZLn4pWg1l6m0/9p2Xr3UfAbY
         SXokKhaHI5cychSNayJ38CiAwLTSxx4gm/kO0=
Received: by 10.210.28.4 with SMTP id b4mr400427ebb.138.1214314692571;
        Tue, 24 Jun 2008 06:38:12 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Tue, 24 Jun 2008 06:38:12 -0700 (PDT)
In-Reply-To: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86053>

On Tue, Jun 24, 2008 at 14:17, Klas Lindberg <klas.lindberg@gmail.com> wrote:
> Hi
>
> I have a repository "bogustree" that contains tags "test_tag" and
> "foo_tag" (both on the same branch, with "test_tag" pointing to an
> older commit).
> I also have repository "R", which contains "test_tag" from "bogustree"
> and a branch "b" created from "test_tag". The active branch in R is
> "master".
>
> Now I want to do the following from R:
>
> git-fetch bogustree refs/tags/foo_tag:refs/heads/b
>
> but this fails with the message given below. The interesting part is
> that git-fetch tries to write a "non-commit object" and indeed I have
> no idea what this thing is (the commit pointed to by "foo_tag" has
> commit ID cab0a25388f1884a1ab16bd0d66f877c0b36f1d5).

non-commit object is an object that is not a commit, like a tag, a
blob or a tree, and you are trying to write a tag in refs/heads/. Only
commits objects (no tags) are allowed in refs/heads/.


> Another
> interesting detail is that the command fails and then continues
> anyway. That seems wrong in itself.
>
> # remote: Counting objects: 6, done.
> # remote: Compressing objects: 100% (2/2), done.
> # remote: Total 4 (delta 0), reused 0 (delta 0)
> # Unpacking objects: 100% (4/4), done.
> # error: Trying to write non-commit object
> 5f61233bc5dad0f3e25ecea65457f5bb528174d2 to branch refs/heads/B
> # From /home/qliklas/bogustree/b/b
> #    72f0622..5f61233  foo_tag    -> b
> # From /home/qliklas/bogustree/b/b
> #  * [new tag]         foo_tag    -> foo_tag
> #  * [new tag]         test_tag   -> test_tag

Are you sure it is written as a branch? What is the output of "git tag
-l" and "git branch -a"?


>
> Why can't I fetch like this? The manual page for git-fetch says that
>
>       <refspec>
>              The canonical format of a <refspec> parameter is +?<src>:<dst>;
>              that is, an optional plus +, followed by the source ref,
>              followed by a colon :, followed by the destination ref.
>
>              The remote ref that matches <src> is fetched, and if <dst> is
>              not empty string, the local ref that matches it is fast
>              forwarded using <src>. Again, if the optional plus + is used,
>              the local ref is updated even if it does not result in a fast
>              forward update.
>
> so I think it should be OK?

as long as <src> are commit objects.

Santi
