Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929E5C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 17:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350457AbiD1RGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 13:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348341AbiD1RGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 13:06:16 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F82127E
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 10:03:00 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f7ca2ce255so59901917b3.7
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptrix-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=E+kerxOFUFViOvbu05Ye+ww+5Imjzk3V4TZJVCeTHoM=;
        b=Hla2tpohWiDg8B6FVzKP3Lmd6SxeVrGtXhbSJsd2bTtlbggJX51OrsWAKDVOLcrhAg
         82E0APwN5q0AtIF2bXxRb11Hf0rkPOisxWkpLzvWjUOSZlp0OCJ4GA3Dv4DEylF4Mc5+
         1bLI0WdKrdYQg96jQ5TVVh0m/I/MBGbxU8Ig7qYiFXElZLXrm0tl9epwsxfCvvx33Eqp
         QjWSLURk5NlqHBT6AvQRoB9FiafNv2RAOBDCsyB1JtdRzhsHfJdjbJTOQElXgT4u6YQt
         8Ipuu9sZGbNpPFDdtVLyPA1DM8eUEO1Rb08hHpPHAEIpcpszCCkMACxIHnyjThVX02/2
         duAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E+kerxOFUFViOvbu05Ye+ww+5Imjzk3V4TZJVCeTHoM=;
        b=0D9VUbL7C1ZgvIBXSda1FHsViaDUbvuThqaKdInkQbjXkW47aT3yl/T26Gj9yF4grx
         DfVRXeF9zpH++yqKZM54rvRzk/gSISpcHHAo4dbzAZwa2zzl/wWAOjA2gZO3cvbSEm5/
         jbQpty4+fQkU5DbiCG1es1rA/WnN2OJrAymljcw5aVAnNM+T4fj3E+BE2ayxY/gDI6cY
         uy1YzCPSIBshUd3nVLC8hIlbVNojG++lQc66mj/zWSC/50TOV8qyqYsLEQFgpovNuRqZ
         hI1gIgMZ1nkNCtH+Yj5/nn2Om1KTa6HkP8084kh0Nm8/o1XJUq/SKIRWp7MclPIoP147
         2hdw==
X-Gm-Message-State: AOAM5337nD0rUUQI8qraIKXCQXe8nWPwo+eZS/WscKnM33BrOLWNsYeI
        cKxoy518fSn+80lLAopYwi7M+d8y+Sq+RJn77Y15RgTefiH9XOpy
X-Google-Smtp-Source: ABdhPJyJo0mfwnFs1KtgVdSUFzO2JQG1lBb1ANhi2vSy+/rkV3lBhUabI7VKyw3ofoKdHGFLN388cpnIVpesJYF0ZuI=
X-Received: by 2002:a81:2fc3:0:b0:2f4:d2f3:4f58 with SMTP id
 v186-20020a812fc3000000b002f4d2f34f58mr33109403ywv.350.1651165375345; Thu, 28
 Apr 2022 10:02:55 -0700 (PDT)
MIME-Version: 1.0
From:   John Wilson <johnw@synaptrix.com>
Date:   Thu, 28 Apr 2022 10:02:39 -0700
Message-ID: <CA+o=yoqriRR15qYdHjWscLoc5UZWuhJwn9PSR8D-+s_XVsyRag@mail.gmail.com>
Subject: Git credentials lost after sysprep
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have "worker" instances on AWS, windows unfortunately, that require
me to sysprep a base instance before imaging it.  This process removes
saved git credentials.  I want to use a scheduled task on startup to
pull a repo to ensure the servers are always using the most current
code without having to reimage them for every change.  How can I
store/use credentials, either standard or SSH, neither of which works
now, so they persist?
