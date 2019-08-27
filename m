Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493AE1F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 08:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfH0Ind (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 04:43:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45776 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfH0Ind (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 04:43:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id o11so5170536lfb.12
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Pap+vAMkXYMURYH/fIZsbgTebkaHRu8kE/cMk4ODd6I=;
        b=pkan7ejxenfOXIZ5bUACSS2AGhr1PsVVEhPmMkNFtRiGEwCLTLUclHzb902Pt3pDMH
         mkauU97dVv2q9cLtk3C1V4kYOeqdCWV+olmjWB5WtvqJOUZho4GQPwd7Xlx+EdEU70h7
         pqgbZP1GCnX/H5fDcrDguZFlGNE3xCKnhbVuQgmAHWs/MbX8jv49YdbpiV60AFFPcXhe
         iZCy31AjeKjlenxfE+7XleaJdJYjaFgrZv2uqcP9rJAD44U54vOUQ1yflSe8uSC63HTa
         ceRHxVSfL3RIZH4HWZmB+e2zNyKYK6xvY/Mx+LdKlP2dXFT1YeXhawS6Y6ShwkWJs6AH
         L8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Pap+vAMkXYMURYH/fIZsbgTebkaHRu8kE/cMk4ODd6I=;
        b=afFLjXyESE4enc6UY+XcXbTelsIgdfK69wVGx3mBOEPK9hjRoUDCdGoKqDnYpMt11r
         rKYT6VG4leB0vqtTNsswyWrs4HqHxT5iqtbfDYsij2V2/0WIlL2FHO9ekqgdqoC48lXd
         9Nz1+arPGkfweyFlcJnREUo7IQKqs34fvsISUvGSBN168/Q7LPKrru+Cq3zC9jRBdfyn
         0uR44fj6EipRWHfvBHmBCcGn8OIHoV9KsCKkSJRgwOjmXmq2r3eVDMRnM+8Mj7GNxCyH
         33W1+i9v2t/BqgfrOGFfmgMFC0Ssjve3s4WAQRrE03+2a94wR1TWmjGJUdP+fanOZtJx
         ZbKQ==
X-Gm-Message-State: APjAAAWoT8MfLlmDwHN7bGaVezmBIH5X3Qiu3VxnpEZrVL7iW/Odap8j
        IRWDXodJm+Le28RJmy+VLyZaqhFH
X-Google-Smtp-Source: APXvYqxjTQUx5fHpp49RNmDtp4Ke7KM8J9vfX7XO7ZcoB1KTFqhwkxIq64iuDCUUFIdQemXtPZrE2Q==
X-Received: by 2002:ac2:42c3:: with SMTP id n3mr8002021lfl.117.1566895411104;
        Tue, 27 Aug 2019 01:43:31 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l25sm2510602lfc.20.2019.08.27.01.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 01:43:30 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it elsewhere
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
        <20190826235226.15386-1-newren@gmail.com>
        <20190827070324.7l2cpc3dlnithbm6@whir>
Date:   Tue, 27 Aug 2019 11:43:28 +0300
In-Reply-To: <20190827070324.7l2cpc3dlnithbm6@whir> (Eric Wong's message of
        "Tue, 27 Aug 2019 07:03:24 +0000")
Message-ID: <87v9ujc827.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:


[...]

> AFAIK, filter-branch is not causing support headaches for any
> git developers today.  With so many commands in git, it's
> unlikely newbies will ever get around to discover it :)
> So I think think we should be in any rush to remove it.

Nah, discovering it is simple. Just Google for "git change author". That
eventually leads to a script that uses "git filter-branch --env-filter"
to get the job done, and I'm afraid it is spread all over the world.

See, e.g.:

https://help.github.com/en/articles/changing-author-info

> But I agree that filter-branch isn't useful and certainly
> shouldn't be encouraged/promoted.

Well, is there more suitable way to change author for a (large) set of
commits then?

> Yet there's probably still users which ARE happy with it, that
> will never hit the edge cases and problems it poses; and will
> never read release notes.  And said users are probably getting
> git from a slow-moving distro, so it'd be a disservice to them
> if they lost a tool they depend on without any warning.

Personally, I'm far from happy with it, but I have no clue how to
substitute it in the job above. Anybody?

-- Sergey
