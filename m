Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gExMqnPu"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6628093
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 04:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702470537; x=1703075337; i=l.s.r@web.de;
	bh=jYuPLFiOkaITAqk9bMbolbLebKOah42wCYSxa1bjkIE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=gExMqnPuslj36SWxnNSj4FEbDMdU9mfbycjjL/ZoO5pdySmrOGOnP5d2LEQR3iN9
	 4l1dKf82Xk7KxFATt5VLyGuFFMW4hxoB+UZ6RZVwglZ/764T2W0fhaWvJiT/60/0l
	 MVjT5C18VdmwgbQzaxo5eMxAukq2vA38RPpkYhF/A/wi02aJOa0UD/DgGSAVmXIpQ
	 G6yvL7ykkmUNjtSoHBze6qgT+zrTKb3k8eDwAUNfHm1vU1fk8EggecT6Rz1sIcBg6
	 YX9791N+E23pvNbd3A80jheXCakx3ecY65L3UOn5E+0uj/Jw/evpSFyHYsscnlp7a
	 SpH/AeebqcNJAwQrwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgANA-1rhWul2Ssg-00hpja; Wed, 13
 Dec 2023 13:28:57 +0100
Message-ID: <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
Date: Wed, 13 Dec 2023 13:28:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/1] test-lib-functions: add object size functions
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Ondrej Pohorelsky <opohorel@redhat.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
Content-Language: en-US
In-Reply-To: <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uFFhX1jbY3fApAbE+k9vj6S0biNze0haoHmQCB9SdpggqthaY4V
 e9PwuY3FFi9+pddNIlnPaS5VnVEqbJlu4AK385JAfmL1ROdwadNfwEVQiPaAqBOdRMwgXxl
 z6DcxDo9JzP8h96jLPnYVz3pVU3iTiqAsAfRzBeNpMbIOmVvtUV44U/HWFmz+ScxAGyHFJO
 Yziq7TKY60dN05FdhPMHw==
UI-OutboundReport: notjunk:1;M01:P0:Ij9L9co3VNw=;MHYoAEp/g34ym8TIe7YbH80vFJs
 yYvwtdpctpW6J2CrNwwFhCVMzmzAAaZR/WG8OByKDUdUsGV64Rul1tdTultGOWeHv9lj+LsJQ
 30vTSKGr0pF2hWb0OQirntzlpEbGcgnDlZWOOMOnteFeWhl00M1H1ub5JOfGW385CrTqxGgIf
 aqaxB2D2l2u5QBOXx7RdUFi92tean10A3Dvh7PZJUiLMWv1lyMQ2gl9UKZ85a3lbTOkn3KG83
 lFR5mZycvlyArJLddPfeZO/LtGrCcZTut0QCOj0DpHApgS6OQ0Y61Q6QCWzDNk/Pne3epgSD5
 358iicMxKonC7c1y56QGuxHll222e37FQVhL+zpWDq4irwmrVvgb2PJmiA2oVvoPYMv5PW+yj
 N5HipFeJKtuKZ1l2jSUbDkO9KXypMCmqKWDJ3Dl2gNEdx4j0NQAhGpFNyrUVi8oxx5pqLz1mB
 rBewS0xxSosWkBsiyF+AtxX2xsaCV6PMIa33xLmlkyC8aTl7gMpwOpwjR8FomxIfFQSggaQt/
 AiWHQ2tXQ0ZI7xSo8HqQpi2s8uXmdSqYDAMWJtyOWy0tzdBWffaaGubVPJeIY1jZtpzEgW4ul
 7Hpx8ye4b2sOeB1dOnuTEw3RC/VJOZNV0NnNHN/SJBkxKDMIWlBdy5CrYqKlFWI55FXe00hbT
 J1dJT3XxoZWmshfkhMGPWwNGmkvtJRxWAERf11NLClfqqcuA9kjo7Mz7hbob1MI+hHP9yaQcP
 mjHPset+iSlTv5pqk8kzZ81gMUMbBEcQnhHR2oevCwkdDgtoI03wP4Ire7MvrFaPK3JsHV8nD
 GeB1PN3s7mYDT+YkEURfsWLFvBSapRaWqVMZEZn/o0qnps+h6PA/hbBzUDsPNOAL490MLOJpM
 khru4CU6Sd6UbqeoaUf9J8bE9Q/wgs8jRAuXfT246vqgDo9S/kRTfKCIn6rYTNwl4pvaJ/L97
 G+RfWQ==

Add test_object_size and its helpers test_loose_object_size and
test_packed_object_size, which allow determining the size of a Git
object using only the low-level Git commands rev-parse and show-index.

