Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0531F859
	for <e@80x24.org>; Wed, 24 Aug 2016 06:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbcHXG2r (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 02:28:47 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36215 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbcHXG2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 02:28:46 -0400
Received: by mail-yw0-f195.google.com with SMTP id u134so394827ywg.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a/LQ3Yebmn/0536Nvj23gLIgFbjHYaPDcO7GN7HNVf0=;
        b=TJfTWfTiz4Mib71Zq3+n/a5++xMo+mOL+ZbwLmD/WHJAq5RnfNBkiEuurfVUNWXm6u
         4qs2y9pfCwAOXTsYzhVwxW2dMYaBba1FRi/fY7xu9gxnfn2AbgDmzbxYY7wzSZ323wt3
         Wpwyoyhf2tWNJYF/98/+vi8tWZiN6JjaQjR16T8inAP+P5kAFBRclrnfxzsNBw/JlWrB
         LHQ/9+6GyvrZT+QN9EHRTBMgxCvdSgAXimwmWoymLrpRRhCKTVy4ISIr8QDPa3ALqlM5
         3XshOCyQm9f3sJ/9LUOnu9MkPa+dA0W8HHrbNRrDYzu4/sWPbFyeNs1QdbcB90PqliXS
         rv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a/LQ3Yebmn/0536Nvj23gLIgFbjHYaPDcO7GN7HNVf0=;
        b=KTPfKqhJtvqpAakUfLO1gYa119PQAGyU+w+zOKpfZSim8fFRubDrNUotxWzu0vR1BT
         FgCoQchPFsp+Xzpc1tVhxuWzGP7GFDjt6pfwPmEa6nhI+V6+BidH9uR+wJ2hSr4uSvZu
         800KA3KdOgUWrYyUexxAc8qSBdU6BRB2Wo0A0YXQfBQB8/RzWkSiSqG+7QVUexLwDgUR
         xc0TgMp/kiiBsmkG5myCIqw24bmL5kEAlKoeo/L9ujCZTH29dzrXb6lmc5AHY+C1N6ak
         kdtaZXyzrBr199lRoIjeVJ/b6MPAPRphvQtKvWml1rF+VXTKSI++/Bxuc8FTznnjRIEm
         xgtg==
X-Gm-Message-State: AEkoouvxOdsOkwGBk90sTTnbrpPp3zCdeYWIrVN/XD72U/FNxpfol6hKwLrWJSuwLpY6k8rPcEDScgH+7i3csA==
X-Received: by 10.129.95.70 with SMTP id t67mr1082914ywb.284.1472020125875;
 Tue, 23 Aug 2016 23:28:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 23 Aug 2016 23:28:25 -0700 (PDT)
In-Reply-To: <xmqqfupvt776.fsf@gitster.mtv.corp.google.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
 <20160822234344.22797-9-jacob.e.keller@intel.com> <xmqqfupvt776.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 23:28:25 -0700
Message-ID: <CA+P7+xoae0vdMNd7zv7L7r68VcZ2zJPBoyvc6nzDDn-z9WUcFg@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] submodule: refactor show_submodule_summary with
 helper function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 4:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> A future patch is going to add a new submodule diff format which
>> displays an inline diff of the submodule changes. To make this easier,
>> and to ensure that both submodule diff formats use the same initial
>> header, factor out show_submodule_header() function which will print the
>> current submodule header line, and then leave the show_submodule_summary
>> function to lookup and print the submodule log format.
>>
>> This does create one format change in that "(revision walker failed)"
>> will now be displayed on its own line rather than as part of the message
>> because we no longer perform this step directly in the header display
>> flow. However, this is a rare case as most causes of the failure will be
>> due to a missing commit which we already check for and avoid previously.
>> flow. However, this is a rare case and shouldn't impact much.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>
> Up to this step it all looked sensible.  I'll take a look at 9/9
> later.
>
> Thanks.

There is still some outstanding comments from Stefan that I am looking
at, whether to use a die() or not in do_submodule_path.

Thanks,
Jake
