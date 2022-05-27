Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E63C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 17:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351525AbiE0RCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 13:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiE0RCm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 13:02:42 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5BF1356BA
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1653670932;
        bh=8/cmgGY8ca8d+z2jh7Gqz8RMtNh6Jm4SuBYKsgeGkVk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sQD/7tQa4NCpz23NQ8TpasfwkNwetbF20BZl3dA6vwh4H+mNGud1BD4NPW3hGHum0
         kR676F/5x5ZnZc/omdZK6eQVoizhr4Jxq6Om8cXCCV+zmHoEYfABzDOgRD1TK76iJN
         gnuzIoqGfIzKzn2x+HQPAuvqkiOVZQXzTrH0UjSk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BHw-1npvqc01OQ-013jEf; Fri, 27
 May 2022 19:02:12 +0200
Message-ID: <71ae5983-6ef8-fe28-46ab-1675e819ce8b@web.de>
Date:   Fri, 27 May 2022 19:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/7] archive: optionally add "virtual" files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
 <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <0005cfae31d52a157d4df5ba3db9f9f5b2167ddc.1653145696.git.gitgitgadget@gmail.com>
 <xmqqfskx5ndd.fsf@gitster.g> <7815a07a-da2f-d348-4179-6dc5b1d5fee6@web.de>
 <xmqqee0g1aoz.fsf@gitster.g> <ed95b26a-2fa3-d1f7-3142-05719a44a8f7@web.de>
 <xmqqfskwxd6j.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqfskwxd6j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lBjM10aSz9MvU1qJcol10Zb0dmBe1LRTKYZhgDYp8/Ar9k+5VNP
 Dr3E+MsjgBq5ZXectOatWSH9uFI7OnUfgDVfAa3UH+jgD93ONUlb7NwyV4mc3iZHqYf/Kxk
 HYjxnlxjF+O9hkQ7Va6DXBdNkSkPj0I1jppjR6JOOher98p4dqeRJncPR8d+Pm9FCxmmoae
 Sv37tVgyZWseK3curQfNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SQnomS1WTjo=:iccpJKsSAy/0WyvvznOwD8
 o0mczKiE7Kk5Y4dT2qf/eYCH5MpeKtnfpqAVDKItHFDa9Ze3lqZSfFvwRYBe+veUkWFgvspaz
 NwS68lORc2NXwcGq1csMBGO7Bw/sMpkAXe78OIgx4X12t1K1cbJMJ//gypO5cZfOCKd0/9qob
 EyOnol8pwyPeWY8qJWEL7GjC/SE4CqUDOjuV8axNzsBlIkKk5tONNcwDK+qCgLbSq3rmZDi41
 nsaJVcGPbZxDTa2OaxUSf1YDmu8BKG8zvnwf2F2fHwF3bdxOJ5vtcvN+k9Az8rTMY4e/mhX1y
 rssPdan0Dkm4SsZ1WMzvi6JOo7Xm/0sfYI/QBu12es/TcPnryOutmdzp5+Qh2qfqWeOVFeuJF
 C8w0VX4bmDlm+KY49DJcIJb5PC6M0gy4h96xl/2G72QTa5y9fa3v2gNDXD28v+gzjXBkE9Tqd
 JE9owKXFQ/6Pws9q5nRHsuMAv6KVWRBXaAHgT4j/IIcYGkboUva6QjzDv0IY7HEQ6E24wLWSC
 ysnJGJ1OhHKOoJdc9OjM/c4lGBw7s0gcuUxh0vjB+rbhwnw7gF4G512C5gj0vqifhAnOYhNE7
 PLzBg8n7bpjj/j7uXaU98SezDytzRNiYSFamZfcpBfhXrKQoZnZacjT+lQeKNz6t77+FdaAO3
 MFx4Ismcv+uRbdzdmSu+KLJyWGjEl9AzRkzRSNXiSNXCuflfT+syINgsVT5WKjzCwlC05kVTf
 OR7tQ20vQfDsudHzdaBhYthjUuHAYki24t34QxuXK2T0e8Rc3r4ROMAndiiLM+Sjq97MKirrp
 go9Fmhy91YqhkB1xArIpAua5LT6H6eBhHSVlJvdTvD4ilPgsvaVd9mdXaeSJ8IzYy6LJx55Jo
 HOpWAB8rO+WVgGs+Bbu06A9K4u5MsL7H8qb9p9jG5BEInQv+0K/czI6H/JcqJlao5RTuy2zMW
 KSAramvyyAEofikpw96pPszfQhV0WdgiE1jVQTJ6aQroUnJ/1BVHel5+0+p9nfbrZbs+tfe6m
 Gay/SEPNWOShJmtcn2k9nzMbu7B/BDTDW7LlgsWD1kS2i9skGMvMDJLkkQukhCrP0yvQyJXsg
 UZX0M6A/0udv5YjNs0OCsX2DzmQlwfk+mUU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.05.22 um 22:16 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
