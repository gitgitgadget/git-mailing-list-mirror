From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: Spurious line insertion/deletion stats for binary file
Date: Fri, 15 Oct 2010 14:26:57 -0500
Message-ID: <i9a9va$ror$1@dough.gmane.org>
References: <8CFCE61F-591A-4B56-B701-D1A391FBB088@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 15 21:28:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6pwd-0004VD-Ru
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 21:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566Ab0JOT1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 15:27:54 -0400
Received: from lo.gmane.org ([80.91.229.12]:54250 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092Ab0JOT1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 15:27:54 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P6pwV-0004Ri-2p
	for git@vger.kernel.org; Fri, 15 Oct 2010 21:27:51 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 21:27:51 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 21:27:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159133>

"Kevin Ballard" <kevin@sb.org> wrote in message 
news:8CFCE61F-591A-4B56-B701-D1A391FBB088@sb.org...
>I just noticed something fairly odd when making a commit that changed a 
>single binary file:
>
> kevin> (develop +=)> git ci -m 'Replace binary file'
> [develop c0c3b98] Replace binary file
> 1 files changed, 8 insertions(+), 14 deletions(-)
> rewrite Resources/some_image.png (99%)
>
> The commit results seem to be treating the binary file as text in order to 
> give me insertion/deletion stats. This is quite obviously wrong. For this 
> situation, a fairly simple solution would be to change that line to 
> something like
>
> 1 files changed, 2652 bytes removed
>
> but the correct behavior is a bit less obvious when there are multiple 
> files changed. Does anyone have a good suggestion for how to handle this 
> case?
>
> -Kevin Ballard--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

We track all our binaries so each commit is a working state of our system. 
Git just seems to know they are binaries and reports them as such in the 
diff pane of gitk:  "Binary files a/path/binaryA and b/path/binaryA differ". 
We are currently using 1.7.1.  I guess it "knows" they are binaries because 
we don't their paths in the "gitattributes" file.

Based on the gitattributes manpage, it sounds like you have "diff" set for 
the path to your binary listed in your .git/info/attributes (git attributes) 
file.  If the binary is in the same path as the source you could set the 
"binary" attribute macro for your binary(s) if the path or name is 
distinguishable from the source.  I played around with this in the past, but 
currently don't have a need for it in my current configuration, so I'm 
getting all of this from the gitattributes manpage, 
http://www.kernel.org/pub/software/scm/git/docs/v1.7.1.2/gitattributes.html.

v/r,
Neal
