From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 0/2] Teach read-tree the -n|--dry-run option
Date: Wed, 25 May 2011 22:06:54 +0200
Message-ID: <4DDD615E.7020809@web.de>
References: <4DDC1DF9.9030109@web.de> <7v39k37kmo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 22:07:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPKMH-0000Yg-Kh
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 22:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab1EYUHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 16:07:00 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:46332 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab1EYUHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 16:07:00 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5406118F6CAE4;
	Wed, 25 May 2011 22:06:58 +0200 (CEST)
Received: from [217.249.54.24] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QPKM6-0006yz-00; Wed, 25 May 2011 22:06:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7v39k37kmo.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18zeFQBlg4gQr8EXTBijq8A9zifz3IA487RETIl
	VuSTCWkprOquq1SBKnYdcWS95LzY0GlI0TCdTgYK1bx0JJ5BQs
	a0R7NDm1DqUoM3snjjTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174457>

Am 25.05.2011 01:18, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> My "Teach read-tree the -n|--dry-run option" adapted to this new flag
>> runs all tests successfully ...
>>
>>
>>  unpack-trees.c |    4 ++--
>>  unpack-trees.h |    3 ++-
>>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> But on which change does this come?

As a preparing step for "read-tree the -n|--dry-run" (and adding
a dry-run option to other users of unpack_trees() should be pretty
straightforward now too).

The first patch in this series enables unpack_trees() to do a dry-run.
That enables users of unpack_trees() to see if running this function
with the update flag set would succeed.

The second patch uses this new dry_run flag to teach read-tree the
-n|--dry-run option.


Jens Lehmann (2):
  unpack-trees: add the dry_run flag to unpack_trees_options
  Teach read-tree the -n|--dry-run option

 Documentation/git-read-tree.txt      |    5 ++
 builtin/read-tree.c                  |    3 +-
 t/lib-read-tree.sh                   |   43 ++++++++++++++++++
 t/t1000-read-tree-m-3way.sh          |   81 +++++++++++++++++-----------------
 t/t1001-read-tree-m-2way.sh          |   45 ++++++++++---------
 t/t1002-read-tree-m-u-2way.sh        |   81 +++++++++++++++++-----------------
 t/t1004-read-tree-m-u-wf.sh          |   23 +++++-----
 t/t1005-read-tree-reset.sh           |   13 +++---
 t/t1008-read-tree-overlay.sh         |    3 +-
 t/t1011-read-tree-sparse-checkout.sh |   27 ++++++-----
 t/t1012-read-tree-df.sh              |    9 ++--
 t/t1020-subdirectory.sh              |    5 +-
 unpack-trees.c                       |    4 +-
 unpack-trees.h                       |    3 +-
 14 files changed, 202 insertions(+), 143 deletions(-)
 create mode 100644 t/lib-read-tree.sh

-- 
1.7.5.2.355.gdceb0
