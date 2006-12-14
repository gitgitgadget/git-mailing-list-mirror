X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Thu, 14 Dec 2006 11:31:38 +0000
Message-ID: <b0943d9e0612140331q4c3a32e2l361fd04375f091d7@mail.gmail.com>
References: <20061207101707.GA19139@spearce.org>
	 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>
	 <b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com>
	 <Pine.LNX.4.63.0612140045430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 11:32:01 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e9HCzXVwTFnDu6Hyb+ssujhrNLG8LYsHoCeWnw9FQqWMS7euwL+gebR0P5BpuCkYCvknHE7fxwJt2ERWfAVyQJHFydaeoc8omfMziSSOZ4McbQvvX7SqX+m/Y+gpQ7PJOsSQOShtDu0mSayqJTeqm8ncThPml+fGog4kuTcgY8o=
In-Reply-To: <Pine.LNX.4.63.0612140045430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34319>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guooh-0005z5-Fx for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932635AbWLNLbl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWLNLbl
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:31:41 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:4882 "EHLO
 nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932635AbWLNLbj (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 06:31:39 -0500
Received: by nz-out-0506.google.com with SMTP id s1so231287nze for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 03:31:38 -0800 (PST)
Received: by 10.65.54.9 with SMTP id g9mr1382788qbk.1166095898528; Thu, 14
 Dec 2006 03:31:38 -0800 (PST)
Received: by 10.65.126.2 with HTTP; Thu, 14 Dec 2006 03:31:38 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 13/12/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> xdl_merge(), as Git uses it, tries harder to find the true conflicts. So,
> if the files actually differ in only one line, just this line will be
> shown as conflict.

I gave the latest GIT a try and it works OK with StGIT.

This new merge looks much better than diff3 (or rcs merge) because it
only shows the true conflicts.

What it the relation between git-merge-recursive and "git-read-tree
-m" (if any)? I currently still use "git-read-tree -m" for some merges
because of the speed gain due to the --agressive option (really
noticeable when picking a patch from an older branch). Probably
git-merge-recursive cannot implement this since it needs to track
deletion/additions for rename detection.

Are there any other things to be aware if I completely replace the
"git-read-tree + diff3" with git-merge-recursive?

One nice addition to git-merge-recursive (probably only useful to
StGIT) would be more meaningful labeling of the conflict regions,
passed via a command line similar to the "diff3 -L" option. StGIT
generates "patched", "current" and "ancestor" labels with diff3.

Yet another nice feature would be the ancestor region (which diff3
doesn't add either but it gets added by emacs'
ediff-merge-files-with-ancestor function if you use the interactive
merge with StGIT).

-- 
