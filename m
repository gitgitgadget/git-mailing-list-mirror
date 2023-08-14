Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C2C001B0
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 22:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjHNWRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 18:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjHNWRM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 18:17:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B74918B
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:17:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589cd098d24so44461647b3.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692051431; x=1692656231;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xiOzCO++o+mQYMwK+auHX9s96QdPeR/nQ68nKSZK6S8=;
        b=OgfhaPK8KmGJGJpYFNHpjc0Mk0mzGUWFyC/cbYp5KA+qWdMIZ8J8KThgkvWSpCZwh5
         IGUBw7xcI9VbPL7xi5PF7Tmb4cyzL1svKuUYWYKgXvh3vhbg2tTcHOpo+WF2QQUW2ZlM
         caFGW/Dkk54ZjqpSC1v52Nc5ban0yeGvR/EerSenhh+rJC8af/KWulFo7XU85J8DN+bK
         qm45+lr+xE3Wz1WMd8Y74gU5gwjZDCtWMZ0ZUlQU4ZlTdqRIKxDDQQKvWONRp/ptTPS0
         OhaJcoZeIwOEEfUIPlz5PcekvNx/u4c0bf0RAgvpaZVBrvwkGjb7SXNAQr+EGd+BQHg3
         lYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692051431; x=1692656231;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiOzCO++o+mQYMwK+auHX9s96QdPeR/nQ68nKSZK6S8=;
        b=gJAV2hFY2Grwh6e5inv3gZ123Vx/Yq5iC5206/rxOuy6UKoXacgMTUB6qLLvHQB7ug
         olHN49PobQnpMVR+sXJ+SErXP1P43MJFL/79/z/VoF/14eusMKik151EE5LgIbfcm8K1
         Vv+nNM+9nGzpTEdPTG5xfxKEW+8aOLLWhlT35FMqzBLSsmyEgaC0w8ooB/OYK1xRiv2e
         mdammQIHHhGb/qD62EOeNqx1SHXccNoEnnMNPeuKzXx3tF/cPqF7HPMx3VnIeCf4CzsE
         DRAd/SMus/8M2KtRSoqaPQMaf43+qmz/hEEp1YgaSyvnaETjlfbF2ejeejTsrC3tjhMA
         nvFg==
X-Gm-Message-State: AOJu0YxcDC/p248Yo+Mi5zeb3d40sjKIDzmfPJ9obC5nuhhvwRT6NJrl
        LqaHE9a71ZS6FD5m93ZsODBq1Tl3D2Gjcb9OXnqq
X-Google-Smtp-Source: AGHT+IGNAgyu0vePu4lc2IL9RV23QJB6VHhm7PIze5sJWpTWlzahDkIEEr7rN/ELJU11t8qQpxGQZxbzPbrGxjZohOLE
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:51f6:bcfb:aa2f:af1f])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b623:0:b0:57a:793:7fb0 with SMTP
 id u35-20020a81b623000000b0057a07937fb0mr167010ywh.3.1692051431257; Mon, 14
 Aug 2023 15:17:11 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:17:09 -0700
In-Reply-To: <20230810163654.275023-5-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230814221709.62539-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH v2 5/7] date: push pager.h dependency up
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, chooglen@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> In order for date.c to be included in git-std-lib, the dependency to
> pager.h must be removed since it has dependencies on many other files
> not in git-std-lib. We achieve this by passing a boolean for
> "pager_in_use", rather than checking for it in parse_date_format() so
> callers of the function will have that dependency.

Instead of doing it as you describe here, could this be another stub
instead? That way, we don't need to change the code here.

I don't feel strongly about this, though, so if other reviewers think
that the approach in this patch makes the code better, I'm OK with that.
 
