X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Thu, 14 Dec 2006 14:15:14 +0000
Message-ID: <b0943d9e0612140615u2d91fec4qe3c8a3d0b6515026@mail.gmail.com>
References: <20061207101707.GA19139@spearce.org>
	 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>
	 <b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com>
	 <Pine.LNX.4.63.0612140045430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <b0943d9e0612140331q4c3a32e2l361fd04375f091d7@mail.gmail.com>
	 <Pine.LNX.4.63.0612141436170.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 14:15:29 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gCKZwc2aUQ9vMMURvpKj8qwGyZSDNV6J9LuXu0h0T0nGC/nAwbx6G6bEvNs15DNPozXQXnKmeGw9P4wjerinK0qe/MhKFXHItCQ6psi4PJ/M/DXtwfOcIRQvw3o/MGmRwc75MeAY94JHyjRxcG/9lADzd1h5ortQPNrZR4f+90I=
In-Reply-To: <Pine.LNX.4.63.0612141436170.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34341>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GurMp-0001tU-6D for gcvg-git@gmane.org; Thu, 14 Dec
 2006 15:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932746AbWLNOPT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 09:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWLNOPS
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 09:15:18 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:48929 "EHLO
 nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932746AbWLNOPQ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 09:15:16 -0500
Received: by nz-out-0506.google.com with SMTP id s1so251344nze for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 06:15:15 -0800 (PST)
Received: by 10.65.241.20 with SMTP id t20mr1588267qbr.1166105715569; Thu, 14
 Dec 2006 06:15:15 -0800 (PST)
Received: by 10.65.126.2 with HTTP; Thu, 14 Dec 2006 06:15:14 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 14/12/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 14 Dec 2006, Catalin Marinas wrote:
> > What it the relation between git-merge-recursive and "git-read-tree
> > -m" (if any)?
>
> git-merge-recursive internally calls the equivalent of 'git-read-tree -m'
> (it does not fork() and exec(), but rather calls the C functions
> directly) and does nothing more if the 'git-write-tree' succeeds. At least
> that's the theory...

OK, thanks (I imagined it might work like this).

> > One nice addition to git-merge-recursive (probably only useful to
> > StGIT) would be more meaningful labeling of the conflict regions,
> > passed via a command line similar to the "diff3 -L" option. StGIT
> > generates "patched", "current" and "ancestor" labels with diff3.
>
> This is possible. However, it is not _that_ horrible to see "HEAD" and
> some SHA1 which is obviously non-HEAD. Added to that, a quite common case
> are the intermediate merges which make merge-recursive so powerful, and
> they are rightly called "Temporary branch 1" and "... 2".

From the StGIT perspective, it only does a three-way merge and passes
commit id to git-merge-recursive, hence the complicated naming.
However, it wouldn't be hard to modify StGIT to actually replace the
hashes in the file with meaningful names.

> > Yet another nice feature would be the ancestor region (which diff3
> > doesn't add either but it gets added by emacs'
> > ediff-merge-files-with-ancestor function if you use the interactive
> > merge with StGIT).
>
> Is this really that nice? I never needed it... Besides, it can get really
> crappy when the conflicting regions are too large.

I think I only used the ancestor region for a mental representation of
what xdl_merge already produces :-) since emacs (nor diff3) wasn't
able to show the real differences. Probably no longer needed now.

Thanks for the explanations.

-- 
