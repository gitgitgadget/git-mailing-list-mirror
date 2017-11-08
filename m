Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D8E1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 22:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbdKHWzm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 17:55:42 -0500
Received: from avasout04.plus.net ([212.159.14.19]:38275 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752534AbdKHWzk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2017 17:55:40 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id CZFwe5CYQzbmWCZFye3Iz7; Wed, 08 Nov 2017 22:55:38 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8
 a=A1X0JdhQAAAA:8 a=UJGXVSz7gd6jF7HModwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22 a=Df3jFdWbhGDLdZNm0fyq:22
X-AUTH: ramsayjones@:2500
Subject: Re: Test failures on 'pu' branch
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <cf38b57d-1424-0776-b67f-8cfd24e087bb@ramsayjones.plus.com>
 <CAGZ79kb3NpuWW=BpTjF_DrdVhXHh3d_8aF77Jdpi+8yTxtAbVw@mail.gmail.com>
 <e2d10701-2deb-4f03-f4ce-3da7d48effa3@ramsayjones.plus.com>
Message-ID: <d4eb2005-aaf0-0ae4-e719-5dae25e7a254@ramsayjones.plus.com>
Date:   Wed, 8 Nov 2017 22:55:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <e2d10701-2deb-4f03-f4ce-3da7d48effa3@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJlxT0yhY8fSIoExjRD5DqYyz9VHVElW8KJcYtc3N/JFeVrizPPM7EvXbMRsuVAIs9bKNhD/XAl0wiDjs/kB7MZ0zEyFk98TAWDzad+oswE3tmO8E7hY
 78GokWo6XYkYAKJccWWs25gJVhBJjNretfOSWAQO4osayz3N5rq0emE9KGcNEjWgpRqymkBXx067jw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/11/17 22:34, Ramsay Jones wrote:
> 
> 
> On 08/11/17 20:36, Stefan Beller wrote:
>> On Wed, Nov 8, 2017 at 12:28 PM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>
>>> t5300-pack-object.sh                             (Wstat: 256 Tests: 40 Failed: 2)
>>
>>> t5500-fetch-pack.sh                              (Wstat: 256 Tests: 355 Failed: 6)
>>
>> These are series
>>
>>> t5601-clone.sh                                   (Wstat: 256 Tests: 102 Failed: 4)
>>
>> This one is a spurious test. I had that flake on me once in the last weeks, too.
>> But upon investigation I could not reproduce.
>> See https://public-inbox.org/git/xmqq376ipdpx.fsf@gitster.mtv.corp.google.com/
>>
> 
> No, this is not related to that. In fact several tests start
> working if I change the '--filter=blobs:limit=0' to instead
> read '--filter=blob:limit=0' (ie. change blob_s_ to blob).
> 
> In fact t5601 now works with the following patch:

OK, so the patch given below fixes all tests except t5300.37.
All the patch does is change 'blobs' to 'blob' in the --filter
parameters.

The single failure looks like:

  $ ./t5300-pack-object.sh -i -v
  ...
  Initialized empty Git repository in /home/ramsay/git/t/trash   directory.t5300-pack-object/server/.git/
  [master (root-commit) a72904c] x
   Author: A U Thor <author@example.com>
   3 files changed, 3 insertions(+)
   create mode 100644 .git-a
   create mode 100644 a
   create mode 100644 b
  Counting objects: 2, done.
  Compressing objects: 100% (2/2), done.
  Total 2 (delta 0), reused 0 (delta 0)
  ad26794874784493dafa81f1644b3dcfad05d843
  not ok 37 - filtering by size never excludes special files
  #	
  #		rm -rf server &&
  #		git init server &&
  #		printf a-very-long-file > server/a &&
  #		printf a-very-long-file > server/.git-a &&
  #		printf b-very-long-file > server/b &&
  #		git -C server add a .git-a b &&
  #		git -C server commit -m x &&
  #	
  #		git -C server rev-parse HEAD >objects &&
  #		git -C server pack-objects --revs --stdout --filter=blob:limit=10 <objects >my.pack &&
  #	
  #		# Ensure that the .git-a blob is in the packfile, despite also
  #		# appearing as a non-.git file
  #		git index-pack my.pack &&
  #		git verify-pack -v my.idx >objectlist &&
  #		grep $(git hash-object server/a) objectlist
  #	
  $ 

Hope that helps.

ATB,
Ramsay Jones

-- >8 --
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 0739a0796..17c9ffdca 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -472,7 +472,7 @@ test_expect_success 'filtering by size works with multiple excluded' '
 	git -C server commit -m x &&
 
 	git -C server rev-parse HEAD >objects &&
-	git -C server pack-objects --revs --stdout --filter=blobs:limit=10 <objects >my.pack &&
+	git -C server pack-objects --revs --stdout --filter=blob:limit=10 <objects >my.pack &&
 
 	# Ensure that only the small blobs are in the packfile
 	git index-pack my.pack &&
@@ -493,7 +493,7 @@ test_expect_success 'filtering by size never excludes special files' '
 	git -C server commit -m x &&
 
 	git -C server rev-parse HEAD >objects &&
-	git -C server pack-objects --revs --stdout --filter=blobs:limit=10 <objects >my.pack &&
+	git -C server pack-objects --revs --stdout --filter=blob:limit=10 <objects >my.pack &&
 
 	# Ensure that the .git-a blob is in the packfile, despite also
 	# appearing as a non-.git file
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 86cf65323..08b7a32c7 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -762,7 +762,7 @@ test_expect_success 'filtering by size' '
 	test_config -C server uploadpack.allowfilter 1 &&
 
 	test_create_repo client &&
-	git -C client fetch-pack --filter=blobs:limit=0 ../server HEAD &&
+	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD &&
 
 	# Ensure that object is not inadvertently fetched
 	test_must_fail git -C client cat-file -e $(git hash-object server/one.t)
@@ -774,7 +774,7 @@ test_expect_success 'filtering by size has no effect if support for it is not ad
 	test_commit -C server one &&
 
 	test_create_repo client &&
-	git -C client fetch-pack --filter=blobs:limit=0 ../server HEAD 2> err &&
+	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD 2> err &&
 
 	# Ensure that object is fetched
 	git -C client cat-file -e $(git hash-object server/one.t) &&
@@ -800,7 +800,7 @@ setup_blob_max_bytes () {
 do_blob_max_bytes() {
 	SERVER="$1" &&
 
-	git -C client fetch --filter=blobs:limit=0 origin HEAD:somewhere &&
+	git -C client fetch --filter=blob:limit=0 origin HEAD:somewhere &&
 
 	# Ensure that commit is fetched, but blob is not
 	test_config -C client extensions.partialcloneremote "arbitrary string" &&
@@ -816,7 +816,7 @@ test_expect_success 'fetch with filtering' '
 test_expect_success 'fetch respects configured filtering' '
 	setup_blob_max_bytes server server &&
 
-	test_config -C client extensions.partialclonefilter blobs:limit=0 &&
+	test_config -C client extensions.partialclonefilter blob:limit=0 &&
 
 	git -C client fetch origin HEAD:somewhere &&
 
@@ -835,7 +835,7 @@ test_expect_success 'pull respects configured filtering' '
 	test_commit -C server three &&
 
 	test_config -C server uploadpack.allowanysha1inwant 1 &&
-	test_config -C client extensions.partialclonefilter blobs:limit=0 &&
+	test_config -C client extensions.partialclonefilter blob:limit=0 &&
 
 	git -C client pull origin &&
 
@@ -852,7 +852,7 @@ test_expect_success 'clone configures filtering' '
 	test_commit -C server two &&
 	test_config -C server uploadpack.allowanysha1inwant 1 &&
 
-	git clone --filter=blobs:limit=12345 server client &&
+	git clone --filter=blob:limit=12345 server client &&
 
 	# Ensure that we can, for example, checkout HEAD^
 	rm -rf client/.git/objects/* &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index f18d9454a..0074690f7 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -630,7 +630,7 @@ partial_clone () {
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
 	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
 
-	git clone --filter=blobs:limit=0 "$URL" client &&
+	git clone --filter=blob:limit=0 "$URL" client &&
 
 	git -C client fsck &&
 
@@ -651,7 +651,7 @@ test_expect_success 'partial clone: warn if server does not support object filte
 		     test_create_repo server &&
 		     test_commit -C server one &&
 
-	git clone --filter=blobs:limit=0 "file://$(pwd)/server" client 2> err &&
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client 2> err &&
 
 	test_i18ngrep "filtering not recognized by server" err
 '
@@ -673,7 +673,7 @@ test_expect_success 'batch missing blob request during checkout' '
 	test_config -C server uploadpack.allowfilter 1 &&
 	test_config -C server uploadpack.allowanysha1inwant 1 &&
 
-	git clone --filter=blobs:limit=0 "file://$(pwd)/server" client &&
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client &&
 
 	# Ensure that there is only one negotiation by checking that there is
 	# only "done" line sent. ("done" marks the end of negotiation.)
@@ -705,7 +705,7 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
 	test_config -C server uploadpack.allowanysha1inwant 1 &&
 
 	# Make sure that it succeeds
-	git clone --filter=blobs:limit=0 "file://$(pwd)/server" client
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
 '
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 8< --

