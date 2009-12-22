From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: Regression: git-svn clone failure
Date: Wed, 23 Dec 2009 09:35:32 +1300
Message-ID: <1261514132.23944.6.camel@denix>
References: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com>
	 <20091222192115.GA10313@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Andrew Myrick <amyrick@apple.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Dec 22 21:36:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNBSb-0001jd-AH
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 21:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbZLVUf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 15:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbZLVUf4
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 15:35:56 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:41767 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbZLVUf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 15:35:56 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id DA30821C372; Wed, 23 Dec 2009 09:35:54 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.234] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 9778E21C372;
	Wed, 23 Dec 2009 09:35:33 +1300 (NZDT)
In-Reply-To: <20091222192115.GA10313@dcvr.yhbt.net>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135598>

On Tue, 2009-12-22 at 11:21 -0800, Eric Wong wrote:
> That looks like a simple error, does the following patch help?
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 3670960..dba0d12 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3163,7 +3163,8 @@ sub find_extra_svn_parents {
>  				next unless $new_parents[$i];
>  				next unless $new_parents[$j];
>  				my $revs = command_oneline(
> -					"rev-list", "-1", "$i..$j",
> +					"rev-list", "-1",
> +					"$new_parents[$i]..$new_parents[$j]",
>  				       );

Yes, that is the intent.

Hrm, I'd have thought my test would have stepped over that code when it
merged in a branch which merged two an svn branch which included a merge
of another svn branch.  Obviously not!  I'll cook something up to cover
that..

Sam.
