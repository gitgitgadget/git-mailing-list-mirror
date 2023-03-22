Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F4AC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 11:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCVLNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 07:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCVLNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 07:13:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2BFF30
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 04:13:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o12so71273609edb.9
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679483621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWFdOhyWZIlZlvBp7oWmLnDSIyTGxI+5bmZ4/3vWVfk=;
        b=QM5jDjm+3SCxGyU/aVTS/WJlpednSOmIL95kj1uWMxPDuMXSwc0kZIYo6pKP7P9OAs
         4LDTE7BwzhL3QO25Gz/PjSu/sD9rkQhPpa6342Ze+cr9P8nxSkLsMvvRCEIdpDHRxRNx
         VA2RVQ0Tj5MrXp3jUnJvTYdK8poMtegCF1Tdzdwcd+Wv18PyypqcRTc+e0iGti0gZJpI
         EJWYYU0vr00iibWorptwZNG3+2opNStTbXgMv5DwYL5bo+DQ0aCBhwM04XUu2LN7ntdy
         vEqsIaM3WKeP0z0QU/yqqJaCOWq6KgGMWA7Ln2ssoqB0qtJkef8MXQA//3GnEyEFGAOV
         CuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679483621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWFdOhyWZIlZlvBp7oWmLnDSIyTGxI+5bmZ4/3vWVfk=;
        b=GM2tC+KP4q+1l0hFVsIwLBeLmMUhfcHIBxW+EtwnIG/4ctCKOY9guwSnG5H2givDOA
         JTX2xdeMkNpfXT7g+sbJoS2IEARpEE4Nv6NSDJdvZHqj7b5tdVq+Fsamjua+zTnOm53R
         +XLH04ZFaz2AGW+GtFJCZDeSaIYTKYl2rtbEwutYv87i268zTXQU90ktMoo6dK9X9GFG
         Pg1A/aqS5KszGNF4Eov3bF/wM+J9ci/8x0yd3CyUfK2tbJH6bOQLDZDw2OFKtnDx2FoU
         zkaixqm+2AWmT80SSQ4wqgIxHAjsw0nv42meZN2srbe+YQ54sCT6baAzL4Wulr+8wrZo
         qCtw==
X-Gm-Message-State: AO0yUKUsgnThg3GVOMp2cIAs50oJO7fdD2oARzzzTWpd/Jh4D6H2nAB1
        ElXVVjKRPlapwgwBeE82hZM=
X-Google-Smtp-Source: AK7set8o1R6v3YKuJsT02rpf5P/Bx6rWMRQEmWlUypSFX420c+ssUUX5lTBlKkCvaIi/EewbIo2KlA==
X-Received: by 2002:a05:6402:150e:b0:4fa:d83b:f5da with SMTP id f14-20020a056402150e00b004fad83bf5damr5902591edw.30.1679483621707;
        Wed, 22 Mar 2023 04:13:41 -0700 (PDT)
Received: from localhost.localdomain (adsl-178-39-131-155.adslplus.ch. [178.39.131.155])
        by smtp.gmail.com with ESMTPSA id u5-20020a50d505000000b004c09f0ba24dsm7540806edi.48.2023.03.22.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:13:41 -0700 (PDT)
From:   Ridil culous <reallyridilculous@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, reallyridilculous@gmail.com
Subject: Re: Feature Request: Allow to stash push and pop file modification times to avoid rebuilds
Date:   Wed, 22 Mar 2023 12:13:29 +0100
Message-Id: <20230322111329.781-1-reallyridilculous@gmail.com>
X-Mailer: git-send-email 2.40.0.windows.1
In-Reply-To: <xmqq5yathkwh.fsf@gitster.g>
References: <xmqq5yathkwh.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, i wrongly addressed my reply before (https://lore.kernel.org/git/202=
30322110309.760-1-reallyridilculous@gmail.com/) to rsbecker.=0D
=0D
Junio C Hamano <gitster@pobox.com> wrote:=0D
=0D
> Now what timestamp should "stash pop" give to the working tree files=0D
> in this case?  The contents of the file probably is identical to the=0D
> timestamp of the working tree files immediately before "stash push"=0D
> was run.  If we restore the original timestamp, because it is way=0D
> older than the build artifacts of your second build (which was done=0D
> after "stash push"), the build artifacts would not be recreated.=0D
=0D
The usecase for which i'd like to have the feature would avoid that because=
 there would be only build artefacts from the time of "stash push".=0D
