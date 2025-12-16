Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E313242D8
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911222; cv=none; b=OpmdxTjwxVltXi/yHbC+J/fHrd2aqxLWUx7tIUIORG12uFXVlrKBk8WDEaObYHq36VhXj8QZtugn9V13JQOe9K2KnFohoNv2T7Xtb7JQR0g9jbXdagN3OSVkUrVOio9x1YS5s1GCTXOXnRXM9nFn/AGZCYALlWsQT7mT6Q03Ya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911222; c=relaxed/simple;
	bh=70PrgL6Lzt47jY20o1NTc67+S9PZIeyB8aXXRKiiYI8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=Dh/s6hltybB+EEmrGBLXx3+n0FA5hamV/mw2Y6TaYtSqNms9SYporYLFJC3I2pfbEbEFR67AeIa4uIcMsrDdCabO58L1KRSoFxEzC4rok9Wlwj7bnKRvhe73XMtTnfaSXfbdLlnVSeXcRFco5uh6vhm6M9d/dhdCmDxaxlh6wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=UAYpq4Hs; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="UAYpq4Hs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765911218; x=1766516018; i=l.s.r@web.de;
	bh=J3cAv7H2QhgI7/AQ6DiBb31/D5o7oyjoaimfI415OsA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UAYpq4HsE/CJbO159VjNIGtUqsgDM5ZNjKAh59mphyNdqFNqTPHsbyihZyzOrzqw
	 KSw0sDYVoYTQVe+cpDpife4wi5FwAK/2Frg9woniDx+DSzQ9ELMlkhmPUpyW9TNr9
	 4Gy3BFnYr/EXkkSKPYXNi07rEphzVoaruwsBYoN7aDpRLUMfAyf0SgfnY98VlUthW
	 +DJ8qhJq4ZYM0U6p8ods4EWzqVGdbAzEcH0nfifOx1y0At1Pw0D9b/Yg72urQi1AZ
	 n95fs0sCHALvs8ALi0AEd5eeM2sIOZBkIs+e5zOL6CUGm7fzI7tw3N2LokXg2GI4R
	 /ITJm4MDlraOY4s3cA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCE0-1w6pjt3t3A-00cprQ; Tue, 16
 Dec 2025 19:53:37 +0100
Message-ID: <98695ef0-b6bc-4929-8581-2ecb894cd604@web.de>
Date: Tue, 16 Dec 2025 19:53:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/2] macOS: make Homebrew use configurable
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Language: en-US
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Git List <git@vger.kernel.org>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>,
 Yee Cheng Chin <ychin.macvim@gmail.com>
