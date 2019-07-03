Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46A591F4B6
	for <e@80x24.org>; Wed,  3 Jul 2019 18:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGCSh4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 14:37:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58267 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCSh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 14:37:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 395E3153AD8;
        Wed,  3 Jul 2019 14:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jEUNxIWbz4kqmnP/34IGSuUXyQ4=; b=cBXIjg
        mDIZh5OAZACCWJrCvYklpdoxQU9P9Uud+5OSzOcu0IGTAjIQ2NjOTPoFKXKdo5Z8
        RWJqO11eBlBFiv7WbsP2SnVSvhdYLZRt+GMe5K4v96V4uv82IvSa+uyXcs+JEge2
        QGkKCP3dLOiUrAJSLEBN2YMxtUlPkqJuKRlyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LUBkF4Mmy6AhZfM68R3Qdw70IdfXuqMe
        TpBvcMJMMHiB6s3xjYBwH+lNqab9ysopYEgMlfRwzkkBhp3pAi0H+2uZJ4+t/Ucg
        Ec8dhKjASdWCuf0XXUPTstpRwsDhrM3ZbkE6DvkLi6CL0coaL7Zzoj+vXGGVRekm
        KJsiSyrLuqA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30155153AD7;
        Wed,  3 Jul 2019 14:37:54 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8470D153AD5;
        Wed,  3 Jul 2019 14:37:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Janos Farkas <chexum@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] repack: warn if bitmaps are explicitly enabled with keep files
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
        <875zow8i85.fsf@evledraar.gmail.com>
        <20190623180226.GA1100@sigill.intra.peff.net>
        <20190623180825.3ospajjgat3clwiu@dcvr>
        <20190623224244.GB1100@sigill.intra.peff.net>
        <20190628070211.hfweqcons6c6gy52@dcvr>
        <87zhm26uq9.fsf@evledraar.gmail.com>
        <20190629191600.nipp2ut37xd3mx56@dcvr>
        <xmqq7e917h9x.fsf@gitster-ct.c.googlers.com>
        <20190703173814.GA29348@sigill.intra.peff.net>
        <xmqqftnn0z1t.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 03 Jul 2019 11:37:52 -0700
In-Reply-To: <xmqqftnn0z1t.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 03 Jul 2019 11:10:22 -0700")
Message-ID: <xmqqy31fynen.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB0E6852-9DC1-11E9-B8CA-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>
>> A much more robust solution would be to stop conflating user-provided
>> permanent .keep files with temporary locks. I think that was a mistaken
>> design added many years ago. We probably could introduce a different
>> filename for the temporary locks (though I am not entirely convinced
>> they are necessary in the first place, as gc expiration-times would
>> generally save a racily-written packfile anyway).
>
> True, true (and I tend to agree).
>
>> Or perhaps we could differentiate our temporary locks from "real" .keep
>> files by looking at the content; I think our locks always say something
>> like "(receive|receive)-pack \d+ on .*", and it wouldn't be too onerous
>> to commit to that, I think (or even adjust it to something even more
>> unambiguous).
>
> True, but it may be overkill to open and read.
>
>> It does muddy the meaning of packed_git.pack_keep a bit.  Some callers
>> would want to consider it kept in either case (i.e., for purposes of
>> pruning, we delete neither) and some would want it kept only for
>> non-locks (for packing, duplicating the objects is OK). So I think we'd
>> end up with two bits there, and callers would have to use one or the
>> other as appropriate.
>
> Yeah, I agree that we'd need to treat them separately in the longer
> run.
>
> Thanks.

In the meantime, this is about patch 2/1; the underlying "when .keep
is there, disable bitmaps" is probably good to go, still.

-- >8 --
From: Eric Wong <e@80x24.org>
Date: Sat, 29 Jun 2019 19:13:59 +0000
Subject: [PATCH] repack: disable bitmaps-by-default if .keep files exist

Bitmaps aren't useful with multiple packs, and users with
.keep files ended up with redundant packs when bitmaps
got enabled by default in bare repos.

So detect when .keep files exist and stop enabling bitmaps
by default in that case.

Wasteful (but otherwise harmless) race conditions with .keep files
documented by Jeff King still apply and there's a chance we'd
still end up with redundant data on the FS:

  https://public-inbox.org/git/20190623224244.GB1100@sigill.intra.peff.net/

v2: avoid subshell in test case, be multi-index aware

Fixes: 36eba0323d3288a8 ("repack: enable bitmaps by default on bare repos")
Signed-off-by: Eric Wong <e@80x24.org>
Helped-by: Jeff King <peff@peff.net>
Reported-by: Janos Farkas <chexum@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/repack.c  | 18 ++++++++++++++++--
 t/t7700-repack.sh | 10 ++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index caca113927..73250b2431 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -89,6 +89,17 @@ static void remove_pack_on_signal(int signo)
 	raise(signo);
 }
 
+static int has_pack_keep_file(void)
+{
+	struct packed_git *p;
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		if (p->pack_keep)
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Adds all packs hex strings to the fname list, which do not
  * have a corresponding .keep file. These packs are not to
@@ -343,9 +354,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
 
-	if (write_bitmaps < 0)
+	if (write_bitmaps < 0) {
 		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
-				 is_bare_repository();
+				 is_bare_repository() &&
+				 keep_pack_list.nr == 0 &&
+				 !has_pack_keep_file();
+	}
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 86d05160a3..0e9af832c9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -239,4 +239,14 @@ test_expect_success 'bitmaps can be disabled on bare repos' '
 	test -z "$bitmap"
 '
 
+test_expect_success 'no bitmaps created if .keep files present' '
+	pack=$(ls bare.git/objects/pack/*.pack) &&
+	test_path_is_file "$pack" &&
+	keep=${pack%.pack}.keep &&
+	>"$keep" &&
+	git -C bare.git repack -ad &&
+	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
2.22.0-214-g8dca754b1e


