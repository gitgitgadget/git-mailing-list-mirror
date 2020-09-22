Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12357C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B6A2065D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 20:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np2U6m45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVU5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 16:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVU5W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 16:57:22 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830AC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 13:57:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z13so21239907iom.8
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zHOBt40l6Z8WxaGjEGkxHONRSzkd4CNiCzjR0/eThSo=;
        b=Np2U6m45Cg1XYGMIxZx2xs1bvFLGAVLU6j4A7Yo/Aw9GfwsJUrAqPGz8DFeD8QUJS6
         9c2o+xlutq3V+oSJrKgQiNesNkavhQeR44lqXMEZxDuaig5+vlCgxOIUn9Yag3KWJ1Io
         LwoqeYBhbDI7c9znsf1KXSibdIZLtptNblcsThgiEgm1jy8KW+WoWwLTh5lzblF5i4q5
         nsP5p/ihfur9keo3sN7VBdNj/tcw+XtDa9R4CdKfG7oqZsPojSZZThq5VTSfIsbZwBap
         t3OmaPQRUJr/Rx8CGytMkgyEle+MYQoGSARLySwXCFESQF0SkL+p2sjTyLdAS8/dHB9B
         ITKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zHOBt40l6Z8WxaGjEGkxHONRSzkd4CNiCzjR0/eThSo=;
        b=SwDRW/SJvPhIfneBS3XmgNXAfkdaOvOA6QGfj1IpId3DKEtPDRy4+qws8wNhqzqP+9
         X8pDo9u/+2aV7DL5Jbby5Q7bBy91VNV/deQKUtz36/5kf4CZ/4ELBdFYT/4NqkdIgJJM
         b6aHyGRLr0E3rsQ0fVlDn47rEAD+cvlqQEVdGeYc7T3hbMy/aR5292oQ09MTxf/c/oMa
         7QVUehawPZH4EnEDeohAw+8FqjvryBpQo1kdGD5ehLYWIh/mTBe9fX/2hyfWy60hKa4y
         rENl9Q3HGjZ8DgQHw542Ca909lgZKaojNBcUiChr29ivQxl/+rYR2J7DunVn+9wm6gF/
         7S6g==
X-Gm-Message-State: AOAM533EWpVd9NuL82SNekpMQuVRSm9MGfV0y0ALW7VxZxyV6bXcoNTj
        HA2xFYGbaN3Vt5nalQr+bSqt54tOXH9ojcojLXfXmaHE
X-Google-Smtp-Source: ABdhPJx+uJtIfkUw0bESQU6GikMwPkFw8ct7ZFdmQl/enSxNfX2mc8zVqUaf2oxG9x03xucGJd+rFEcaYBpJKcLW0lU=
X-Received: by 2002:a02:76d5:: with SMTP id z204mr5438378jab.93.1600808241485;
 Tue, 22 Sep 2020 13:57:21 -0700 (PDT)
MIME-Version: 1.0
References: CAD2jYq-ntdKVBKXPxzjTSBv31-NGhUXOJmr5vwDF=Ync_F=3zw@mail.gmail.com <20200922193407.23931C0613CF@lindbergh.monkeyblade.net>
In-Reply-To: <20200922193407.23931C0613CF@lindbergh.monkeyblade.net>
From:   Ilan Biala <ilanbiala@gmail.com>
Date:   Tue, 22 Sep 2020 16:56:45 -0400
Message-ID: <CAD2jYq_-yOgVDd8280+T1E1hT1r0DfN1xFN6V0Hz_v7wnsENpQ@mail.gmail.com>
Subject: git diff --name-only --submodule=diff combination does not work
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been running into issues with using the --name-only and
--submodule=diff flags together in Git 2.27.0. Is this a known bug?

Thanks,
Ilan
