Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B987C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348649AbiEZS6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiEZS6S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:58:18 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D6DCC169
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1653591472;
        bh=YC//nQJVtJMG/TFQtM0HOEqpNHKZ58KRjp8JeoHEwsw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MXQjkQWc0asKJ8H5pL+2+YoZMmqCn35wwpsTYPSlf18wE9+cMhkpJtaM98WmdQcf1
         ORmnwll+9gy4DDlBkF7us1pkQRMSOAuM6aUH5JgbmTSGHM7xmrlHTeLQIXTKQ1hIrS
         rtD07kFoCEnxpd3gxvFCu1xW15LZwu/NPPM9PjA0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HK6-1nwVbM1w9A-006yu6; Thu, 26
 May 2022 20:57:52 +0200
Message-ID: <ed95b26a-2fa3-d1f7-3142-05719a44a8f7@web.de>
Date:   Thu, 26 May 2022 20:57:49 +0200
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
 <xmqqee0g1aoz.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqee0g1aoz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ijM2SRby7GGnw4YkkdwewEfgIzHOwrCY/bgsaD19LR99sVaugUd
 Fn3rEZTiXmrhy5T5JC8tigZOx2INBOtNbelVDpFAUEIZI+l7UBDsI9w+EmyrXEM4yM3K99r
 xQ0Lks6QVBftj/7KLI/VZThs+VM/olghTNVk+Uhe9fPbE7nurMgxbnl9KEIyQGPEus2skkK
 nSQxUxJPq0gQd/DJmebgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6mpa4igplXs=:PRk4y2y2W5Ur3GK1DpHyKw
 lbz8GNhqWaucRW5v7ckdU2LuFeWjyshKDVuZKMqlcfvbA4tmMRUhwAXXH3XzyZePXy5E6YXnS
 suQtk+m5S1Se10IrqBnhG9UY3L4ADewNak4y5efzOlr68nvNjbn8tjtJVtRQoQ376Br+zGftk
 xH7jDQ3Phro/ovlq0UO1fCAf1/VouRK0YE5sx5ikHScSWC2g3lVS2wx4XobliUzPfquILEf7T
 jkFla+/xT0/mmRCApVCNfQBYSQ7dAeskUA+TiqgUjxO5kQH0Uas83i7gRUHjwBr7ls4reRtPP
 ueoJIuFVgruuMAVDp73zYWdndkBt0DNQUuLEki0w3Oz4nNG+5poZGHVtUQVhurNnipvZweJlL
 pexQFmkz1/L7Ms0sHZkyM71LJ16Y2mEs5Ci3aPTZMyDrqaIBaGiWCXJhBOLPQnPDVU/rOXhow
 vPnHKoGhr5UtcdGZ2CWJykXKjzkrf81m7rXxzWe9pZ0PQVKvPqOx8rAo0Ny9lO8/Nhsj3EODc
 RcEnHWjZGoAXdf3ebHYPJPoF1ZJ+rasEMQHwwZNO/fMc3Sy5U5k8bloCVrGS4LCg41qbrDhAP
 uLtta0TdC+kUhnESc1/h5AtdrMLk/D5CAtWF9gXIq3K+vHevPndMXVbCu1wBoQObxkDLgWl6Z
 f6hLiEBUqSBk6nImYZkq08kFni6w5Hb5X66SRgx/+X9im16Hnmyt0SHo63eEnuuYP9Ghv5QBb
 DcZ7PsnTiORB6PKmP4GkQOAxu29Pp8Tg7ZuTaE5GJ42tDeOplMlmqd1gFhX7tvJ3ZD+Gs5VXE
 2WYCz6K5ZMaR0bB0ZAlq4I8f0wb1Im+VzPGcws2BvGmCQDIgpUrhwlWZYMs4qp5KYCYp//CLr
 YwMWEE/KzEvdIjd08Bx1Zk2QzWpmUGIbs7aO75w7DMtPEX90yKvbqqbciacc1EA6f9wkh1T7P
 Q6wW5M5/YEZV3nIGIN5mCeB7aLaruZb1zs6cJFH4zNo3YPPJaRYQ31DNM4zg2Srl8rjmESRou
 WD5q5pdj9SHhWtq6qFXwmcXySMglubXKO5+O1ourkGMbnDaCx0isl7llBLJqSicpe3oE3TMal
 ZMM9Dd1BZ/tNt+/g/Dkr+sVemTLc6bk9NsN
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.05.22 um 19:10 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> If the prefix is applied then a prefix-less extra file can by had by
>> using --prefix=3D or --no-prefix for it and --prefix=3D... for the tree=
,
>> e.g.:
>>
>>    $ git archive --add-file=3Dextra --prefix=3Ddir/ v2.36.0
>>
>> puts "extra" at the root and the rest under "dir".  The order of
>> arguments matters here, and the default prefix is the empty string.
>
> This was the part of the design for the original "--add-file" that I
> was moderately unhappy with.  If "--add-file" were the only feature
> that used "--prefix", I wouldn't have been unhappy, but this rule:
>
>         The value of "--prefix" most recently seen at the point of
>         "--add-file" is prepended.  (By the way, it is not clearly
>         documented what happens when you give multiple prefix and
>         when you give prefix before or after add-file)

