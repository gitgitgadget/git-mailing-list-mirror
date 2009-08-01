From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5] Add Gitweb support for XZ compressed snapshots
Date: Sat, 01 Aug 2009 01:14:35 -0700 (PDT)
Message-ID: <m3zlakq7bt.fsf@localhost.localdomain>
References: <B05AF655-7430-420A-A22E-389601558B0D@uwaterloo.ca>
	<4A739087.1090301@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Aug 01 10:14:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MX9js-0004bb-57
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 10:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbZHAIOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 04:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbZHAIOi
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 04:14:38 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37153 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbZHAIOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 04:14:37 -0400
Received: by ewy10 with SMTP id 10so1986146ewy.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=bIXkSXgbSUy10gBmYrhI4+SA9rd5gBwAIBmxCct3I78=;
        b=pXQq9KU7fSqyqnbSI7dgbslyCaZKDsBxeipcTSio5P3EcS1l3hO2jJtHk9K/4z5Qhm
         1+sFXqujxr/L4JBMTccqJYX6Nsgfy59t2M+6fqqPYqTvH3fQJCl43jBOvG4kA+lASmaQ
         tSbl0prsynKD5x2+SIRFBEe6cEz74FsoEDFvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=d7iVa1WllVOgl9YMJlXdB0ER0E1yuWXJHD9u9JGINHoXWVy90JHvwRKlT/YMJkBNkr
         zDA34ZuhxrKk8woSuS+z/oXlsXan1sVaRInO7L+EiEJ4mar218QIIk9eGI64JdCt/oO8
         EuwDmZzrOm9qyyGzlu7bdzbCdzNxET0+dHE4M=
Received: by 10.210.102.12 with SMTP id z12mr4216870ebb.89.1249114476419;
        Sat, 01 Aug 2009 01:14:36 -0700 (PDT)
Received: from localhost.localdomain (abvt17.neoplus.adsl.tpnet.pl [83.8.217.17])
        by mx.google.com with ESMTPS id 5sm5775334eyh.56.2009.08.01.01.14.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 01:14:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n718EWZd005718;
	Sat, 1 Aug 2009 10:14:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n718EVG9005714;
	Sat, 1 Aug 2009 10:14:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A739087.1090301@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124611>

"J.H." <warthog19@eaglescrag.net> writes:

> Well you can always call xz with -[1-9] to change the compression
> level (same as gzip and bzip2) though I think a full disabling would
> be 'more' preferable, though I'm not sure I like Jakub's suggestion of
> just deleting it after the fact, it would work.
[...]

The problem is that 'keys %known_snapshot_formats' serves also as list
of allowed snapshot formats, if project specific override is enabled.
We can add another optional flag ('disabled' => 1) if you don't want
to delete from %known_snapshot_formats in $GITWEB_CONFIG, though I
don't know if it is worth it.  Anyway such mechanism can be added, and
IMHO should be added, in a separate commit.

> I think more my concern is more what's enabled by default, and since
> xz is still new (as was pointed out) it's probably worth only enabling
> if the admin selects it to be enabled.

By default (i.e. as in gitweb in git.git) 'snapshot' feature has
disabled projects specific override.  Which means only 'tgz' snapshot
is enabled / used.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
