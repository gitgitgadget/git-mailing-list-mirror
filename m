Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884A41FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 00:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdJFArn (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 20:47:43 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:53860 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdJFArm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 20:47:42 -0400
Received: by mail-pf0-f176.google.com with SMTP id n73so2088064pfg.10
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 17:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LUrW16qY4x3h9oMPRJtFvuExEFPPgnStImDlUd8qfiw=;
        b=wYDaXZ6TXJ+a/zqsYWTRc+phbBi7vzEEgl54Zv095MJ+Lhtw5PKhdfEAtCTMcCD1rx
         Qi8X52sOnDetyf5z5D2ltf3GADPJHAJcTwJMDL1VvvjSqFSu9aW6O9OJWFHXCzzyzkxG
         Yn16M9it1d+XV8co//Cm6gv6XW4Z8bkMjUv7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LUrW16qY4x3h9oMPRJtFvuExEFPPgnStImDlUd8qfiw=;
        b=ujeo8dv0m46tOHS7ZBqLSxJ9/sqWDXUxafDk67hIu1WidxZu7KdhA/T4mmVXujjfvH
         9cnU9yIYPUhijyxYB+XfKszmK/TtWoa5WgmuEZEPO9ZvUUxGk4P/o/L7UR3FalO4B7nm
         BHHupejVzad3rpykCucHqOvnI9XPwTpZ0mm7udM9dqVDhiJVyvNvilGAOkfHkpcMoKWd
         uPmC7z0PfhCCHGhBaX9pZ1UM6k4OxmPn3+rG4fdumRyeXaLzXDPAtb75klsI2qG2A9N3
         +5MKIULL+4wMmS84Nbwufb9i9Y4jaCqkDFqjt2Or4t3rUZOtUuTfAUp7E65hQ+++NEL8
         Ca1g==
X-Gm-Message-State: AMCzsaU0OjYmAIV4RcmSJ+SEn+QD/RW0PkYp5IEbBlPkU7ss9Yp5bjsV
        Zk2ARD0tuW6qW1TV/eFrZ/p5fydv7u8=
X-Google-Smtp-Source: AOwi7QB6zVyVIx4jocDuYMsrImM6jZUW0hb8aA2yoWZjgQjtTsOZWAjZ2+/B+HFWB/quLVxXyGA6ag==
X-Received: by 10.101.70.138 with SMTP id h10mr421375pgr.8.1507250862158;
        Thu, 05 Oct 2017 17:47:42 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br02.corp.dropbox.com. [205.189.0.164])
        by smtp.gmail.com with ESMTPSA id r11sm288423pfk.108.2017.10.05.17.47.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 17:47:41 -0700 (PDT)
Date:   Thu, 5 Oct 2017 17:47:36 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC] Reporting index properties
In-Reply-To: <xmqqzi955cnx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.10.1710051745060.812@alexmv-linux>
References: <alpine.DEB.2.10.1710051625430.812@alexmv-linux> <xmqqzi955cnx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 6 Oct 2017, Junio C Hamano wrote:
> > Do folks have feelings about surfacing this information, and where such
> > logic should live?
> 
> Probably one of the t/helper/test-dump-*.c programs, if we already
> do not have one.

The goal would be to be able to extract this information from
repositories, with a standard git install.  That directory only
contains developer tools, which aren't part of the install, no?

 - Alex
