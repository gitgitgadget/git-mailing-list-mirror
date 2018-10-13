Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1365B1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 00:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeJMITA (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 04:19:00 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45224 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeJMITA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 04:19:00 -0400
Received: by mail-pg1-f202.google.com with SMTP id q143-v6so10444935pgq.12
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 17:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oNstZzPAdaIsqmMUsxImT08lg5tjNi0Sy8MwdNWSjCk=;
        b=PoXrrlArolXjUsIrMc1kVUWGoZTdhVTClG8xKNgWhw6XVzj/iqRsmeBzOdNZdg7UHj
         1Tp7Lq1zOmqllsLFcyh9BVE16pqJ7s+BF5ZCLbxMXQksnwaEsybjJJx6eMTx9b9mLf56
         blaHpRuwoDOLdmk0Ow+cHlev63ddLuHbJb2TTFkrq1As0R3wXM53KGjzRPnO7wwLzslb
         jzATSFiX4PIVfUV8zpbc+NWarvAeUKZddOsj79SO3aECDzKJl3z5Ld64hb2NDoVrRcPk
         K/dBwa16GurG5adcnSRoHbs7GFfDEig6z6lUcRtlyyh00/Vj6ON14mHzwWb6T/nsHW6b
         8j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oNstZzPAdaIsqmMUsxImT08lg5tjNi0Sy8MwdNWSjCk=;
        b=sLtTKOpi9QHraw4AYLW5R2OJFi3PCFBkOJK+c2lvk1vJXQ+CGVi0YnByUI99jSA/10
         XM/ufn8X3334iM+EBYY76qPQ4/njLnl1O89K9RFY7YTYA1AupZhgFDz7Wem1lNkr83LP
         qiq2hcqTGjp4bN31gtzJ9geMDAX3DFL/GcMR8B5dZUHvJo0RHhF+dUWicCn0A88cpgwT
         cNeu+shx8gIeb30RoG98oT3toZtahtzZrlja5mkoTPf9X2yPIknGCngIFRihbma4fzNn
         5/XA/N8PlBJgHYB4Iz/i92rCN7buptnVgam0VD2Tt8mqbouj+1WtnEcH5uVFifjGSLCL
         aW1g==
X-Gm-Message-State: ABuFfohspC8Hwg0OioJfUebcAZIRJZkMRxCDU6uLmJfIRybVNUNrtltZ
        lnSQAmxI5g0OMfWleQfp02rqNgTip6TppiASI9Sb
X-Google-Smtp-Source: ACcGV634tSuSBGnkvqXr7xcrWW3jL/nDQzoBO3EhTn3NQ5PBq1UKLwh8syIBrsl/kh6NtEQJdsM1wYC9L/9a6g7oc19y
X-Received: by 2002:a62:cc4e:: with SMTP id a75-v6mr4531151pfg.38.1539391441648;
 Fri, 12 Oct 2018 17:44:01 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:43:56 -0700
In-Reply-To: <CAGY-PBgsG-T3JY=awszwGMpFx+jDx-a1FcV0s6vR067bSqgZaA@mail.gmail.com>
Message-Id: <20181013004356.257709-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAGY-PBgsG-T3JY=awszwGMpFx+jDx-a1FcV0s6vR067bSqgZaA@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: Git wire protocol v2 fails fetching shallow changes with `pack
 has XXX unresolved deltas` on large repos with lots of tags Inbox x
From:   Jonathan Tan <jonathantanmy@google.com>
To:     arturas@uber.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On large repositories with lots of tags - git wire protocol v2 fails
> to fetch shallow changes, it fails with error `pack has XXX unresolved
> deltas`. Unfortunately I didn't find easy way to reproduce it except
> cloning+fetching chromium repository, the way jenkins does.
> Reproduction steps:

[snip]

Thanks for your bug report and reproduction steps. I managed to
reproduce your issue and took a look.

The main issue seems to be that with v2, upload-pack doesn't pass
"--shallow X" to pack-objects (the write_one_shallow() callback is never
called, even if I change the "if (shallow_nr)" to "if (1)"), so
pack-objects probably doesn't know that some objects cannot be used as
delta bases. (With v0, write_one_shallow() is indeed called.) The issue
probably lies in how v0 and v2 handle client-provided shallows
differently.

There also seems to be another issue in that negotiation occurs
differently in these 2 protocols - I see the full list of "have" lines
being sent in the final request to the server in v0, but a very limited
list in v2. This might be because of the ref prefix limiting in v2, but
I haven't fully investigated it.

I'll look some more into this.
