From: Wolfgang Denk <wd@denx.de>
Subject: git error in tag ...: unterminated header
Date: Thu, 25 Jun 2015 17:51:28 +0200
Message-ID: <20150625155128.C3E9738005C@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 17:51:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z89RB-0006cl-A5
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 17:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbbFYPvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 11:51:33 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40882 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbFYPvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 11:51:32 -0400
Received: from frontend02.mail.m-online.net (unknown [192.168.8.183])
	by mail-out.m-online.net (Postfix) with ESMTP id 3mHQnH1HvKz3hjcJ
	for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:51:30 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.6.69])
	by mail.m-online.net (Postfix) with ESMTP id 3mHQnG4nNkzvdWV
	for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:51:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.184])
	by localhost (dynscan2.mail.m-online.net [192.168.6.69]) (amavisd-new, port 10024)
	with ESMTP id XBgPsydJKqmr for <git@vger.kernel.org>;
	Thu, 25 Jun 2015 17:51:29 +0200 (CEST)
X-Auth-Info: jq6dO7FAizRyRgwQeabKPyDp6awxTN/GHNX9oVV0Q1U=
Received: from diddl.denx.de (host-80-81-18-216.customer.m-online.net [80.81.18.216])
	by smtp-auth.mnet-online.de (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:51:29 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.0.0.2])
	by diddl.denx.de (Postfix) with ESMTP id F06C91AB2C9
	for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:51:28 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
	by gemini.denx.de (Postfix) with ESMTP id C3E9738005C
	for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:51:28 +0200 (MEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272689>

Hi all,

it turns out that recent versions of git (i. e. git version 2.2.0 or
later, resp. anything which includes commit 4d0d8975 "Make sure
fsck_commit_buffer() does not run out of the buffer") throws errors on
our git repository  git://git.denx.de/u-boot:

-> git fsck --full
Checking object directories: 100% (256/256), done.
error in tag eb394f56db3e05d00891d6dc36a00df0025cf255: unterminated header
error in tag 9bf86baaa3b35b25baa2d664e2f7f6cafad689ee: unterminated header
error in tag c7071e6d645a8e13adb0d4cea2caad27213fa62f: unterminated header
Checking objects: 100% (328644/328644), done.
Checking connectivity: 325719, done.

Apparently for some reason the tags  LABEL_2006_03_12_0025,
LABEL_2006_04_18_1106, and LABEL_2006_05_19_1133 are missing newlines,
which was undetected so far, but now is raised as an error.

Question is: how can we fix that?

Is there a tool to "auto-repair" such kind of errors?

If not, would it be be a harmless thing to just delete and recreate
the same tags (referring to the same commits)?  Or can anybody see any
problems tha might be caused by such a tag re-creation?  I mean, it is
not like a rebase of the repository or something like that?  Right?

Thanks in advance.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Artificial Intelligence is the study of how to  make  real  computers
act like the ones in movies.
