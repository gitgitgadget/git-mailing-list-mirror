Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1002022D
	for <e@80x24.org>; Tue, 28 Feb 2017 10:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbdB1K5p (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 05:57:45 -0500
Received: from mout.web.de ([212.227.17.11]:61658 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751341AbdB1K5m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 05:57:42 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGRdk-1cVU6A1lpY-00DGpA; Tue, 28
 Feb 2017 11:50:54 +0100
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
To:     Junio C Hamano <gitster@pobox.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
 <20170225101307.24067-2-vegard.nossum@oracle.com>
 <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de>
 <xmqqmvd7wgc7.fsf@gitster.mtv.corp.google.com>
 <f191e3a8-a55b-7030-ebbb-3f46c74fdc94@web.de>
 <xmqq1sujnu1g.fsf@gitster.mtv.corp.google.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <05fe5800-ebc0-76d7-579d-77f64a851fc1@web.de>
Date:   Tue, 28 Feb 2017 11:50:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq1sujnu1g.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:446X10cn+3/Y4ghH5gRtp5jcNejBoaihY/bz69ZQzy3C3Mq1w8K
 kdCVmDXmTYLnuzhX5Aqeqavw87KSFvb9pmc8vDA3MTm1R9u5A0ziGXT9gs483uzmra45XOA
 2eQScqGq4JBR1nyp7pRWsGvs+u9m8u94AZxga5vVJKQNofD4eQ6c4mMUtUT5tbOCcFwYO3T
 vjGDfXv28To9I0YUJRBVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mlrWT5qhgMo=:wxAyi96jQf7oAtvjHYU3k6
 H1hdYFxVcaBrRwh4QCmo8AZP8atcYEEWWKFivCXS1j31pqQ6RDRgPlepKbfBI/aBN5zAVDFlz
 GWASAV4xkshznWXE0y/+O8WayI3Ayhcm7F9tjNq1pCi2iKU26hYcnXQR3pug18ioUNUI48C9C
 JubgVkI8Lf40gw4wPAy8vvjan7nUySYob0sfB8BW3ZZUYZu2KUPGSw3nSr5DAHYbVLdbejE9J
 vHh79qspSdaa6q3cgL6aHwgnwkBA9EXFEwM9esBRPZAiOlQfp/DL/S9NquyxHdF7wT/nVtTF4
 ejfzrhh0BntJSVy291TFECwW0qvCRgO5OeCdN/vwcev2ZzrbB1pptkftvpEhSRf6Y2Y0gt60r
 70VqOA53mWLJkH2Qg/sGeMRQczlVQp3YlPAVoNi4yq3f8h/JOga+yAv9qiuFSqru6puim9Vev
 Ej3XsmXknFhmpP46y0zV9FRXgyXhNf8lSzpEbf1TEhpsC2nu1PSgVE4YKFv3QizZ0UFblLZYR
 wDORIv59RbtodxG/OtNvud+TPGANb59MuEXNFwfY7dGOMyBPxg1oiHPTbcHClMkQYhIcQZi8A
 ODHcw54y+4B3oF2L+ZJzgDeoRG8d0lcAdI2whhp88EHDP1JKHOTLC/BPSqowE9k7dkCEBR9cK
 yZyAfY9lPNkPgxeSliyLncJsK43REn2hMC8iyGBCIThvYM7F2xgcbVR0EGL0tPQ5+xDsCnDV4
 DNGh66/xiqNp4oZ1CqdOuQnAfMIJovWXZekiwE7mKjEYQzf5KSXucgkCi8i/npKlDe24OhA+W
 hPFeURE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.2017 um 23:33 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 27.02.2017 um 21:04 schrieb Junio C Hamano:
>>> René Scharfe <l.s.r@web.de> writes:
>>>
>>>>> diff --git a/apply.c b/apply.c
>>>>> index cbf7cc7f2..9219d2737 100644
>>>>> --- a/apply.c
>>>>> +++ b/apply.c
>>>>> @@ -3652,7 +3652,6 @@ static int check_preimage(struct apply_state *state,
>>>>>  	if (!old_name)
>>>>>  		return 0;
>>>>>
>>>>> -	assert(patch->is_new <= 0);
>>>>
>>>> 5c47f4c6 (builtin-apply: accept patch to an empty file) added that
>>>> line. Its intent was to handle diffs that contain an old name even for
>>>> a file that's created.  Citing from its commit message: "When we
>>>> cannot be sure by parsing the patch that it is not a creation patch,
>>>> we shouldn't complain when if there is no such a file."  Why not stop
>>>> complaining also in case we happen to know for sure that it's a
>>>> creation patch? I.e., why not replace the assert() with:
>>>>
>>>> 	if (patch->is_new == 1)
>>>> 		goto is_new;
>>>>
>>>>>  	previous = previous_patch(state, patch, &status);
>>>
>>> When the caller does know is_new is true, old_name must be made/left
>>> NULL.  That is the invariant this assert is checking to catch an
>>> error in the calling code.
>>
>> There are some places in apply.c that set ->is_new to 1, but none of
>> them set ->old_name to NULL at the same time.
> 
> I thought all of these are flipping ->is_new that used to be -1
> (unknown) to (now we know it is new), and sets only new_name without
> doing anything to old_name, because they know originally both names
> are set to NULL.
> 
>> Having to keep these two members in sync sounds iffy anyway.  Perhaps
>> accessors can help, e.g. a setter which frees old_name when is_new is
>> set to 1, or a getter which returns NULL for old_name if is_new is 1.
> 
> Definitely, the setter would make it harder to make the mistake.

When I added setters, apply started to passed NULL to unlink(2) and
rmdir(2) in some of the new tests, which still failed.

That's because three of the diffs trigger both gitdiff_delete(), which
sets is_delete and old_name, and gitdiff_newfile(), which sets is_new
and new_name.  Create and delete equals move, right?  Or should we
error out at this point already?

The last new diff adds a new file that is copied.  Sounds impossible.
How about something like this, which forbids combinations that make no
sense.  Hope it's not too strict; at least all tests succeed.

---
 apply.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/apply.c b/apply.c
index 21b0bebec5..6cb6860511 100644
--- a/apply.c
+++ b/apply.c
@@ -197,6 +197,14 @@ struct fragment {
 #define BINARY_DELTA_DEFLATED	1
 #define BINARY_LITERAL_DEFLATED 2
 
+enum patch_type {
+	CHANGE,
+	CREATE,
+	DELETE,
+	RENAME,
+	COPY
+};
+
 /*
  * This represents a "patch" to a file, both metainfo changes
  * such as creation/deletion, filemode and content changes represented
@@ -205,6 +213,7 @@ struct fragment {
 struct patch {
 	char *new_name, *old_name, *def_name;
 	unsigned int old_mode, new_mode;
+	enum patch_type type;
 	int is_new, is_delete;	/* -1 = unknown, 0 = false, 1 = true */
 	int rejected;
 	unsigned ws_rule;
@@ -229,6 +238,36 @@ struct patch {
 	struct object_id threeway_stage[3];
 };
 
+static int set_patch_type(struct patch *patch, enum patch_type type)
+{
+	if (patch->type != CHANGE && patch->type != type)
+		return error(_("conflicting patch types"));
+	patch->type = type;
+	switch (type) {
+	case CHANGE:
+		break;
+	case CREATE:
+		patch->is_new = 1;
+		patch->is_delete = 0;
+		free(patch->old_name);
+		patch->old_name = NULL;
+		break;
+	case DELETE:
+		patch->is_new = 0;
+		patch->is_delete = 1;
+		free(patch->new_name);
+		patch->new_name = NULL;
+		break;
+	case RENAME:
+		patch->is_rename = 1;
+		break;
+	case COPY:
+		patch->is_copy = 1;
+		break;
+	}
+	return 0;
+}
+
 static void free_fragment_list(struct fragment *list)
 {
 	while (list) {
@@ -907,13 +946,13 @@ static int parse_traditional_patch(struct apply_state *state,
 		}
 	}
 	if (is_dev_null(first)) {
-		patch->is_new = 1;
-		patch->is_delete = 0;
+		if (set_patch_type(patch, CREATE))
+			return -1;
 		name = find_name_traditional(state, second, NULL, state->p_value);
 		patch->new_name = name;
 	} else if (is_dev_null(second)) {
-		patch->is_new = 0;
-		patch->is_delete = 1;
+		if (set_patch_type(patch, DELETE))
+			return -1;
 		name = find_name_traditional(state, first, NULL, state->p_value);
 		patch->old_name = name;
 	} else {
@@ -922,12 +961,12 @@ static int parse_traditional_patch(struct apply_state *state,
 		name = find_name_traditional(state, second, first_name, state->p_value);
 		free(first_name);
 		if (has_epoch_timestamp(first)) {
-			patch->is_new = 1;
-			patch->is_delete = 0;
+			if (set_patch_type(patch, CREATE))
+				return -1;
 			patch->new_name = name;
 		} else if (has_epoch_timestamp(second)) {
-			patch->is_new = 0;
-			patch->is_delete = 1;
+			if (set_patch_type(patch, DELETE))
+				return -1;
 			patch->old_name = name;
 		} else {
 			patch->old_name = name;
@@ -1031,7 +1070,8 @@ static int gitdiff_delete(struct apply_state *state,
 			  const char *line,
 			  struct patch *patch)
 {
-	patch->is_delete = 1;
+	if (set_patch_type(patch, DELETE))
+		return -1;
 	free(patch->old_name);
 	patch->old_name = xstrdup_or_null(patch->def_name);
 	return gitdiff_oldmode(state, line, patch);
@@ -1041,7 +1081,8 @@ static int gitdiff_newfile(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	patch->is_new = 1;
+	if (set_patch_type(patch, CREATE))
+		return -1;
 	free(patch->new_name);
 	patch->new_name = xstrdup_or_null(patch->def_name);
 	return gitdiff_newmode(state, line, patch);
@@ -1051,7 +1092,8 @@ static int gitdiff_copysrc(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	patch->is_copy = 1;
+	if (set_patch_type(patch, COPY))
+		return -1;
 	free(patch->old_name);
 	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
@@ -1061,7 +1103,8 @@ static int gitdiff_copydst(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	patch->is_copy = 1;
+	if (set_patch_type(patch, COPY))
+		return -1;
 	free(patch->new_name);
 	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
@@ -1071,7 +1114,8 @@ static int gitdiff_renamesrc(struct apply_state *state,
 			     const char *line,
 			     struct patch *patch)
 {
-	patch->is_rename = 1;
+	if (set_patch_type(patch, RENAME))
+		return -1;
 	free(patch->old_name);
 	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
@@ -1081,7 +1125,8 @@ static int gitdiff_renamedst(struct apply_state *state,
 			     const char *line,
 			     struct patch *patch)
 {
-	patch->is_rename = 1;
+	if (set_patch_type(patch, RENAME))
+		return -1;
 	free(patch->new_name);
 	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
@@ -3704,10 +3749,8 @@ static int check_preimage(struct apply_state *state,
 	return 0;
 
  is_new:
-	patch->is_new = 1;
-	patch->is_delete = 0;
-	free(patch->old_name);
-	patch->old_name = NULL;
+	if (set_patch_type(patch, CREATE))
+		return -1;
 	return 0;
 }
 
-- 
2.12.0
