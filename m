From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH] git-filter-branch: Add an example on how to remove
	empty commits
Date: Thu, 30 Oct 2008 11:06:18 -0400
Message-ID: <20081030150617.GA14098@euler>
References: <1225326833-15210-1-git-send-email-pasky@suse.cz> <20081030132623.GC24098@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:08:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZ85-0002Ck-LD
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbYJ3PGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755502AbYJ3PGc
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:06:32 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:43597 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497AbYJ3PGc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:06:32 -0400
Received: by qw-out-2122.google.com with SMTP id 3so288946qwe.37
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=8FUIwjZCKI45KGpsy2t5gCQe9bWa9COLpsIiGRPVsyY=;
        b=vVtmMtKmbFLait4orqH/BQ2ZngsqqDb5DeyPLeO0D9Q3BbTUs3Nvvvi1AY4sbm4txv
         IXPxvS9UMnoy9jxnlELF7AfRbjny2qA1dAYhfZmIVID7wYunitu60eCR+SqT2c3HqyH9
         hmHRoHDGk2WVtUSoiNJYdZRXTRHu+tunLTUtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=UWxZQuo0u7HdFHQlnObOAW3IGdtvK++v1Hrbb4fhJLazk8ahQ6GnI1Po4Zg/C2beEh
         XtFDfD/rEvOvoEMCFPatdSSGRbNA2rR44Zoy9hpRMnPDdPgNTEYZ026ycdpdtRlmEuq3
         FvsLY2BpaMTuUIeVgJmRfE9i87tR3D/03UJHE=
Received: by 10.65.189.20 with SMTP id r20mr11108097qbp.51.1225379189966;
        Thu, 30 Oct 2008 08:06:29 -0700 (PDT)
Received: from euler ([141.213.134.34])
        by mx.google.com with ESMTPS id 27sm3291442qbw.0.2008.10.30.08.06.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Oct 2008 08:06:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081030132623.GC24098@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99484>

On Thu, Oct 30, 2008 at 02:26:23PM +0100, Pierre Habouzit wrote:
> Why not add an option to filter-branch that removes a commit if it's
> empty ? It's quite useful, it helps the user concentrating on just
> keeping what matches *his* criteriums, and not caring about the minor
> details of cleansing the result.

I've thought this would be useful at times myself.  One potential complication,
however, is that the history could come from a SVN repository via git-svn, in
which case it's possible that empty commits exist due to an incomplete mapping
of SVN's changes, e.g. SVN property changes will get their own revision, even
if the file content does not change.

Therefore, if one were to write a patch such as Pierre suggests, I'd strongly
suggest checking the commit message first for any git-svn-id: line, and either
refusing to work without some --force option from the user, or giving a strong
warning to the user that their git-svn setup may not work properly any more,
and clear instructions on how to recover those refs, or update the svn-related
metadata.

On further thought, automatically updating the svn metadata might be useful to
add as an option to filter-branch regardless; I'll think about that some
myself, any thoughts from others?

My $0.02,
Deskin Miller