>> index bc4e76a783..10a48ab5f8 100644
>> --- a/Documentation/git-archive.txt
>> +++ b/Documentation/git-archive.txt
>> @@ -49,7 +49,9 @@ OPTIONS
>>  	Report progress to stderr.
>>
>>  --prefix=3D<prefix>/::
>> -	Prepend <prefix>/ to each filename in the archive.
>> +	Prepend <prefix>/ to each filename in the archive.  Can be
>> +	specified multiple times; the last one seen when reading from
>> +	left to right is applied.
>
> That can be read to mean that we will use C consistently,
>
> $ cmd --prefix=3DA other-args --prefix=3DB other-args --prefix=3DC other=
-args
>
> which was what I am worried to be a source of confusion.
>
>>  -o <file>::
>>  --output=3D<file>::
>> @@ -58,8 +60,8 @@ OPTIONS
>>  --add-file=3D<file>::
>>  	Add a non-tracked file to the archive.  Can be repeated to add
>>  	multiple files.  The path of the file in the archive is built
>> -	by concatenating the value for `--prefix` (if any) and the
>> -	basename of <file>.
>> +	by concatenating the current value for `--prefix` (if any) and
>> +	the basename of <file>.
>
> "the current value for `--prefix` (if any)" would work well once we
> somehow make the reader form a mental model that there is "the
> current" for the "prefix", which starts with an empty string, and
> gets updated every time the "--prefix=3D<prefix>/" option is given.

Right, "current" has a well-known meaning, but its not enough to convey
that the non-standard concept of capturing option values in the middle of
the argument list is used here.

>
> So, perhaps with
>
> 	--prefix=3D<prefix>/::
> 		The paths of the files in the tree being archived,
> 		and untracked contents added via the `--add-file`
> 		and `--add-virtual-file` options, can be modified by
> 		prepending the "prefix" value that is in effect when
> 		these options or the tree object is seen on the
> 		command line.  The "prefix" value initially starts
> 		as an empty string, and it gets updated every time
> 		this option is given on the command line.
>
> or something like that, with something like
>
>> +	by concatenating the current value for "prefix" (see `--prefix`
>> +	above) and the basename of <file>.
>
> here, it might make it less misunderstanding-prone, hopefully?

So how about this, which avoids mentioning the idea of a "current"
option, or of updating its value (which implies an order that might not
be obvious)?

=2D-- >8 ---
Subject: [PATCH v2] archive: improve documentation of --prefix

Document the interaction between --add-file and --prefix by giving an
example.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-archive.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index bc4e76a783..9c0e306c03 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -49,7 +49,9 @@ OPTIONS
 	Report progress to stderr.

 --prefix=3D<prefix>/::
-	Prepend <prefix>/ to each filename in the archive.
+	Prepend <prefix>/ to paths in the archive.  Can be repeated; its
+	leftmost value is used for all tracked files.  See below which
+	value gets used by `--add-file`.

 -o <file>::
 --output=3D<file>::
@@ -58,8 +60,9 @@ OPTIONS
 --add-file=3D<file>::
 	Add a non-tracked file to the archive.  Can be repeated to add
 	multiple files.  The path of the file in the archive is built
-	by concatenating the value for `--prefix` (if any) and the
-	basename of <file>.
+	by concatenating the value of the leftmost `--prefix` option to
+	the right of this `--add-file` (if any) and the basename of
+	<file>.

 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
@@ -194,6 +197,12 @@ EXAMPLES
 	commit on the current branch. Note that the output format is
 	inferred by the extension of the output file.

+`git archive -o latest.tar --prefix=3Dbuild/ --add-file=3Dconfigure --pre=
fix=3D HEAD`::
+
+	Creates a tar archive that contains the contents of the latest
+	commit on the current branch with no prefix and the untracked
+	file 'configure' with the prefix 'build/'.
+
 `git config tar.tar.xz.command "xz -c"`::

 	Configure a "tar.xz" format for making LZMA-compressed tarfiles.
=2D-
2.35.3

