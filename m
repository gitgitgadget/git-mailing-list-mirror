From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3.1 3/5] Introduce new pretty formats %g[sdD] for reflog information
Date: Sat, 17 Oct 2009 08:06:13 -0700 (PDT)
Message-ID: <m3y6nadpu2.fsf@localhost.localdomain>
References: <8a5b3a586d437f02e2a75edd2786636b605522a7.1255701207.git.trast@student.ethz.ch>
	<e0ab6923eb4057bcbc8e97980dad5e4a37e53067.1255790816.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Oct 17 17:07:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzArP-000860-8d
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 17:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbZJQPGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 11:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZJQPGN
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 11:06:13 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:36815 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZJQPGL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 11:06:11 -0400
Received: by fxm18 with SMTP id 18so3456243fxm.37
        for <git@vger.kernel.org>; Sat, 17 Oct 2009 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=KXia4Hnrv7DiPBzuZGlHnCSRsmq6lX8ZtB4ME3M/b0U=;
        b=iovDNF36+rqGD+2KujBfr9UWWO1K5iu/nmhk9lRgJg+OKAq5FA/YUh5Jl5ZSDv2iwU
         JosG3F5Df34z1Fq+yQuQWhfDgUmmXlu87LXf/oMUk3oijXEh37wujY3iRJOfPt3OMKBY
         ktLaIbTELiXSfr0XoX4smwHFd33o4qVLajtA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WXYlREaSBQlYeVQ7yDS2OGfeQ2XxFagcaMgLEPf4mWJYmkjv3o1VtgyuRSvFEYlkny
         IAl6WUP0iGeFd12NM7+rZmInBl01s6KJLkMCQHyzxfUN4Qc6yKL+BQsU7D7gMhpCxMm0
         XsP1ROqTdeCS9HLfsk3GQMiDVMBpdq8WmNDyY=
Received: by 10.204.156.19 with SMTP id u19mr2644046bkw.62.1255791974853;
        Sat, 17 Oct 2009 08:06:14 -0700 (PDT)
Received: from localhost.localdomain (abvw176.neoplus.adsl.tpnet.pl [83.8.220.176])
        by mx.google.com with ESMTPS id 28sm3201878fkx.31.2009.10.17.08.06.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Oct 2009 08:06:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9HF506b031611;
	Sat, 17 Oct 2009 17:05:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9HF4Ltf031603;
	Sat, 17 Oct 2009 17:04:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <e0ab6923eb4057bcbc8e97980dad5e4a37e53067.1255790816.git.trast@student.ethz.ch>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130559>

Thomas Rast <trast@student.ethz.ch> writes:

> Note that the --format="%h %gD: %gs" tests may not work in real
> repositories, as the --pretty formatter doesn't know to leave away the
> ": " on the last commit in an incomplete (because git-gc removed the
> old part) reflog.  This equivalence is nevertheless the main goal of
> this patch.

Perhaps just-introduced grouping syntax would help there?  You could
for example write

  --format="%h%[all() %gD: %gs%]"

which would expand nested group if _all_ placeholders within it have
expansion.  Perhaps %[ ... %], or %[? ... %], or %[* ... %] could be
shorter versions...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
