From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 0/2] Submodules: Add the new config option "ignore"
Date: Fri, 06 Aug 2010 00:37:42 +0200
Message-ID: <4C5B3D36.1060902@web.de>
References: <4C4DD33F.4020104@web.de> <4C4DD3CF.9070906@web.de> <7vhbjjware.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 00:38:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh94f-0005B7-AZ
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010Ab0HEWhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 18:37:50 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41307 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208Ab0HEWhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 18:37:45 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0693515CFC5F5;
	Fri,  6 Aug 2010 00:37:43 +0200 (CEST)
Received: from [80.128.118.249] (helo=[192.168.178.29])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Oh94I-000776-00; Fri, 06 Aug 2010 00:37:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <7vhbjjware.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+qv3Ywuc/mQfhYx9W+60XawReGhXVexdKe9lhD
	C1c/BvcI+c3gWrF/MZBkrxivVmnAW4a7CPwV59oM/lON5evgec
	JPHxObXIBUgn7PtE2R2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152731>

Am 28.07.2010 23:35, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> The .gitmodules file is parsed for "submodule.<name>.ignore" entries
>> before looking for them in .git/config. Thus settings found in .git/config
>> will override those from .gitmodules,...
> 
> Hmph.
> 
> The value of "submodule.<name>.path" does not have to be "<name>".  There
> seems to be a bit of confusion here.

Thanks for clearing up my confusion, this is v2 of this patch using the
path configured for the submodule instead of its name.


Jens Lehmann (2):
  Submodules: Add the new "ignore" config option for diff and status
  Submodules: Use "ignore" settings from .gitmodules too for diff and
    status

 Documentation/config.txt       |   13 +++
 Documentation/diff-options.txt |    6 +-
 Documentation/git-status.txt   |    6 +-
 Documentation/gitmodules.txt   |   15 ++++
 builtin/commit.c               |    2 +
 builtin/diff-files.c           |    2 +
 builtin/diff-index.c           |    2 +
 builtin/diff-tree.c            |    2 +
 builtin/diff.c                 |    2 +
 diff-lib.c                     |   15 +++-
 diff.c                         |   35 +++++++--
 diff.h                         |    1 +
 submodule.c                    |   76 +++++++++++++++++-
 submodule.h                    |    4 +
 t/t4027-diff-submodule.sh      |  152 ++++++++++++++++++++++++++++++++++
 t/t7508-status.sh              |  175 +++++++++++++++++++++++++++++++++++++++-
 wt-status.c                    |    8 ++-
 17 files changed, 496 insertions(+), 20 deletions(-)

-- 
1.7.2.1.54.g6bed1
