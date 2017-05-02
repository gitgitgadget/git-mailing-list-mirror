Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50C81F829
	for <e@80x24.org>; Tue,  2 May 2017 09:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdEBJwX (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 05:52:23 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:36802 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdEBJwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 05:52:22 -0400
Received: by mail-it0-f48.google.com with SMTP id r185so46605393itd.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iHCm+04OIN5xejNFbPpaKU9NBJts3i6wT8x6Ng+LSzI=;
        b=rnOCWaXzmUhXDZlzMZWAn+VnRldpdoCcs4+UJ2NYz+h8YA5hgu9DM4dEnSfriO4Amc
         G/AWmCxhEKQhgaIcWrC2BakGqKgd2dMKYoreS0e68mRR4F8/zsPtoXFhFIi1m3hEWj/P
         ihENN5gr5lBfeQe3fOgSxdIe5Gr3yj+FnZsUQSgw5DtWmBqHuXep5KS7hvY9S+BTY7h9
         6FhKlqils/GakWVoKXmOfiIOxMq4lNT9GcGjLlNIUCuPkIehvIoRpGJCGp/tHtZ/keap
         VKhnL2MFAdw0eOiL/C5l/E7owQqOQFIOhcXe7JYz0Oc+cEPJVCeSZy+Ska/MfySM5y/u
         uA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iHCm+04OIN5xejNFbPpaKU9NBJts3i6wT8x6Ng+LSzI=;
        b=efip3BM+jpLSJWuyBcQT7hCCDSedWQ0lgTUv0UqHIym1dr307rGJtbBzOE+n2l6h/X
         RgJDm16vIdIzEoyoyHUbvOfYiMlmRAJ84FAKfAQ1NUzVPT6Tbr0LgFwwF+c5B7Nrsb9i
         AIFjiEE6abz6b9I1hTpTsaA2m1OFaQHRRDkRzn2zZW/nqc0+XH9okHol4Um1HGc2H0lI
         6sMYiveP5TeS1ef3v8Mlc+HfMKLoBLJ4GkYxO3a5VTCy4DYwKm0Jq9x59beW6L+LQuJP
         /IM9MGCpKi0I6aJgCdeIyPqjzecaHkjm8BMe5n8yMOPR8NAJQd2hGJW95xLcN34VEj+f
         A6SA==
X-Gm-Message-State: AN3rC/5UO3l98nDqH9FyhW6Mt3rBvM9t7oioCxaJB+Gluo4eS1MlTit+
        +aVDHzuZ+rhCDlhsQZncRTRvAK5rYg==
X-Received: by 10.36.43.79 with SMTP id h76mr2056420ita.92.1493718741692; Tue,
 02 May 2017 02:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.88 with HTTP; Tue, 2 May 2017 02:52:01 -0700 (PDT)
In-Reply-To: <C434AB60-F2BB-44A1-B40D-449EA27E2314@gmail.com>
References: <20170429184822.10128-1-larsxschneider@gmail.com> <C434AB60-F2BB-44A1-B40D-449EA27E2314@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 2 May 2017 18:52:01 +0900
X-Google-Sender-Auth: KWaiBMclndnsNvAy_RwE14WTuH0
Message-ID: <CAPc5daUOQVu66RDspzScUjufJvLs7TUS0UtqTZjJ=5sMBuF=TQ@mail.gmail.com>
Subject: Re: [PATCH v1] travis-ci: retry if Git for Windows CI returns HTTP
 error 502 or 503
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 8:32 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
>>
>> this should make the Git for Windows build a bit more stable. We saw
>> a few 502's recently. E.g. https://travis-ci.org/git/git/jobs/226669324
>>
> Please don't move this to next, yet. This seems not to work as expected :-(
> https://travis-ci.org/git/git/jobs/227513693

Sure. I am wondering if your other one to run both asciidoc & asciidoctor
tee'ed to log files should be ready to work on 'next', though.

Thanks.
