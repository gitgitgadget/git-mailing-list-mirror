Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B1C433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 06:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbiE1G6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 02:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242410AbiE1G6S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 02:58:18 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F78183A5
        for <git@vger.kernel.org>; Fri, 27 May 2022 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1653721069;
        bh=CKghe6N1+QakRBnOZhxYDjO2q35CDjK2Qz72l7aS2tg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=V6OnDG22Pyi6JyPMyfd/nbHFZ7Mx4c+LcmvumMWsG4tjvVH16H83aIBGqyEk7x4oZ
         o8u/AKnPIPVvmokVXeWSeAC58sXsuwoXxdXiKljmuo4gcee7xwkRW58wLqQ60uDUw7
         Fh6SIdpoG5gVQEF3+Bxp72/adiY65BcWoa2uRsD8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUWM-1o23Fv0GSo-00GSqo; Sat, 28
 May 2022 08:57:49 +0200
Message-ID: <6ef7f836-45f6-8386-03c0-dc18b125ec67@web.de>
Date:   Sat, 28 May 2022 08:57:46 +0200
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
 <xmqqfskwxd6j.fsf@gitster.g> <71ae5983-6ef8-fe28-46ab-1675e819ce8b@web.de>
 <xmqqh75a3imc.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqh75a3imc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q0xm3oDczUUYzpeBxDDxI6TrA8LB1dUhRdnLz+1uWBUexW+WMv/
 E+yEUoL4U2050BaXxCMH4GxFmcg/ScS+wmbUGPqIFBsz6mS3wOyVhXlMQAOSVr8Sk0TdARx
 +DKfSMaXKKgiuxKi9bvR7eA47u6uEjROHjWsdN5qSlik0eYG2E4dvDk4zDDecf6MoHVgyca
 aH0CHelsdf6SHf5y2XPjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uRp22xjf7Dc=:PMtx9wy/fCbnnPFJX32N3V
 fcS2v/TId2tCS4VlGhaiPxfM80JW6xidpd8iDZy7V54xjo/tKaRC5GAzeV+Mlse5WIN8yDrOH
 6DonxLYh1/vK8v4fbtl/92xYyDkP/3ON5UfPygsgt12gCK9T3gfvi4YYvCIG9jXNpL1kwFj3w
 QwLyvIDRIsxZSbRtz39TA17byS8u1Z8htM//biwx8BC+s5VZyhC4pjpZwrzlRnajN03EeEYpt
 7PMXAaA0uOMw/tSkbGScsCQ2z8vvobn/gZgcPWxWfutlg6S7uZMpflOELx63TGRfhWKNZkyTz
 7IxY1xSJxuf4XfaI5VZfXYuyI9UnFqa4V4eGySQfllCYByWLjMvNnHjEiQ6Odebbn7kgzJ3NL
 xaCx/hhIZrmKfLqECmh/tEeshPPvrtZsH9kuEkG97tUEr5Iq0ojY7LVNZoJIQ4ZsSDSUKAWz1
 nXIlC9+m3EyWa3J4C+BwvUj9bPtc8yvoE+o2IhgOzgQEQ+TnrDSjU0uVzU+5RcblBZ65KIP6S
 TlldmvkOwlgG9rsnKG/fI/TYxDUL0MM4R514b/L3H8vGnyTu+dk8hGyIN2m+/v5ee7DadGCt2
 mMiO+epgfzPLV8OC7xE5dHbVi0ZXROEe20MowzYWGXBWaVEgn7eXDeraEp+WbeChbcqE3O86M
 zNV1De9kYypovxm0Wb+zNRJ1XwaxUYcF83MT0BEwhBNMzcXiIvPO6HwTGoXaOXHxyD3Can4Xs
 B/hg2k3v+VoQJknIe9wYjktOgciCcmoN3xOxMe+7ZJqSa7iprXwwjMakAk0WUIiLm0lqK6W0N
 IB6W+GAZ6IFgFzxjPhvfMTfv3s0NYJ2CoZOoS+J55O/iTEMuM/jxueyFhlZ+Qgn9EfEf70ke2
 dBftwFyTxrkA4nbRvcWSOr0wKtL8BgKMaKaVhTDnCJctWiH8EGoxZ70k9rTCDkOn4tOadxg6E
 wWXrdz+yQcrEagjDMRL2d4duQ6vPQoqS4yHpFLe/qHf/2ByWlTdH6ZugRJBA8yoiSiDKXIBRR
 zNRYrgzx6Sr/px/lhwokErli76/4Y6begRlTyJvYe//TfMJzYa+bxMkvkocUUroHrya4HFr+4
 WWfgT/3RENF+b7IGnTWV9YhaD+gNJ9uutl/
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.05.22 um 21:01 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>  --prefix=3D<prefix>/::
>> -	Prepend <prefix>/ to each filename in the archive.
>> +	Prepend <prefix>/ to paths in the archive.  Can be repeated; its
>> +	leftmost value is used for all tracked files.  See below which
>> +	value gets used by `--add-file`.
>
> Doesn't "the last one wins" take the rightmost one?

