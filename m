From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config options
Date: Wed, 01 Dec 2010 08:23:13 -0800 (PST)
Message-ID: <m3aakp4g5o.fsf@localhost.localdomain>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
	<7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
	<b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
	<AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
	<20101201160503.GB26120@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 17:23:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNpSk-0006MH-5W
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 17:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab0LAQXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 11:23:17 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50336 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab0LAQXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 11:23:16 -0500
Received: by gyb11 with SMTP id 11so3503968gyb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 08:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=uWqS06R8niDG89a7swAeb/XOrrlJBdWaoU8KWE5iS9k=;
        b=r547nuWQ0j3WCWwsGQhv5T2L1Ab1ULzCyJJPi6l4OLQqUxpoisQSET6pSOpG8GPe1a
         vv7EYXbveNXcr6MWrBUaCXaONJ0uanUe5m7p+HI7ydUXsBcu3Ty32cC/wUYT4YpSS6nc
         EoKffQebnIfi0TiiE1hlYF5cU8tDyhXVClgsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=wshCP7gKpos/VBbrBSSQidCxsgcm6rs0HtB/AQkMmSKm0uEhPbuS3gFnKao84TtMel
         /B+7iPJVEz43rTOgWODOW3gvCoZgcs/pRoFfihzLUHiMMh0sjG7q3lnAktMcJ4Wy8AqU
         ucFnwvueUDsMObH2lmoFPgDV62HBrTAWba0Y0=
Received: by 10.204.73.75 with SMTP id p11mr8720263bkj.46.1291220594464;
        Wed, 01 Dec 2010 08:23:14 -0800 (PST)
Received: from localhost.localdomain (abvl90.neoplus.adsl.tpnet.pl [83.8.209.90])
        by mx.google.com with ESMTPS id 11sm3501910bkj.0.2010.12.01.08.23.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:23:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB1GMaFZ023683;
	Wed, 1 Dec 2010 17:22:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB1GMCV8023677;
	Wed, 1 Dec 2010 17:22:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101201160503.GB26120@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162544>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Martin Langhoff wrote:
> 
> > So cvsimport.remote (for -r) and cvsimport.revisions (or
> > trackrevisions perhaps) seem more appropriate.
> 
> I somewhat like this idea.  So let's build a full table, shall
> we?  The embedded dashes are meant for the command-line options
> rather than the config file.
> 
> 	-v	verbosity
> 	-d	cvsroot
> 	-C	[doesn't make sense in a config file; you've already
> 		 found where to read the configuration from, right?]
> 	-r	remote
> 	-o	mainline
> 	-i	import-only
> 	-k	kill-keywords
> 	-u	replace-underscores
> 	-s	replace-slashes
> 	-p	cvsps-options
> 	-z	fuzz
> 	-P	[doesn't make much sense in a config file; for one-shot use]
> 	-m	detect-merges
> 	-M	merge-regex
> 	-S	ignore-paths
> 	-a	import-all
> 	-L	max-commits
> 	-A	authors-file
> 	-R	track-revisions
> 	-h	[doesn't make sense in a config file]
> 
> Hmm?

Good idea, though I'd rather we avoid new convention for multi word
names separated with '-' (multi-word), but rather use camel case
(multiWord).

Currently we have only unfortunate exception of `add.ignore-errors',
all others use either same case (`core.ignorecase') or camelCase
(`core.ignoreStat`).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
