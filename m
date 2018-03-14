Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E171F404
	for <e@80x24.org>; Wed, 14 Mar 2018 14:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbeCNOad (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 10:30:33 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35618 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCNOac (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 10:30:32 -0400
Received: by mail-io0-f180.google.com with SMTP id k21so4622773ioc.2
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NL9St70SjaEHwO7dbREvZr1LUsyhh1HkJ+RC8mrzTDw=;
        b=cegShkJeNllxYsGcbhix3u3Zj+3P0dejgpPR8VvdgwMPacpQrBcAIqmEnyqXIxcbza
         ApJTR+MdEuC4bUaM2aAJUjVxf2hyh0o62umX5uvh4dzwFhKpVf4T/58xp2c1Ejw9EjvP
         CifhELbqQpb8G892BU5zfy1DCLNyqWRAxqE3GSOW+yL4KJ9UH437kKMIVjqilK+0HJt5
         hM2F0D6aluFld23noN+NVdwlHzpVm1V/N0iAMmwTuggzG7cep70EBthIPms9YOCx7KTh
         MMa3WYLSpdymYzVinZWKphMSxmeI1aKjpDdJ8PSzyzAh9u1emtv/YacjNzBTl6pb05ma
         xdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NL9St70SjaEHwO7dbREvZr1LUsyhh1HkJ+RC8mrzTDw=;
        b=n+Ul5CoZHb72ouTELUO7d4jU5QcrZqPmHCzCDaWziHqNKI8ZrTsXgCFtWCODiwsSh2
         sH5DE6p4rIY8VdwNB1dolDhYLacCn4SN5lAIGOzlwHHrKxnI1W+j9NO8bqKkMa9W+u8E
         w8N2WunTUQVHmsNWlG+p9DwSrJ3axy0PWExRBfNzRi/fs1NeUGL/SSCLtjsXuo02RsE1
         cwN1Q1uf7yDuCi/8nxIZoyHtklyB/b3pw+LiqJoEdWRdqQrsXUsYc3Nves/oO/1zhqhx
         2yaW53LzOL/Dk2yNpyc4th06lwJ0XymOsC2N0/JjH6zFXgmEZrL7aXyNY+k+MTSUxh09
         1bQg==
X-Gm-Message-State: AElRT7F5/1SQgIAeQvQNZn02l/RumcoRBif1jYwNFGGkhQ9XZ2uBeWAl
        vGW2wEpLDEyRM1ssS1sPqqXygLriEyzbkAJfkKNpjDyq
X-Google-Smtp-Source: AG47ELv41KhIsGCOdjzoWcPNgk3IGbBBOCTbL1bsDNPW5ZXPcI7ZMvDPgvdJPTFNOuyH/PF2MfLmjTSPG7KPLfVKsqE=
X-Received: by 10.107.50.17 with SMTP id y17mr4693457ioy.223.1521037830828;
 Wed, 14 Mar 2018 07:30:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Wed, 14 Mar 2018 07:30:30 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Mar 2018 15:30:30 +0100
Message-ID: <CAP8UFD29eFPfiW2PjOr4evjB2X=yDWULOgUx2NRM83Mt0FDXUw@mail.gmail.com>
Subject: Running some tests with -x fails
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't know if this is well known already, but when when I run some
tests using -x on master they consistently fail (while they
consistently pass without -x).

For example:

./t5500-fetch-pack.sh -x

gives: # failed 3 among 353 test(s)

./t0008-ignores.sh -x

gives: # failed 208 among 394 test(s)

Are we interested in trying to fix those failures or are we ok with them?
