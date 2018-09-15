Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE881F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeIOVTx (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:19:53 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35116 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeIOVTx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:19:53 -0400
Received: by mail-wm1-f41.google.com with SMTP id o18-v6so5013482wmc.0
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f442xCZ/X4ysmrl60AYoxJoIDkRM+Qb7fp+KCgUhM3I=;
        b=NE6bVJWKpDJaO5g6Ti5//3D6Ee/5Kjc49mZg54NMNtiWRh/8ZViEWYqw//GAEAgfYt
         WOND4hvMmuEbzvZOTN3j/QeuY6Uvgyz24wYfxN+ga8yS/dVLxf7H06HP2hSskdDh2OAG
         /gaMuCAwXJ7HvCwYO1pN6fU8FpZWiSXE//tPuUZHauxGWIPsoafCPXxGXm5YgQt5+HDV
         4Cu//4oGqxCrXefvYQ4vqYLUKUKigbuETnNbAOodq3wyqgdG+IjUPXeqcN2EUqShT3+9
         U5CyfzSJgbLYF/5nsLh+PwEu4Hc6DPLHxIAGNDSnYgKJrnLiIA9zNaj21Tb6ANavy3E2
         eang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f442xCZ/X4ysmrl60AYoxJoIDkRM+Qb7fp+KCgUhM3I=;
        b=kx9d+zWlMQpz27N3hUtfqHj6vOieuOYaarpa2ZltkBYjq7WS89x7Q+fT0lcHTu/Cqe
         KS3ywCuXLOxWRv8ca2t3VSX5m4AzR9iFXmQUBfYADSVUjPlZHUOc4pX4GnKj+Y5/5lPr
         J3jXGvdwHu8AlS7edzXmVlFjgQcwSmG1e0WHT0ltgsmINAWz2MpKPiTJR3LYV6JFU9TS
         GKwfQA95eXOXO44cJ0cHrlkLumCwnXKv7JxTmsAUolHLy/cyJWJwSkE5/RFJIJGr3ZUM
         6w/d6s0P5tVYGq2g0CnLK202/drA366WJHZmmRjDrZCW3ArYDuC5TFOl3wyFR4p0ctD1
         9Wbg==
X-Gm-Message-State: APzg51BhpBWBtLYbqRmKtTeuKY4tY82ReNVaT7k4mRf04WJB4zsyVk7L
        Speqppk/yl7vtgjDmBzyFlvq94lE
X-Google-Smtp-Source: ANB0VdZYx+8AyXhxqbpOrXAxMG2o/coNNutL7apZjO/s6yfuqzBiaT9J/nbPmJkpAVi46jBSIu8NJA==
X-Received: by 2002:a1c:e286:: with SMTP id z128-v6mr5693231wmg.30.1537027226074;
        Sat, 15 Sep 2018 09:00:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l18-v6sm11242846wru.75.2018.09.15.09.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 09:00:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: garbage collection following a "git remote rm"?
References: <alpine.LFD.2.21.1809151027350.17253@localhost.localdomain>
Date:   Sat, 15 Sep 2018 09:00:24 -0700
In-Reply-To: <alpine.LFD.2.21.1809151027350.17253@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 15 Sep 2018 10:31:02 -0400
        (EDT)")
Message-ID: <xmqqh8iqagyv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   is there a command (git fsck?) that would display exclusively
> objects in the object store corresponding to objects that are suddenly
> unreferenced due to the removal of a remote?

fsck gives you dangling ones (and can be told to give you
unreachable ones, too) but the list will be more like "these are
unreachable, period".  It won't be like "these are the ones that
recently became unreacable, and I am not listing ones that were
unreachable already in N hours ago".

