Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBFBC76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 13:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjDFNkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 09:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbjDFNj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 09:39:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05726E78
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 06:39:48 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g19so38026733qts.9
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680788387; x=1683380387;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWUszyY/6uGWoqnACMSAqbI+tK1RWwAgIHYI6ZA4L3M=;
        b=PAWis0JfV/NdQqPTy02hM110xDIFw9c++5QBIzlGmLWupyH9CoOIKXdrXsZtVjYYnE
         rTRzQlwGb2kMffra7uZ/pUr0lTeVFQTyBjd399adBPLalJL69/yMBDyTItaT7/VTEeAP
         ekcsEi9yEYUI2Er4YrS3tOUv1uzj5rKs/iuRkt2P1wpEQkOL5Wen3QhxEtKF7HrykUHz
         mMWsXwEAm9w8D6cWQoP7CRlPShxBzSCaKiU+puz8WXo0aCnmE0lT781Hpkw1GR9tcdOc
         rXHOqRiHuwcwYHhQ9SMrXNUQuJ1w6Nf1Sq+StcLOxxzNfeVCoCxdply62fAmz1JQn9b2
         vkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788387; x=1683380387;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWUszyY/6uGWoqnACMSAqbI+tK1RWwAgIHYI6ZA4L3M=;
        b=3ncLySta2TPYifMFMztVx5YEtqH19orx5UJJITz2wnlREawEWAl8vv4jNJGTFiFsqc
         UlImZb60NxNswDbPh1koh/+FbkdNXvXmL0n7JzPxtGbGcGixfVEq0Ww/2z404s3Ylnzt
         s0BbFA3/zt9T2BviClKxSP8N3n78+meLUWQIKlNyo9fci9q3/0w2eKk9eRAHx0GvBpi/
         afyNm2tje+5RxSyXQ3VmEaZ2uNWW75LEARxzsjT3gszoFoxPfQixUcl9X7h3MGmetB12
         dF7TRVyKBBNsUDjFV9WOKqTOLg9RW6rXKgjo/XCFYrMknCsB3JFr9/FgrrUfoECZovRC
         pNag==
X-Gm-Message-State: AAQBX9e5ImJoREVetp0byzSPxblLB0H5UfpeTyOSNuEzq4oiucR0W1fA
        j7vl0BGncOJwHa9dw27aHKw=
X-Google-Smtp-Source: AKy350b7e86NiqFuWf0Qdwq/zkxBWvyZ4+/VSg00rBfkeIi+w/boRpsTE2RWoM5DGab0XJgTqOaXPw==
X-Received: by 2002:ac8:7f01:0:b0:3bf:e15f:935c with SMTP id f1-20020ac87f01000000b003bfe15f935cmr10849581qtk.14.1680788386906;
        Thu, 06 Apr 2023 06:39:46 -0700 (PDT)
Received: from smtpclient.apple ([2601:5c4:4280:38d0:b05f:4a57:f2e6:c25e])
        by smtp.gmail.com with ESMTPSA id t186-20020a3746c3000000b00746ae84ea6csm485225qka.3.2023.04.06.06.39.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:39:46 -0700 (PDT)
From:   Benjamin <ben.knoble@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: regex compilation error with --color-words
Message-Id: <74D4E05A-FC1F-4AE0-A0BB-7EC381C04501@gmail.com>
Date:   Thu, 6 Apr 2023 09:39:44 -0400
Cc:     dds@aueb.gr, demerphq@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de, mario_grgic@hotmail.com
To:     sunshine@sunshineco.com
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was also discussed in February[1]. Giving --word-diff is to =
git-diff is enough to trigger the error in non-C locales.

I am pleasantly surprised to learn that LC_ALL=3DC temporarily avoids =
the problem; that makes it useable again, for now. But a fix is much =
welcome!=
