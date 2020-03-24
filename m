Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9821FC43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 20:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F9F20663
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 20:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/6NO72K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgCXU7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:59:01 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42027 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCXU7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 16:59:01 -0400
Received: by mail-oi1-f178.google.com with SMTP id e4so6358343oig.9
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7QcPpee4ppAgoLSllHyWuBlCo2Pu6LAFUj3si/JwvKg=;
        b=Y/6NO72Kv5LyRJBDl98x2yenQqxpc916Wx2tEEN9ifaDo+x+tT0kbCF020nZh5lxOl
         +/wiTjh1zELGPC4qXECvn6WPt1c1JdRHmEmfd5gHQNKQsujuNf9ggBINQ5pMXfiYpJWq
         Du0yIHdccNi5RbanOTtQk4AJC2OdeknD7PituEfkxtZ1Nxf38PpQRtn6oM446PAe+tJi
         jzN8EH8L9A0t7lAa9iniFKCB+05jksQ1bB9DlJi+GME74EUqo+/y1S2S78lIZDMn/7Mm
         PmLSJPbWBEbE+dvxGi0sSVLi06GtFNo57iKim/LDxch6xO8JlVHV0tcPfWfxw/aXMe8q
         YQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7QcPpee4ppAgoLSllHyWuBlCo2Pu6LAFUj3si/JwvKg=;
        b=WjQXxvIHAfpLhfpLuylnXFFFLimGoAw44jprJGjbGCMy0+vqLnxXQ7kYFJI2+HE6t1
         9AAkvaPcuV26TIKKoOjxbYAXcyNhGhRmH23W1xxqB259UsPHF4XsqJHZWQIYWRF1C1p7
         IVcLwqjwBq475Vg5+TN/mjAnMMJCs5azvQz7ogvzaLueuaILrxFUiec9fVGx1JqGTt/A
         oWEkOksnhL6pkR/1q4kKmvBSKIjXbp1CP7UT56UHjEUBKcEDTNsI8BGo+IVQD/KW7aqw
         VG+ykUe0IHGiTKCAvwm08aVMSVrZj5Yf8VGRQAdTX3Eam+J7vUowOqOGeWRHD0lqisT1
         8Msg==
X-Gm-Message-State: ANhLgQ1p66AsK7z8fFhJsUyDx+SwnTEjTNSE0mQqbEiUQcUDSx7Jh20+
        LuJ28hmoKuQQQBGEwYVhQ0lVDOSz9APAI6rvvp5vrqmA26o=
X-Google-Smtp-Source: ADFU+vvO4hbYC8yle5CM3nypY+d7iW3uwXPgsPSfaWncZ8f84Vvz2MoDSb0vNv83r5/KxsHOb1pZ9JaglQE50CiC9LA=
X-Received: by 2002:aca:706:: with SMTP id 6mr106293oih.115.1585083540242;
 Tue, 24 Mar 2020 13:59:00 -0700 (PDT)
MIME-Version: 1.0
From:   Sitao Chen <sitao977g@gmail.com>
Date:   Tue, 24 Mar 2020 13:58:49 -0700
Message-ID: <CANwgwky6GgqQe0hSw3RtfEoOJPZNdwjnUy-WSSvoA2Jat49avw@mail.gmail.com>
Subject: [GSoC][t2400] Use test_path_is_* functions in test scripts
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

My name is Sitao. I am a CS Master. This is my first time applying
GSoC. I am currently working on replacing =E2=80=98test -(e|f|d|=E2=80=A6)=
=E2=80=99 with the
corresponding helper functions in t2400-worktree-add.sh. Let me know
if you have any comments or anything else!

Best,
Sitao
