From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: Re: [egit-dev] Re: [EGIT PATCH] Rename org.spearce.egit -> org.eclipse.egit
Date: Fri, 19 Jun 2009 09:47:42 +0100
Message-ID: <7270CCF7-45F2-46DE-BD4D-41D921852947@gmail.com>
References: <1245253576-13324-1-git-send-email-spearce@spearce.org> <200906190120.29915.robin.rosenberg@dewire.com> <20090618232431.GR11191@spearce.org>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"egit-dev@eclipse.org" <egit-dev@eclipse.org>
To: EGit developer discussion <egit-dev@eclipse.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 10:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHZkq-000891-Ol
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 10:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbZFSIrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 04:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZFSIrP
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 04:47:15 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:43954 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbZFSIrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 04:47:14 -0400
Received: by ewy6 with SMTP id 6so2328483ewy.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=+88mzh817QZUm3flxnl6Qp+NcqRND1UcB6DcWYEGi4k=;
        b=sbQydlJ3FfGptXgsACl1248bN8soc8k8y8jORm5TmeJY4RDuBCF7rSpDOf8VBbaK16
         Ez0XZxqmUV+dqW1BA/DV0jbiYab2HENMRUH5fhKsNruu95WdCynba52blRahVqPPGYxm
         feay5HJqsePjmiBpzZXDDtOo0qFKLOFNPFKPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=NqvRuIu3WWcfzuOaBbVbO5l7sdIBDEPYSiuAmo8u7mwBFIbAjw0JDdQUPDAWeriPRU
         dNfkeK69beqiuxsveAgL5QKsnzq+O5tTAke2Ua1SNETfQ5rZlTiPl6gCJM1sodtITer2
         n4ahgOV6/CwLjPQG2PhizvcSDik8dIdBz3aBo=
Received: by 10.210.65.2 with SMTP id n2mr2818141eba.66.1245401235115;
        Fri, 19 Jun 2009 01:47:15 -0700 (PDT)
Received: from ?10.28.82.88? ([82.132.139.20])
        by mx.google.com with ESMTPS id 23sm1037954eya.49.2009.06.19.01.47.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 01:47:14 -0700 (PDT)
In-Reply-To: <20090618232431.GR11191@spearce.org>
X-Mailer: iPhone Mail (7A341)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121888>

One possibility is to provide a compatibility bundle such that the old  
API subclasses the refactored classses. That way, existing projects  
will continue to work.

However, it is quite likely to be difficult to do it with 100% success  
so another option might be to provide an upgrade option, only visible  
to the older projects , which will do the change in place.

But since it's a fairly major change, and that people will have to go  
somewhere else to get the plugins etc, it is probably a more efficient  
use of time to just make a note in the release notes about the change  
and let people upgrade themselves.

Alex

Sent from my (new) iPhone

On 19 Jun 2009, at 00:24, "Shawn O. Pearce" <spearce@spearce.org> wrote:

> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
>>
>> Need an idea on how to proceed here. There is a problem related to  
>> updating
>> plugins here. We have renamed feature with one unrenamed plugin. How
>> to we avoid problem when switching from org.spearce to org.eclipse
>>
>> One option is to release a v0.4.1 (which we should do anyway),  
>> which is the last
>> version from master before the split. For technical reasons this  
>> will be
>> a branch since the split occurred already.
>>
>> That 0.4.1 feature should require jgit < 0.5. Then we jgit to v0.5  
>> and
>> make org.eclipse.egit require jgit >= 0.5
>>
>> Having two EGit features will be confusing. You get two of  
>> everything. E.g.
>> Team>Share will have two Git's to choose from, but you cannot tell  
>> which
>> is which.
>>
>> That said, having both could be a feature, since it (didn't really  
>> try it), would
>> be possible to switch between new and old workspaces and get the  
>> plugin
>> configured for that workspace. The wierdness make me suggest we do
>> not do this. If we really want it we could choose to create a proxy  
>> plugin
>> for attaching old workspaces to the new plugins.
>
> Yikes.  I didn't even consider this.  My own workspaces freaked out
> at the change, but I just deleted the projects from the workspace,
> re-imported them, and re-attached them to the new team provider.
> I never even gave it a second thought.
>
> You're right, we should have a better plan for existing deployments.
>
> Its a good thing I didn't just shove this into the tree, even though
> it seemed simple on the surface.  Too simple.  :-)
>
> I like the 0.5 cut to define jgit versions pre/post split.  But I'm
> really not sure what to do about the rename on the EGit team provider
> for existing workspaces.
>
> -- 
> Shawn.
> _______________________________________________
> egit-dev mailing list
> egit-dev@eclipse.org
> https://dev.eclipse.org/mailman/listinfo/egit-dev
