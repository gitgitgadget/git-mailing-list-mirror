Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428511F463
	for <e@80x24.org>; Wed, 11 Sep 2019 06:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfIKGO7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 02:14:59 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:43230 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfIKGO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 02:14:59 -0400
Received: by mail-io1-f42.google.com with SMTP id r8so18245778iol.10
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 23:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fo/e5T9ieUvnkA/OJ6O0CoOyufMVgjn1RS2+r41fvLE=;
        b=DHGFECskeA7rXvD0H8DyHNT6S3uHjfQhPyDqQxAsVFCjtWniqPAEDyG2eqNg8GWMDh
         EzkgjRulhVADxG/gueI4gyCpgOsWZmViLH04rKbdtR90KmQtbRvnRoe/uhbyh+Ar+ISa
         Y6ugQ+qQn5wXL5ccabEJIdyO98HQmsCkEA1BTjdiqwRrS0TRw6FSfEMgypEavyJfkdmh
         1gYrw9AyhkW8VXJZXA3LGnmcROr8YndOWF8gmRO547s36nnH7KDLP4UxYvGpGtPflBfW
         oKfy/VMEaR7XPZdttQ63vz4XVdds+GsgvxBIXRGn3Pj/uf53i0Fk8OHZ8r6eXm097rI0
         otWQ==
X-Gm-Message-State: APjAAAU6Txkm2MvUPh5XIw8VGwCaiqgHbx1zPybGNTbtqiYI4bL/o77c
        6/pL0AshLk9l+3G2I+2rnQB8qG382QiXgXlPAgnZoZ1U
X-Google-Smtp-Source: APXvYqzol5Wa+HUtfskL3eTG/5fpS/HStauEkJaHYXPvqJkIOU82mkI9E5Hk/QGx8jHUIfE64hYADdDTbpk/CCtXLFY=
X-Received: by 2002:a5e:8219:: with SMTP id l25mr5954844iom.177.1568182496548;
 Tue, 10 Sep 2019 23:14:56 -0700 (PDT)
MIME-Version: 1.0
From:   Konstantinos Dalamagkidis <konstantinos@dalamagkidis.info>
Date:   Wed, 11 Sep 2019 08:14:45 +0200
Message-ID: <CANTPZbbLNJPEEeG8BgdDEVYS=gudz4SvqGe==28EQHXDXUxuwQ@mail.gmail.com>
Subject: git-send-email does not use conditional configuration
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

In my git configuration, I have an includeif section for work
related repositories that configures the user and sendemail
sections.

I can verify that the configuration is read correctly by git:

% git config --get-regex "sendemail.*"
sendemail.smtpencryption tls
sendemail.smtpserver smtp.office365.com
sendemail.smtpserverport 587
sendemail.smtpuser dalamagkidis@work.com

But when running git send-email the default sendmail is used:

% git send-email --dry-run 0001*
[...]
Dry-OK. Log says:
Sendmail: /usr/sbin/sendmail -i test@example.com dalamagkidis@work.com
From: Konstantinos Dalamagkidis <konstantinos@dalamagkidis.info>
To: test@example.com
Cc: Konstantinos Dalamagkidis <dalamagkidis@work.com>
[...]

If I move the sendemail section to the main gitconfig file, it
works as expected. I normally use v2.20.1, but I could also
reproduce this with v2.23.

Rgds
Konstantinos
