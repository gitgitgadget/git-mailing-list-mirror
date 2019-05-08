Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E214B1F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfEHLFq (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:05:46 -0400
Received: from goliath.siemens.de ([192.35.17.28]:58497 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfEHLFq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:05:46 -0400
X-Greylist: delayed 1231 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2019 07:05:44 EDT
Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x48AjCsP029875
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Wed, 8 May 2019 12:45:12 +0200
Received: from [147.54.65.49] (MD11GXTC.ad001.siemens.net [147.54.65.49])
        by mail2.siemens.de (8.15.2/8.15.2) with ESMTP id x48AjCsH006616
        for <git@vger.kernel.org>; Wed, 8 May 2019 12:45:12 +0200
To:     git@vger.kernel.org
From:   "Osipov, Michael" <michael.osipov@siemens.com>
Subject: [PATCH] Improving HP-UX support
Message-ID: <603989bd-f86d-c61d-c6f5-fb6748a65ba9@siemens.com>
Date:   Wed, 8 May 2019 12:45:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------3B16D09EFA379C872B72F04E"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------3B16D09EFA379C872B72F04E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

please find a patch attached to properly compile and link Git 2.21.0 on 
HP-UX IA64.

The patch includes basically two changes:

* Detection of big endian on HP-UX otherwise SHA1 calc is broken
* Detection of linking style with HP aCC

> export PREFIX=/opt/ports
> export LIBDIR=$PREFIX/lib/hpux32
> export CC=/opt/aCC/bin/aCC
> export CXX=/opt/aCC/bin/aCC
> export CONFIGURE="./configure --prefix=$PREFIX --libdir=$LIBDIR"
> export CPPFLAGS="-I$PREFIX/include"
> export LDFLAGS="-L$LIBDIR"
> autoreconf -fi
> $CONFIGURE --with-editor=vim --with-zlib=$PREFIX --with-perl=/usr/bin/perl --with-iconv=$PREFIX \
>   --with-libpcre=$PREFIX --with-gitconfig=$PREFIX/etc/gitconfig --with-gitattributes=$PREFIX/etc/gitattributes \
>   --without-tcltk --disable-pthreads --with-lib=lib/hpux32
> gmake INSTALL=$INSTALL_SH install

Note: I am not subscribed to this list.

Regards,

Michael

--------------3B16D09EFA379C872B72F04E
Content-Type: text/plain; charset=UTF-8;
 name="git.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="git.patch"

ZGlmZiAtdXIgY29uZmlndXJlLmFjIGNvbmZpZ3VyZS5hYwotLS0gY29uZmlndXJlLmFjCTIw
MTktMDItMjQgMTY6NTU6MTkgKzAwMDAKKysrIGNvbmZpZ3VyZS5hYwkyMDE5LTA1LTA4IDEx
OjMxOjQyICswMDAwCkBAIC00NzUsOCArNDc1LDE4IEBACiAgICAgICBpZiB0ZXN0ICIkZ2l0
X2N2X2xkX3JwYXRoIiA9ICJ5ZXMiOyB0aGVuCiAgICAgICAgICBDQ19MRF9EWU5QQVRIPS1y
cGF0aAogICAgICAgZWxzZQotICAgICAgICAgQ0NfTERfRFlOUEFUSD0KLSAgICAgICAgIEFD
X01TR19XQVJOKFtsaW5rZXIgZG9lcyBub3Qgc3VwcG9ydCBydW50aW1lIHBhdGggdG8gZHlu
YW1pYyBsaWJyYXJpZXNdKQorICAgICAgICAgQUNfQ0FDSEVfQ0hFQ0soW2lmIGxpbmtlciBz
dXBwb3J0cyAtV2wsK2IsXSwgZ2l0X2N2X2xkX3dsX2IsIFsKKyAgICAgICAgICAgIFNBVkVf
TERGTEFHUz0iJHtMREZMQUdTfSIKKyAgICAgICAgICAgIExERkxBR1M9IiR7U0FWRV9MREZM
QUdTfSAtV2wsK2IsLyIKKyAgICAgICAgICAgIEFDX0xJTktfSUZFTFNFKFtBQ19MQU5HX1BS
T0dSQU0oW10sIFtdKV0sIFtnaXRfY3ZfbGRfd2xfYj15ZXNdLCBbZ2l0X2N2X2xkX3dsX2I9
bm9dKQorICAgICAgICAgICAgTERGTEFHUz0iJHtTQVZFX0xERkxBR1N9IgorICAgICAgICAg
XSkKKyAgICAgICAgIGlmIHRlc3QgIiRnaXRfY3ZfbGRfd2xfYiIgPSAieWVzIjsgdGhlbgor
ICAgICAgICAgICAgQ0NfTERfRFlOUEFUSD0tV2wsK2IsCisgICAgICAgICAgZWxzZQorICAg
ICAgICAgICAgIENDX0xEX0RZTlBBVEg9CisgICAgICAgICAgICAgQUNfTVNHX1dBUk4oW2xp
bmtlciBkb2VzIG5vdCBzdXBwb3J0IHJ1bnRpbWUgcGF0aCB0byBkeW5hbWljIGxpYnJhcmll
c10pCisgICAgICAgICAgZmkKICAgICAgIGZpCiAgICBmaQogZmkKZGlmZiAtdXIgc2hhMWRj
L3NoYTEuYyBzaGExZGMvc2hhMS5jCi0tLSBzaGExZGMvc2hhMS5jCTIwMTktMDItMjQgMTY6
NTU6MTkgKzAwMDAKKysrIHNoYTFkYy9zaGExLmMJMjAxOS0wNS0wNCAwMToyNjoyMiArMDAw
MApAQCAtOTMsNyArOTMsNyBAQAogI2RlZmluZSBTSEExRENfQklHRU5ESUFOCiAKIC8qIE5v
dCB1bmRlciBHQ0MtYWxpa2Ugb3IgZ2xpYmMgb3IgKkJTRCBvciBuZXdsaWIgb3IgPHByb2Nl
c3NvciB3aGl0ZWxpc3Q+ICovCi0jZWxpZiAoZGVmaW5lZChfQUlYKSkKKyNlbGlmIChkZWZp
bmVkKF9BSVgpIHx8IGRlZmluZWQoX19ocHV4KSkKIAogLyoKICAqIERlZmluZXMgQmlnIEVu
ZGlhbiBvbiBhIHdoaXRlbGlzdCBvZiBPU3MgdGhhdCBhcmUga25vd24gdG8gYmUgQmlnCg==
--------------3B16D09EFA379C872B72F04E--