Ha ha!  Classic mistake, I do that all the time, especially when in a
hurry. >_<

>
>> @@ -58,8 +60,9 @@ OPTIONS
>>  --add-file=3D<file>::
>>  	Add a non-tracked file to the archive.  Can be repeated to add
>>  	multiple files.  The path of the file in the archive is built
>> -	by concatenating the value for `--prefix` (if any) and the
>> -	basename of <file>.
>> +	by concatenating the value of the leftmost `--prefix` option to
>> +	the right of this `--add-file` (if any) and the basename of
>> +	<file>.
>
> It is not what archive.c::add_file_cb() seems to be doing, though
>
> It is passed the pointer to "base" that is on-stack of
> parse_archive_args(), which is the same variable that is used to
> remember the latest value that was given to "--prefix".  Then it
> concatenates the argument it received after that base value, so
>
>     by concatenating the value of the last "--prefix" seen on the
>     command line (if any) before this `--add-file` and the basename
>     of <file>.
>
> probably.  I always get my left and right mixed up X-<.

You too?  So yeah, avoiding the terms is appealing.

>
>> @@ -194,6 +197,12 @@ EXAMPLES
>>  	commit on the current branch. Note that the output format is
>>  	inferred by the extension of the output file.
>>
>> +`git archive -o latest.tar --prefix=3Dbuild/ --add-file=3Dconfigure --=
prefix=3D HEAD`::
>> +
>> +	Creates a tar archive that contains the contents of the latest
>> +	commit on the current branch with no prefix and the untracked
>> +	file 'configure' with the prefix 'build/'.
>> +
>>  `git config tar.tar.xz.command "xz -c"`::
>>
>>  	Configure a "tar.xz" format for making LZMA-compressed tarfiles.
>
> Thanks.
>
> This patch probably needs to come before the "scalar diagnose"
> series, which we haven't heard much about recently (no, I am not
> complaining---we all heard that Dscho is busy).
>
>

=2D-- >8 ---
Subject: [PATCH v3] archive: improve documentation of --prefix

Document the interaction between --add-file and --prefix by giving an
example.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-archive.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index bc4e76a783..94519aae23 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -49,7 +49,9 @@ OPTIONS
 	Report progress to stderr.

 --prefix=3D<prefix>/::
-	Prepend <prefix>/ to each filename in the archive.
+	Prepend <prefix>/ to paths in the archive.  Can be repeated; its
+	rightmost value is used for all tracked files.  See below which
+	value gets used by `--add-file`.

 -o <file>::
 --output=3D<file>::
@@ -57,9 +59,9 @@ OPTIONS

 --add-file=3D<file>::
 	Add a non-tracked file to the archive.  Can be repeated to add
-	multiple files.  The path of the file in the archive is built
-	by concatenating the value for `--prefix` (if any) and the
-	basename of <file>.
+	multiple files.  The path of the file in the archive is built by
+	concatenating the value of the last `--prefix` option (if any)
+	before this `--add-file` and the basename of <file>.

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
