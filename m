Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1DB020401
	for <e@80x24.org>; Sat, 24 Jun 2017 14:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdFXOJ7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 10:09:59 -0400
Received: from mout.web.de ([212.227.17.11]:57701 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdFXOJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 10:09:58 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mg7Dt-1dAfHl2myT-00NNeG; Sat, 24
 Jun 2017 16:09:40 +0200
Subject: Re: [PATCH] sha1_name: cache readdir(3) results in
 find_short_object_filename()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
 <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
 <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
 <d06fb033-294e-f364-3dde-394624e83cd6@web.de>
 <20170622231041.2zdjypviwmndjnsb@sigill.intra.peff.net>
 <97a8def3-d2ed-9212-4d87-8767de6f2695@web.de>
 <20170624122057.ndmlsa7e7dksejg3@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <03dc365d-41f7-dbe7-3c22-bdeee77a817c@web.de>
Date:   Sat, 24 Jun 2017 16:09:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170624122057.ndmlsa7e7dksejg3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:7qZ0hG5KGyJqNOY8XI6JtoBK7kmg/ACmhfFreANKYcdAFERkk5V
 xcb590Q19mvjGBxAmnUFRaRcuScovduzIeyz0TFw4ZI+l4JeSd6c2MERmJB6dqj5Xhucx+T
 vfnwP2tLcwouQrDMXripD9U4/N2Wu+7e50PzDu2XnWbX9L3HqsRO5rjB3+WEaWY2b/E1kwz
 gQKZ6GcBkAr0USP6cLrmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DzOLLmZPKhI=:rhrrSZNyhVfu9qx/QqaoDK
 Ly/kXZBPmnsdqkenP3K5BXOujl0mYUnMd2wXQLBCzIwgqbpD/iT1ou5h0iE6Vrl9wZYuumdKb
 YqyMuXeIu0+Z7GfZJ9PuBT589nKv6CDYvvoDYENhrOBOsXZcX+G/WzsQ5o1eFWhvJ3PxWoWZr
 TCgYzJshJSEygQQW2VxtDK+UkPIiNkI8M2dvpQF1+qVYYE8GZieTmD8tBBMz3agS6u9fWSBRe
 PeHxyTzFikZFNggWrfJat0QrWVnajxe+aKclH2FuatOcDiQ8szkSBnYOCma1gj0OiSkvTAsm/
 VRw9cJw9eMkJUmGCxSWg3xyG4ST42hPK+LDRgL9OvuPddp7CEsaWfs8V5uIx/43Gmwbzeo7pE
 Dm/O/YkqACTlFD6TGTClgefOtnjLcXwSUMn2eHLHZgYB7DlzYEMlVwfbS77WLEFxd9IBQiKey
 fob9cdlsRGz7a0dh1zmYpCstYkzBI2lUKgst7R8WSIqVfd7vA2hh099zy0XI/uEMlA+gaNwhU
 itED1BcJCt2R2nhaSKAC+/j4j5f0G99uMTcr61F9qxRPX0BxrCf7ywKxZGgnIQUzZlQIwSI3x
 IPDVzD9OhF3mhefA6u3sISlA2QKJ3lsYCLXMxjHQZ2Xh+FSDZO3mTnQB5Tpkuc7gNJ0On+uss
 VziFWzPPvdi7MejsTaS4TvyVkwUDcpAK0Tx2Aucww6KfS3xfoJ7TqKb8YBccG0gCMSYR2Xi9z
 QvrM/xBXECJU+7J02SqqH0ab60uQ1UOs0FV30Z9JaBZwF78oYejXrQ7AlyvrvIlzqovqkKT4t
 GYnkk4+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.06.2017 um 14:20 schrieb Jeff King:
> On Sat, Jun 24, 2017 at 02:12:30PM +0200, René Scharfe wrote:
> 
>>> That's redundant with "subdir_nr". Should we push that logic down into
>>> the function, and basically do:
>>>
>>>     if (subdir_nr < 0 || subdir_nr > 256)
>>> 	BUG("object subdir number out of range");
>>
>> Hmm.  I don't expect many more callers, so do we really need this safety
>> check?  It's cheap compared to the readdir(3) call, of course.
> 
> To me it's as much about documenting the assumptions as it is about
> catching buggy callers. I'd be OK with a comment, too.

I didn't catch the off-by-one error above in the first reading.  Did you
add it intentionally? ;-)  In any case, I'm convinced now that we need
such a check, but with hexadecimal notation to avoid such mistakes.

