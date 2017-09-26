Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19B5202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 02:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935403AbdIZCQu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 22:16:50 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33092 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934681AbdIZCQt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 22:16:49 -0400
Received: by mail-pg0-f66.google.com with SMTP id i130so5890255pgc.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Frh9eN03DKtyD04iPnh+YrBm5mJCaV9XkWSa1CmP80k=;
        b=Uw2/gyKkikJBni16ozSFBhvlWcOEBRTK0vveltHG6Trrx5mPwBLC1tGdkSsBTuKJ1T
         VXUEq5/QaJBFe/wohSCvqC1crCr52tAs4Ms0vD+irOkl7l+TFRCnMvNRxxJ5d4eL9p25
         Xn0kY9Ax6K6sFpdeCOdqaCK/FW5ss7RDuCoBconQhJ6Kp+9NykqVk8obdFcoZsVJxeE6
         w1b0v84FGRSRoTALoqb7DeVFB6nG97NJ7LwR9da0QhW8L4uE5n6tCyhrDNyVyN8TJdt0
         ysDYE8QoIMrk4NAzb0EczYn/6Qi8O1mTeaW5lNqo97OqLI+luuOfyOcrNJtxFG+Aveco
         3+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Frh9eN03DKtyD04iPnh+YrBm5mJCaV9XkWSa1CmP80k=;
        b=nJDZCOeBcvNLO4Zfs8kpfPKEecO/b9LPm3B565IT7Na9n+AU+MxdJn5Z/cqp7E2udT
         gf5jI/fopX4XkzAz1xFn4uN59NwuQ2oMJJ74gKa/06bUJc16kvrtlP5Q57H5RW4WNVZ9
         AmUfkXzgpAsA3lxIr+WpNGo8H+Z/M/fjhKqhRhpKO2DPknuJoy3TEpq35JAzqpcD+nlS
         uk8AtK11AawXC859Rk5dGqYv+sq0plOitecKIIxmal2nImG3vnSvbI8Tzx7C+XL5ncM0
         P5ldiROSU8XrrryEzBJLfPP7UTiSJuXhJD+GtqoYeSeWxWoO5yHN/4el6vpNllxGxn7K
         w3oA==
X-Gm-Message-State: AHPjjUjgUBRy7tAYWgSQ74skR5qCofqBpqLR6OnaaNO9il9Oezy4WspK
        B9T9cquTI0Ru5MfWOHVMPwAO692y
X-Google-Smtp-Source: AOwi7QCj9erQ9tsiBmFyIzdg/LavnWUZF2MC+g6bkiBmhCT1uV2NOqTzceniCJP5WQqBswoQ7Qr5wA==
X-Received: by 10.84.216.24 with SMTP id m24mr9311928pli.205.1506392208773;
        Mon, 25 Sep 2017 19:16:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id f13sm14433667pfj.127.2017.09.25.19.16.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 19:16:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: -X theirs does not resolve symlink conflict  Was: BUG: merge -s theirs  is not in effect
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
        <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
        <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
        <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
        <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
        <xmqqing6cje7.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 26 Sep 2017 11:16:46 +0900
In-Reply-To: <xmqqing6cje7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 26 Sep 2017 10:56:32 +0900")
Message-ID: <xmqqefqucigh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not recall people talking about symbolic links but the case of
> binary files has been on the wishlist for a long time, and I do not
> know of anybody who is working on (or is planning to work on) it.

Ah, I misremembered.

We've addressed the "binary files" case back in 2012 with a944af1d
("merge: teach -Xours/-Xtheirs to binary ll-merge driver",
2012-09-08).  I do not know offhand if it is just as easy to plumb
the MERGE_FAVOR_{OURS,THEIRS} bits thru the symbolic link codepath,
like that patch did to the binary file codepath.

