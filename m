From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 1/2] Ensure consistent usage of mergetool.keepBackup
	in git
Date: Thu, 9 Apr 2009 20:27:32 -0700
Message-ID: <20090410032731.GA1545@gmail.com>
References: <20090409153033.GN23604@spearce.org> <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Fri Apr 10 05:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls7RX-0007ba-Vb
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 05:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765642AbZDJD1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 23:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764314AbZDJD1u
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 23:27:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:13484 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763584AbZDJD1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 23:27:49 -0400
Received: by wa-out-1112.google.com with SMTP id j5so485914wah.21
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 20:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=J9RZW8lpWViMBcCWzcYYOa56ebD9mqPq3x+FdOJPsTk=;
        b=PwIcmJ5NKJRh4IP9FfmX4oYGe1kV4xe73P9zlsnTTCHN+MYG48p2sIJTaPp5UZMjED
         rITCD0aREQCngKud7BD5972b5PQtznMdgI8RdBtpwTFY2PT1x6AnDUx+7HpOIKVbHJbP
         kLhMKmtKInyntDnaBgXH2NKK2Wi4jE3uznD6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Tf1H13rCtGGHqMCGGYzJdY+FFeooDIUvAmAdW6E73ZtsjpJfcXJjvVYpIgl6rxUK/L
         MIj7JHT7hC47mdQeLuxKTM+tYB007938h9XpSeECLU3K8Fsgos+/g2sqNT/f/a6uei3O
         GdFliTtyf9RYbGuxe7ydMjdwRCc5vxYwv+A98=
Received: by 10.114.159.5 with SMTP id h5mr1728264wae.36.1239334067737;
        Thu, 09 Apr 2009 20:27:47 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m30sm824387wag.47.2009.04.09.20.27.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 20:27:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116237>


Hi

On  0, Ferry Huberts <ferry.huberts@pelagic.nl> wrote:
> In several places merge.keepBackup is used i.s.o.
> mergetool.keepBackup. This patch makes it all
> consistent for git
> 
> Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
> ---
>  contrib/difftool/git-difftool.txt |    2 +-
>  git-mergetool.sh                  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)


You missed the usage of merge.keepBackup in
contrib/difftool/git-difftool-helper.

But.. (for better or worse) the "keep backup" feature
was completely removed from difftool, so patching this for
difftool now isn't very useful.

See 2e8af7e4 which is currently in origin/pu:

	difftool: remove the backup file feature


Also, we just got through a very large round of
mergetool/difftool changes.  The latest version is sitting in
Junio's pu branch.  The "da/difftool" branch's head is
currently pointing at 21d0ba7e.

It might be worth basing your work on top of that series since
that'd make things much easier to merge.


My only other comment is:

Aside from git-gui, there are other scripts out there that
use merge.keepBackup instead of mergetool.keepBackup,
so changing the name of the config variable has negligable
user benefit and will cause problems for people that:

A) already have merge.keepBackup configured and then get
surprised when one day all of a sudden git starts leaving
around these ".orig turds" (technical term, overheard from an
actual user) for no apparent reason even though they had
already configured it to do otherwise in the past, or

B) have written GUIs or scripts that know about
merge.keepBackup.

Aside from the naming, there's little user benefit to this
change in my opinion.

Anyways, just my thoughts.

-- 

	David
