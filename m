Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E22B1F78F
	for <e@80x24.org>; Mon,  1 May 2017 20:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbdEAUkb (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 16:40:31 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37306 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdEAUka (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 16:40:30 -0400
Received: by mail-wm0-f48.google.com with SMTP id m123so678764wma.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:subject:message-id:date:to;
        bh=i0ijrqp1KDXFlLBkxVWUzIp9pGkpIfcJgUatYUFVAys=;
        b=G2zN+qMoYX0qo3kvYSpzu+bwAh0RJXu86l9pXRzZCtp6ciQnAllebdwK9F64mrXAnR
         OZxfq0xuUX8iW5KjB+f3Bxk+AlBZWZp2q45bytfjTJnZVvRhC2iT1ALXkXlooFTeol0R
         VM2hTmJmRotZ7RUcM9BrjQmRfm/cK4zKMyP+9FlgBDE1SXuqpOLbAQxbaTHUzeUiVed5
         WtECHjycwrDGiZAYJ+iAiX4vY0gT9+L6877osDAqfQ6hWEO6N4NGfiRfI8xJzkr5YfMO
         Xwgx4j7gqH/UzMpRZyr9BPG/mLDGG0j9L+ZkKbj2/lTAIae6Y94vGwnwYvNhVePvR35x
         +n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
        bh=i0ijrqp1KDXFlLBkxVWUzIp9pGkpIfcJgUatYUFVAys=;
        b=II4MD08xF1gEzQJaLw+nWyMHT52CzoV4R1txKQXjKKt853Q28dumInIV6bPjEQ3HPJ
         TyxCg6e+E06TFAcFEL8sgaYVcerPRLa+WJlHFqfcOe/sfTq7MpyoXhYxMncD4gHGzbAk
         S3aTlJPpk3kbMKxIOe9G64jWwuX+sLSXpooGxKIIKz1MEVr25KVq5cVoiFaQtQ7ingIi
         3qPZ/PoFxbec4GGg4jLRJApqThMxxIIT5QSQDTMGIigJHZs+cQvn2TzTGy4euKNB/0jr
         OPB8W0Q1tiRTCO7bjCbq+uXQ5veDuRQNARJIIs5IDNAp/AvMDsxmjoC5hJi2esqyPNU/
         V6tA==
X-Gm-Message-State: AN3rC/6QiylgH62PX6/sJS5JpnZ3iKjlez/iGNylp8GitLHAGSmZ/7as
        0ZDGpircfoq7ShhyrAk=
X-Received: by 10.80.174.230 with SMTP id f35mr21262740edd.157.1493671229276;
        Mon, 01 May 2017 13:40:29 -0700 (PDT)
Received: from [192.168.1.12] ([46.7.146.185])
        by smtp.gmail.com with ESMTPSA id m53sm4947810edc.29.2017.05.01.13.40.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 13:40:28 -0700 (PDT)
From:   David CARLIER <devnexen@gmail.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_AB66953F-310E-4521-AC70-2751C5591B96"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: [PATCH] small memory leak fix
Message-Id: <C3A43A45-9120-4755-AE42-FD33F68F3FCB@gmail.com>
Date:   Mon, 1 May 2017 21:40:24 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_AB66953F-310E-4521-AC70-2751C5591B96
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi this is my first submission, a memory leak found in the maint branch =
(might be in master as well).

Kind regards.=

--Apple-Mail=_AB66953F-310E-4521-AC70-2751C5591B96
Content-Disposition: attachment;
	filename=0001-memory-leaks-fixes-for-remote-lists.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-memory-leaks-fixes-for-remote-lists.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20d98f3944780730447f111a4178c9d99f5110c260=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20David=20Carlier=20<devnexen@gmail.com>=0ADate:=20=
Mon,=201=20May=202017=2021:14:09=20+0100=0ASubject:=20[PATCH]=20memory=20=
leaks=20fixes=20for=20remote=20lists.=0A=0Aboth=20push=20and=20fetch=20=
lists=20were=20not=20freed=20thus=0Ausing=20free_refspecs=20usage.=0A=0A=
Signed-off-by:=20David=20Carlier=20<devnexen@gmail.com>=0A---=0A=20=
remote.c=20|=202=20++=0A=201=20file=20changed,=202=20insertions(+)=0A=0A=
diff=20--git=20a/remote.c=20b/remote.c=0Aindex=209f83fe2c4..2f8cb35a3=20=
100644=0A---=20a/remote.c=0A+++=20b/remote.c=0A@@=20-742,6=20+742,8=20@@=20=
int=20for_each_remote(each_remote_fn=20fn,=20void=20*priv)=0A=20=09=09=09=
r->push=20=3D=20parse_push_refspec(r->push_refspec_nr,=0A=20=09=09=09=09=09=
=09=20=20=20=20=20r->push_refspec);=0A=20=09=09result=20=3D=20fn(r,=20=
priv);=0A+=09=09free_refspecs(r->push,=20r->push_refspec_nr);=0A+=09=09=
free_refspecs(r->fetch,=20r->fetch_refspec_nr);=0A=20=09}=0A=20=09return=20=
result;=0A=20}=0A--=20=0A2.12.2=0A=0A=

--Apple-Mail=_AB66953F-310E-4521-AC70-2751C5591B96--
