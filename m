Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB3CC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 06:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA37A206B2
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 06:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lufia-org.20150623.gappssmtp.com header.i=@lufia-org.20150623.gappssmtp.com header.b="f/fkDfD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgHKGRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgHKGRB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 02:17:01 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387FAC06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 23:17:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x25so3680444pff.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=4FHShsKL28CUORvJxgbRZzJHrh5L5rchhrPgB0eJm00=;
        b=f/fkDfD4NReJERz/XTnaXT2vZjsx4aPxIcOy0puidI3YCtYBrIqHPywF2vwYRn/qVg
         rfruvWy0MQj2qo2AxO+yKhWYuURORqXULWxxz8nxevqBDzQX01CWF8tOAE+48T8xVmfi
         dAtWvLSCWxixQ03ya6zzNJExl7MX5bdAy6p4TEZBF2StGAsLwgma/hkc1uoLBCFvKcNy
         bBf1o8/qUZbKhWMMtoMC7X5ebPnM4+Y7WPK7FwXshPJEm5mZUs/8Q95lSENmOhPn5xa7
         8xtG8zo9ukrFpd2JKXYei5Ka3CssEoAQnl+WoSNPin+gSTrP80d+v6o1DWQQOdRL0IRW
         u2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4FHShsKL28CUORvJxgbRZzJHrh5L5rchhrPgB0eJm00=;
        b=VAKPkdrOA5t/ur2p/VaE5HAa4QcuL7xUdLN8FCcBeusSYoZhFZ/sAJ52IqY09HrIGQ
         oS/sgl9KPaiJuAKtfsZ1j76H7JJPliCACJpcsM1Dl4EfruMrFvk2RJQEHztcP6cgT5JB
         /YWtfL/ZoZNDmSGMSyTA8fFiUo9gSPzM1l3mFQjOnOk/WI2tNRIn9OQrtI+G9ozeSW1R
         fCmhH6dpGnjj4R7TqUumaC6gl9i4PXD/f3FRrwRseKqZwEnvkXt3R8BNwxqcuaVSbNwd
         Qb8js1yURw5niB2seuUEkqJ8qK/OlgkKGQTiH2o5r8J8hSQAPIOOrK94h9J5ZNzE7oGd
         XOcA==
X-Gm-Message-State: AOAM5328fJIqyKEfgmoHyWY7IZaqzIr1BB7P/OC1vqtsnm3RuXvong/a
        +2dFsdjuHyhpxm19ZUJAxE62cN3CfKjt1ugyO2AvfYE4dYmFhOlp
X-Google-Smtp-Source: ABdhPJyQY57y0G9t/Wp1ERv5xRKox25X7TFTOyPjofX1NQhU1Lsn13Oxdou2RwgJ++Nx1ABuMOKZkOHUmWOCPj2X5Kk=
X-Received: by 2002:a05:6a00:7ca:: with SMTP id n10mr4581594pfu.129.1597126620465;
 Mon, 10 Aug 2020 23:17:00 -0700 (PDT)
MIME-Version: 1.0
From:   Kyohei Kadota <lufia@lufia.org>
Date:   Tue, 11 Aug 2020 15:16:49 +0900
Message-ID: <CAFMepc=iqyHG7V4LPcyZ-fmmWp176YpW_88joLtYxQrpsM5UFA@mail.gmail.com>
Subject: Does git-apply --recount search a extra line?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just found a strange error in git-apply --recount.

======= output ========
% git --git-dir= apply --check --recount -p1 -v <patch.diff
Checking patch main...
error: while searching for:
    mountfs\
    configdist\
    confignet\
    mountdist\
    fmtventi\
    download\
    copydist\
    bootsetup finish stop\
    stopether stopppp\
-- /n/sources/plan9/sys/lib/dist/pc/plan9.ini.cd    Wed Apr 13 21:19:21 2011

error: patch failed: main:8
error: main: patch does not apply

======== patch.diff ========
diff -Nru /n/sources/plan9/sys/lib/dist/pc/inst/main /sys/lib/dist/pc/inst/main
--- /n/sources/plan9/sys/lib/dist/pc/inst/main    Fri Apr  1 15:10:39 2005
+++ /main    Sun Sep 18 00:00:00 2011
@@ -8,9 +8,9 @@
     mountfs\
     configdist\
     confignet\
+    download\
     mountdist\
     fmtventi\
-    download\
     copydist\
     bootsetup finish stop\
     stopether stopppp\
--- /n/sources/plan9/sys/lib/dist/pc/plan9.ini.cd    Wed Apr 13 21:19:21 2011
+++ /plan9.ini.cd    Tue Nov  1 00:00:00 2011
@@ -5,6 +5,7 @@
 dmamode=ask
 adisk=/dev/sdD0/cdboot
 cdboot=yes
+installurl=http://148.251.6.120/plan9/download
 # console=0
 # baud=9600

======== main ========
#!/bin/rc

# must be topologically sorted (by prereq)
tasks=(\
    configfs\
    partdisk prepdisk\
    fmtfossil\
    mountfs\
    configdist\
    confignet\
    mountdist\
    fmtventi\
    download\
    copydist\
    bootsetup finish stop\
    stopether stopppp\
)
#    startether startppp stopether stopppp download\

======== plan9.ini.cd ========
partition=new
mouseport=ask
monitor=ask
vgasize=ask
dmamode=ask
adisk=/dev/sdD0/cdboot
cdboot=yes
# console=0
# baud=9600

[install]
nobootprompt=local!/boot/bzroot
bootfile=sdD0!cdboot!9pcflop.gz
