From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 1/8] git-gui: Cleanup handling of the default encoding.
Date: Thu, 18 Sep 2008 19:02:39 +0400
Message-ID: <20080918150238.GC21650@dpotapov.dyndns.org>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <1221685659-476-2-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 17:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgL2z-0006oT-2n
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 17:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbYIRPCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbYIRPCq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:02:46 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:13364 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbYIRPCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 11:02:45 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1723007gvc.37
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5yky+gVBYFgB5ZB+6BkqjC9tlQJwSE90ciKZspLx4Fw=;
        b=mnhslnuW+34W6MhLMgdsDzCoBEQE0pzsUnjGof46jcj3OnaOazwN6WWLXAGzxksOiK
         ulPjXnN9yslodJuUVd9wAzCHP3HzyHBUuddAxzdJ7GsAqdj6hxtPNTWMze3yQ9qsZlbF
         FeVKX70bymaRIJbyNwaN09PWMILBBtNmrl0bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YJ3rcdPBwft67Ija6yk8eRAdylbyBGvurBB6qaDqZS7iQAtZuWDZsNmHuWVDEh1ar7
         dCHU0EvcSaNzUuaGZ8V0gCfG98vT4+3jB+xEpzn3QDPPeJoA8fEx05e0rB4wwACQW8JW
         QNLXnEq7YmAfnvraINv+BJhWgU+UPMeZuQzZY=
Received: by 10.102.228.2 with SMTP id a2mr2972824muh.79.1221750163637;
        Thu, 18 Sep 2008 08:02:43 -0700 (PDT)
Received: from localhost ( [85.141.191.174])
        by mx.google.com with ESMTPS id s10sm15701045mue.15.2008.09.18.08.02.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Sep 2008 08:02:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1221685659-476-2-git-send-email-angavrilov@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96197>

On Thu, Sep 18, 2008 at 01:07:32AM +0400, Alexander Gavrilov wrote:
> - Make diffs and blame default to the system (locale)
>   encoding instead of hard-coding UTF-8.
> - Add a gui.encoding option to allow overriding it.
> - gitattributes still have the final word.

The subject line of this patch is a bit misleading. I would not expect
from "clean up" to change the existing behavior and existing default.

> The rationale for this is Windows support:
> 
> 1) Windows people are accustomed to using legacy encodings
>    for text files. For many of them defaulting to utf-8
>    will be counter-intuitive.
> 2) Windows doesn't support utf-8 locales, and switching
>    the system encoding is a real pain. Thus the option.

I don't care much what is the default for Windows, but I wonder whether
this rationale is good enough to change the default for other platforms.
If you have systems configured with utf-8 and others (usually old ones)
with legacy encoding, you will store files in utf-8 in your repo, thus
having utf-8 as the default makes sense for non-Windows platforms.

BTW, when you said the system encoding above, what exactly encoding do
you mean? AFAIK, Windows has two legacy encodings OEM-CP and ANSI-CP.
If I write a console program and compile it using MS-VC then it should
use OEM-CP.  However, if you write a GUI program or a console program
that is compiled using gcc from Cygwin, you have to use ANSI-CP. For
instance, if you use the Russian locale on Windows, ASNI-CP is 1251 and
OEM-CP is 866. So, my question is what exactly encoding do you call as
"system" above?

Dmitry
