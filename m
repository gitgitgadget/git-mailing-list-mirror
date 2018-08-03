Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17FA01F597
	for <e@80x24.org>; Fri,  3 Aug 2018 16:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeHCSVR (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:21:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41183 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeHCSVR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:21:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so5923155wrr.8
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=U0II+I+oc+GlhZID393EPbeII2UNi8S83eTS5+ux4cY=;
        b=BW+R/WgJ05lHnpquFRKkKQ01XNBICL2LpsMypXlOA0IKNrJr3TQQouRmlsa41n8vvQ
         +fNgU3Kpyl8bToY0Za83lmXyDwcU90fVaQb4RsMDg1s2eqzAz/k6KUH7fjbXRleQ0ke6
         oRWdS4hEc8cnRnQ0VGleVaoDqAo0zXO3hbsZZnAHY/XVYYfcMqwQLWKGkbUNOgY+kRg7
         BnZqgmpLlHWb5cyABSCU4RdXnOte5FS5G+jx80zOiDm4H4qF5CCTN4PGfAMQPHmmGNaX
         aa9I9kOdEB3+BaxbiMyl8NH2XlAnGxF0hLhkBTbebOf103vH6AoNdBzY82+CW1T6dO1J
         MthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=U0II+I+oc+GlhZID393EPbeII2UNi8S83eTS5+ux4cY=;
        b=ciMd5Q35rcl0cXEiVIawlKQM0Nf9f9tTFsxMk2wT2yt+vF3JDb9LGCxFA5Bl2xicFK
         QR+NoVajdCS3IUzt8y7YERUi021vCU78AQ/J1xJeutWF+jog2Ya/ZU9mZfMWoopeBH+o
         AnzVNPOD/SspJ7tzJOYRgi5ZNoJYmQ7A3dcYbehAkdN/QXshu36mAOpvoI7Ih3uoShde
         HCbx96yPHpB3xytndxUsTdA1AwlHF431qeOzzo9sWl1xUx+xKPmMJb77rsW7iMroaU/O
         XrQGFNcMX262vanwXX5SPsExZJz1Fh3la2TjdKZx8KPegW6ifqgKEP7rndPF6a+Z2tSj
         qSLg==
X-Gm-Message-State: AOUpUlFntR7QzWFS0/DmqLML5mkSPpPR2oKRN/nkuA4U+OxjCppK6iVL
        ZajDeLJIxcS0lmBtgDBVjHs=
X-Google-Smtp-Source: AAOMgpcKogbhT/MC+7K3jOJxd31GWLCpt0LzyeSFakMaZvYAnLxXdzrHieeXX99WrFNAxpTpE3xJJw==
X-Received: by 2002:adf:e542:: with SMTP id z2-v6mr3095300wrm.40.1533313455116;
        Fri, 03 Aug 2018 09:24:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u7-v6sm2670021wrq.13.2018.08.03.09.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 09:24:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH v2 06/12] submodule--helper: add a '--stage' option to the 'config' sub command
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-7-ao2@ao2.it>
        <xmqqd0v01trp.fsf@gitster-ct.c.googlers.com>
        <20180803130334.3979eedb0733c609815e9fd5@ao2.it>
Date:   Fri, 03 Aug 2018 09:24:14 -0700
In-Reply-To: <20180803130334.3979eedb0733c609815e9fd5@ao2.it> (Antonio
        Ospite's message of "Fri, 3 Aug 2018 13:03:34 +0200")
Message-ID: <xmqqbmajzadt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> The rationale behind the change is to close the circle started with 04
> and 05 and stop referring to .gitmodules explicitly by file path in git
> commands. The change is not strictly needed for the series, it's for
> consistency sake.

Sorry, but I am still not quite sure what consistency you are
referring to.

I also do not see a reason why we want to stop referring to
.gitmodules explicitly by name.  We do not hide the fact that
in-tree .gitignore and .gitattributes files are used to hold the
metainformation about the project tree, saying that it is an
implementation detail.  Is there a good reason why .gitmodules
should be different from these other two?