In-Reply-To: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IipnaOr9B4he31tN6TGwtC6ul71my50wPKt7ULqUt7AZ+pPFSn6
 RfzLTsbA/MQZis51VotzISmMCN/CgX1x453/W/T4DkVkbMULQHdHMYt6O3OqRxUEl6SWqLc
 tAISgsfKocYuZihJm5p0A46La2P5bdl2e29ejq73CgN8vo2jyYSMAC4En6pPCCxbxWkmqc0
 JvWmODu85ti/yaD2mip9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RgQKVK25elI=;1pr0183TqBfNc7Lju1nT4+wPBqh
 DpcHuxBoycjZWAmQAEALwLAbBRSp5pUsKVlnL1bcAVXxh8Ld6J5jd7CrVTwWEc1ndrwqhT1tq
 8hnphnnKschDhMdrdX/HvyoosYRiJvpFFRz/0ZHdp3ZlZC2qDBKGvOjsU0LFDp+n1Ck5Cvxpr
 18t/i8qLnV0XHv1YfyxqlxZr+pm3hAnIqiMBXFp88IjHbGB5IZCwpzETngz4VqJR/7JSKojjg
 AukX0wvQCD0ERG7m80fUIhUMMbb6mDQYHFHAG41KTMib4RGMv+F3krQM4q/kqZYFCfceYIQXz
 BuvzrUHdcx+boxMouG+yIZKLXz5q8WbUE+j6IMtVzeZwultIs5Rr3G/e+sP7Mo1sT6DS7YrEs
 YFTN7pnHTx61lJN8w44a5S+oGOP5jB7thOFlTiOhsVXmR7Dcv1IYPtIe0ozGg0rBujwtNSnW1
 5QIc26+Fs5U8LpuIpCXV7YsIJty8rhRE5k6gi1rl5DX4Txcn3tDYzfJYhDBPzfab6VHcC3Ibw
 zR5LJZyBvcQej2QPxs2ap7Gqk1X2ZHWNbXw3jba4jj4SZ0PEpuD5acSTrf6KxbwN9M5u/AfXB
 51SLbwAlZ4Ruhn8naUSu7vOSP49Bw0O3e+Xu6D4mW3hBDJv948STdz5oW2LZbS65aLx3E85E8
 Pu2JZHDm9ZmkqSQfW1tKqn9D4XhiiNW3NHgZQWOydb+dXe2Jn7KY/2pN1vVBp/pHxgCdAvX7f
 uHe4js1GRoEqXs36qnojmU4yRFZe6PaW6SvI7dllDnnPaJ7uLLT+f6g6+frHpQhJl3k8eet1A
 t5n4Gu+D6rpc7Ik4BLSIQBq9rTXSXVa0BBEkdbihpmFlf50TcjYip4W1rpgK8Mid2x+Wg2iTL
 W8pxygFWgTFPN4iLzmmmX0FL4xnsODlnqEGRSTrYuZ0BusSgGhnXyB+w1gyol/DhNG+y1kfzY
 rIiBKz7NaRDCYjbG6KlpADxvDhHIF8ZDkcmPZdV/z+zUoFQ7b47nleJcSY9LF6TZIBpy5MWFA
 rpDkTheeEbX5Sr0PNKSuHh+Sf/zJ9i/SElMl89vs0t/82sWVcVj4xJydbOWBywjBj8Ez1qKrC
 eNNVxtCAxxjiarJF1mwl8JiPDusbiARSIftYlEKBneL1BX0+xQlnrEtAUpW5urU5al+jic4PV
 rJ3bhZubW7pA3yoxkT/qVO2ARVazex4bSfcQlgCUElsxrPCRMDh9K6B/epiGSDRyRXo+mr9Fo
 FSaMMqNd/Y8Mv9xN5APGQ+f6RMF45zrCD21pPHzufQCssT3qXNX22gdNNBpbBkKqhGFZCRHT1
 9WAtPFc3rGRl/wyiICxa+F3ta6FIx470MqgAr9AjPGh6OO/K/IBbiJyaGV5cnBc9TlMjl+9A6
 02kiD0LTnL+hRK+yG1aKo8t2YDllBreJGPoyfaNcQEEyrD8Qhoj18b2PSysroNdq6jfMgsy7W
 Y39OknUBPk25wRPa3dqe4u/eEZi9AU95jwOD2IVsZj7Mf1iqclyZVwni+ParK5elJfQLV93ak
 6MbWD6y0VUrP8BHly4qDuGNUudZECzKOsHWMtzUtdUIsgaN/s4Bife+g4reQrZFeGv/c2QLbj
 6imspl79sOK0fyrsf4e3GaCk59pVbqqDdBOiMmHNEjVjjYi62q7s2N9N5vSZdbj5Iyo2RQS5u
 gSNdta+7xlOTv2AJBWSyeJh1fRm3kJYJOzp/M1JvIqluA1Ypycb8PXJ0321JXm/b+zX3+0jge
 aODTLO6S32BFfrde6iZ5Fcz6UbhfETDM5pQX4U9G9pgVsTgyiywFsVeOHZnBg/5RZ0aPIBcoh
 68Xi3Wm3UYt7SBDQEnBrG0C1PPFBOK28EWXL03lfmKMzmRjWzSoOK4vvm02PhHM6ZtWuxR+qS
 4Qzvh0qIoX1a1dpgx6jmStwUzy/W6H4SUJRa/uy2L/Z1PV/icGrywjpZjh1gWtMg4tz5u1Spd
 ab5/9QJDEbp+dGu8NcaoBtTiML9mgSW/MNbpKliXUc4e6Q/gVGqT0bVFnBRyovjgC6/lKxivX
 yuZgDXK7TFXEbPbDe6i3ztRUS2vzgNKtUBK9QYNlLRuKtBregiVVDQtoMnUcmszYSOP43qplO
 EoNyCNBqaODHXyWkbrheBsjN6oSpnHU+Ai6pWOBLAssHrDU2iNHIVBM86covDkJf016/oBQ11
 y4eDwa4hnG+mwz0CtQrQfq2hDCod28nzlHqICef96BK1n7N3cDg5YfMHJ0mobRWuLSZJAqZyv
 TYoYsZ3mjFmoq0wJ/PKd2bU31WFVKjcOst5N1vKcKVMNKZAafQFfHr30nEm/AavacDWPqsZ74
 fK6O1hSeKHVioC93fHfb4HXUs4tFTSX91mCEZm8qSD2RhiYwhxB5yH+FSHAA8Xotzxg7VEIb/
 t+H53MHQLxbBx7q07yRrEhkOEwnSOFxUImb1w3t9X/D7m5XwWQCFmIvxYqCaxy7xmYAJdsawI
 +C/i1JbVIMFNLHLJlEZBclGF5wkLKU/2d+uxkiyqQLpyUdqbgcqUJXRX4jgYmPVPzdf7PjCPi
 jjTrpcKhpm8bW9Mot/koorTsp4SHYuWuTKlPzCeoiP/cua+ZaHtucuMv4kKO7ZYWyOAFK95pw
 hVxdsiLVyYtNlF23LstpAe73qpjWkLdfrkqWmfiBCaf/M93HZByEj42qT9pzrkzDWNcT3jSDS
 /l4sWHrdbyOLCWRuJZzmgRqUcq5T2vFdphPp/vmDsn+JMrvSlOUkF1EK+Vl2YsoZzHFDGd5VM
 HNXA+cm1YbznMNBU+/xVOnH+sWstL5H5TLbUEMZ0zv9ErSY4eCVgYxwIM9u8IkSJWT2bzK19V
 XVWYC9YoTv1MQeEtH/BxX0CF9jyRyWcws/vOj0CFXmyDZsgd9RWpn7WNbOJFUDhQgCj9+ESrz
 ehYVRL59qGEu7xQDJhEbuO0MED71N2Eh1dU5y/McLHr6DvavjWAyAdRT2ZMuzmLU1rWKfoyqd
 DjDDVS5wojuRVe/koZyfKuXiydLZcli5UKvBVFUhTgKQe+u8s/0Jmog5hU5HmfQP6yGJOtNwB
 1OrVL2xNaGZfaFN3Jbmt4N3fijnfi+D77uBWHIEh4ljhRCF5gArOf9yXE1ecrdmwDOrfoleO/
 Io6AEKi3kT75fig7Z/rKm0tg9IudGbLH0V5+B3RZMM/z9fxmn+mExIDCR60GxDK2FYx9H0nn/
 LaGEiHhE+XEsJm1xwcVNoVI46XSFwH6Iday1RHcnJNSbmAxKV+gTlaCjvnWSOpIApZlYJ4Ue0
 N6o+28zjHobT5OU85QN9R2DaOs8LJeZUWQetMDMT2nyu9ecBJdYdJaGr+uT57O1GsoK4kDdMh
 nLC6t/7Gz8KXWl5BMlYVZkXlW4t+fmxAbL/NExNyHqwgPg6tbSRSbzZc2PYW98Vl9il+PTq9C
 u54bxFL6mmfROJo4jEaN2XizH30mqG7Uk/gO5bw5N5zXHM7U4SFgnjnBpw6aLULFGiSJ4O+fD
 SNJBFNYalWtQqVaS0h5N16cbhjdGxt9sJTFvWB/fyYyWGw2n1I4OABw13POv01fY15Uueqnh/
 IR2j0qUbe7wngzNXzM6Ox1ED+5sQtd+LNA9EAMA7uN0/4+l1LS6tCjRYkHrqspAV68A/F7GiH
 J08yGRHAiWjmBaAgVYwRTDf5zXx2U5k/pSoJSbFsNi+19WSseyXARCjHxn74tUZzeBlphf+5e
 EcytzI7929QDDLHYIZX3T7PT3G1KaVHpDa+UPGuuoZ8xvNdoJSgY9YxxXMFwMqinVDlmJZPKP
 /P3cBfsmbPhl2zyoXssZOjLCaF4xcJZ01KAS2pUIqJ4tfFIHy3gLUsNsxNy+0lJvT9pfCcQzX
 LPO7qV4PJRWNlpDIswW836/iu58WTvGnhNTAP1iRIp5LO4oCQ0ldO5+1X/PTdDPznwtR0H+z0
 EEfdjoHVLwAiVqIXWRMnr5K3Sj4jtvBwol+3rUxYjTTaOU+Kl6gdHEaUx7/zVZuwopRN8A0fG
 0qjvmcXMoTgIflj8pBdbXvkV9JqRKLwoaaR0xDyJUagfUpZZu4gQhubQVVGqogl/c5+VGHdfZ
 DPA+HrfzkX5DmuNuETcgB6eovlf8viRuW5NQyyg9fXwrugxpTrXGD+O0ODQRJMaRWbJEV8rlv
 DfV0S/7EQlXNMwkSvyVAu4+ICucCFXcZR7yrTvLLlmzYkAWG1AgV4bFVDkHnFs1NF50sXovMX
 j47lUYtbSsZMLjj0tZTzbyIPCjspjuRBAT8ZDYEx/xEgH8vdE7msZknXnvd2KUj1Go7TbsOvQ
 tzrnhvc7Jo8uxNH50ZooOSuXU1GXqZAG7JtO9P9j+zNqNo6unOCVbXEbOdXEPJHFxqx0ICARF
 ngumx+LpxAjQIQwWv4XZ1dCejlRH75/Up0jtUytKKSRFRB4tfjPYQoSN/gUgjXRFUhBDYuXp4
 asvyxBspMw1GOJYTG0YFLxVjGK54xB1hKoCjOn2rHnzXxrb/pm9kEQW4ecp+y67zr82NTUmKa
 ibJ0QKPIdTm7KOHCcc4oXFRULSDoCZePMQuNez49nWi3ZECan5bC+kPo0vnJM4qmJCGd5O/la
 G0a/zg7m9I4oDFzsi0YqQvJ41TnLfp2K/WNf343C4LqKowE83RzKi1b7SNDzt5NVTxW9DxCnk
 ghKOEXPY4TSJ7awef0NG8sHMQDav0UNf9Dk6epr1/ukl4KkomROW1QhIyUbCpKGUc2lxvTTR+
 Qq+0cDHCmY+rf1KIeD7AV5/OeUKDpaYqay8DCSGVs7WPMzsXF8td929xNrHAL6iz/zYct86OD
 EseqrziXzr6WUJP0DdVhJteZdnjOpgJjbTN67U0UkY7ux+4Yp8NfYzf42w+dyM+VOkGygVzPQ
 0fEJjEjQsOZ8qHLwQ/EXj+5t28AsmS4TP+p1MhePkSLOkSfauWllvhnYbqXYcxLB7gxLOnncl
 Id+4ycl7RHEwdNf9SYxzAr3e3idGXU0ZuxNsH7rlva8f49x94pMplQMN80GyiJ80P2TO8rXTL
 CfmzDdTT49+h4PzkC0kZj3qB9At0i48N+3TX7RRHhxKcXZF3LRWcfMyZ9NT+/EljSp/EeLhsP
 ij6Xj/rfZq0fsAzIQy862q4B3TvIseGv2wohpfO+Ylk/5CDAkvZ48auAJJq2PNuTcBYuE3kKo
 PY9CKKKusCTaqKhtFs1apbkZvgPoFJ0yH7JxJsgStB1re1fBRryQKIEKAzJ9VVAD8gu7aSvO2
 Edx/B5qgQydWPCMUVolRuXccV62ti

