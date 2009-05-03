From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: specialize diff options for emerge and
	ecmerge
Date: Sun, 3 May 2009 11:21:38 -0700
Message-ID: <20090503182137.GC50640@gmail.com>
References: <1241254641-54338-1-git-send-email-davvid@gmail.com> <20090502194636.GA599@gmail.com> <200905030827.56932.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, marcin.zalewski@gmail.com,
	charles@hashpling.org, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun May 03 20:21:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0gJx-0003Mi-SA
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 20:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbZECSVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 14:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754855AbZECSVm
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 14:21:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:12116 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZECSVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 14:21:42 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2594837rvb.1
        for <git@vger.kernel.org>; Sun, 03 May 2009 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RNfIOcck5aHJjpaqrfoyi9OPypbIpzZWBS0PEp8X8rc=;
        b=lJ39omYUCzo2iXRkfT30CV6Yig8AAaO5bo/YPobXi12K9XsTlRUe1+lVTfkND4wAkJ
         oAqnlfAfTgB5oS1NNGV9nLHQhWjmB+6tFiFeqZSaHP2MatRzvna9VUNf/Lt2dTq0X+Aw
         WDv4Oe/9VMgolcMI/fGhWyvmEG58cJTJnHWCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dJXyGzeMBUfC/d+hXS6bey7U9i8ygA5W3Z8FyxOIyQS50exAIj7O5MG5rrmArGu7sR
         NcVxtbcCoif1sCPgHUrz0gGggbUDFIYbxPpPlKxKOWgOG0IqnWfQVfgAN2AXHCgDX2Tp
         EyZdzdUpILsqSeEomPWhqPgTzqOIU1dRF+wt4=
Received: by 10.114.106.13 with SMTP id e13mr3796787wac.128.1241374902446;
        Sun, 03 May 2009 11:21:42 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m30sm8534307wag.53.2009.05.03.11.21.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 11:21:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200905030827.56932.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118182>

Markus Heidelberg <markus.heidelberg@web.de> wrote:
> David Aguilar, 02.05.2009:
> > I installed ecmerge on a mac today and gave this a try.
> > ecmerge is indeed better with this patch.
> > 
> > After configuring the path it all "just works":
> > 
> > $ git config --global mergetool.ecmerge.path \
> > 	/Applications/ECMerge.app/Contents/MacOS/guimerge
> 
> Would it make sense to set merge_tool_path to guimerge by default then?
> 
> Markus

On Linux, ecmerge is "ecmerge".
Macs are weird.  Windows--even worse.

We could test $(uname) = "Darwin" and do the user-friendly thing by default,
but that might not be a good idea.  The user-friendly thing is actually
"/Applications/...lots.of.stuff.../guimerge", and that's a lot more
platform-specific than just "guimerge".

The usability fairy says we should be nice to users and turn
translate_merge_tool_path() into a massive platform-specific 
hack.  The lazy person in me would rather list the tweaks
on the git wiki and silently reward linux users since
the defaults work fine there as-is.

What do you think?

-- 
		David
