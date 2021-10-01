Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3398C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB5D61A84
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhJAJNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:13:07 -0400
Received: from mout.web.de ([212.227.17.12]:40023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJAJNH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633079480;
        bh=LcOPzV+0bnAqp2HCpIIetJESiKvwf1IAj32T8E2f6Eo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Gyop/eGW6JoL/kU0oxgmf1N+52loq9GTBrcP0hBL7n5yPBFvaQzUgvOcAYKASsiIb
         H56lckFd+ez+VJchkfrapz//F1cEGDtKphAmJzMFm5Zqwz7YJy1IATSeCC7hGoxEft
         gmiSTv3no3ICAW92q4HyX9lSJ7WIig2q/C7BXcYc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lmu2K-1n1zPw2lzg-00h6ts; Fri, 01 Oct 2021 11:11:20 +0200
Subject: [PATCH 2/9] test-mergesort: add sort subcommand
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Message-ID: <f0a8c3c5-4c51-5128-42a3-3dadb8600a6f@web.de>
Date:   Fri, 1 Oct 2021 11:11:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UCS2Njyu/GnEbjoh/Xb+YD0IdjZV/V+9iHZnBI8MJgY8/dAtUum
 5Dji5TrzeOq+MQKnHmnL/73oDFHLUB7Y+LdZ84Ix0dFwrNv0qFOXKXmaFKimbx8zZsBzTxU
 abQJcBpq5XIUrXI+nxUlCvAEP0YiZkWkBhe4LyuZb/g88cCtkcFI+pH/VxBK4R6YEwPmLmw
 8kesLZo2Ydvob3qRC5Aag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SYzfaI6Zm1E=:P/FIBBr60jhIpLibgqEZ/p
 +zmTThWS+zRAvuCLU1Ztn+aahSEZrKbIHrZMHqMQ0BuDTkO8iwsA+Vs72Na/kbJd4U0MHG/nR
 2wK/E/Kd4zdsWPZxF+ZfbUl48jFbxTKPuyt3gwmxS8xu2olhnIGHWnYtbbO0m3B6wgp95P41I
 nPGDVa/PWn6QB3t0bslb8IS9PTpMYraaUrpLnLHnXTtqHQ25vM8Lv1PrAJg65/ShEZuJa7UWe
 zTAm6mvkoHlFWzabiSdBm8BfwZI+Aj5o98dCEXscs8Z72/DlW72pbaPwsBgv7o7ypx3FHnuim
 O/FA3duVfk+/9g5zALW8vEcWQ8u2OHsHB4+nBlLxBYdBnyZshp+5lP/7zN+9qOqPJdsHvzphi
 RxRggvLd/qwtp42Fl0ypA6BiroUMWt/H+Qn4lIATnBeXGmcaEKWl1YcKhDpmCqIPIvUr7Feqb
 eriJoNHRVAocL+y1M5sTe5b5Tt1PwbGUyuBX6gcLnIZb7+E3dscz8le33dbN6K46466rtujK3
 l00tLdF1Ueal6V2c8S9Hid/RgDwXftY90Y+R5ivTFUKsgnXl+Y6cDRU9UX2gOMr2Xs86fM4kQ
 iooqd8SrCaecxI+pqRqSRBWGRNYgNDG26C7HpnGvJVc/jZbfaitplKSzy3Mb9dWMqCmXU2EEa
 WogIPr1HA5jMRUP/zj3YwsOHcgTWHmQKNmFUiSIY+hy+lG2gjt9z4cg2qrWt6dOMVTVX+8G/7
 id5I6R7+zKy4VH1XHNTPDb4jBdsG+ou+jWgp7y1oQ+XEcGnwMCXJtBJB4zw2x99+oPPlDAwbw
 19hKOjTyG4h8olaxXFJpRhtZ2lj0k5GJaEI68r+Uwm6jfQmiRqksQfVbv9mSNUvBxBsXhtOUP
 jGOuZ2zfl/ZKB0Cw87M3rXlW6pIni33+STNdB383jSXc+0HSGBOCxu3s/irGjKYyWVwOhl1lA
 VOWMrerynAbOgj9+/jVvjYRfEVhrAGTWMvNwvAiD5LIE9UuJEQ3WhkXMoEnoTUGgiCWclSKsU
 qq1n4HXf6OckDUXuNBrtRa9vFKv12vCIaskCOJ0zUFKVMkBBdbk+8Y/FnZyymFQV+Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Give the code for sorting a text file its own sub-command.  This allows
extending the helper, which we'll do in the following patches.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 621e2a5197..05be0d067a 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -23,7 +23,7 @@ static int compare_strings(const void *a, const void *b)
 	return strcmp(x->text, y->text);
 }

-int cmd__mergesort(int argc, const char **argv)
+static int sort_stdin(void)
 {
 	struct line *line, *p =3D NULL, *lines =3D NULL;
 	struct strbuf sb =3D STRBUF_INIT;
@@ -49,3 +49,10 @@ int cmd__mergesort(int argc, const char **argv)
 	}
 	return 0;
 }
+
+int cmd__mergesort(int argc, const char **argv)
+{
+	if (argc =3D=3D 2 && !strcmp(argv[1], "sort"))
+		return sort_stdin();
+	usage("test-tool mergesort sort");
+}
=2D-
2.33.0