On macOS we opportunistically use Homebrew-installed versions of
gettext(3) and msgfmt(1).  Make that behavior configurable by providing
make variables to disable Homebrew usage (NO_HOMEBREW), to allow using a
non-default installation location (HOMEBREW_PREFIX), and to control the
use of the individual items (USE_HOMEBREW_GETTEXT, USE_HOMEBREW_MSGFMT).

Precisely Link the gettext keg (the opt/gettext subdirectory) instead of
risking to link random other Homebrew-installed libraries as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile         | 28 ++++++++++++++++++++++++++++
 config.mak.uname | 28 ++++++----------------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index cf3f4b585f..a97e9e4d7d 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -100,6 +100,18 @@ include shared.mak
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
+# Define NO_HOMEBREW if you don't want to use libraries and commands
+# installed by Homebrew.
+#
+# Define HOMEBREW_PREFIX if you have Homebrew installed in a non-default
+# location on macOS or on Linux and want to use it.
+#
+# Define USE_HOMEBREW_GETTEXT to link against the gettext library
+# installed by Homebrew, if present.
+#
+# Define USE_HOMEBREW_MSGFMT to use the msgfmt command installed by
+# Homebrew to compile message catalogs during build, if present.
+#
 # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
 # and do not want to use Apple's CommonCrypto library.  This allows you
 # to provide your own OpenSSL library, for example from MacPorts.