>> But wouldn't it make more sense to use an unsigned data type to avoid
>> the first half?  And an unsigned char specifically to only accept valid
>> values, leaving the overflow concern to the caller?  It warrants a
>> separate patch in any case IMHO.
> 
> Using unsigned makes sense. Using "char" because you know it only goes
> to 256 is a bit too subtle for my taste. And yes, I'd do it in a
> preparatory patch (or follow-on if you prefer).

It's subtle on the caller's side, as big numbers would just wrap if the
programmer ignored the limits of the type.  On the callee's side it's
fundamental, though.

Anyway, here's a patch on top of the others.

-- >8 --
Subject: [PATCH] sha1_file: guard against invalid loose subdirectory numbers

Loose object subdirectories have hexadecimal names based on the first
byte of the hash of contained objects, thus their numerical
representation can range from 0 (0x00) to 255 (0xff).  Change the type
of the corresponding variable in for_each_file_in_obj_subdir() and
associated callback functions to unsigned int and add a range check.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/fsck.c         | 2 +-
 builtin/prune-packed.c | 2 +-
 builtin/prune.c        | 2 +-
 cache.h                | 4 ++--
 sha1_file.c            | 5 ++++-
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3a2c27f241..5d113f8bc0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -536,7 +536,7 @@ static int fsck_cruft(const char *basename, const char *path, void *data)
 	return 0;
 }
 
-static int fsck_subdir(int nr, const char *path, void *progress)
+static int fsck_subdir(unsigned int nr, const char *path, void *progress)
 {
 	display_progress(progress, nr + 1);
 	return 0;
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index c026299e78..ac978ad401 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -10,7 +10,7 @@ static const char * const prune_packed_usage[] = {
 
 static struct progress *progress;
 
-static int prune_subdir(int nr, const char *path, void *data)
+static int prune_subdir(unsigned int nr, const char *path, void *data)
 {
 	int *opts = data;
 	display_progress(progress, nr + 1);
diff --git a/builtin/prune.c b/builtin/prune.c
index f0e2bff04c..c378690545 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -68,7 +68,7 @@ static int prune_cruft(const char *basename, const char *path, void *data)
 	return 0;
 }
 
-static int prune_subdir(int nr, const char *path, void *data)
+static int prune_subdir(unsigned int nr, const char *path, void *data)
 {
 	if (!show_only)
 		rmdir(path);
diff --git a/cache.h b/cache.h
index 00a017dfcb..04dd2961ad 100644
--- a/cache.h
+++ b/cache.h
@@ -1819,10 +1819,10 @@ typedef int each_loose_object_fn(const struct object_id *oid,
 typedef int each_loose_cruft_fn(const char *basename,
 				const char *path,
 				void *data);
-typedef int each_loose_subdir_fn(int nr,
+typedef int each_loose_subdir_fn(unsigned int nr,
 				 const char *path,
 				 void *data);
-int for_each_file_in_obj_subdir(int subdir_nr,
+int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 				struct strbuf *path,
 				each_loose_object_fn obj_cb,
 				each_loose_cruft_fn cruft_cb,
diff --git a/sha1_file.c b/sha1_file.c
index 98ce85acf9..90b9414170 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3735,7 +3735,7 @@ void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-int for_each_file_in_obj_subdir(int subdir_nr,
+int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 				struct strbuf *path,
 				each_loose_object_fn obj_cb,
 				each_loose_cruft_fn cruft_cb,
@@ -3747,6 +3747,9 @@ int for_each_file_in_obj_subdir(int subdir_nr,
 	struct dirent *de;
 	int r = 0;
 
+	if (subdir_nr > 0xff)
+		BUG("invalid loose object subdirectory: %x", subdir_nr);
+
 	origlen = path->len;
 	strbuf_complete(path, '/');
 	strbuf_addf(path, "%02x", subdir_nr);
-- 
2.13.1
