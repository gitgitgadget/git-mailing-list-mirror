From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2009, #04; Sun, 15)
Date: Sun, 15 Feb 2009 03:12:17 -0800 (PST)
Message-ID: <m3ocx4t0mv.fsf@localhost.localdomain>
References: <7v1vu0nfu4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Sebastien Cevey <seb@cine7.net>
X-From: git-owner@vger.kernel.org Sun Feb 15 12:13:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYewX-0005LM-S7
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 12:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbZBOLMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 06:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbZBOLMV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 06:12:21 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:32277 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZBOLMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 06:12:20 -0500
Received: by mu-out-0910.google.com with SMTP id i10so736110mue.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 03:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=d5i45uuc1wpgzQQl394W6KalytfUAmc3QY96rQtSjBg=;
        b=plZabaaIQiSpHSPem6cs+6UXjSVlHU1a+nucq7ipX+cKVP3s+k3a3zZhFaazOhcAm5
         0IZE72vTAxVDJTqoON1X5BB12josqkfFGOpbKA0eJ4KYHsQJ1cNq08bWbrxKeCyaawMY
         UHQXdLr0minTu1Uu6hxY0xOspCffoNVmM8dlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=EWCYptbHjuwPQSIxzGZpp7r51LQnmzkSn9odbJPgkMzBVtWh9RobvFvSWz37RvXYlM
         RJkFnRphq7oVxjQZ9oqZ0DylQDXEJl2w6/wmdJQqWuahXNaeQDv5wA5UnzHF6AQCjWgD
         fCS6LbgRRw2V4Kv3vbrX0t8q0J/b/JcJ/pf5o=
Received: by 10.103.218.9 with SMTP id v9mr2291310muq.78.1234696338275;
        Sun, 15 Feb 2009 03:12:18 -0800 (PST)
Received: from localhost.localdomain (abvc8.neoplus.adsl.tpnet.pl [83.8.200.8])
        by mx.google.com with ESMTPS id s11sm3675169mue.17.2009.02.15.03.12.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 03:12:17 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1FBCD7U025991;
	Sun, 15 Feb 2009 12:12:14 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1FBC94s025987;
	Sun, 15 Feb 2009 12:12:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v1vu0nfu4.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109992>

Junio C Hamano <gitster@pobox.com> writes:

> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>  - gitweb: Optional grouping of projects by category
>  - gitweb: Split git_project_list_body in two functions
>  - gitweb: Modularized git_get_project_description to be more generic
> 
> Design discussion between Jakub and Sebastien seems to have stalled.

I have changed signature of new git_get_file_or_project_config in
first patch in series from $variable_name, $repo_path to reverse
order, i.e. $repo_path, $variable_name to make it easier to extend it
further in the future if needed (for example have config variable name
be different from name of file in $GIT_DIR).  BTW. commit message
should mention what for this refactoring is preparing.

But I am bit stalled at second patch in the series, which extract
_printing_ the rows in separate function... while it should IMHO also
refactor _filtering_ projects list, and not have "filtering as we
print" current code uses... which would be night incompatibile with
dividing projects list into pages.

I think this patch series is definitely for after 1.6.2
-- 
Jakub Narebski
Poland
ShadeHawk on #git