@@ -1692,6 +1704,22 @@ ifeq ($(uname_S),Darwin)
 	PTHREAD_LIBS =3D
 endif
=20
+ifndef NO_HOMEBREW
+ifdef HOMEBREW_PREFIX
+ifdef USE_HOMEBREW_GETTEXT
+ifeq ($(shell test -d $(HOMEBREW_PREFIX)/opt/gettext && echo y),y)
+	BASIC_CFLAGS +=3D -I$(HOMEBREW_PREFIX)/opt/gettext/include
+	BASIC_LDFLAGS +=3D -L$(HOMEBREW_PREFIX)/opt/gettext/lib
+endif
+endif
+ifdef USE_HOMEBREW_MSGFMT
+ifeq ($(shell test -x $(HOMEBREW_PREFIX)/opt/gettext/msgfmt && echo y),y)
+	MSGFMT =3D $(HOMEBREW_PREFIX)/opt/gettext/msgfmt
+endif
+endif
+endif
+endif
+
 ifdef NO_LIBGEN_H
 	COMPAT_CFLAGS +=3D -DNO_LIBGEN_H
 	COMPAT_OBJS +=3D compat/basename.o
diff --git a/config.mak.uname b/config.mak.uname
index 1691c6ae6e..54e3a26649 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -149,29 +149,13 @@ ifeq ($(uname_S),Darwin)
 	CSPRNG_METHOD =3D arc4random
 	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS =3D YesPlease
