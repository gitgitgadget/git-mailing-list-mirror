Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2EBC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 20:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDLUj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 16:39:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351179C
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 13:39:54 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id CE95CE0004;
        Wed, 12 Apr 2023 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681331993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TY0EWLWjguDAvIXbQz/p1a2WH412+tZeQz8fEB0gJjQ=;
        b=FimBhvlaMwFlzHV6wvciW9wmoBs/rhr1UjoY0Kye5Uid0tjyz2G1sSprZGPi335BK85Z6g
        s3JoquoqTNa7KTxiN2XBe+RaIXVU0P0JAywWsxjPrpXvJpfLk6bLIey12rt6q7PNtjw2uI
        OEkXZmr4W3cjskqWG+g4br7nHKqiJHwtgmjdkUh6v4cVaWxs9XlIuCH46YPK76e+bI46Fw
        op2CzspWngESKe+Z5v4Wpg98m2o8kcU2uXi19PwDwEkk2t+ndcOuwnWG1EGw2AfVbJT3HR
        u+NF1L/Q3sE9bKNo5QZR3eOQIPz1psIQf2FtVPlWe3zzOgnBn35FAegZ+hH8Qg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Apr 2023 22:39:51 +0200
Message-Id: <CRV2G5WD329G.3ATH750WRKPIF@ringo>
Cc:     <git@vger.kernel.org>, "Phillip Wood" <phillip.wood123@gmail.com>,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH v2] send-email: export patch counters in validate
 environment
From:   "Robin Jarry" <robin@jarry.cc>
To:     "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc/0.14.0-152-g2abc6042d510-dirty
References: <20230411114723.89029-1-robin@jarry.cc>
 <20230412095434.140754-1-robin@jarry.cc> <xmqqfs957zs4.fsf@gitster.g>
 <CRUZR9IO75B2.3DTTR2N12SQRL@ringo> <xmqq7cug96qv.fsf@gitster.g>
In-Reply-To: <xmqq7cug96qv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Apr 12, 2023 at 22:37:
> You are the user who just ran format-patch to prepare sending out
> the patches, and you are checking your patches.  Wouldn't you have
> the blobs already anyways?

But these will be new blobs since we are applying the patches from files
into another detached branch.

> I'd rather not to see anybody go in that direction.  "set -e" is a
> poor substitute for a properly designed error handling.  Between
>
> 	set -e
> 	command A
> 	command B
> 	command C
>
> and
>
> 	command A &&
> 	command B &&
> 	command C || die message
>
> the former can only say "command B" failed because command B was run
> under some condition that it did not like, but that is too low level
> an error that is close to the implementation.  As opposed to the
> latter that can talk about what it _means_ that any one of these
> three commands did not succeed in the end-user's terms.

Ok.
