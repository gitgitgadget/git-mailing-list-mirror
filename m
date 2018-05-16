Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C7A1F406
	for <e@80x24.org>; Wed, 16 May 2018 16:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbeEPQbo (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 12:31:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37051 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeEPQbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 12:31:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id l1-v6so3249945wmb.2
        for <git@vger.kernel.org>; Wed, 16 May 2018 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLak7s0+iB8eVAAAt7PJHNXCQodlaiBbOttGXY/xdyk=;
        b=bBvagqLtXbNkqekvu9pndqyvmMwYsaenyI5KXCQ7eoaNiZ09tmXZmyy3R2CsvJlWOP
         4C74fVSVDt0Zs7ETUuL5xcDo9PLHWjRtO6ZNjlfh6uk/7nvqmxfF9PhGpKEG4D2PNvEO
         I6HuEudU1xvGd/1aZ0Udji5FudXpKv2Ekn6fH9V5fKCxXb60GOkS2Sc6EqU5Iwl3Bac9
         u9JMJXZiIz0QiYmzCAlg7BVD0I5bIPOEzdQdKhxVqcIKV349FD6q2bY2AGj7R04hdqiR
         zuKPI8o1lbWpxZu/IIeQB03+MtdqbZMeICupdvKRtY0nsrDjdJuyu+QVorg+JsyLg1VH
         KKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLak7s0+iB8eVAAAt7PJHNXCQodlaiBbOttGXY/xdyk=;
        b=YouxNsZwwbvir5Jd3dZkQ4gMtZ5w4ZOHngzQwpRKFj73bE21mFVHkYHqyOwdLoFDwH
         5eJVeRBgTHSG+/gOFP1RDX00pxs7+P1F7H519W+XWgxMI/zR2Daa+4ZhDW0jwD3tA62a
         dyt6X5+KFa0ZYkmpfdLAjCL7xp9PH/FtXwsGS710qxnov6BPIJOnpyu3JRZvDfNtxu1m
         FhgSdc3admURxn4A1nJTPWsjlgCHQtabJ1Ix3aoacK2tvuKZDUvCrryOho2CDcM851jL
         Iipuzux8GCaeO25slO2REuB5It97GIeymKwF+mpdaDNBfpJ1YSHOf4J2R3fiO37P3JpZ
         /eMg==
X-Gm-Message-State: ALKqPweCeyvKaW/pmsmzIJGo9tKJMamIh0Q+A4r8EgUWihpFmsRY4vJ+
        bg7cEG4e4DMtBTGsOHzhemcjgy+vZyg=
X-Google-Smtp-Source: AB8JxZocLsSjR02uKNiJTMhWDePZEt1l0XuDjBHq0FmRLEQaW0IFklUOow/Vt4wisjjll73DI4TVEg==
X-Received: by 2002:a1c:ee95:: with SMTP id j21-v6mr1153943wmi.16.1526488302331;
        Wed, 16 May 2018 09:31:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id s14-v6sm3931772wmb.5.2018.05.16.09.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 May 2018 09:31:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/3] unpack_trees_options: free messages when done
Date:   Wed, 16 May 2018 18:30:57 +0200
Message-Id: <cover.1526488122.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.583.g9a75a153ac
In-Reply-To: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 16 May 2018 at 16:32, Elijah Newren <newren@gmail.com> wrote:
> On Sat, Apr 28, 2018 at 4:32 AM, Martin Ågren <martin.agren@gmail.com> wrote:
>> As you noted elsewhere [1], Ben is also working in this area. I'd be
>> perfectly happy to sit on these patches until both of your contributions
>> come through to master.
>>
>> [1] https://public-inbox.org/git/CABPp-BFh=gL6RnbST2bgtynkij1Z5TMgAr1Via5_VyteF5eBMg@mail.gmail.com/
>
> Instead of waiting for these to come through to master, could you just
> submit based on the top of bp/merge-rename-config? 

Sure, here goes. This is based on bp/merge-rename-config, gets rid of
all leaks of memory allocated in `setup_unpack_trees_porcelain()` and
cuts the number of leaks in the test-suite (i.e., the subset of the 
tests that I run) by around 10%.

Martin

Elijah Newren (1):
  merge-recursive: provide pair of `unpack_trees_{start,finish}()`

Martin Ågren (2):
  merge: setup `opts` later in `checkout_fast_forward()`
  unpack_trees_options: free messages when done

 unpack-trees.h     |  5 +++++
 builtin/checkout.c |  1 +
 merge-recursive.c  | 30 ++++++++++++++++--------------
 merge.c            | 37 +++++++++++++++++++++----------------
 unpack-trees.c     | 11 +++++++++++
 5 files changed, 54 insertions(+), 30 deletions(-)

-- 
2.17.0.583.g9a75a153ac

