From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Implementing CSP (Content Security Policy) for gitweb in the future
Date: Sun, 5 Jun 2011 15:33:51 +0200
Message-ID: <201106051533.51735.jnareb@gmail.com>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com> <201106051103.59541.jnareb@gmail.com> <1307278350.23564.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Sun Jun 05 15:35:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTDTq-0004wZ-6M
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 15:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab1FENeC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 09:34:02 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58031 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab1FENeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 09:34:01 -0400
Received: by fxm17 with SMTP id 17so1984539fxm.19
        for <git@vger.kernel.org>; Sun, 05 Jun 2011 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=R4pDKn50y9LpTzoAlzsI3S1Mu6rGUC1WVuHNE8y8AuE=;
        b=R73nxAirdmSP4a6/FinP+rphg8xiJiJiyniYFwND1E7qDxjz9dL52ZwjNM6s7Az2YU
         m3PznzB+2eM0dTtONCpCi9pkHJoXjJ4cmm3FUj82GWrSUpMsR+23N3Sg9DaF9pzX/zXu
         miRFN/uCGMjFcL7aN0F7wAVyUh/Nb8eKmeSWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=woONGa2OU5s8uh+hP9c8QHhVfq6UoCU2ziZdbI/bdNspkP5RCl31YNi9tHbOJEpbbn
         BF4HZQi8yudSOnCn9snZYShwJdoMskeiSPqSUlCnoZ0J2PIhxPh03nHtsa774n0GAwfW
         KlB8eIn1HMGyLhOSZ/7YbB919M8f3T5Ausq9s=
Received: by 10.223.13.13 with SMTP id z13mr1169411faz.114.1307280839652;
        Sun, 05 Jun 2011 06:33:59 -0700 (PDT)
Received: from [192.168.1.13] (abvi97.neoplus.adsl.tpnet.pl [83.8.206.97])
        by mx.google.com with ESMTPS id r10sm1031102fah.26.2011.06.05.06.33.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Jun 2011 06:33:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1307278350.23564.5.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175075>

On Sun, 5 July 2011, Matt McCutchen wrote:
> On Sun, 2011-06-05 at 11:03 +0200, Jakub Narebski wrote:

> > In the future however it might be better solution for gitweb to implement
> > (as an option) support for CSP (Content Security Policy), which IIRC did
> > not exists in 2009, in addition to current $prevent_xss.
> 
> Sure.  CSP is not a substitute for designing to prevent harmful HTML
> injection, but a mitigation for some of its worst effects in case some
> injection points are overlooked.  There's no reason not to enable it by
> default with $prevent_xss, though third parties adding functionality to
> gitweb would need to know to disable it or modify the policy
> accordingly.

I propose CSP support _in addition to_ and not replacing $prevent_xss
(which would be nice to have more fine-grained control over).

Well, while we can whitelist HTML fragment from README.html, or render
README.md / README.rs / README.pod etc. instead of blocking it like gitweb
currently does if $prevent_xss is enabled, I don't think it would be
feasible to do the same for text/html 'blob_plain' pages. 

Serving HTML pages etc. from 'blob_plain' view with path_info links
is quite useful feature; this way one can use gitweb as a cheap and easy
way to deploy web pages and web apps; or just test results of development.
CSP would serve this purpose well; current $prevent_xss behavior of
serving as attachment (forcing download), or serving them as text/plain
as e.g. GitHub does simply remove this feature.

-- 
Jakub Narebski
Poland
