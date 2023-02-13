Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D29AC636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 21:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjBMVMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 16:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBMVMO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 16:12:14 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1971E1D3
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 13:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676322722; bh=MQfrfcDhIlHjQ/7VRuiRXFbFUOVWw1fvdop1YZCeLgU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=l8vLiqMf8yWKdAIo9lXagsCRY22XjuD+pCLhxjLUR2uI6ftQND5nZTb6l+HRKoQal
         WvE+icEPvgxs980kfx13K9tDV9yvgL7Lo7h2/CSgnm0SG9nP/91luhmQueeovbqTOW
         ReQYbx/w+bqWp3bX75DlZo6h5d6H/kkNwEUSw3smPXC9zOJQ0cHWa1rwyl+QNifk2e
         X84OTK8q4aubeGteH4VFURAIm0V+DgIfPfUsKQVMxSw+RWBdirOt5I0guhdlEvzPw/
         /5MTn1WBzskbEVsmZUGaPz4MwDwDvd4rOfvN0sQQKNTnPjYBZZrnsNHPjVCaTjnQ9V
         OLDafX4rNB8XA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0Ix-1oclC52tnn-00yS1W; Mon, 13
 Feb 2023 22:12:02 +0100
Message-ID: <cae75cb9-305b-5ffd-dbb2-8cb83f102541@web.de>
Date:   Mon, 13 Feb 2023 22:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH v2 3/3] test-ctype: test iscntrl, ispunct, isxdigit and
 isprint
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
 <81eee04b-598e-dfe1-f954-3105bcbcb2f2@web.de>
In-Reply-To: <81eee04b-598e-dfe1-f954-3105bcbcb2f2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bPok1YOWxttx0RJcslQuBBWT5dpgaarEnh0RDN8WVwoKANFEP9w
 aXfXIYEh2InU2bSRilZVs9sp4fl45khuBfbzoeNVu9cNeVMd838HKUoyjp1lIMobyb+09fM
 uy5LibzNTt6k1w1arnjAbSngmn8w+EeaEh4qGZL4Sn2xEiCI2Ma6PbD6+2V3HOjEvyjg38x
 TZW9wvpNfAq26eJ/MX0zw==
UI-OutboundReport: notjunk:1;M01:P0:yZVNl7XSRtA=;L5GSWMOM649g7JSiTtbnPOFj66c
 v6NNth+XDYralWYinSgF6MepBEo3gRqRClJKFkRVJR2gKoWplr1Vxk9Tz+bTcMPPZirboFiZl
 JfmzTJa+rTfQPMMf84vzd3oiJ5gBqIl8QMchgEoSAuV90+0O+z3uX1jUa8VL8xiAHxLXDTBmc
 mOj2fubrzXYcXAvozz6awtVwnF1iooYjADz97UdqnXWixcxYINkdXBWAndxY5RlXC5DyAG1rU
 qFbVVzpMzu69hSXzmiBFcL6DAIHyMyOVDXcBkde9+8alpM+GP+4euKOkZvj/E0pz5CWTuyLQJ
 KME94J0goGohLrCoq8rBcRwzZn62ZO5ToRy2e2rxhuAIJptiw6ngw0HBUnav+VvivbSGWM263
 rMk9CinP84UsukirunL688O8WZiYUYjNu7FYaZtxFdpcMQJP5OpuFEU3p09X3JC+7P9Eee233
 F+r18hpmTHbmuMwJfggZpPqPZcneUywgHPyJg9IUDnmXcGpJLBgaVY6SofUmnA3yxwsa0Xueo
 7wmu2E3LtNDlRom4WgvHmMABLfRplUnTqPo1X8OEuodJ9qxyKzSGmibNT8N4NUnHoBYQltEnF
 aPDQoyngpgZYbt+dvCzrTlLpOIj7p68w06hZhO76kwhD73lJNi+ISBL7lKDJb2pBdxDsHKBbL
 7rqxjtcfj+BsNf/9VOQhhMOj0aHyigl1yL+qJF7sWrfZ7dN6ZVr55dC/cokc/TRKbuWe7iK32
 zDoo6aaBLNDDgcX0meR3r3d1/tf8SBTgBHnrnNM5PcieeK1zmYbKjlq1M0tv51IdRUSrvVaD9
 /4XuWaPnCxmxRxtgP4lnZKbK+2Do8OhwBnztwvlN49xtdIUkG50HBfrBKv2KfC5Hfp3dBblyJ
 R9Wa0Uc6LZweUc0oEzNEDkhPNKtWI9MEkmUmmN0GwFdalIzt1lRVE3gYUNsrCSVBJ8aqULiyH
 46/Dmm+WEjPvQXcHubz+IF+iSUk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the character classifiers added by 1c149ab2dd (ctype: support
iscntrl, ispunct, isxdigit and isprint, 2012-10-15) and 0fcec2ce54
(format-patch: make rfc2047 encoding more strict, 2012-10-18).

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-ctype.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index 8ac76e93e4..b21bd672d9 100644
=2D-- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -33,6 +33,7 @@ static int is_in(const char *s, int ch)
 #define DIGIT "0123456789"
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define PUNCT "!\"#$%&'()*+,-./:;<=3D>?@[\\]^_`{|}~"
 #define ASCII \
 	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
@@ -42,6 +43,10 @@ static int is_in(const char *s, int ch)
 	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
 	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
 	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+#define CNTRL \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x7f"

 int cmd__ctype(int argc, const char **argv)
 {
@@ -55,6 +60,10 @@ int cmd__ctype(int argc, const char **argv)
 	TEST_CLASS(isascii, ASCII);
 	TEST_CLASS(islower, LOWER);
 	TEST_CLASS(isupper, UPPER);
+	TEST_CLASS(iscntrl, CNTRL);
+	TEST_CLASS(ispunct, PUNCT);
+	TEST_CLASS(isxdigit, DIGIT "abcdefABCDEF");
+	TEST_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");

 	return rc;
 }
=2D-
2.39.1
