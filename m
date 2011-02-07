From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] pull: Document the "--[no-]recurse-submodules" options
Date: Mon, 07 Feb 2011 20:27:57 +0100
Message-ID: <4D5047BD.6030304@web.de>
References: <4D4C5EBC.2090100@web.de> <201102042326.08607.j6t@kdbg.org> <4D4D33E7.4000303@web.de> <7vipwwx56r.fsf@alter.siamese.dyndns.org> <4D4F19D0.2000408@web.de> <20110206220939.GC17210@elie> <4D4F273C.8030003@web.de> <20110207074157.GA2736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 20:28:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmWkw-0006yl-Bh
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 20:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab1BGT2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 14:28:08 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:38039 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab1BGT2H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 14:28:07 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3EB89187573C6;
	Mon,  7 Feb 2011 20:28:05 +0100 (CET)
Received: from [93.246.35.64] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PmWkn-0007r1-00; Mon, 07 Feb 2011 20:28:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110207074157.GA2736@elie>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18ars0hPHwJ5PIXYy1862lEeMIn62wNZ3bhGs/B
	ICQnE7idq92sfq5Aq+NTr7Meq1z6R9cxQieiRJj6EkDVuHd4XY
	PHHJipbF06pLpUp5hwnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166274>

In commits be254a0ea9 and 7dce19d374 the handling of the new fetch options
"--[no-]recurse-submodules" had been added to git-pull.sh. But they were
not documented as the pull options they now are, so let's fix that.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 07.02.2011 08:41, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
>> --- a/Documentation/git-pull.txt
>> +++ b/Documentation/git-pull.txt
>> @@ -84,6 +84,10 @@ must be given before the options meant for 'git fetch'.
>>  --verbose::
>>  	Pass --verbose to git-fetch and git-merge.
>>
>> +--[no-]recurse-submodules::
>> +	This option controls if new commits of all populated submodules should
>> +	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
>> +
> 
> Is it worth mentioning that this does not (yet) automatically check
> out the new commits in submodules after a merge, or would such
> documentation be too likely to be forgotten and left stale in the
> future?

Good point, here is v2! (And I will add an updated description to the
relevant commits in my github repo, so we won't forget that later)

 Documentation/fetch-options.txt |    2 +-
 Documentation/git-pull.txt      |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 695696d..ab0dbfc 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -64,11 +64,11 @@ ifndef::git-pull[]
 	downloaded. The default behavior for a remote may be
 	specified with the remote.<name>.tagopt setting. See
 	linkgit:git-config[1].
-endif::git-pull[]

 --[no-]recurse-submodules::
 	This option controls if new commits of all populated submodules should
 	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
+endif::git-pull[]

 ifndef::git-pull[]
 --submodule-prefix=<path>::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 3046691..b33e6be 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -84,6 +84,15 @@ must be given before the options meant for 'git fetch'.
 --verbose::
 	Pass --verbose to git-fetch and git-merge.

+--[no-]recurse-submodules::
+	This option controls if new commits of all populated submodules should
+	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
+	That might be necessary to get the data needed for merging submodule
+	commits, a feature git learned in 1.7.3. Notice that the result of a
+	merge will not be checked out in the submodule, "git submodule update"
+	has to be called afterwards to bring the work tree up to date with the
+	merge result.
+
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
1.7.4.47.g87a200
