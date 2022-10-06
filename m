Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6058EC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 15:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiJFPdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiJFPd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 11:33:29 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF30A598C
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665070389; bh=YN5jTs5gv9ohiSk2VZZ5e7HkApxJCnvemTbXHhABD/M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Wg7VhwVjSQpBqGT3fobohFUfZEQQu7qGerPkjPiIA72GeJuS++psFiK8LxgH/H5Ed
         sJ7BHAlIhGLcmXQsu4QUtNi/kyUgKoQQ4riPuUN9gGJdAlGHBqLOXwLTFlk5ywp9Mw
         PawZcq06M4ciIUUaxFvafysWfcf3JrcGo1WGuRxCkXRHSDAn+yfZqUixl5vRoSo7L/
         Ob7iA5IweMT+0dBufJrcXYAjXSVjzYXiMI5zykpZjlfaDchofxyuXqqgCGGhPguXkB
         aewWg/rmAqAjmL9Qa82RZa8Ka+YursFZX4+YZ0CwmMTHx9Jij6zLcFJtqv/j/F6yo0
         176DrWxk48Byg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEXi-1oTDJV1NK4-00DdRw; Thu, 06
 Oct 2022 17:33:09 +0200
Message-ID: <a1699375-c660-13ab-42fb-26a8afe4c376@web.de>
Date:   Thu, 6 Oct 2022 17:33:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: [PATCH v2] t/lib-httpd: pass LANG and LC_ALL to Apache
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <3b370f7b-df84-0629-d334-aa9dfbca1c05@web.de>
 <xmqqtu4inj6q.fsf@gitster.g> <Yz31Lv+97z9p/0TK@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Yz31Lv+97z9p/0TK@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oiPexHO00V7xu+hpx2z5/JNILLLFlHb9weNO7ym49B+4ufihbfr
 yih0J0GhVEIs+H73ZjytCejVxH5BFyJ124CR46tZ3bSY9RLPJNcaGSfcdTVV7FGUx9TesQj
 1FahGEU7rLY6JSFGlYG1QGx82boBZb2aQBVQcldNJs5c0u65circr2fe0F6OO/X+wLGWWd/
 dA1QhlK+UiREHyNQx4YgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:efwYEtmI3CM=:alRuipi+0N6R1bEwa23IK+
 zDOYTsC8ZCYORgqHJpPbb1+5x2vlLMi5J35xmiVYYMx7+auEPEntpvT4c7VDHllVdxX+ck4KT
 p/eab1FRXU9dHFBUGEpF9MhW8SMAgUGONYnvZ8aFaO2NarDOCP4K5ezNtjkdoglmL5YBQmdRt
 c6mi8Ti60zkhugnq/R0BohPeGFgcfIRhrM/a5zTZRx5Q8vYx3Xcx9+5h2jcEAC7gRCRUMXGxo
 cTzM3JY60ADTTRmAUR55D0Kk8gtczBeHOHD/FMsBreL2FT4acUpO8q64iGIhUSlhVrr0c7bay
 ujtcXY5XHEKMhg7iClEp3ZYY1ul3QhglCvuH3F9NyOrgC4Fo2u5yS3o5trhOXI0jSqOfSZz0W
 sbCP9lVq5QQegxSuIWrJTiDTZhcEZCWAJDOih0TLauay+/n5jmlAL9lctJq4iAb0RPhVAcVQn
 KNuRr40+fwiw7XGfQwUJ8MLNrb2SR2s/a+hdGIVrdw0iqFXuYuurkwKB5hr7c23gzTDDh0dwB
 1am/VMbI08jL4BV9UwkzuSWu/eJVflKLwY/WvQeFhSrr1c3LBtIBRWWZVCVxIY2Gq37Dclw/L
 Tsk7z9vWJhxNLrpvBMqtl4nWdt8WHN7tVivUEc57mLYjpmaZKMxGwUpgvgZcBx0rREUgdLr6P
 SmmTSR4Nk23ZFI1hnoZtNnYzAmrPHQSdg9YCSLdM4zPzot3bRWr54byD2qeGhLaaj7DOQzyhj
 Gcd2aY2fADKlnPFxJ5qo+QNPDwFz+5yMRBDNHGdxL2cBzksqrh4PMosfCfKgKP3Z9gtnbcQZk
 4KCKreCqh01q1n5gL1wPhBhJ+8wIbLXXUGt5geh5MmhOUZtfj5O3HQ6iNXdxvP1evtNXNoHRb
 6SrXDMAvzOwiObGxTDUAnFVApIIiMW+SwTWNwxCL4sy2c8HyoISMzjOu/4GDvsiqPlmihzyb3
 cwWFyTnGuI0CmRQdJpwdWnTKSaoARc0tDUUfjtBomjvygE0wx9JFT42/Kcdqnj9DA6mIlznVV
 vdS6z7Ub8pJlb9Y/NDkxtDgWEqJCvFdBI2X/W6Vrmwawx50f4xXAc+GQklAs3pvmWyz8OL6Kc
 qtilXlmMRCdSCwHAFTSO4C5wlH2Ktd3/XVslcTft4cbTa6rhThiGNQ3ohWtX7nzF5QS8Am/g4
 wYZeNZBuIAbrCdrNeuwcQYNe1yhHNtWUjgvnAUtvCDQcLL8C3qcOnIDhtivn1eNJA5OfibL7F
 N5OuzN78XxjrTeWYjSAge4uLpv3IA5pxun49174zA5aN4wn4HnKXgbP70z9VfmJDam4CM1OG2
 dGOWpJODyT3+se1Ym7S/I1xxZTZGfHrDhkOwtkSNdwVBGh9EOsF9NGQ7A0ls+IqtaElItuS8G
 /pAVyKWQrlXaH/IEMx1turkz9V4DD6Zd3YkNrz0OPbcXOjsuH0iYUK/r1YcHtTA0JohAJIpXM
 QXk0tjZIPiRwi8hnwLqegc67nVW/5h3yWKf/U71pmHqK/7Bn45GNJhSbKpQHTgFYnm0ddWwHK
 ZXny2M38JBlur/gPx+x8l4ZhMDXVElzg5/f/7bhoctMjc
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t5411 starts a web server with no explicit language setting, so it uses
the system default.  Ten of its tests expect it to return error messages
containing the prefix "fatal: ", emitted by die().  This prefix can be
localized since a1fd2cf8cd (i18n: mark message helpers prefix for
translation, 2022-06-21), however.  As a result these ten tests break
for me on a system with LANG=3D"de_DE.UTF-8" because the web server sends
localized messages with "Schwerwiegend: " instead of "fatal: ".

Fix these tests by passing LANG and LC_ALL to the web server, which are
set to "C" by t/test-lib.sh, to get untranslated messages on both sides.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Thank you, forgot that LC_* exists..

 t/lib-httpd/apache.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 497b9b9d92..706799391b 100644
=2D-- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -80,6 +80,8 @@ PassEnv LSAN_OPTIONS
 PassEnv GIT_TRACE
 PassEnv GIT_CONFIG_NOSYSTEM
 PassEnv GIT_TEST_SIDEBAND_ALL
+PassEnv LANG
+PassEnv LC_ALL

 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
=2D-
2.38.0
