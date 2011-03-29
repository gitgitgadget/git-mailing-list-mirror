From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 15:02:48 -0500
Message-ID: <20110329200230.GA377@elie>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:03:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4f83-0003Bl-Ry
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab1C2UC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:02:57 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38931 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147Ab1C2UC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:02:56 -0400
Received: by vxi39 with SMTP id 39so475278vxi.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=P4l/BwWFj9Kph2sek19c1awNZbuFju23qUuHsbJGVVE=;
        b=YL0eplHzxUFt7qR+H+bxlIl+L4UQ0wWKxEBdPNTqdRQbENQWYW23NKiPr8xu/N1hIP
         xTZxmjgAQ6oL3zLJRMZqcLNAOLzOleIuC4McgKRqG8dNX6nPBoVib5For3HfMP6pnp1i
         JTsKwrb31OpLimdPtaSzmk58etWEWfb/1H++I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=p0aU7bdPKScfj1Lr5JdwnruyyZVuIdegvkQP1eHmPPNA3C+VUhBDssVlhbiCt9EYcH
         5uPvDpeGa+zIWA3kJvOIFkfSyGdXTDfg3qbZb/jxzxAx1KgDFWPw3V+W6XBxa1oknSUr
         DZZopdp6oezCvqsFbxXNmMbPWTXmn7l/p1/mw=
Received: by 10.52.0.109 with SMTP id 13mr359470vdd.109.1301428975633;
        Tue, 29 Mar 2011 13:02:55 -0700 (PDT)
Received: from elie (adsl-76-206-232-54.dsl.chcgil.sbcglobal.net [76.206.232.54])
        by mx.google.com with ESMTPS id dc3sm1093490vdc.23.2011.03.29.13.02.53
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 13:02:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170315>

Hi,

Michael Witten wrote:

> Currently, building git with:
>
>   CFLAGS="-std=c99 -pedantic -Wall -Werror -g -02"
>
> causes gcc 4.5.2 to fail with:
>
>   vcs-svn/svndump.c:217:3: error: ISO C forbids 'return' with
>                                   expression, in function
>                                   returning void
[...]
> Signed-off-by: Michael Witten <mfwitten@gmail.com>

Thanks, looks sensible (and thanks to Junio for a pointer).  Applied to

  git://repo.or.cz/git/jrn.git svn-fe

Next step is to figure out the longstanding mysterious bash + prove
hang in t0081.

Jonathan Nieder (2):
      vcs-svn: add missing cast to printf argument
      tests: make sure input to sed is newline terminated

Michael Witten (1):
      vcs-svn: a void function shouldn't try to return something

 t/t9010-svn-fe.sh     |    8 ++++++--
 vcs-svn/fast_export.c |    3 ++-
 vcs-svn/svndump.c     |    3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)
