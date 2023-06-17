Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4E2EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 20:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjFQUhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 16:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346478AbjFQUhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 16:37:40 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2CE1732
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687034251; x=1687639051; i=l.s.r@web.de;
 bh=ZtxBEtinCysIzlmTRZjwhS/U01Vob/BHv60ySFuOB5E=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=ZelvFI/gv2rXiXuCw3x12MkciPMj5a6NW3yOTlJowTXo3XJR1YpFl7TAd9ERxYMM81rY58j
 lUB0/1X2cnb2D7PVKWDrHQv9nnm8fLec7ZZB4o8e7C3Exs75v5m3k/GHYJwChMpsf1c+2LuCJ
 XQ45u3K6iCRPXMVu3Gv3yXO09XZ2eW67UuT6FUpe2Dk96CoHi+tZO/3CiPKhyPc2rPieky2bI
 U76UaU5B8bY4jUj779j2qgaMaBTkcLFMyEFkTLTK0Vq2Y+2ydBRTICNicw5OC8/tHmYJJ3yxd
 TxbBafQXYpEleuy4DHx+fUcaS+owXw0G2s3cBIl3sKB6yznRAypA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.195]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1qN19b47c5-00EMgq for
 <git@vger.kernel.org>; Sat, 17 Jun 2023 22:37:31 +0200
Message-ID: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
Date:   Sat, 17 Jun 2023 22:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/5] replace strbuf_expand()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TOaoGi4Vnf/KHxmvY+M8sYFaWFMcGGB64cCaLhdoa0Re1ektIfW
 KVXI9ShcB2oG0VfWTWSUSNoviy5xZnO3YuGDPlg8tJ4GVdoO3Xdo0DUzdffQHE2SE1QVOVG
 /mExCvzSQEXtNKK/Kk3pgBZhij6Hot56YJt3dtJxntClnFrQBiNcEXkjleNKiQyRzldynDV
 NIv5gATZcQauyWWerLd2A==
UI-OutboundReport: notjunk:1;M01:P0:tKXfB0RzmBI=;wFH9Fb1Qhc2c4VOJM9ujcUQe3iO
 8PYHWfD4j6KQM8DEzEwdEmGCZniIW7i0wqen4e4ngJFmIhv93OoSdR4YngcDfrDasWCMEvOSA
 GWo15uf6Pz2dEZ6MKPwJaS5HkIv7oJijsYo8H61QcA51GHGsfjkAUgP7r1lAasM52BymJvYZ1
 aG8CYfCazbhsWn3Al+ywKJLxJjYiuDhR/OkahcfEcmn3IkX4YH929vtOjdcaDilvo2JcjNfDz
 fxOXaVHu6j58PUSkFtDVfpmgXVyIuOfPxRuqc0lCI/BAeD3zI8gmNo8gMPAJgve8ztPoT4FAG
 lcyniFBwQSbc6iOLJb+mXza/RG78cM00aXwpWkhcFjXTfva37jveQ+/cXbKEtP0iTbqlBsK1t
 YNtyrqS7a1l+dWxcSs5V1zbfF9BD/3khYz8C/JLMYsKMV0zDUBqFE+dVw09ft2etE0Q+sNV1O
 nPVxDRPgc83v8HyL6ztg8dK/Apn8EUlkIm4DqWgzvuvq2XrsF8IfUxs/Tmen8Mf23kv+Yoo7K
 129V3GH98rMyGfnWuBaYABDJxiw33aidLxuwjYNIPB9ksnvmwBxuw0qmmssE0LWtgZ/3Ouc3r
 CVlddlyWhlOO0a7j1KG3M/9jyHbydHlxqsgO1SOvcDyrfYFoEtiExuO8t6O+DLl03MaywXCKM
 22NkhEhivedLBarlQqcGfMron6m5kuK2d7bqUINUzHconaHC1h90i5nUICRxdHoQJtTN4D+Gv
 bJr/99XyQDqSv8MD7/tFrBHJ1v1i6/Yb7Yg8tgXN7QPnBNVHsEKaW4nOm1ZbBK0jg0Sspaixf
 zE/RNJU9KMOgwjvBiyn8RIWG0x5J/bb4ThClBbC6LopxmFT2ZMzxM6QBwc8wOSPePKNUp3+K5
 tQhy5QQwOtUahoKKzAxSz7pzQY4bXPycnc9odO1wICuN8JK5LWkF/eqe7pN99hFQ8phYFLJKM
 ZFuBTg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_expand() is used to interpolate placeholders that start with a
percent sign (%) in strings.  It invokes a callback function to handle
those placeholders, expands "%%" to "%" itself and copies unrecognized
placeholders verbatim.  Context info for the callback needs to be
passed in via a void pointer, e.g. to a custom struct.

There is a better, simpler way: Use a loop to iterate over placeholders
and access variables directly, without the need to take a detour through
a context struct.  This series converts the callers of strbuf_expand()
to use the new helper strbuf_expand_step(), removing the overhead that
comes with using a callback.

  pretty: factor out expand_separator()
  strbuf: factor out strbuf_expand_step()
  replace strbuf_expand_dict_cb() with strbuf_expand_step()
  replace strbuf_expand() with strbuf_expand_step()
  strbuf: simplify strbuf_expand_literal_cb()

 builtin/branch.c   |  13 +-----
 builtin/cat-file.c |  35 +++++++--------
 builtin/ls-files.c | 109 +++++++++++++++++++--------------------------
 builtin/ls-tree.c  | 107 +++++++++++++++++---------------------------
 convert.c          |  22 +++++----
 daemon.c           |  61 ++++++++-----------------
 ll-merge.c         |  32 +++++++------
 pretty.c           |  99 ++++++++++++++++++++++------------------
 strbuf.c           |  58 +++++-------------------
 strbuf.h           |  57 ++++--------------------
 10 files changed, 228 insertions(+), 365 deletions(-)

=2D-
2.41.0
