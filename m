Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B5C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 21:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52732613D7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 21:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhEZVJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhEZVJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 17:09:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8EC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 14:07:59 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j184so2557079qkd.6
        for <git@vger.kernel.org>; Wed, 26 May 2021 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=+SblLhUkBsD9u1PVgcT539Xdss90H8sDUmhp4KREkas=;
        b=QuIc9G/9FDrQLxibQvE/EN5gSCCAcerc3D17zKymRZM8omAfzlTDlbV4Z4ERaOgVRu
         BDxpcPcb7wqwgE12X86MPS67GTNW/pwxybtwEAcAdVlEIrx+rvIadJ8u8/wD067do6aF
         kaqQb6FNPZVt7swgqsuEF4lckzlM+M2M7emh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=+SblLhUkBsD9u1PVgcT539Xdss90H8sDUmhp4KREkas=;
        b=poexuB9PT3JRwxsb2ue0XzjstTlKAiNc8aNqHACnPxAC2Ez1uZd80vKos3vMIBUFAE
         yts/zjtNT76Bf/1dukli2zzaDk13tEAeAQ7uP8RS74svKAWO/72HfkhZarWqMC3RfoKu
         zIgkct6xo40qRDaIll7Bw+bnLju58Hr8goUbMC+2P9q3050VLemRr7YdvaBfEOKQTRtI
         1vFlqT+L9F3glDa5TdRhRugQvoOP+SuSKNAlu8s8b3CBQzVsJca9JzWoDVJrYKj3V4P0
         NHax8zrnr1fSLmCDc4S9tbuQENdBt/zaEZlwgKIu8Cht8oAz4EXMzsHpdots9YIGZnFu
         xj+A==
X-Gm-Message-State: AOAM533W6v7+0VQHr4m8BIDuh1GH7nmv2mlQbqKzVoWS3HF/PjNk8LNu
        uqv7TKUX/8J4TV9Ug281Fv3X+p+VbRl1QyeL6mg=
X-Google-Smtp-Source: ABdhPJz25IJW73QDFJOnHayzuwmNI4nCcAGPZLnMJ5zDcXbl+iEZOLJX8Kh6wPCClpf7Gq3dwAXNpQ==
X-Received: by 2002:ae9:f105:: with SMTP id k5mr67727qkg.63.1622063278587;
        Wed, 26 May 2021 14:07:58 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id x10sm44888qkh.124.2021.05.26.14.07.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 14:07:58 -0700 (PDT)
Date:   Wed, 26 May 2021 17:07:56 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: patatt: end-to-end developer attestation for patches
Message-ID: <20210526210756.ue5lfcyexz2dwfa6@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

I would like to introduce patatt, which is a small tool/library for end-to-end
cryptographic attestation of patches sent via email. It aims to solve the
problem of needing to trust mail gateways, mailing list archives, or any other
kind of inherently untrustworthy infrastructure.

# How it works

Patatt works by adding a separate header containing a cryptographic signature
attesting the body of the message, plus the headers relevant to git commit
operations ("From" and "Subject", specifically). The hashing and signing is
done using a slightly adapted version of the widely used DKIM standard.

Since the signature is placed into its own email header, it will stay
completely out of the way of any existing tools operating on patches (git-am,
patchwork, stgit, quilt, etc), so patches carrying attestation will not break
any of the existing workflows but will be picked up and checked using tools
like b4 (starting with version 0.7).

For more technical details, please see:
https://pypi.org/project/patatt/#basic-concepts

You can also watch the presentation I made to the OpenSSF developer
attestation WG:
https://www.youtube.com/watch?v=no6r1iUqY1A

# How to start signing your patches

It is very easy to start signing all your patches, especially if you use
git-send-email.

1. install patatt (e.g. with "pip install --user patatt")
2. tell it which PGP key to use, or generate a new ed25519 key
3. add a sendemail-validate hook

See instructions here for full details:
https://pypi.org/project/patatt/#getting-started-as-contributor

# How to start verifying attestation as a project maintainer

The only tool currently implementing patatt attestation is b4, and if you're
using a workflow that relies on patches sent to mailing lists, I invite you to
try b4 out for your needs. B4 can either work with remote public-inbox
repositories, or fully local mailboxes. To install b4, you can use:

pip install --user b4

## Maintaining a project keyring

Patatt/B4 can use your global GnuPG keyring for validation, or a separate
keyring maintained as part of the project's git repository. It can be kept
either in the main development branch, in a dedicated repository ref, or in a
wholly external repository used just for the keyring.

Please see this here for the concepts and general overview of in-git
contributor keyrings:
https://pypi.org/project/patatt/#in-git-pubkey-management

Here is an example of b4 retrieving an attested patch series:

    $ b4 am -o/tmp 20210521184811.617875-1-konstantin@linuxfoundation.org
    Looking up https://lore.kernel.org/r/20210521184811.617875-1-konstantin%40linuxfoundation.org
    Analyzing 3 messages in the thread
    Checking attestation on all messages, may take a moment...
    ---
      ✓ [PATCH 1/3] Sign Message-Id header if present
      ✓ [PATCH 2/3] Make header order deterministic
      ✓ [PATCH 3/3] Release as 0.4.0
      ---
      ✓ Signed: openpgp/konstantin@linuxfoundation.org
      ✓ Signed: DKIM/linuxfoundation.org
    ---
    Total patches: 3
    ---
     Link: https://lore.kernel.org/r/20210521184811.617875-1-konstantin@linuxfoundation.org
     Base: not found
           git am /tmp/20210521_konstantin_sign_message_id_header_if_present.mbx

As you can see, b4 will validate both the DKIM signature, and the
X-Developer-Signature header when it finds it.

# Questions welcome

This is still considered an experimental feature, so I would be happy to
receive feedback about the concepts and implementation.

Best regards,
-Konstantin
