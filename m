From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: crash proof / recovery from power loss
Date: Thu, 25 Jun 2009 06:11:52 -0700 (PDT)
Message-ID: <m37hz0xxuq.fsf@localhost.localdomain>
References: <20090623210556.GB31015@twin.sascha.silbe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sascha Silbe <sascha-ml-reply-to-2009-2@silbe.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 15:12:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJokH-000845-8K
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 15:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbZFYNLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 09:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755313AbZFYNLw
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 09:11:52 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:45866 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbZFYNLu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 09:11:50 -0400
Received: by bwz9 with SMTP id 9so1384871bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=nCydaIuURoMj2ebCGpREwtKGFUuvp9tJhvzsp8ff0Mo=;
        b=tFL+toPMkWjbB3uJM+TI5ubzLbEtRldZM6/U9HNK4+CAJVpABiMgXyG6b6WxMWis3z
         LzILLKTPy1lES3Ckx2HOPDvv9GH3P/DLJvIZPR2Cybqx2G0KG9tB9sgLN6V7ulGyubDy
         Nr5GNn1pJXyaoxb7QFw/B42d+Go96NF5y14wU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=aOnvsdQVQ3l2t6sUxIvCmcwMGVzkspy9nv3rQrc0Hk63xVpE5hfWiaDBZKr6FGM4o8
         804b8+qAgfqmx/rtnex+NlPxBDfOpjshL20yicOdNN4ch4/Kgs/baIMaYZVaSI/79MkX
         KFmugcGDLZNdIQSPSt0f7l+qnNlGG55wAlBjs=
Received: by 10.204.72.15 with SMTP id k15mr2486885bkj.14.1245935512743;
        Thu, 25 Jun 2009 06:11:52 -0700 (PDT)
Received: from localhost.localdomain (abwu167.neoplus.adsl.tpnet.pl [83.8.244.167])
        by mx.google.com with ESMTPS id 31sm3476140fkt.13.2009.06.25.06.11.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 06:11:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5PDBAJ6018703;
	Thu, 25 Jun 2009 15:11:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5PDAspe018690;
	Thu, 25 Jun 2009 15:10:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090623210556.GB31015@twin.sascha.silbe.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122206>

Sascha Silbe <sascha-ml-devel-vcs-git@silbe.org> writes:

> I'm going to use git as a back end for the Sugar data store /
> Journal. [1]
>
> One thing I'm worried about is how it's going to behave if a crash
> (e.g. power loss - no corruption) occurs.
> What can happen in such a case? Is it always recoverable and if so, how?
> 
> 
> [1] http://wiki.sugarlabs.org/go/Version_support_for_datastore

In Git all operations are atomic.  

In most cases Git uses the following 'trick': it first
downloads/saves/creates data, and only then automatically update
information that it is available.  So crash would result in some
unreachanble objects, which would go away on prune.

In some cases Git uses locks to ensure atomicity.  I don't know what
happens with locks after a crash...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