=20
-	# Workaround for `gettext` being keg-only and not even being linked via
-	# `brew link --force gettext`, should be obsolete as of
-	# https://github.com/Homebrew/homebrew-core/pull/53489
-        ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
-		BASIC_CFLAGS +=3D -I/usr/local/include -I/usr/local/opt/gettext/include
-		BASIC_LDFLAGS +=3D -L/usr/local/lib -L/usr/local/opt/gettext/lib
-                ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt &=
& echo y),y)
-			MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
-                endif
-	# On newer ARM-based machines the default installation path has changed =
to
-	# /opt/homebrew. Include it in our search paths so that the user does no=
t
-	# have to configure this manually.
-	#
-	# Note that we do not employ the same workaround as above where we manua=
lly
-	# add gettext. The issue was fixed more than three years ago by now, and=
 at
-	# that point there haven't been any ARM-based Macs yet.
-        else ifeq ($(shell test -d /opt/homebrew/ && echo y),y)
-		BASIC_CFLAGS +=3D -I/opt/homebrew/include
-		BASIC_LDFLAGS +=3D -L/opt/homebrew/lib
-                ifeq ($(shell test -x /opt/homebrew/bin/msgfmt && echo y)=
,y)
-			MSGFMT =3D /opt/homebrew/bin/msgfmt
-                endif
+        ifeq ($(uname_M),arm64)
+		HOMEBREW_PREFIX =3D /opt/homebrew
+        else
+		HOMEBREW_PREFIX =3D /usr/local
         endif
+	USE_HOMEBREW_GETTEXT =3D YesPlease
+	USE_HOMEBREW_MSGFMT =3D YesPlease
=20
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
 	# Unix domain sockets and PThreads.
=2D-=20
2.52.0
