Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18C71F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbcHAR6w (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:58:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754220AbcHAR6v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:58:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D51C2327A2;
	Mon,  1 Aug 2016 13:58:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WmXW3+KFnFgi8JDo8+Et5Ueam2s=; b=OXF1qh
	ZECubjO0vZ5l+ANBt7p0s2BnnWLRP1v++a2D6jmXmLnX+SiCzucmYA2dYHRvUWmZ
	I+rwDXFgju6Y315BflmlwlAZBLwpfm23PzO6j/15WeGcWn3Qv+7/KAcQ75IHjX4s
	dTW6fxDkxuhBvxfEZ948PReayJ5ixZ86PAzAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cuh0F706xyjb+chYF3ZKX1DMd7f61GkP
	ob6DZR/1/ZlQ4Y/vDzdNj2YMvOJAl1OrsFBAj7IVdyfL+ewPqsrkvki6Ouew1FYk
	PR0P/2VXb7sFTaZXIvhVUhvbOS1DPKftilazp5FrySLC37KIlV71dl3JPTbge5ln
	nezGyg1BsPQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD3BA327A1;
	Mon,  1 Aug 2016 13:58:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54D01327A0;
	Mon,  1 Aug 2016 13:58:49 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Paul Tan <pyokagan@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
	<CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
	<20160729002902.GD9646@sigill.intra.peff.net>
	<CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
	<20160729155012.GA29773@sigill.intra.peff.net>
	<xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
	<20160729180517.GA14953@sigill.intra.peff.net>
	<CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
	<20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net>
	<xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 01 Aug 2016 10:58:47 -0700
In-Reply-To: <xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Aug 2016 10:49:12 -0700")
Message-ID: <xmqq7fc0l6aw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99741DA6-5811-11E6-97C7-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> So maybe we would have to put reset_ident_date() at the end of the
>>> function instead, at least after git_committer_info() is called.
>>
>> Yes, although "reset and end" still feels a bit weird to me.
>>
>> I'd almost prefer to just have long-running programs insert resets at
>> strategic points.
>
> Certainly "reset at the end" feels weird but it can be explained as
> "for a one-shot thing we use the first time of the default date and
> it gives a consistent timestamp; conceptually, things that make
> multiple commits are like doing that one-shot thing multiple times
> in a row."
>
> When viewed that way, it is not _too_ bad, I would guess.

An interdiff to what we queued previously would look like this:

 builtin/tag.c | 11 ++++++++++-
 commit.c      | 15 ++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 5dccae3..e852ded 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -225,7 +225,6 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (type <= OBJ_NONE)
 	    die(_("bad object type."));
 
-	reset_ident_date();
 	header_len = snprintf(header_buf, sizeof(header_buf),
 			  "object %s\n"
 			  "type %s\n"
@@ -287,6 +286,16 @@ static void create_tag(const unsigned char *object, const char *tag,
 		unlink_or_warn(path);
 		free(path);
 	}
+
+	/*
+	 * Reset the default timestamp for the next call to create tag/commit
+	 * object, so that they get their own fresh timestamp.
+	 *
+	 * NOTE NOTE NOTE! if you are libifying this function later by
+	 * turning exit/die in the above code to return an error, be
+	 * sure to jump here to make this call happen.
+	 */
+	reset_ident_date();
 }
 
 struct msg_arg {
diff --git a/commit.c b/commit.c
index b02f3c4..db24013 100644
--- a/commit.c
+++ b/commit.c
@@ -1543,7 +1543,6 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	}
 
 	/* Person/date information */
-	reset_ident_date();
 	if (!author)
 		author = git_author_info(IDENT_STRICT);
 	strbuf_addf(&buffer, "author %s\n", author);
@@ -1564,11 +1563,21 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	if (encoding_is_utf8 && !verify_utf8(&buffer))
 		fprintf(stderr, commit_utf8_warn);
 
-	if (sign_commit && do_sign_commit(&buffer, sign_commit))
-		return -1;
+	if (sign_commit && do_sign_commit(&buffer, sign_commit)) {
+		result = -1;
+		goto out;
+	}
 
 	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
+
+out:
 	strbuf_release(&buffer);
+
+	/*
+	 * Reset the default timestamp for the next call to create tag/commit
+	 * object, so that they get their own fresh timestamp.
+	 */
+	reset_ident_date();
 	return result;
 }
 
