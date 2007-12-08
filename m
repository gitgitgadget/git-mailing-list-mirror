From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make config_to_multi return [] instead of [undef]
Date: Sat, 08 Dec 2007 08:13:45 -0800 (PST)
Message-ID: <m38x45tb9y.fsf@roke.D-201>
References: <20071208123058.7364.25491.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Dec 08 17:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J12Jn-0004nZ-1r
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 17:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbXLHQNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 11:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbXLHQNx
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 11:13:53 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:37250 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbXLHQNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 11:13:52 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1439593mue
        for <git@vger.kernel.org>; Sat, 08 Dec 2007 08:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=blK+ligalry1U+haR8XwXIkBc4RIAmjcu0EdDpEOURY=;
        b=loOLoW07QNIUZHkcsTEqHRCVpEwumPujR7c5BDLoYsj3OA3M0qmtKtPlzD8EZ1ZpWY2WLjS5RY+etaJQ2UszZ+JRgKlNkhtZra+3q5pKYDPKVLZ7iylmQ0gCrmZLXlVIjNCuSwSezBTnT2xrtqU1MYHKo6BPx2op9RaXY72fYrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=KaVrrKo6y3AzanJDlKHKVjexSz54DilyfgHyAvLvogJlMmx8H2RBQM9v/qPsqN/RkXXTi9rOxe11Ft34orRQoOzTzemJ2vhUYjJ125LL5yXFCDNeBzgr878AdgyzK1iqK3sXjZ1v7T4nSwtuiMfF4z3eLHpR+PaZgxD3anVn0hE=
Received: by 10.82.181.7 with SMTP id d7mr4140535buf.1197130427243;
        Sat, 08 Dec 2007 08:13:47 -0800 (PST)
Received: from roke.D-201 ( [83.8.230.31])
        by mx.google.com with ESMTPS id i5sm2300569mue.2007.12.08.08.13.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Dec 2007 08:13:45 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB8GDiRm017508;
	Sat, 8 Dec 2007 17:13:46 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB8GDfTi017504;
	Sat, 8 Dec 2007 17:13:42 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071208123058.7364.25491.stgit@rover>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67558>

Petr Baudis <pasky@suse.cz> writes:

> This is important for the list of clone urls, where if there are
> no per-repository clone URL configured, the default base URLs
> are never used for URL construction with this patch.

Thanks.
 
> @@ -1512,7 +1512,7 @@ sub config_to_int {
>  sub config_to_multi {
>  	my $val = shift;
>  
> -	return ref($val) ? $val : [ $val ];
> +	return ref($val) ? $val : $val ? [ $val ] : [];
>  }

Shouldn't it be

  +	return ref($val) ? $val : defined($val) ? [ $val ] : [];

-- 
Jakub Narebski
