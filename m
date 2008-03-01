From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: ambiguous git-log date and timestamp syntax
Date: Sat, 01 Mar 2008 09:10:39 -0800 (PST)
Message-ID: <m3d4qejroy.fsf@localhost.localdomain>
References: <715587AA-D485-4B31-A786-D26334506007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 18:11:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVVF3-0005in-FZ
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 18:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbYCARKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 12:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbYCARKo
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 12:10:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:2038 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYCARKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 12:10:43 -0500
Received: by ug-out-1314.google.com with SMTP id z38so942937ugc.16
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=mmgvKYIvbzYlv0aDXkrppmZNQdEeZl9NmUFJRLPgBsg=;
        b=aVVHJ62CzwF43iPeS7cl+vp5R57IHEH6n+AO932pB2rQ+pe4J1qiPSVvm0knSOqSTEd2Q0t7O70g26TwccUWG6961P9RwgKlyM4Ytc+bR9hSvwoD7DHTct1R5Qw0BWKOgjuN5OvZGeH0GekGM4BiojgMxVIel25Px+1+A4Y8INI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=fMLD+ChPiudzvTsxovxLmUdzq5R1mV07x3gih0mc2uRrZIcTvaWO4jrbOZuFmlfDnI08ksdKlZ2PZ95anipGcTC7ySUIFOBXVN+ju9rxy/3CSVTxXv2AnFwSGC+ns5Mzl6ML3Ic7Ek4chzO/X1S7sj88Hmp1M5mGDvvKQKk3LT4=
Received: by 10.66.250.18 with SMTP id x18mr3042983ugh.79.1204391441491;
        Sat, 01 Mar 2008 09:10:41 -0800 (PST)
Received: from localhost.localdomain ( [83.8.199.142])
        by mx.google.com with ESMTPS id j2sm1156261ugf.5.2008.03.01.09.10.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Mar 2008 09:10:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m21HAcVI000742;
	Sat, 1 Mar 2008 18:10:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m21HAbYC000739;
	Sat, 1 Mar 2008 18:10:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <715587AA-D485-4B31-A786-D26334506007@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75686>

"Rhodes, Kate" <masukomi@gmail.com> writes:

> The docs are a little vague on exactly what your options are when
> specifying dates. If someone can provide me some details on this I'll
> make a patch for the docs.
> 
> --since=date, --after=date
> 	Show commits more recent than a specific date.
> --until=date, --before=date
> 	Show commits older than a specific date.

Those are porcelain (meant for user) options.

> --max-age=timestamp, --min-age=timestamp
> 	Limit the commits output to specified time range.

Those are plumbing (meant for scripts) options.

For example git-rev-parse translates --since into --max-age, etc.

> From what I can tell it seems that dates can be specified relatively,
> e.g. "2 hours ago", or with any ISO 8601 or RFC 2822 date syntax. Is
> this correct, and are there any docs on specifying relative dates?

I don't know why git doesn't use getdate_r for this, instead rolling
out its own date parsing routines: approxidate*, parse_date. From what
I remember it should accept any date "date" (from coreutils) accepts,
but it does (from comments) for date to be in "C" locale.

So I'm sorry, but I cannot help you here...

> I can't find any details on what the "timestamp" format should be. Can
> someone point me in the right direction?

Timestamp is Unix date (epoch), i.e. number of seconds since
1970-01-01 00:00:00 UTC, the format git uses for dates in commit and
tag objects.
 
> -Kate == masukomi
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
