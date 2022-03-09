Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93CCC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 17:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiCIRxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 12:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiCIRxA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 12:53:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73A12E9D7
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 09:51:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p9so4239929wra.12
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=vNIeDDSzjDGh5wO6FglKYD24aoFd4zl5sa+4EPzDQY4=;
        b=WKRxan2xm/K0Q6NjoCoqfhhkP9mSedLlgKcIszlQN/jcsolQCJEh1MexE/sFoPdLyp
         mXeR8kqcy4wRGYNcZNdxGJs08KvcGthDu4mvGrn0GsaCDWAdTAKN/A/CiGozHssYze3u
         R+rWXOPCw0UtF1SK9mxUzEtrLbbKc7PksV4k1yl/ufyVOWS3GkwuvsjNBRLPQWykOt6Z
         WCwzQwpYoFau77XaB2I0bcrUrTUeZEGNYhSsAeTrsR8/xP0ZHi0DRmebiml6FExXg1gA
         mFRYm6Gk9YAucl7QToi/iQoRe8357sJbVSucD6obkSllvcL0JCv/Zz5TDH0OQyVj/lfM
         gyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vNIeDDSzjDGh5wO6FglKYD24aoFd4zl5sa+4EPzDQY4=;
        b=j3CZDUeq5Hn0uuce1NlGweSm1SY4Djr0dhrTyFei2/QjpOby9apHyQHUGSVyJdWQhd
         Y4C6peF3PfOB4j6wz+T/fUb7a+nnJYB+IDL8OfNgPe/u3Y+N2kpaQDPSBCGhdz7fB25k
         H3eygJfFrnCylzsG9zaPr9bCMnPn7VOp9yMWeGOJnHlOSlOmBFiJV8k8KxQeo4SUhPYu
         u1i+dJ1NiYfvMN2eYTX0b8IcV/6UW82en1354/+BlRZoY1DziQVDMO3rVLzEMOzo06AC
         eJstRFG1RKe0L4iczcHRBLeWc5eM2SjjndpxJSDLsyARM3OA4Gbz3lAm/yguxo6XarzI
         oH2g==
X-Gm-Message-State: AOAM533+kbczu91zm8edXysZ19u6t69zJT3jjR1pVaDBAAnrtoGWLFl8
        Wm/UnQNoLheYW10M1gXDh181hwSfUI1eKqsdI2gHrz9wuqiIbQ==
X-Google-Smtp-Source: ABdhPJyEpqMleH/GCfvek8898EYwcF4ecBv71QJc6N87ITPfZlPbTQKeR9fiSVaYIw+FFJzp8VX4CBzceabWsGuGhew=
X-Received: by 2002:adf:f849:0:b0:1ef:5d80:c68a with SMTP id
 d9-20020adff849000000b001ef5d80c68amr590494wrq.280.1646848316098; Wed, 09 Mar
 2022 09:51:56 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?4oCN7Jqw7Iq57ZuIWyDrjIDtlZnsm5DshJ3Ct+uwleyCrO2Gte2VqeqzvOygleyImOujjCAvIA==?=
         =?UTF-8?B?7Lu07ZOo7YSw7ZWZ6rO8IF0=?= <seunghoonwoo@korea.ac.kr>
Date:   Thu, 10 Mar 2022 02:53:44 +0900
Message-ID: <CAPb83E-1Ken14G9xdyw9MqZ6AiAZkwDuwRf_5NmqoUEvHcAqYQ@mail.gmail.com>
Subject: Possible bug reports for git-credential-libsecret
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Development team

Hi.
Recently, I noted that the vulnerability patch (CVE-2020-5260) for
"git credential" is not applied in the "git-credential-libsecret"
program (./contrib/credential/libsecret/git-credential-libsecret.c).

Actually, I'm not sure whether "git-credential-libsecret" is actually
used. But it can be potentially intimidating, thus it would be good to
apply the same patch of "git credential" to
"git-credential-libsecret".

- Patch for CVE-2020-5260
   * https://github.com/git/git/commit/9a6bbee8006c24b46a85d29e7b38cfa79e9ab21b

- Similar but not patched code in "git-credential-libsecret"
   * https://github.com/git/git/blob/master/contrib/credential/libsecret/git-credential-libsecret.c#L306-L311
   * When I put the malicious URL in the test code shown in the
CVE-2020-5260 patch into "git-credential-libsecret", it does not
terminate.

Could you please check whether this is an actual bug?

Thank you.
Best regards,
Seunghoon Woo
-- 

Best regards,

Seunghoon Woo
Korea University Dept. of Computer Science and Engineering
Computer & Communication Security Lab.
seunghoonwoo@korea.ac.kr
(+82)10-8147-9308
