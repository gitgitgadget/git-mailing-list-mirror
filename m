From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Wed, 30 Dec 2009 23:16:45 -0800
Message-ID: <20091231071642.GA10067@gmail.com>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com> <20091230121319.6117@nanako3.lavabit.com> <7vy6kk52an.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, peff@peff.net,
	sam@vilain.net, git@vger.kernel.org, paulus@samba.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 08:17:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQFHO-0000Os-NN
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 08:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbZLaHQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 02:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbZLaHQ7
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 02:16:59 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:40934 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZLaHQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 02:16:58 -0500
Received: by ywh6 with SMTP id 6so12707526ywh.4
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 23:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GxcTLc7I8IYz6ug+G0LDVQ5Dpv8qQJi27VROhCMlrf0=;
        b=cdysGwYsQfbXdGg/cCSeY8zr3XpsjxoPz2i+xTVvQ+pwkjjmF/NcgwnaM2HGtuMCgo
         BxkD0n4b7DlOi0KooeeZiNsvY+aGTVsyNV7z4ZBGjlskb2WVog9X4BE8djNfzywywm55
         dGVCFtXsGKF+Md0ZqYlcDA+pbsjIW4LN2XGKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=C1m2hrq8PVQbSAu/PRqhAgQI8jFmI9tvNtYKcG/6cHxFbztdJHxy1nZJ91bzsldvp+
         33aiojpG2TubsAWx4VtxbiduoAXS3inqgK1sMz/n/tEAve0ie8XrSuqRD+2mT81k2rP2
         AIjwRmA8Tsig1159hGPuS2t02L59QgH/hG+IU=
Received: by 10.150.77.13 with SMTP id z13mr27948852yba.23.1262243817947;
        Wed, 30 Dec 2009 23:16:57 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm5762296yxd.26.2009.12.30.23.16.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Dec 2009 23:16:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vy6kk52an.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135937>

On Tue, Dec 29, 2009 at 11:49:52PM -0800, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
> > Junio, could you tell us what happened to this thread?
> 
> See http://thread.gmane.org/gmane.comp.version-control.git/132983/focus=133414
> 
> In short, the particular way to call difftool this patch implements was
> found to be inadequate to support existing external diff support by gitk
> and a small difftool update will happen first, followed by a patch to gitk
> to use the updated difftool, to avoid regression.


I started the first step:

http://thread.gmane.org/gmane.comp.version-control.git/135613
http://thread.gmane.org/gmane.comp.version-control.git/135613/focus=135612

The 2nd patch implements the the --gui option which Markus
pointed out would be needed to avoid issues such as calling
"vimdiff" from a console-less gitk:

http://article.gmane.org/gmane.comp.version-control.git/133386


I marked the --gui patch as "RFC" since it introduced a new
config variable and I want to make sure that we agreed on its
name.  I didn't get any feedback about that patch
(my fault-- we were in RC freeze and I forgot to CC: Markus).

If that looks like a good first step then we can do the next
step which would be to introduce the --extcmd= option as
mentioned here:

http://thread.gmane.org/gmane.comp.version-control.git/132983/focus=133386

I will try and prepare the changes for --extcmd= within
the next week assuming the existing --gui patch is ok.


On a related note, Jay Soffian recently submitted a
git-mergetool--lib patch adding support for "diffmerge".
It made it clear that there were parts of git-mergetool--lib
that could use some refactoring:

http://thread.gmane.org/gmane.comp.version-control.git/134906

Jay did mention that he'd give it a shot at the time, though
it does seems like the refactoring could wait until we see
how --extcmd= fits into the world.


Thank you for following up on this thread, Nanako.

-- 
		David
