From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Oct 2009, #02; Sun, 11)
Date: Wed, 14 Oct 2009 20:29:20 +0200
Message-ID: <4AD61880.4040600@web.de>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8mq-0005gB-6d
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbZJNSgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbZJNSgs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:36:48 -0400
Received: from [217.72.192.221] ([217.72.192.221]:59157 "EHLO
	fmmailgate01.web.de" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756651AbZJNSgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:36:46 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 242EF12BDE954;
	Wed, 14 Oct 2009 20:29:22 +0200 (CEST)
Received: from [80.128.106.100] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1My8bB-0002yA-00; Wed, 14 Oct 2009 20:29:21 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+CxuNNu0erOadmASWH8aXKUJ+x8g4utSQrgqdT
	EVjugjAuxE01xqle7QrpXutomHYigS76fEd3TRFABPBgcRvAC0
	cz1Ok0NLFSgLu0MB13mg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130317>

Junio C Hamano schrieb:
> * js/diff-verbose-submodule (2009-10-04) 1 commit.
>  - Add the --submodule-summary option to the diff option family
> 
> Dscho sounded like he has some corrections after list comments, but I did
> not pick up his interdiff in the middle.

Dscho condensed his initial patch with the interdiff you mentioned,
additionally silenced a compiler warning and activated --first-parent.
This follows as patch 1/4. Patches 2/4 to 4/4 contain my two bugfixes
and the testcase i copied from submodule summary while adapting it to
the changes of the output format.

The remaining differences from the output shown by submodule summary are:

1) git diff shows only two dots for a fast forward (submodule summary
   always shows three)
2) git diff shows "Submodule" instead of a single '*' in the first line
3) git diff doesn't add a newline after each shortlog
4) submodule summary prints out the number of shortlog entries, this
   version does not
5) submodule summary can limit the number of shortlog lines, git diff
   can't do that right now
6) When files are replaced by a submodules or vice versa, git diff
   generates an extra hunk for the deleted/added file and one saying
   "(new submodule)"/"(submodule deleted)"


> The output format needs to be described better here and also in
> Documentation/diff-format.txt.

Will do when it is clear which of the 6 differences should be fixed and
which can stay.


Jens Lehmann (3):
  fix indentation depth for git diff --submodule-summary
  fix output for deleted submodules in git diff --submodule-summary
  add tests for git diff --submodule-summary

Johannes Schindelin (1):
  Add the --submodule-summary option to the diff option family

 Documentation/diff-options.txt    |    4 +
 Makefile                          |    2 +
 diff.c                            |   14 +++
 diff.h                            |    3 +
 submodule.c                       |  113 ++++++++++++++++++++
 submodule.h                       |    8 ++
 t/t4041-diff-submodule-summary.sh |  206 +++++++++++++++++++++++++++++++++++++
 7 files changed, 350 insertions(+), 0 deletions(-)
 create mode 100644 submodule.c
 create mode 100644 submodule.h
 create mode 100755 t/t4041-diff-submodule-summary.sh
