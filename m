Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93CD20401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbdFXMMl (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:12:41 -0400
Received: from mout.web.de ([212.227.17.11]:60761 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbdFXMMk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:12:40 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUWBb-1dFczT2pyV-00RKnO; Sat, 24
 Jun 2017 14:12:32 +0200
Subject: Re: [PATCH] sha1_name: cache readdir(3) results in
 find_short_object_filename()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
 <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
 <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
 <d06fb033-294e-f364-3dde-394624e83cd6@web.de>
 <20170622231041.2zdjypviwmndjnsb@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <97a8def3-d2ed-9212-4d87-8767de6f2695@web.de>
Date:   Sat, 24 Jun 2017 14:12:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170622231041.2zdjypviwmndjnsb@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:11TaO3fHvR54F5WsPQA6sAvferwe/VR6E6KekuGoefTJj544LYk
 vWJqjirO/pWoxOAFjKuJ1X+dgRra/lgeCFA67fBVzzYiMIr+XnV0gMLiUTvIj7VzDQ8Ov3n
 ScmH1s34NDAAnbeN2ygOcYs95Jv3vzL4RDW04Hulgp0JF/dGY5pB2xRsXuJacZf4Xl4FIoc
 V6tjFXwynN8pen1CTLRHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zWvDfQltdac=:fH3l7GBRz3aKLKQ07Ju3Li
 iRC4RgnoQKT+BUHM5jpYjYi/BcilVy7ja/D+NEDelbDC2fl51MWzBRJCZ6Bzry/UNxWRyp13J
 9XrcAWSBMhHaKN0G+L/MiPNdub6nXmHUnmp+hUuFfEjpaJ+anBH1WiU1FD7jpD1Vgf88m4UEM
 zCaw2R6ZZjyromtDejA1sq+QBrs0yZ0L6E1BLl/2jpUq/lXzzLIafay9gaJsQ0+xOZBOYCJkC
 27OewO4dJLavQsVXUvo7A843cb3C5yOi3IhZniyhSztlh6EJz255+AaFF3HTB1El5K/8pPgS4
 2hKtxIXiR33qZa0eIrgx9hpz5tUnl/piy9Saiiz2pUaeNQtM7eoZ4DKXpuRTq56+ix7sH4zDk
 7MK+bk4UdhNNQqNXI41Xry80TyJmAjLroHweMpvB+PtTFsHjxSdyHgSawskq62vKCpqifOr5W
 rw7G3AxkeRs/AoehY+0q3Rwfg60XgA7VPowIIj5+Vu1MrfYgwrEy/pkiL1EIdHOrXJhZ5xkwM
 8gL2xKQst04mx0QAD1s9XdxcXV5l70fO/QMbtC40pbzvC9vuGMlfbGxZGOUNpXGqjtxRO1rjw
 moBIVapePb4gklY7tgTfoMjFCimI5Q3H5bMxqzRWnZnQeF4Neu3KlcKSMMy1xTRGmu/+bP0Ea
 c/4ZhhZLiunhY+mBBETAbYmt81XWPIU693b67o2sSmR/EciwG9O/JHYnlATjFr5+GW8JA1ja0
 vANlpREjIjA62zIOVWdjViovhxe9LXvN//F+B/+e2B9LHPJWCTFVn9CaO5c6pGy1kfMtXqD1c
 UMn4tuR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.2017 um 01:10 schrieb Jeff King:
> On Thu, Jun 22, 2017 at 08:19:48PM +0200, René Scharfe wrote:
>> @@ -1811,6 +1822,12 @@ typedef int each_loose_cruft_fn(const char *basename,
>>   typedef int each_loose_subdir_fn(int nr,
>>   				 const char *path,
>>   				 void *data);
>> +int for_each_file_in_obj_subdir(int subdir_nr,
>> +				struct strbuf *path,
>> +				each_loose_object_fn obj_cb,
>> +				each_loose_cruft_fn cruft_cb,
>> +				each_loose_subdir_fn subdir_cb,
>> +				void *data);
> 
> Now that this is becoming public, I think we need to document what
> should be in "path" here. It is the complete path, including the 2-hex
> subdir.
> 
> That's redundant with "subdir_nr". Should we push that logic down into
> the function, and basically do:
> 
>    if (subdir_nr < 0 || subdir_nr > 256)
> 	BUG("object subdir number out of range");

Hmm.  I don't expect many more callers, so do we really need this safety
check?  It's cheap compared to the readdir(3) call, of course.

But wouldn't it make more sense to use an unsigned data type to avoid
the first half?  And an unsigned char specifically to only accept valid
values, leaving the overflow concern to the caller?  It warrants a
separate patch in any case IMHO.

>    orig_len = path->len;
>    strbuf_addf(path, "/%02x", subdir_nr);
>    baselen = path->len;
> 
>    ...
> 
>    strbuf_setlen(path, orig_len);
> 
> That's one less thing for the caller to worry about, and it's easy to
> explain the argument as "the path to the object directory root".
> 
>> +		if (!alt->loose_objects_subdir_seen[subdir_nr]) {
>> +			struct strbuf *buf = alt_scratch_buf(alt);
>> +			strbuf_addf(buf, "%02x/", subdir_nr);
>> +			for_each_file_in_obj_subdir(subdir_nr, buf,
>> +						    append_loose_object,
>> +						    NULL, NULL,
>> +						    &alt->loose_objects_cache);
> 
> I think the trailing slash here is superfluous. If you take my
> suggestion above, that line goes away. But then the front slash it adds
> becomes superfluous. It should probably just do:
> 
>    strbuf_complete(path, '/');
>    strbuf_addf(path, "%02x", subdir_nr);

So how about this then as a follow-up patch?

-- >8 --
Subject: [PATCH] sha1_file: let for_each_file_in_obj_subdir() handle subdir names

The function for_each_file_in_obj_subdir() takes a object subdirectory
number and expects the name of the same subdirectory to be included in
the path strbuf.  Avoid this redundancy by letting the function append
the hexadecimal subdirectory name itself.  This makes it a bit easier
and safer to use the function -- it becomes impossible to specify
different subdirectories in subdir_nr and path.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 22 ++++++++++++++--------
 sha1_name.c |  1 -
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5e0ee2b68b..98ce85acf9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3742,15 +3742,22 @@ int for_each_file_in_obj_subdir(int subdir_nr,
 				each_loose_subdir_fn subdir_cb,
 				void *data)
 {
-	size_t baselen = path->len;
-	DIR *dir = opendir(path->buf);
+	size_t origlen, baselen;
+	DIR *dir;
 	struct dirent *de;
 	int r = 0;
 
+	origlen = path->len;
+	strbuf_complete(path, '/');
+	strbuf_addf(path, "%02x", subdir_nr);
+	baselen = path->len;
+
+	dir = opendir(path->buf);
 	if (!dir) {
-		if (errno == ENOENT)
-			return 0;
-		return error_errno("unable to open %s", path->buf);
+		if (errno != ENOENT)
+			r = error_errno("unable to open %s", path->buf);
+		strbuf_setlen(path, origlen);
+		return r;
 	}
 
 	while ((de = readdir(dir))) {
@@ -3788,6 +3795,8 @@ int for_each_file_in_obj_subdir(int subdir_nr,
 	if (!r && subdir_cb)
 		r = subdir_cb(subdir_nr, path->buf, data);
 
+	strbuf_setlen(path, origlen);
+
 	return r;
 }
 
@@ -3797,15 +3806,12 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
 			    each_loose_subdir_fn subdir_cb,
 			    void *data)
 {
-	size_t baselen = path->len;
 	int r = 0;
 	int i;
 
 	for (i = 0; i < 256; i++) {
-		strbuf_addf(path, "/%02x", i);
 		r = for_each_file_in_obj_subdir(i, path, obj_cb, cruft_cb,
 						subdir_cb, data);
-		strbuf_setlen(path, baselen);
 		if (r)
 			break;
 	}
diff --git a/sha1_name.c b/sha1_name.c
index ccb5144d0d..5670e2540f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -109,7 +109,6 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 
 		if (!alt->loose_objects_subdir_seen[subdir_nr]) {
 			struct strbuf *buf = alt_scratch_buf(alt);
-			strbuf_addf(buf, "%02x/", subdir_nr);
 			for_each_file_in_obj_subdir(subdir_nr, buf,
 						    append_loose_object,
 						    NULL, NULL,
-- 
2.13.1
