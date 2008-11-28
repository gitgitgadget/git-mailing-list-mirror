From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 0/2] fixes to gitweb feature check code
Date: Fri, 28 Nov 2008 21:39:51 +0100
Message-ID: <1227904793-1821-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 21:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6A90-0007Jo-4W
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 21:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbYK1Ujd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 15:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbYK1Ujd
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 15:39:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:16189 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbYK1Ujd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 15:39:33 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2079235ugf.37
        for <git@vger.kernel.org>; Fri, 28 Nov 2008 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vmC5OOND87Pm6GERtO/sAe8sZ/uXh8TbpwhQUto6sPQ=;
        b=AwUM6R1hNJtJmZ0oZ3gHy4Dtd2lpMWpBfBg4QhdI2b6iXj4u8pd102joHit6Mk4aTr
         X3kYs5WzMh6BWjLOCq0qRjmjG5oHSij4ech+DvX2V6Jep01YcXxlKOiZLn2uusr6qbMF
         tlur3lGw/RTTD6vn3A94I4H1LxkOYqsdQY/98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=I2DzJaeFOwJKlhzzpDmPe+sUqI0zYanIiIShkzHYXcFKgEaWEZZs3jiSye9QthPVc2
         kwu4sVx5kdl0P++u7dXvC6JrYFpY3ARyQvVSt8Rn9jQKjo0hX63ETb+GfjsxwLM3PkU3
         dzaaPjOcs9J1maZioJkzGESvjYqbef5dlSFDw=
Received: by 10.103.222.1 with SMTP id z1mr3289600muq.100.1227904771128;
        Fri, 28 Nov 2008 12:39:31 -0800 (PST)
Received: from localhost ([78.15.14.10])
        by mx.google.com with ESMTPS id u9sm2666243muf.34.2008.11.28.12.39.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Nov 2008 12:39:30 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101882>

This is v2 of the gitweb feature check fix patch, which has now been
split into into a code patch and cleanup patch.

The first patch introduces git_get_feature() to clearly distinguish the
feature retrieval from the boolean feature check (which is kept at
git_check_feature()). The new function is used where appropriate.

The second patch cleans up use of git_check_feature(): since the
function now returns a boolean instead of an array, the often-used
construct
  my ($somevar) = git_check_feature('somefeat');
although still valid, becomes a rather clumsy stylistic choice, as it
introduces an unnecessary ambiguity. Make it clear that we're now
dealing with scalars by using scalar assignment.

Giuseppe Bilotta (2):
  gitweb: fixes to gitweb feature check code
  gitweb: clean up git_check_feature() calls

 gitweb/gitweb.perl |   52 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 35 insertions(+), 17 deletions(-)
