Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74240201CF
	for <e@80x24.org>; Wed, 17 May 2017 11:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbdEQLii (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 07:38:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32817 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdEQLih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 07:38:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id y10so2901960wmh.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTW4BNEItWj/m4TzXdH4EJQ2pQAKEoHsUAV+NCq44II=;
        b=Byx9EPUXh/inYVdDD0CUjkHGfohxggIZy/RqcvuE8pE+To8V0OUKqzw6+6pPElBbOZ
         U0MJee1Atjwiwb4daIv5ez82UN8stoYaymjI2Xucc5j7TPPosOyDLZzsgmjpac8Evai/
         LOAnB63aGZVYyiyYs/WXVE7ScTnoK8wiEGzcujNRzUORINsUam9OnS2xuGzGgLSFdraT
         rzPyu5zy9sWonxo6gmjtI9bYR2f48Kc46CLdKBCMtUBVXHKUDJ0dSeKEfhbn6Nu/aKlG
         645WEJjOE8JljYGLPdc2ENoFyIlU8sqGRCZFxQ6Km+qIVSiziFXttwTPHnIHt4Cskhcq
         j/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTW4BNEItWj/m4TzXdH4EJQ2pQAKEoHsUAV+NCq44II=;
        b=MNxd7drgVj2R9aP502T8LgPPN8Pl6qpzKjpwtNSJcVN1ucZ2zFA5945Ty7/X8oO9i/
         EafuXkdK8BN1LxC2GJfFaK12Al8GClrP9FnAdskSIKgbiHlKF4YGMJktIJn8C38/gjFV
         P4/wRn4VfaCPgQ+7pr2mnxAIMg5IvbXYLVN/1hIGQgjHFQlnrNJ3a0HytnOr8yQGx8cj
         oZMfxKy0U8Ulfel/quuP3Pa+H0UTaqMUsxh5h5cBvlMoP776ykJDYrVVEwcnDVSVtsQy
         D7Y5Jcp4QyqKmsVPxPeHoxgVx3/UbkHMTp4kXAEftkDH8HOM2t77A9fcWrGEd5TCjdIW
         GkLA==
X-Gm-Message-State: AODbwcAYbXits8x1ZVlk03QFzdZUDAkyPyALaI1pK/IqBekYjgt8ud4Y
        W7ybtE/7XukYLg==
X-Received: by 10.28.154.86 with SMTP id c83mr10808946wme.94.1495021116311;
        Wed, 17 May 2017 04:38:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm12502473wmd.1.2017.05.17.04.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 May 2017 04:38:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC 0/3] Use sha1collisiondetection as a submodule
Date:   Wed, 17 May 2017 11:38:21 +0000
Message-Id: <20170517113824.31700-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com>
References: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 9:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, May 17, 2017 at 7:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> From: Marc Stevens <marc@marc-stevens.nl>
>>>
>>> Some big-endian platforms define _BIG_ENDIAN, which the test at the
>>> beginning of file has missed.  Also, when the input is not aligned,
>>> some platforms trigger SIGBUS.
>>>
>>> This change corresponds to 33a694a9 ("Fix issues with a big endian
>>> platform", 2017-05-15) in the history of the upstream repository
>>> https://github.com/cr-marcstevens/sha1collisiondetection
>>
>> Then why not just update sha1dc from upstream instead of
>> cherry-picking one patch from them?
>
> See the original message upthread.  I did the cherry-pick simply
> because that was what Marc instructed the patch recipient to do ;-).

Since that patch is now in Marc's upstream code we can just update to
that.

While we're at it let's see if Marc will take a patch so that we can
use his code as-is with some Makefile trickery of our own, instead of
having to solve merge conflicts each time we update from him. I'll
submit a pull request for that shortly.

And since if and when that pull request gets accepted we're at the
point of being able to use the upstream code as-is & don't need to
locally modify it, we can just use a submodule to track it.

Ævar Arnfjörð Bjarmason (3):
  sha1dc: update from my fork of upstream
  sha1dc: use sha1collisiondetection as a submodule
  sha1dc: remove our old copy of the sha1dc code

 .gitmodules            |    4 +
 Makefile               |   13 +-
 hash.h                 |    2 +-
 sha1collisiondetection |    1 +
 sha1dc/LICENSE.txt     |   30 -
 sha1dc/sha1.c          | 1809 ------------------------------------------------
 sha1dc/sha1.h          |  122 ----
 sha1dc/ubc_check.c     |  363 ----------
 sha1dc/ubc_check.h     |   44 --
 sha1dc_git.c           |   19 +
 sha1dc_git.h           |   14 +
 11 files changed, 49 insertions(+), 2372 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection
 delete mode 100644 sha1dc/LICENSE.txt
 delete mode 100644 sha1dc/sha1.c
 delete mode 100644 sha1dc/sha1.h
 delete mode 100644 sha1dc/ubc_check.c
 delete mode 100644 sha1dc/ubc_check.h
 create mode 100644 sha1dc_git.c
 create mode 100644 sha1dc_git.h

-- 
2.13.0.303.g4ebf302169