Use it in t6300 to replace the bare-bones function test_object_file_size
as a motivating example.  There it provides the expected output of the
high-level Git command for-each-ref.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
So how about this?  I'm a bit nervous about all the rules about output
descriptors and error propagation and whatnot in the test library, but
this implementation seems simple enough and might be useful in more than
one test.  No idea how to add support for alternate object directories,
but I doubt we'll ever need it.
=2D--
 t/t6300-for-each-ref.sh | 16 ++++++--------
 t/test-lib-functions.sh | 47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 843a7fe143..4687660f38 100755
=2D-- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -20,12 +20,6 @@ setdate_and_increment () {
     export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }

-test_object_file_size () {
-	oid=3D$(git rev-parse "$1")
-	path=3D".git/objects/$(test_oid_to_path $oid)"
-	test_file_size "$path"
-}
-
 test_expect_success setup '
 	# setup .mailmap
 	cat >.mailmap <<-EOF &&
@@ -40,7 +34,11 @@ test_expect_success setup '
 	git branch -M main &&
 	setdate_and_increment &&
 	git tag -a -m "Tagging at $datestamp" testtag &&
+	testtag_oid=3D$(git rev-parse refs/tags/testtag) &&
+	testtag_disksize=3D$(test_object_size $testtag_oid) &&
 	git update-ref refs/remotes/origin/main main &&
+	commit_oid=3D$(git rev-parse refs/heads/main) &&
+	commit_disksize=3D$(test_object_size $commit_oid) &&
 	git remote add origin nowhere &&
 	git config branch.main.remote origin &&
 	git config branch.main.merge refs/heads/main &&
@@ -129,7 +127,7 @@ test_atom head push:strip=3D1 remotes/myfork/main
 test_atom head push:strip=3D-1 main
 test_atom head objecttype commit
 test_atom head objectsize $((131 + hexlen))
-test_atom head objectsize:disk $(test_object_file_size refs/heads/main)
+test_atom head objectsize:disk $commit_disksize
 test_atom head deltabase $ZERO_OID
 test_atom head objectname $(git rev-parse refs/heads/main)
 test_atom head objectname:short $(git rev-parse --short refs/heads/main)
@@ -203,8 +201,8 @@ test_atom tag upstream ''
 test_atom tag push ''
 test_atom tag objecttype tag
 test_atom tag objectsize $((114 + hexlen))
-test_atom tag objectsize:disk $(test_object_file_size refs/tags/testtag)
-test_atom tag '*objectsize:disk' $(test_object_file_size refs/heads/main)
+test_atom tag objectsize:disk $testtag_disksize
+test_atom tag '*objectsize:disk' $commit_disksize
 test_atom tag deltabase $ZERO_OID
 test_atom tag '*deltabase' $ZERO_OID
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9c3cf12b26..9b49645f77 100644
=2D-- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1733,6 +1733,53 @@ test_oid_to_path () {
 	echo "${1%$basename}/$basename"
 }

+test_loose_object_size () {
+	test "$#" -ne 1 && BUG "1 param"
+	local path=3D$(test_oid_to_path "$1")
+	test_file_size "$(git rev-parse --git-path "objects/$path")" 2>&4
+}
+
+test_packed_object_size () {
+	test "$#" -ne 2 && BUG "2 params"
+	local oid=3D$1 idx=3D$2 packsize rawsz end
+
+	packsize=3D$(test_file_size "${idx%.idx}.pack")
+	rawsz=3D$(test_oid rawsz)
+	end=3D$(($packsize - $rawsz))
+
+	git show-index <"$idx" |
+	awk -v oid=3D"$oid" -v end=3D"$end" '
+		$2 =3D=3D oid {start =3D $1}
+		{offsets[$1] =3D 1}
+		END {
+			if (!start || start >=3D end)
+				exit 1
+			for (o in offsets)
+				if (start < o && o < end)
+					end =3D o
+			print end - start
+		}
+	' && return 0
+
+	echo >&4 "error: '$oid' not found in '$idx'"
+	return 1
+}
+
+test_object_size () {
+	test "$#" -ne 1 && BUG "1 param"
+	local oid=3D$1
+
+	test_loose_object_size "$oid" 4>/dev/null && return 0
+
+	for idx in "$(git rev-parse --git-path objects/pack)"/pack-*.idx
+	do
+		test_packed_object_size "$oid" "$idx" 4>/dev/null && return 0
+	done
+
+	echo >&4 "error: '$oid' not found"
+	return 1
+}
+
 # Parse oids from git ls-files --staged output
 test_parse_ls_files_stage_oids () {
 	awk '{print $2}' -
=2D-
2.43.0
