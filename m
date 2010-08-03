From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git instaweb + webrick does not work
Date: Tue, 03 Aug 2010 15:07:48 -0700 (PDT)
Message-ID: <m34ofbpcyr.fsf@localhost.localdomain>
References: <1272BF62-A0C8-4940-9472-E46C05BF1723@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Mike Dalessio <mike@csa.net>
To: Michael Dippery <mdippery@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 00:07:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgPeP-0005LS-Ao
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 00:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801Ab0HCWHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 18:07:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36181 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932556Ab0HCWHu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 18:07:50 -0400
Received: by fxm14 with SMTP id 14so2169150fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 15:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=LOLcF6FdcHgipSrjChljoFf0jj4I/daHwdQZGEHR0ds=;
        b=ZQjM3tj31g2N3RHQBIhpVNChr+QIrmlnYc0ffiEIh8pqxW8E+cblXYwvbjWYEO9wxZ
         H2RO3XMJvU1UjxWMvkhopWfx1rsbagTL7UPfy5ASi5TAwXWGrpcZv2xC0vfnsiY+vIO1
         up/1+/UcWO28a35RDsx3TMqUfZxt6+X/TJTlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=edpsLnokaEIOPeUCbmsl+0ZbHKyrFoE9SD69vdOyqOs9+AYZixn5NiWxguXU/5t1rs
         bxb/4NEuortQFM77YlEox14Q/+ewa60EJe9cWgw9JZ3WnC7fCd4buCRd+tMrPt+1IY8z
         PulcDviBRVrfJN4sDb1pD0TgMg4wB8WBuAnJk=
Received: by 10.223.113.135 with SMTP id a7mr7999686faq.40.1280873269556;
        Tue, 03 Aug 2010 15:07:49 -0700 (PDT)
Received: from localhost.localdomain (abwi87.neoplus.adsl.tpnet.pl [83.8.232.87])
        by mx.google.com with ESMTPS id b36sm2700403faq.11.2010.08.03.15.07.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 15:07:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o73M7msE006620;
	Wed, 4 Aug 2010 00:07:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o73M7PNd006615;
	Wed, 4 Aug 2010 00:07:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1272BF62-A0C8-4940-9472-E46C05BF1723@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152544>

Michael Dippery <mdippery@gmail.com> writes:

> I'm trying to use `git instaweb` with Ruby's webrick (which I have
> installed) on Mac OS X, but every time I fire up it up via `git
> instaweb --httpd=webrick`, I get the following error:
> 
> "webrick not found. Install webrick or use --httpd to specify
> another httpd daemon."
> 
> I _do_ have webrick. Asking around a bit, I was told the the problem
> may have been introduced in commit be5347b. Is this so? If not, any
> other ideas on what may be causing the problem?
> 
> I'm using Git v1.7.2.1 on Mac OS X 10.6.

To be more exact commit be5347b (git-instaweb: Put httpd logs in a
"$httpd_only" subdirectory, 2010-05-28) by Pavan Kumar Sunkara added
resolve_full_httpd before running *_config (webrick_config in this
case).  But resolve_full_httpd() beside setting $httpd_only needed
later for functionality provided by this commit, does also setting
$full_httpd and checking if given web server can be run.

The `webrick' support in git-instaweb is peculiar in that webrick_conf
creates 'webrick' shell script in "$GIT_DIR/gitweb/".  The code that
checks if web server is available in resolve_full_httpd() searches
also in "$GIT_DIR/gitweb/"... but it is run before webrick_conf
function in git-instaweb has a chance to generate 'webrick' script.

The solution would be to either split resolve_full_httpd() into one
function generating $httpd and $httpd_only, and second function
generating $full_httpd and checing for web server existence, or create
a separate check for 'webrick'.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
