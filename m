From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 00/12] gitweb: remote_heads feature
Date: Fri, 24 Sep 2010 18:02:35 +0200
Message-ID: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:03:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAjv-0005c4-PO
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0IXQDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:03:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53181 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab0IXQDD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:03:03 -0400
Received: by wwd20 with SMTP id 20so25969wwd.1
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=CY0PJdwPUgepDwkbp3r01rt0YIZm3MQXTqepWjxXSJk=;
        b=lwrNkZ1LzKmejMCI3xi4LIt/fF3l+mKucbdk81WOBgMrv0X+mgSbvYULabno71ypAQ
         eWr2OiuprEeobW/LWnw6h6UEiBsCwjJGoE8bjUn1EJyAdcHeBC+xV5FLXE/qYacxGg4R
         ZduqdwphAJBBMnTNx6ka9etCNPCaN4hrxVKYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=N1tlAEoNMCeudzyPitK8mOySkzAyyecJqWPoQsNggkyKHpal3sTRBeJvu/sDw1VA9/
         8CsZZg4fCf2eGvzIvV6gQy1GFTLDvN73pxRZCmDGtuw/O4M9vFsn15IFutkk3AX3BEZe
         EOCLBjrPoDqbA/dFnBKW4gdOsp/bFhPLo+oNw=
Received: by 10.216.155.206 with SMTP id j56mr2888622wek.67.1285344182333;
        Fri, 24 Sep 2010 09:03:02 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id n40sm1434682weq.5.2010.09.24.09.02.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:02:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157001>

New version of the remote heads feature for gitweb (v5 because the
previous rehash was actually v4, although I forgot to prefix the
patchset accordingly).

I've included all the comments received from the previous review (unless
I forgot about something), as well as the suggestions about how to
select and present remotes in summary view.

The first 4 patches are rather straightforward and can probably go
straight in. The 5th patch is a bugfix for something that is only
triggered by the name manipulation done with the remote heads, but can
probably useful even without the rest of the series.

Patch 7 provides 'single remote view', depending on patch 6 for
improved visuals of the page header.

Patches 8-9 present a new routine for grouping data (will only be used
by the final patch in this set presently, but it has other prospective
uses too), patch 10 introduces refactors some code that is used in
summary view (patch 11) and in the final version of the remotes view
(patch 12).

Remotes view now displays the remote URL(s) together with the heads (or
only the URL(s) in summary view if there are too many remotes), although
I'm open to suggestions about the opportunity of displaying ssh URLs.

As usual, you can see it live @ http://git.oblomov.eu (look at the rbot
project in particular for the "lots of remotes" case), comments welcome.

Giuseppe Bilotta (12):
  gitweb: introduce remote_heads feature
  gitweb: git_get_heads_list accepts an optional list of refs.
  gitweb: separate heads and remotes lists
  gitweb: nagivation menu for tags, heads and remotes
  gitweb: use fullname as hash_base in heads link
  gitweb: allow extra text after action in page header
  gitweb: remotes view for a single remote
  gitweb: auxiliary function to group data
  gitweb: group styling
  gitweb: git_repo_url() routine
  gitweb: use git_repo_url() in summary
  gitweb: gather more remote data

 gitweb/gitweb.perl       |  256 ++++++++++++++++++++++++++++++++++++++++++++--
 gitweb/static/gitweb.css |    6 +
 2 files changed, 252 insertions(+), 10 deletions(-)

-- 
1.7.3.68.g6ec8
