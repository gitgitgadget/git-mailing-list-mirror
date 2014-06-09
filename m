From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] t3302: coding style updates
Date: Mon,  9 Jun 2014 16:22:51 -0700
Message-ID: <1402356175-7249-4-git-send-email-gitster@pobox.com>
References: <1402356175-7249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8ua-0004KM-C6
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933896AbaFIXXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:23:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56924 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933957AbaFIXXR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:23:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 585C71D3FF;
	Mon,  9 Jun 2014 19:23:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tFPh
	Y6qAr9fntxEz0bB2kTidiEw=; b=wqLc4y+CKo0Ex3kMAeKhaXuSUx5+JXBZuBvg
	ibNqoO1j119qYkWCdYga8qpDBrFL283gZs87qVpoHyS0YqKvwYnnwJXsF2OX17pl
	afhWttt8aDL9a4ko8l7Vn7UB+kn8TTkQ3P5pwIjEfDicvD6wiPF3+qQUqQM/bIjB
	d7y5dLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PVTP2P
	UE17CW3JnAbPzYyBMET3zfk9X2bGaVuHDjp/61VUMwcRB0NYsad1P4MZ7gt5/Zzw
	vmT4gCFMicLDBP2eQgAWkRk07xgZ+4MZCK4h62ixyUB+saPaZ3z+PKfW+SBYAsIC
	JDe0LOBbxRodRcLuh9bbnRyQJ75p3x3Dk+dRI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D98D1D3FD;
	Mon,  9 Jun 2014 19:23:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0428E1D3FC;
	Mon,  9 Jun 2014 19:23:12 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-483-g1a584c4
In-Reply-To: <1402356175-7249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 06D84A24-F02D-11E3-9225-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251134>

Use "<<-END_OF_HERE_TEXT" to push the contents of here-text to the
right in order to show the loop structure better.

Use write_script when writing a script to be run.

Use "test" (not "[ ... ]") and avoid unnecessary ";" in the middle
of a line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3302-notes-index-expensive.sh | 90 +++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index dc706ab..aa9dbd7 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -16,43 +16,43 @@ create_repo () {
 	test -d .git || {
 	git init &&
 	(
-		while [ $nr -lt $number_of_commits ]; do
+		while test $nr -lt $number_of_commits
+		do
 			nr=$(($nr+1))
 			mark=$(($nr+$nr))
 			notemark=$(($mark+1))
 			test_tick &&
-			cat <<INPUT_END &&
-commit refs/heads/master
-mark :$mark
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-commit #$nr
-COMMIT
-
-M 644 inline file
-data <<EOF
-file in commit #$nr
-EOF
-
-blob
-mark :$notemark
-data <<EOF
-note for commit #$nr
-EOF
-
-INPUT_END
-
-			echo "N :$notemark :$mark" >> note_commit
+			cat <<-INPUT_END &&
+			commit refs/heads/master
+			mark :$mark
+			committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+			data <<COMMIT
+			commit #$nr
+			COMMIT
+
+			M 644 inline file
+			data <<EOF
+			file in commit #$nr
+			EOF
+
+			blob
+			mark :$notemark
+			data <<EOF
+			note for commit #$nr
+			EOF
+
+			INPUT_END
+			echo "N :$notemark :$mark" >>note_commit
 		done &&
 		test_tick &&
-		cat <<INPUT_END &&
-commit refs/notes/commits
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-notes
-COMMIT
+		cat <<-INPUT_END &&
+		commit refs/notes/commits
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		notes
+		COMMIT
 
-INPUT_END
+		INPUT_END
 
 		cat note_commit
 	) |
@@ -64,38 +64,41 @@ INPUT_END
 test_notes () {
 	count=$1 &&
 	git config core.notesRef refs/notes/commits &&
-	git log | grep "^    " > output &&
+	git log | grep "^    " >output &&
 	i=$count &&
-	while [ $i -gt 0 ]; do
+	while test $i -gt 0
+	do
 		echo "    commit #$i" &&
 		echo "    note for commit #$i" &&
-		i=$(($i-1));
-	done > expect &&
+		i=$(($i-1))
+	done >expect &&
 	test_cmp expect output
 }
 
-cat > time_notes << \EOF
+write_script time_notes <<\EOF
 	mode=$1
 	i=1
-	while [ $i -lt $2 ]; do
+	while test $i -lt $2
+	do
 		case $1 in
 		no-notes)
-			GIT_NOTES_REF=non-existing; export GIT_NOTES_REF
-		;;
+			GIT_NOTES_REF=non-existing
+			export GIT_NOTES_REF
+			;;
 		notes)
 			unset GIT_NOTES_REF
-		;;
+			;;
 		esac
-		git log >/dev/null
+		git log
 		i=$(($i+1))
-	done
+	done >/dev/null
 EOF
 
 time_notes () {
 	for mode in no-notes notes
 	do
 		echo $mode
-		/usr/bin/time "$SHELL_PATH" ../time_notes $mode $1
+		/usr/bin/time ../time_notes $mode $1
 	done
 }
 
@@ -118,7 +121,8 @@ do_tests () {
 }
 
 do_tests NOT_EXPENSIVE 10
-for count in 100 1000 10000; do
+for count in 100 1000 10000
+do
 	do_tests EXPENSIVE $count
 done
 
-- 
2.0.0-435-g307a092
