Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408D5C77B7D
	for <git@archiver.kernel.org>; Tue, 16 May 2023 02:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjEPCxq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 15 May 2023 22:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEPCxo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 22:53:44 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F54E58
        for <git@vger.kernel.org>; Mon, 15 May 2023 19:53:42 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-757756e2eefso522162385a.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 19:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684205622; x=1686797622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHNAZICkBhv7CQLpMFLYoojLQX9FX9bNn0dUWSvWDEk=;
        b=RIIApfxvZE1NZUPkp/8i2fdAoXdRG0ZTzZEWsmqE61lX2e9GYeabhJa+EKKecxRHGx
         bE2oCPSuWs5u25+/6HGIwiCar06DxWSj+BpvJ6JFwll8DsL+atgYLz1dE25gkF602hRS
         EFnJpxCxMU0RcX0HAkaq6yxel2CamQWj1Bj6B8WBEPoSPqeORR13hu0FkD7+H7LpejEy
         H2C1l1WyFPAj18B0WeisBH5BRJeme9h8k8a+TQ4DlQnAhMCzOhcX5oII8uhBVpmoD9Lq
         3rY31KW9oMyKInpv6435EsPlv6diq1kH6UqLCpczCzL39T23wDlao528WCsman1PnSld
         pBSg==
X-Gm-Message-State: AC+VfDycnuXS8qnpWlpImI2oiwBRYK0qzjgQYUGbbsCBXLgCIjG+2KyX
        Cbo6gx1NoBpEsFrJYLFfaHUY95Ump30+TjYfwj1Qp1C2
X-Google-Smtp-Source: ACHHUZ7AehpPynThrwQW2vIK7dL4r5GXZ0G4MTmMMIbierqI8KuSAWu0hcW9XV8lsxgmVz7INoxaw4RlbxCoX82ku7U=
X-Received: by 2002:a05:6214:20a4:b0:5f7:8b31:454c with SMTP id
 4-20020a05621420a400b005f78b31454cmr49759766qvd.1.1684205621980; Mon, 15 May
 2023 19:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230516022646.648123-1-gitster@pobox.com> <20230516022646.648123-2-gitster@pobox.com>
In-Reply-To: <20230516022646.648123-2-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 May 2023 22:53:31 -0400
Message-ID: <CAPig+cRwPUJZdov7eAZbZ1qji9qj_Oh5RQ8bpLWsXW9J+QnvPA@mail.gmail.com>
Subject: Re: [PATCH 1/3] tests: do not negate test_path_exists
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2023 at 10:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> As a way to assert the path 'foo' is missing, "! test_path_exists foo" a
> poor way to do so, as the helper is designed to complain when 'foo' is
> missing, but the intention of the author who used negated form was to
> make sure it does not exist.  This does not help debugging the tests.

s/a poor/is &/

> Use test_path_is_missing instead, which is a more appropriate helper.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
