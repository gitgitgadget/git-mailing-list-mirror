From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v2] generalizing sorted-array handling
Date: Sat,  6 Nov 2010 22:00:32 +0100
Message-ID: <1289077235-3208-1-git-send-email-ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 22:01:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEpt2-0001XF-VE
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 22:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab0KFVAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 17:00:47 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:58111 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635Ab0KFVAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 17:00:46 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 53152D480DA
	for <git@vger.kernel.org>; Sat,  6 Nov 2010 22:00:41 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PEpsN-0000qT-WA
	for git@vger.kernel.org; Sat, 06 Nov 2010 22:00:40 +0100
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160857>

This is a complete rewrite of the previous series, following a
suggestion by Jonathan Nieder.  It is much more generic than the
previous one, and removes existing duplicated code in diffcore-rename.

I also had a quick look at other binary-search occurences in the code
that would share the same search code.  That revealed
index_name_pos(): not sure it is a good idea to make it use this API -
it would require changes all over the code.  I still include a
possibly-useful additional API for similar cases.
