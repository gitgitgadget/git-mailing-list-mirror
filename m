Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C93AC433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6121F6023F
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 07:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhIDH5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 03:57:13 -0400
Received: from mout.web.de ([212.227.15.3]:51963 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233340AbhIDH5M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 03:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630742168;
        bh=KBkQQSUV1GvjtDUVg/Hs95apeR7h8w5IE6qisUpwcV8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FFSMw5lTtjSyo5RSH2xxViqrscaLuEWA2ycp6MObdVVSPgRhICdhh2hnH5q0dHQ/9
         ccF2LrvXxeZqpvckNVVskAsGn5qWlPSJH7Vw8NJM10z3yJALobr8rq4mqlcfPfvFhq
         /fi4XazyRt59z6W3A1FQDBVoeUjligZpUs2yL2AI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MGzFy-1m8f4K32oc-00Dkbs; Sat, 04 Sep 2021 09:50:58 +0200
Subject: Re: [BUG?] git range-diff -Ix @{1}... segfaults
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqbl59fq9i.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7ac58fa9-f0f3-53bc-e51b-de9cd4efdb29@web.de>
Date:   Sat, 4 Sep 2021 09:50:58 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqbl59fq9i.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bOOxdfAR/v/9nfP07wdvjMhm4RQNXpqLwX/XjM6ierK5m8NHGRb
 H16AVBH6LJ9Q0q8B1V+h/Wnt2Jj3DJKpvpLyvptU2fGXRXbtYmsGbzELlPEG3TWvx/t7TcM
 qV5GzLtKXLoQxuF8h1ANTPKvlY/zxI/NfAHzy8oDQalCzaxzuRRdonrVISvsBSSEKvRqBh5
 S/Di6WnylMhxV3LamXelA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:54TJKnbfDY8=:UYFDqnIidWiWoCML4k9q8s
 UY8cMFUQNEBbCFYi+iE9JS5fayHYbvEleraX9qyjHC2jZ6tCDzkKax8SQBrpk7syWEXZK/Cjj
 tu2Hefo8qwxQKU0ixmqrRxIGaveYhSPh7VDsI5e8fHNvgbMww1SQcLtF6gyrk/a780UvlhTqW
 fkv79NtWCSYno19HOvHwXoVIXA/BJrWiOdWlcIpnxoOBcKbuEB5Lk0wiNYD13sf5D2JI51sf8
 bS/1zEqkOU2qYniFRVaLcl+kbNLrwYC4sGpti0aUsn6WGSgvOq1MTQqjZfkhSjtIodJUF18BR
 t+Frud8wpxqRW++LlqX0wytO5eBR2OUEZiuGNzFH6ChJqIgxX9OgG6+2dEe+9Zmse3Ax0JJS7
 4gqVR3fRjdrVGxxCSbpT8kMMeVBUl0nWheUbW4yOldgBjBiwgLExulYwfXhpJwqunnbcwnt84
 Jmzn5aH4aRqX5KFYDIvEN/+3zFZkmf9I0p2Qn8hg3n//zc1InJbSHFX6Wx8Z/OKPtw//q/22U
 UB1tMbj0F4wlR5CUuIhl1O7+g7KKcnKd4SFIOY/TXfk0dBE+w6dHQfWJIyRBOK/uRrwSrvWlW
 ZppPV33UNojK0mn++8aYjKn5ogEhPZ4cp2WznaAWmMUP6rAsyQgudmw79RAtuF37nxOyF7t++
 xKiA78WOuki5ABdFx4CfbD2tHWVSNlNu9GWHVVFBmSdlzluwrDyhgag05t0jns7Tossxw3Cng
 r87zN1gDMAFl6byuOjG75lcrTkw5wrospDKhlbfQUNNnvLOZOxacHm4x0kXblp6C0c6cjnSzK
 EjEelEYE3RgzidLV62KEcdoJMGkriQdcBfI5q5HzxNwzBizeAzQqHfsRkvpGqOoR62l+cbp8q
 HwknXPY6gX1UoZnF3+apMxqP5nzJda/97T174ZlsnECy/cpeBR8ZsA+qIosaKfFICATX8QJoC
 sb8fLKeuLRH0JLq6SXiISyfTc0RP7oX7KwWc8f3kFhWJqzl2D1x73YroPSSFBT4eEvc17Zj+T
 2kkzgkCu6ZuaxNSLxuDuwVk0EkVD9z44rykGJe+LMUOe1YYgaOrAtXdNuumbP6TLaQ4ANl8n0
 DqJeywckDv3Lba/Y/Z+TFVwWa8GFcAwHrGO
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.09.21 um 20:49 schrieb Junio C Hamano:
> It does not seem to trigger with an empty range, e.g.
>
>     $ git range-diff -Ix HEAD...
>     $ git range-diff -Ix HEAD~...
>     -:  ---------- > 1:  0a0bc7d03a scalar: accept -C and -c opt...
>
> but when it needs real comparison, the -I seems to kill the command
> quite easily.

Reverting c45dc9cf30 (diff: plug memory leak from regcomp() on
{log,diff} -I, 2021-02-11) fixes the segfault.

diff.c::diff_free() frees the ignore_regex member of a struct
diff_options, but doesn't reset the ignore_regex_nr nor clears the
pointer.  It is called from diff.c::diff_flush().

range-diff.c::output() calls diff.c::diff_flush() in a loop with the
same struct diff_options (via range-diff.c::patch_diff()).

So the second iteration of that loop tries to use the already freed
ignore regexes.  Here's a patch for that:

=2D-- >8 ---
Subject: [PATCH] range-diff: avoid segfault with -I

output() reuses the same struct diff_options for multiple calls of
diff_flush().  Set the option no_free to instruct it to keep the
ignore regexes between calls and release them explicitly at the end.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Test missing because I couldn't see any effect of -I on range-diff.

 range-diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/range-diff.c b/range-diff.c
index e731525e66..cac89a2f4f 100644
=2D-- a/range-diff.c
+++ b/range-diff.c
@@ -482,6 +482,7 @@ static void output(struct string_list *a, struct strin=
g_list *b,
 	else
 		diff_setup(&opts);

+	opts.no_free =3D 1;
 	if (!opts.output_format)
 		opts.output_format =3D DIFF_FORMAT_PATCH;
 	opts.flags.suppress_diff_headers =3D 1;
@@ -542,6 +543,8 @@ static void output(struct string_list *a, struct strin=
g_list *b,
 	strbuf_release(&buf);
 	strbuf_release(&dashes);
 	strbuf_release(&indent);
+	opts.no_free =3D 0;
+	diff_free(&opts);
 }

 int show_range_diff(const char *range1, const char *range2,
=2D-
2.33.0

