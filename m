From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sun, 04 Jan 2009 14:07:53 -0800 (PST)
Message-ID: <m37i5abu8a.fsf@localhost.localdomain>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
	<9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
	<7vvdsv3af6.fsf@gitster.siamese.dyndns.org>
	<9b18b3110901040341n5ff5fa09s878228131d11d2a6@mail.gmail.com>
	<20090104155858.GC4205@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 23:09:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJb9r-00069j-1t
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 23:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbZADWH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 17:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbZADWH6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 17:07:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:28717 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbZADWH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 17:07:57 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1424948ugf.37
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=hhI6gD0fs+tCgXxKBcpMHCGViP3glbaX5EYW6jGdADs=;
        b=trcySnVTbtnOUY7lmi0+1Oo1fkrm0yb0mY5KZReEStzlCw37oZLyJ6TN70v5TGb+Lh
         HAk8v9pRkOTMtHwNGuAeAhFqX2IRvYsCZw0s5LoOlxzyE77M8B+YcDGOgleh6WX5FEFr
         wBoI5GwGnlKTA7gO28W43i8tWrVqFIM1ZTTFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ec4sd1w+jBe6HT3dBNLz7g3BdvZqg8eL65UfTYPDtZPK3XvvQ5XgF/ixTiRjXgTYrk
         D2a/8rbCNG581c94KhexMRLYZyW+7utk1MNqWkmi96oeW4adN1Is7UiFjbP0hVFcgYf/
         lOCvHU0f5pRBYje5EMArK300YQ5F08OetsRYI=
Received: by 10.67.123.1 with SMTP id a1mr12504122ugn.42.1231106875017;
        Sun, 04 Jan 2009 14:07:55 -0800 (PST)
Received: from localhost.localdomain (abrz203.neoplus.adsl.tpnet.pl [83.8.119.203])
        by mx.google.com with ESMTPS id u1sm51182700uge.55.2009.01.04.14.07.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jan 2009 14:07:53 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n04M7riW032163;
	Sun, 4 Jan 2009 23:07:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n04M7nNM032159;
	Sun, 4 Jan 2009 23:07:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090104155858.GC4205@ftbfs.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104544>

Matt Kraai <kraai@ftbfs.org> writes:

> I agree that what you suggest is better than the alternatives you
> present.  Unfortunately, none of them match the current behavior.
> Here's the current code:
> 
> 	if ($val eq 'true') {
> 		return 1;
> 	} elsif ($val eq 'false') {
> 		return 0;
> 	}
> 
> 	return $_[0];
> 
> Is there a way to use the form you suggest while falling back to the
> default if $val isn't set to 'true' or 'false'?

IIRC the return value is actually threestate: 1 for true, 0 for false,
and undef for non-bool config value.

BTW. git_get_project_config currently emulates old one git-config call
per configuration variable, with git-config normalizing boolean values
(returning 'true' or 'false'). But it could return Perl truish or Perl
falsish instead, as we now use "git config -l -z" + caching config
variables, and it is Perl that does normalization of boolean values.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
