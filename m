From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the CGI script
Date: Tue, 22 Mar 2011 14:50:10 -0700 (PDT)
Message-ID: <m339mex299.fsf@localhost.localdomain>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
	<20110316143420.GA15371@elie>
	<1300286650.28805.29.camel@drew-northup.unet.maine.edu>
	<m3lj0e59ps.fsf@localhost.localdomain>
	<loom.20110322T165315-910@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Ryan <matt@devaldez.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:50:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q29T4-0007xF-32
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 22:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326Ab1CVVuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 17:50:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51506 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab1CVVuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 17:50:15 -0400
Received: by fxm17 with SMTP id 17so6834916fxm.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=xx/nr28Gv00MSZAbvd4FCckI1WCo58X0T+QEJdXQ35c=;
        b=a4XACzILE/2hi0FINEA3chiuWhB7eMZQLYSbtFLSTew0BxM/pxEdqQ374Zxp5hmW/t
         jjIdlapZlw9oV6FSUHjLqHwIYwxVVz7w3PiqJAulWpcuLuCn/ADIquf2ox/XY6EK4nwv
         lkgqoSKRYnc18gvbtsZp74Po9nVrTHA7yv+94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=kLL/pJVLIbbvnGUYJSDpNKwltQ/6zLWn0oveNi1mBWRN21LI+w7DmY/Ewo/GFZFgGn
         vonz7i8Yh8zU6j8uOcQslEpmUuBhDQEU3Pqo39jqtMZZHIvEynJ229/9L4aWAABX0A6L
         pzgSCuXZeW0AK2X6K6oOeeTHlikZIVIHQ2cvI=
Received: by 10.223.14.137 with SMTP id g9mr1446461faa.1.1300830612958;
        Tue, 22 Mar 2011 14:50:12 -0700 (PDT)
Received: from localhost.localdomain (abwf225.neoplus.adsl.tpnet.pl [83.8.229.225])
        by mx.google.com with ESMTPS id o17sm3178657fal.1.2011.03.22.14.50.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 14:50:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2MLeo45011510;
	Tue, 22 Mar 2011 22:41:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2MLeYTZ011498;
	Tue, 22 Mar 2011 22:40:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20110322T165315-910@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169780>

Matt Ryan <matt@devaldez.com> writes:

> Hey, I don't mean to contribute to the confusion. 
> But, after adding a gitweb_config.perl in the 
> same directory as the cgi I haven't seen all the 
> changes take place. I tried something simple to start like so:
> 
> $feature{'blame'}{'override'} = [1];

This doesn't turn on 'blame' feature, but only allows override with
per-repository gitweb.blame repository configuration variable.

You probably wanted to use 'default', not 'override' here.

> $feature{'forks'}{'default'} = [1];

As you can read in comments, this is about very specific layout of
repositories, namely that forks of 'path/to/repo.git' are all
somewhere below 'path/to/repo' directory.

If you don't have forks organized in such way, you wouldn't see
changes from this feature.

> $feature{'avatar'}{'default'} = ['gravatar'];

This requires that email addresses of authors, committers and taggers
have gravatar entry.  This means that you have to create "account" on
http://www.gravatar.com).

> 
> Gravtar is now working, but I haven't seen 
> the blame or forks added. Any help would be appreciated, 
> thanks!


Hope that helps.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
