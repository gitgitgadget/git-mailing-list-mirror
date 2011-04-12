From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/resend] Documentation: update to git-merge-base --octopus
Date: Tue, 12 Apr 2011 14:45:58 -0500
Message-ID: <20110412194558.GB1209@elie>
References: <4DA47A4D.80909@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Apr 12 21:46:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9jXR-0005v7-8D
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 21:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796Ab1DLTqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 15:46:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50561 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589Ab1DLTqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 15:46:04 -0400
Received: by iwn34 with SMTP id 34so6947937iwn.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8sSud8vukcwfewuNDHQUN+BSBkUO+Yzw6ivRqCp0XXE=;
        b=faXGdaZlXk2GLsYQS9YdiNg32eaKpS7BQmBnnIZIlwT/eEGS89Dk4DvnRsvnHSzJcf
         /XmPvL+Iigei4KnrU3t3PTyByItEY85S8XIzddoJSUJKjdT5/DRAeJ7CMlC5drxelCs9
         7lBF6gu8h5NvcEVgv0v9RJCEitPF3cFxiuTSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CYSQBZtErv5oQiCic0yBy+P74LmXMOC89Y6w3/a3weIXmMANRSnFOiPbwfP4AJ2etf
         oY7IelgmubWgKNO3PG3CBt1FclH+I1Xp78zL8nTdKbbuYOy+qedYY/+oEFQHTQKqR/ne
         iq4owB1jrP1kUwU+CbX+4WOKphxStegMdvSHM=
Received: by 10.42.145.71 with SMTP id e7mr375855icv.314.1302637563530;
        Tue, 12 Apr 2011 12:46:03 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.ameritech.net [69.209.64.230])
        by mx.google.com with ESMTPS id v42sm353510ibg.28.2011.04.12.12.46.01
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Apr 2011 12:46:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DA47A4D.80909@lyx.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171414>

Hi Vincent,

Vincent van Ravesteijn wrote:

> On the other hand, in the
> case without the --octopus parameter, it is necessary to supply a single commit
> and a set. Moreover, in the case of --octopus merging, a single commit is also valid,
> which is not the case otherwise.

So to summarize: unlike plain merge-base, merge-base --octopus only
requires at least one commit argument, and this patch updates the
synopsis to reflect that.  Good catch.

> 2) Add a sentence to the discussion that when --octopus is used, we do expect '2'
> as the result.

Adding an example use of --octopus to the DISCUSSION section makes a
lot of sense.  At first I thought this was being added to the
DESCRIPTION section, which led me to suggest something like the
following:

 DESCRIPTION
 -----------
 'git merge-base' finds best common ancestors between two commits to
 use in a three-way merge.  [... etc etc ...] can be more than one merge
 base for a pair of commits.

 OPERATION MODE
 --------------
 As the most common special case, specifying only two commits on the
 command line means computing the merge base between the given two
 commits.

 More generally, among the two commits to compute the merge base from,
 one is specified by the first commit argument on the command line;
 the other commit is a (possibly hypothetical) commit that is a merge
 across all the remaining commits on the command line.

 As a consequence, the merge base is not necessarily contained in each
 of the commit arguments if more than two commits are specified.
 This is different from git-show-branch(1) when used with
 the --merge-base option.

 --octopus::
	Compute the best common ancestors of all supplied commits, in
	preparation for an n-way merge.
	This mimics the behavior of 'git show-branch --merge-base'.

 --independent::
	Instead of ...

 OPTIONS
 -------
 -a::
 --all::
	...

 DISCUSSION
 ----------

What do you think?

> --- a/Documentation/git-merge-base.txt
> +++ b/Documentation/git-merge-base.txt
> @@ -9,7 +9,8 @@ git-merge-base - Find as good common ancestors as possible for a merge
[...]
> +When the option `--octopus` is given, the result of `git merge-base A B C`
> +will be '2', because '2' is the common ancestor of all branches.
> +

For what it's worth, except for Junio's wording nitpick and the log message,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
