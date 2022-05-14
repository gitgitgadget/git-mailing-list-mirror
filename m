Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF89C433F5
	for <git@archiver.kernel.org>; Sat, 14 May 2022 07:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiENHGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 03:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiENHGf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 03:06:35 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01FCD8
        for <git@vger.kernel.org>; Sat, 14 May 2022 00:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1652511969;
        bh=gnTsN7kvZxkYR8Lbny/MqZ8+QBrqEabOYFLjpQecZSM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dJuh7y1hhDFJCwy3NJJ85ChXexdluEA7p+niDqCqtXaMAl2Vfl0ALnk7/Algz+eNi
         HQzjRkG0MdL+7YsBg2ZPF1SFII33h0dAh95joIgtDnXSONpQZKXhsFIGJ44/E/UQT+
         va+5Y2WR2RaqHaKd9bcpYGImKlaiivH6cA3zo4S8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.145.161]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtPre-1o3aud2WQI-00vBUB; Sat, 14
 May 2022 09:06:09 +0200
Message-ID: <20179ba6-33d5-e95e-cf90-10aabc81734b@web.de>
Date:   Sat, 14 May 2022 09:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/7] archive: optionally add "virtual" files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Taylor Blau' <me@ttaylorr.com>,
        'Derrick Stolee' <stolee@gmail.com>,
        'Elijah Newren' <newren@gmail.com>,
        'Johannes Schindelin' <johannes.schindelin@gmx.de>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
 <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
 <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
 <xmqqtu9x6ovh.fsf@gitster.g> <03d701d864ba$46d15c10$d4741430$@nexbridge.com>
 <xmqq8rr955zf.fsf@gitster.g> <3cf6e4f8-9151-6d68-21ca-b94d6a7557e6@web.de>
 <xmqqzgjnkgy0.fsf@gitster.g> <47ed5a2f-f4aa-1ec1-27c9-9b0b70eb8bca@web.de>
 <xmqqfslefwie.fsf@gitster.g> <xmqqmtfme8v6.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqmtfme8v6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E1iWGkFD+/Wuz4DFgthwdIvIBS66RfUX4b1lAPFxaE1WG+eANum
 SVHRPRMelLw5UZQYofOO0tvrV9yPfTCoH6s1D72UOSYTNhZxDhIXI8BoTNpUI5jrJlIvYw/
 blrlCQLJlgc6n7JOoMKBNkKvAOKhbAh8u41wQwrUshDahOnC7tX7Qg65O+LlUNn331w2iK2
 aOxwpPpqDZhcSYILLq+Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+wUnqsj98kI=:EjfwgpAfYL3FM0H/5DwI7Y
 NBH3tX8+3h+UuTUjXI6U+g5WT80pvEG4xGTMfAzraUtr3REB1692UtydKDpoX1+J0K76795v4
 XTkGpCGwgL8nrBneDs/ce2unPsGky8wA2bQVLKhrSC4x72P0W9Pa1pVusYINesOiNVxRCghzB
 +LoEx8bWP59sSjjbD6/0uuEkUvbGJt3FZE0rR7bsPV4iWgjnxIF0Td8SL/Us2s4u0TRyvoQKu
 Ys0FD1L53OPh8jIRC8B/+XvmfwplJC3DMyVJlgSeF7cyfOCtTyrfRMXfP2HzaG2VzIR7Mn21q
 HEoxMc5POGqMGMahjDOCezFFwqQc/kv1tz2Cf6Oauo0iyC4b54NUuQSDmbpxdqkVle3MbKTHR
 NFNT9cABohJTv+cGEByjca4lslc+sNnixeRYhDAfpFd9NIdL1hUjZJEuVqan+5vaoJFlqpN3u
 ze73AWpmKeGl0fH1JPW3TeMoKRw9bgJoUD72PRUh+9vDjlVhGjENHkRbDBsdOK7uPdpVo5DUM
 jqRwIPQ0DgTcUQK4UnLjrQM6nE7gf6USJGL1jVv0dbjjgGr01n+lNFojm5UCNu2eAgkdUeSA6
 nRdMoi0niczZ+nOyIFbAgPoZmpuwlU64fcUyiPjl5eMprYJ/trYKyzgoVKC2q/hAGj7bUCi1U
 jCu1SnxVGoJBDZzzBZ3xXGJCSqu7UHBWIBiATevZcF4Zl/4MG/LkqiwWrTRJo386siFQJ+EkA
 BZToLq+2vKrBvIEpP33bMJU+JPADOHI0MtxqKy+dWa47D40cHAe8lIedDy9BuINWQoNdha7a7
 pfqzAVtV6hnS89tvMuhQA6kOwCd3OzJWJ8Vj1Z6gqzZMlIXDd+xyDjt1h9JcO/me5CWY3KI+g
 Pah4xpPM5kFkzr4CCEEvIDI+zowZ96odvLq53veS8WZpNEyeezS4lTd7M20BJW2Bx+BN4QRJS
 n4C7g/KbMnusHSLqS1DnPM3GrfSstkW6yQYyBpXkwLcNhRtF/ezliz136EXAWe38JeDOK46E3
 ynVxULuiVvHavbl2I/GcIpH5pZJQSumEH/PLI+1Kguu0CtVsvms7bf5Sb+dQKQTfgGvk4ih/7
 Vr12qiHN+jF/Z4Z22iUUBmXfQYntRXfkvpy
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.05.22 um 23:31 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> So we currently leak permission bits of executable files into ZIP
>>> archives, but not tar files. :-|  Normalizing those to 0755 would be
>>> more consistent.
>
> Today, I was scanning the "What's cooking" draft and saw too many
> topics that are marked with "Expecting a reroll".  It turns out that
> this "mode bits" thing will not be a blocker to make us wait for a
> reroll of the topic, so let's handle it separately, before we
> forget, as an independent fix outside the series under discussion.
>
> Thanks.
>
> --- >8 ---
> Subject: [PATCH] archive: do not let on-disk mode leak to zip archives
>
> When the "--add-file" option is used to add the contents from an
> untracked file to the archive, the permission mode bits for these
> files are sent to the archive-backend specific "write_entry()"
> method as-is.  We normalize the mode bits for tracked files way
> before we pass them to the write_entry() method; we should do the
> same here.
>
> This is not strictly needed for "tar" archive-backend, as it has its
> own code to further clean them up, but "zip" archive-backend is not
> so well prepared.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  archive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/archive.c b/archive.c
> index e29d0e00f6..12a08af531 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -342,7 +342,7 @@ int write_archive_entries(struct archiver_args *args=
,
>  		else
>  			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
>  					  path_in_archive.len,
> -					  info->stat.st_mode,
> +					  canon_mode(info->stat.st_mode),
>  					  content.buf, content.len);
>  		if (err)
>  			break;

Looks good to me, thank you!

Ren=C3=A9