Regarding documentation: I wonder what's missing; a guess is below.

>
> makes the original use of "--prefix":
>
> 	The value given to "--prefix" is prepended to each filename
> 	in the archive.  (IOW "git archive --prefix=3Dgit-2.36.0/
> 	v2.36.0" is a way to prefix each and every path in the
> 	tree-ish with the given prefix)
>
> confusing.  Does
>
> 	git archive --prefix=3Dbonus-files/ --add-file=3Dextra v2.36.0
>
> place the main part of the archive also in bonus-files/ or at the
> top level?  One reasonable interpretation is "yes", if we imagine
> that each invocation of --add-file will consume and reset the prefix.
> Another reasonable interpretation is "no", if we imagine that the
> prefix last specified will stay around and equally affect both extra
> ones and main part of the archive.
>
> Unfortunately what the implmentation does is the latter, and those
> who want to put the main part of the archive at the top-level must
> add "--prefix=3D''" at the end (before the tree-ish).

A one-shot --prefix would be surprising -- usually options keep their
value until they are specified again with a different value or negated
(--no-...).  That surprise could be documented away by using a
different name like --next-prefix or --single-use-prefix.  But a
sub-option to a single option like that would probably be better baked
into that option, e.g. allow --add-file=3D<path_in_archive>:<path_in_fs>.

>
> Because of this potential for confusion ...
>
>> So extra files can be put anywhere even if --prefix is honored.
>>
>> Keeping the whole path from --add-virtual-file makes sense to me; I
>> slightly prefer applying --prefix on top of that for consistency.
>
> ... I was hoping that we can releave users from having to worry
> about the interaction between "prefix" and contents coming from
> outside the tree-ish by ignoring the "prefix".
>
> But either is fine by me.

The unusual thing about the current --prefix implementation is that its
current value is captured along the way instead of just using its
right-most value.  Not sure ignoring it for one of the three archive
content sources helps.  (Really, it's hard for me to put me in the shoes
of someone who doesn't know how these options are supposed to be used.)


=2D-- >8 ---
Subject: [PATCH] archive: improve documentation of --prefix

Document the interaction between --add-file and --prefix by giving an
example.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-archive.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index bc4e76a783..10a48ab5f8 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -49,7 +49,9 @@ OPTIONS
 	Report progress to stderr.

 --prefix=3D<prefix>/::
-	Prepend <prefix>/ to each filename in the archive.
+	Prepend <prefix>/ to each filename in the archive.  Can be
+	specified multiple times; the last one seen when reading from
+	left to right is applied.

 -o <file>::
 --output=3D<file>::
@@ -58,8 +60,8 @@ OPTIONS
 --add-file=3D<file>::
 	Add a non-tracked file to the archive.  Can be repeated to add
 	multiple files.  The path of the file in the archive is built
-	by concatenating the value for `--prefix` (if any) and the
-	basename of <file>.
+	by concatenating the current value for `--prefix` (if any) and
+	the basename of <file>.

 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
@@ -194,6 +196,12 @@ EXAMPLES
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
