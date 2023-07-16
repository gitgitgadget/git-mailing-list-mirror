Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECC1C0015E
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 08:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGPIRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 04:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGPIRl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 04:17:41 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58D118F
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 01:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689495456; x=1690100256; i=l.s.r@web.de;
 bh=T/CAd4a0WPrA5SMb12JFEVN7BZrv+HfDdPGsWkX4FaA=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=sbYiSmqljXsPLjs/b9uC16YCipaoXk7uuvsD2ntyrzHzHwlUO/7T/pvAT1xA9gwf4dIcWVi
 nM1jjp6rbW00qOsG30TWGYoafsIxRaNeviiTtNcnADLVJMLPST3ReRMli51wrbk/3bn34HroI
 gX1ZCOcloVNSsz+ssXYzlmGIRWacB5m6d/y83XmSsO/Zi3aVRUav/0iRJsJYlUsr5NXeMoaPq
 HSQcifeiVHAN9VUR9CeKp4dWYtQ7QvKmQCeJlMcnVjw5A2LtsSc42fmkf3UDqi1CK6ia/snEu
 ZpMSr2fVbc5xoXcYf8OAsc5uZbKtZyXdCTklkpsUGBL6GQkhjZjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.247]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1ptMya0J2q-017O45; Sun, 16
 Jul 2023 10:17:36 +0200
Message-ID: <cbc22750-af93-9274-2ed4-6dfd356568e8@web.de>
Date:   Sun, 16 Jul 2023 10:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t6300: fix setup with GPGSSH but without GPG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7tLtNQc37lE/FS/ghe1nxUBGD3ihaaqIRZQ0pJTW+KDjFvp/SGh
 yqwt0BVAqAMuHXuv69aZ7tbPUazMw+ULUuxa2Wmt2m3GBj/LmjwsXn3nVvQFy9rmPIkw5Tx
 pBfhxaiJw5bvhVkQXYoA+/XYcFdBPMzUyQ1Gf6KwU976i4Astutr6j1OgpsD+a8sdJrTTGu
 kFmvjqohYxqLMWBsb2vkQ==
UI-OutboundReport: notjunk:1;M01:P0:WOAtI//leN8=;dnqOS2nsRW+qIEQ5AG+rEfjj94C
 UrQIwO+5ggYGXcdzV6KAIJGvzAKDWVLwzKrFb8RR+lE6/CXe5V/jD+kB15i/Kyg//SE8IgW25
 qu5BDAae7N6fDktpK11/b6uJLFVXqX6nZ0oH8zWqLtsYzkGcWu7buAoHFEQplw5Mmq8j1vRLM
 WhSLkAGt9bcFVpQnF4g2ooz/E1BE16UrfL33Qcsz8iQG6IUr5eoNV8ojuRBei8ANduiL6ATTr
 2wTOXYDDxYaqGhpXgDQzd8GmQU3PQVxDIdXiUTPGGZuvoFBcAJ0wsNsznR9q4MraA859IurXW
 ev80caSFnFHFEwy8I91RSrn9L1eD44xxQzwQ7YFkQlpxIdvzspu0P9qWvjA2M9KFQZcwxH5e7
 Y6B4w0RgzQB8R1N1Hp/JqhPkRGNnoohxDNQhSgcqnnTf3QG1xdLZ/0tF+/Ph3YfteCZxwhtco
 jwJCDeQio4PxKNTO7qN5SzYYEmuhpQpI6B3+AEMjYRNcRaFtbhCdzf/nedEhonCfJeuK4/Tsd
 aguJPN9MY61INGhwIze4fUCwEbEAAYfhEaGtp+yJI+ru+hWG4qjtci/0KXTGFOrizofMSYRz8
 kBtSFMBRpjNSkBlcw5GfL8K+NMT6GVbQI6hKatt/F0mlh2ManixH5Uojx9WYHi10YwaJC5Y0q
 OI2kf9qhHV8zw3TP1wTJ1sW6QUL+lj5hNGlBNzMEqctw91U1+mHSW3wzau/QqVkOG2J3iTDXs
 hmHuk2ZvK51OmSXhLJbq6wJzhQ+OaqlfG9ss8Y39VEwlFz90Ohk2bjpyibnqt+DHO9AroDP47
 aUX+2VeyxGOu7UZZqnYYy9jeZs/jFAjMq77yrt8R2SgRZ3rgDn5JIC0RpQ6t4THFe+06J+FDF
 drdCAtFClIgt/B4trI64aoaWhT9d0lcbjQqur+wvDFScd0tBEYlWhmQqcLI3eWOoTo9ovq817
 ypzsXqJYdCzjNMWB4bK/7WHGeOo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a test introduced by 26c9c03f0a (ref-filter: add new "signature"
atom, 2023-06-04) the file named "file" is added by a setup step that
requires GPG and modified by a second setup step that requires GPGSSH.
Systems lacking the first prerequisite skip the initial setup step and
then "git commit -a" in the second one doesn't find the modified file.
Add it explicitly.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t6300-for-each-ref.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 6e6ec852b5..1180c3254c 100755
=2D-- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1584,7 +1584,8 @@ test_expect_success GPGSSH 'setup for signature atom=
 using ssh' '
 	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
 	echo "8" >file &&
 	test_tick &&
-	git commit -a -S -m "file: 8" &&
+	git add file &&
+	git commit -S -m "file: 8" &&
 	git tag eighth-signed-ssh
 '

=2D-
2.41.0
