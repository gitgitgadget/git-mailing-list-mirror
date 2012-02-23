From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 05:15:21 -0800 (PST)
Message-ID: <m34nuhelnf.fsf@localhost.localdomain>
References: <4F46036F.3040406@gmail.com>
	<20120223102426.GB2912@sigill.intra.peff.net>
	<4F462E61.4020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nikolaj Shurkaev <snnicky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 14:15:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0YWA-0003uE-7y
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 14:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab2BWNPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 08:15:24 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56537 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab2BWNPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 08:15:24 -0500
Received: by eekc4 with SMTP id c4so396804eek.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 05:15:23 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.199.193 as permitted sender) client-ip=10.14.199.193;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.199.193 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.199.193])
        by 10.14.199.193 with SMTP id x41mr898103een.29.1330002923076 (num_hops = 1);
        Thu, 23 Feb 2012 05:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qq2pMQ4hccqkd7wSm8rJL0sK8xVvpZBSDysAWurs6h8=;
        b=TRLSR02ysrRKHM2N90CAWsifUJi4ri2+GZB5ds2SlQfQF0cF2n7/puE0T0Rq5D2c7u
         BEaukwKIn/aad9QtD+bdenp6cG6aHL5c4ReSX+9mqJCqSbc/Sgm4INysC3QoESBErGDp
         oDyV1WWG6L9nIzipNFRKMnw+JCITmUTHr/oPk=
Received: by 10.14.199.193 with SMTP id x41mr703782een.29.1330002922876;
        Thu, 23 Feb 2012 05:15:22 -0800 (PST)
Received: from localhost.localdomain (abvx74.neoplus.adsl.tpnet.pl. [83.8.221.74])
        by mx.google.com with ESMTPS id n56sm5287257eeh.6.2012.02.23.05.15.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 05:15:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1NDFHQd003007;
	Thu, 23 Feb 2012 14:15:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1NDFGpX003004;
	Thu, 23 Feb 2012 14:15:16 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4F462E61.4020203@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191362>

Nikolaj Shurkaev <snnicky@gmail.com> writes:

> Thank you very much for your tips. They really helped me. I was trying
> to create patches that would affect only some given files or
> folders. By this moment I have the following:
> 
> GeneratePatches.sh
> ---------------------
> #!/bin/bash
> #parameter 1 - <since>..<to>
> #parameter 2 - path to file
> git log -z --reverse --format=email --patch "$1" -- "$2" | xargs
> --null --max-args=1 ./CreatePatchFile.sh
> ---------------------
> 
> and CreatePatchFile.sh
> ---------------------
> #!/bin/bash
> 
> myPatchNumber=$(ls ./*-patch.patch 2>/dev/null | wc -l)
> let "myPatchNumber += 1"
> 
> patchFile="./"$(printf "%04d" $myPatchNumber)"-patch.patch"
> echo "$@" > "$patchFile"
> ---------------------
> 
> I call
> ./GeneratePatches.sh HEAD~3..HEAD SomePath
> and that produces something very similar to what I want.
> 
> Perhaps there is a better way to do that.

So what git-format-patch is lacking?

-- 
Jakub Narebski
