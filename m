From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] git-remote-testgit: avoid process substitution
Date: Fri, 26 Apr 2013 16:26:48 -0700
Message-ID: <7v8v44vpon.fsf_-_@alter.siamese.dyndns.org>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net> <5178C583.6000703@viscovery.net>
	<CAMP44s2nWs3XyaLQUnYd=A9u1=8tB7Qp+FN7gf+SrACxmtP8pw@mail.gmail.com>
	<7vobd1udz2.fsf@alter.siamese.dyndns.org>
	<CAMP44s3j5Bk3eqPeN2qkGTWFLO2NKz0taTGYVNvEut_VM=0NXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 01:27:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVs2Z-000310-Gn
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 01:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940Ab3DZX0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 19:26:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab3DZX0u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 19:26:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 424BB1A3DC;
	Fri, 26 Apr 2013 23:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0k3/PdBLUnRraxxeJOZhaFUhQ14=; b=pWv8kO
	3Gaw+VzNAWU1ztCwTWEnJ94lVQFe7DnTTAY/n+40G61e5xjLZAIFFV637p6WmMV2
	h89QV+ya9Rao9hvgkX5NQ669HPwtc+tB5GRg/f4MLxOKRSAbWUl/gdd9w3uljT37
	eOjaBgoAhkvSmvCM/rMePVxuwtGBPWZkWx12c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9im8/lrQKEzSishlSuWTUk/JIFjSQCn
	5jvznA0YCSX7c8cJOGPbkXIT9NbxDa84dxIFa1ckBSl4m4G5bc5KpVDri8uiOmih
	PN5s+/Li8kEY+roL8XfcYez4Vvd5cjbNo/1Ugo525A4gezg31ID5AUo2OxADJke5
	TiSHDMFlMjk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35D411A3DB;
	Fri, 26 Apr 2013 23:26:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 892DF1A3DA;
	Fri, 26 Apr 2013 23:26:49 +0000 (UTC)
In-Reply-To: <CAMP44s3j5Bk3eqPeN2qkGTWFLO2NKz0taTGYVNvEut_VM=0NXA@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 26 Apr 2013 17:45:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4F64774-AEC8-11E2-A6EE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222606>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> No, it wouldn't, but I don't think there's any way to do \<\> or \b in globs.

This should do in the meantime, but it further needs:

 - J6t's sign off for the follow-up part to remove remaining
   bash-isms to complete this patch (the last part of the patch is
   from <5178C583.6000703@viscovery.net> and we can take half the
   log message from there);

 - Rename it to git-remote-testgit.sh and tell Makefile to replace
   the shebang line with SHELL_PATH like other scripts;

 - Remove the "we need to have bash because we will run remote-testgit"
   logic from t5801



diff --git a/git-remote-testgit b/git-remote-testgit
index b395c8d..ffac950 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+#!/bin/sh
 # Copyright (c) 2012 Felipe Contreras
 
 alias=$1
@@ -23,7 +23,6 @@ then
 	testgitmarks="$dir/testgit.marks"
 	test -e "$gitmarks" || >"$gitmarks"
 	test -e "$testgitmarks" || >"$testgitmarks"
-	testgitmarks_args=( "--"{import,export}"-marks=$testgitmarks" )
 fi
 
 while read line
@@ -62,22 +61,31 @@ do
 			echo "feature export-marks=$gitmarks"
 		fi
 		echo "feature done"
-		git fast-export "${testgitmarks_args[@]}" $refs |
+		git fast-export \
+			${testgitmarks:+"--import-marks=$testgitmarks"} \
+			${testgitmarks:+"--export-marks=$testgitmarks"} \
+			$refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		echo "done"
 		;;
 	export)
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
 
-		git fast-import "${testgitmarks_args[@]}" --quiet
-
-		after=$(git for-each-ref --format='%(refname) %(objectname)')
+		git fast-export \
+			${testgitmarks:+"--import-marks=$testgitmarks"} \
+			${testgitmarks:+"--export-marks=$testgitmarks"} \
+			--quiet
 
 		# figure out which refs were updated
-		join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") |
-		while read ref a b
+		LF=$'\n'
+		git for-each-ref --format='%(refname) %(objectname)' |
+		while read ref a
 		do
-			test $a == $b && continue
+			case "$LF$before$LF" in
+			*"$LF$ref $a$LF"*)
+				continue
+				;;
+			esac
 			echo "ok $ref"
 		done
 
