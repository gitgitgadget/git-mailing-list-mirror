Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CB720248
	for <e@80x24.org>; Fri, 12 Apr 2019 03:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDLDVy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 23:21:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46191 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDLDVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 23:21:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so9911604wrw.13
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 20:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CkfSHljFaQoohzcqDDe6UquXEKeFErgbrvA4Ro9D7PM=;
        b=I7dTIoc94cd5fqAdAbXrWh+mR+ZDTOB3CTI3QkaV4NiWWfjpz/CenPd4PN9CJKTffX
         bGNnHliJt1ta+mHc4j19b+Zr9/D/3iMi4MZiWPznGOkWjhV4T4RzA06rPp5bJkQkziBa
         lCr8mVUhDjtKIDCtx5BxUm3Fe1aqN861+vzLOAkCWeVARZ81buIt/45rb/V3gxaGyi+l
         CdfT8xtu4ZH6XdzKDzoypnOznIktNBk+PqkOvkfi6CVrBkxb0AstG8H0XSLuRquJCKLL
         ihmsSEsw/HMCdPVfue2T/5ZNFLW3opp86VIdnQz7Kgf4Nws4UJF6C2myqvoZOSQgCVNq
         7cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CkfSHljFaQoohzcqDDe6UquXEKeFErgbrvA4Ro9D7PM=;
        b=a1zphck5dr/UcXN6mVv7x9yMbCp24uTqlXP/IdcNOCZt4uAPy5POUPYMlbw22xE3vj
         ghOciPKnO9jHqjryDbVPiZusKdiufVGrGX7ZBcaRXMXr/BHyh6zmsV1yUS7e0KiBCjTQ
         TVp3Fqpt/7MUAjSBPIOSyfqmgw7PbcrpIWKLtTGGtQo+3WYeoymWO2nZ02buEjcUqVRj
         Hoi9Tb6Gqa3aLgyR4kEdkmTd/vIhDo6jFnfpbrZLpUuxIttYFAJmF7f1pWAQjZVXvVZi
         E+KT6+3ZTZRcvNoDdPxlYbUT1+wIZibMh4qPAi+YnKv/tJlueiscFJ51gzcSV8l8PtqD
         tdow==
X-Gm-Message-State: APjAAAWIExZsbJBx1j2L3kaDMebHQLE3IHfCgx08olvdnXqjkJgGvLP7
        Lrp/cRE/KKUSy2Qb13d7XDJOIEruPD8=
X-Google-Smtp-Source: APXvYqzBTzlmWuYUDiBM/WXqxTZK6SYamIVqT3bPbrYnzHXkTBIPszk1dftmNC8fPfuY/v42y6wKbg==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr16227565wrx.76.1555039312079;
        Thu, 11 Apr 2019 20:21:52 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r16sm29277445wrx.37.2019.04.11.20.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 20:21:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
        <20190402230345.GA5004@dev-l>
        <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
        <20190403213318.GA14137@dev-l>
        <20190404020226.GG4409@sigill.intra.peff.net>
        <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
        <20190404122722.GA23024@sigill.intra.peff.net>
        <20190411184031.GA20265@esm>
Date:   Fri, 12 Apr 2019 12:21:51 +0900
In-Reply-To: <20190411184031.GA20265@esm> ("Eckhard =?utf-8?Q?Maa=C3=9F=22?=
 =?utf-8?Q?'s?= message of "Thu,
        11 Apr 2019 20:40:31 +0200")
Message-ID: <xmqqa7gvzz5c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eckhard Maaß" <eckhard.s.maass@googlemail.com> writes:

> ... Wouldn't it be the more sane approach here to fail, when the old
> tag is (or as in your example will) still be referenced?

That is unworkable in the distributed world.  There may be somebody
else who has a copy of the old tag and you may end up getting that
later.
