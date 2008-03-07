From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Improved treatment of links with unknown object type
Date: Fri,  7 Mar 2008 22:03:17 +0100
Message-ID: <1204923800-5923-1-git-send-email-jnareb@gmail.com>
Cc: Gerrit Pape <pape@smarden.org>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 22:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXjkA-0003vg-Qb
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 22:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760143AbYCGVDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 16:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759462AbYCGVDg
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 16:03:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:2082 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644AbYCGVDc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 16:03:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so703928fga.17
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 13:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=+d7xEDVWPhf4NpG/Vid5yY1uYRSsRYigWqQoZ6z5X5M=;
        b=m2vm2kEjEaIQyx1BMklgHwkU3DQATS4tOxlZP4GUVu56B6EwnVltxPJ7/Jmhkmr1765xePIHWy+Uv6qSmncLHnIUy1EFPOEbfe8kVg8QYABnSpwSqZdYGr9sxwMDfIiPd7tKNwNjeBJv0dJjOwmyvWgngDLTRtDWMbo9DpGBQIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mETuYRQijPINj+PweZbby4e/82x2zVaYMtyHtiKvC+9A1/AgQyruTjWoWD0BGDiWyPLVf+Me998jQBMNqlzjLEswSRgSV0ItGV/n+oYmkWfpvWuj7C29Q8FEIMHimv5Mep1FvrTw3jgET8Uvkg411Aztpjc2uhXxd44k/IQyA8Y=
Received: by 10.86.51.2 with SMTP id y2mr2001290fgy.50.1204923809024;
        Fri, 07 Mar 2008 13:03:29 -0800 (PST)
Received: from localhost.localdomain ( [83.8.243.158])
        by mx.google.com with ESMTPS id 4sm4443797fge.3.2008.03.07.13.03.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 13:03:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m27L3PUU005942;
	Fri, 7 Mar 2008 22:03:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m27L3LVU005941;
	Fri, 7 Mar 2008 22:03:21 +0100
X-Mailer: git-send-email 1.5.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76524>

This series of patches make gitweb URLs without a= parameter to use
'object' view, which finds type of requested onject and redirects
(HTTP redirect) to proper view, instead of just displaying this view.
git_object() in turn is simplified to use git_get_type() subroutine,
as was used for URLs without a=.  As 'object' view is just internal
implementation use no a= parameter instead of a=object for gitweb URLs
for which type of object (and therefore view to be used) is not known.

I guess that this series of patches can be squashed into single
commit, but I think that having them split into parts makes reviewing
them easier; it also makes possible to drop indivisual commits, for
example dropping second commit would leave gitweb with modified
finding type of an object.

Shortlog:
=========
Jakub Narebski (3):
  gitweb: Redirect to appropriate view if 'a=' parameter is missing
  gitweb: Simplify object type detection in git_object()
  gitweb: Make 'object' action implicit by using no action URL

Diffstat:
=========
 gitweb/gitweb.perl |   45 +++++++++++----------------------------------
 1 files changed, 11 insertions(+), 34 deletions(-)

This series removes more than adds mainly thanks to second patch in
the series which simplifies git_object() type detection code.

-- 
Jakub Narebski
ShadeHawk on #git
Poland
