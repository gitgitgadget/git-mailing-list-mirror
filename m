From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 0/5] *** SUBJECT HERE ***
Date: Mon, 13 Oct 2008 12:19:20 +0200
Message-ID: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 12:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpKXZ-0003aN-4Z
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 12:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763149AbYJMKT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 06:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762610AbYJMKTZ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 06:19:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:34191 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761500AbYJMKTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 06:19:17 -0400
Received: by ug-out-1314.google.com with SMTP id k3so472841ugf.37
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=w8P/HAvfkkaYIZl+Xg2FaqfiO6jcHuivOSx8wU57JoE=;
        b=TUvl4HHFNQ9uj5GihtvDmJnRaYLy0ISIbuVHGoEJGk6/vIJzpJJfayOSQqsB/RRxAp
         OkD1Ugv6MRwkDJlaSgQ4GxlRgemzBR6/y4BkQXwSERxlZ8eCFZ1HgSI5vLPqGSu3gUmE
         KNoEa9UhBbNf5H7dyX+fM2McS9jG0wYu3+kYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nDeHrLyhlOpucOIK/JzhG39xe9XBPT3lQb7gpbs8zD+SaSJVDs8QB+4CE8yIP8OCBd
         IeXC8FQOx6h2YPTu6DvflIgTSOoDYvg/BF4zqWx3CS0XGkj0ih2NMw/hrQNPCoO74p4Z
         qivo3DJ0WnffVgrWZTVwsMo91rwPcyspjmV3Q=
Received: by 10.210.130.14 with SMTP id c14mr5262705ebd.187.1223893155269;
        Mon, 13 Oct 2008 03:19:15 -0700 (PDT)
Received: from localhost ([78.15.14.149])
        by mx.google.com with ESMTPS id 5sm9710603eyf.8.2008.10.13.03.19.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 03:19:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98103>

Fifth attempt for my gitweb PATH_INFO patchset, whose purpose is to
reduce the use of CGI parameters by embedding as many parameters as
possible in the URL path itself, provided the pathinfo feature is
enabled.

The new typical gitweb URL is therefore in the form

$project/$action/$parent:$file..$hash:$file

(with useless parts stripped). Backwards compatibility for old-style
$project/$hash[:$file] URLs is kept, as long as $hash is not a refname whose
name happens to match a git action.

The main implementation is provided by paired patches (#1#2, #4#5)
that implement parsing and generation of the new style URLs.

Patch #3 is a minor improvement to the URL syntax that allows web
sites to be properly browsable in raw mode.

The patchset depends on my previous input parameter handling patch currently
waiting in 'next'.

Giuseppe Bilotta (5):
  gitweb: parse project/action/hash_base:filename PATH_INFO
  gitweb: generate project/action/hash URLs
  gitweb: use_pathinfo filenames start with /
  gitweb: parse parent..current syntax from PATH_INFO
  gitweb: generate parent..current URLs

 gitweb/gitweb.perl |  124 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 114 insertions(+), 10 deletions(-)
