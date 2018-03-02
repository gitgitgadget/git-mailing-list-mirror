Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC3D1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427672AbeCBRPv (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:15:51 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36288 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424699AbeCBRPr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:15:47 -0500
Received: by mail-wm0-f66.google.com with SMTP id 188so4348172wme.1
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Cnx2gu68KbGe8WjXoAgX0l76oSqBGLnV63zQqkhvBiU=;
        b=c64eNGR+EeTzXvUQKK7Hl5fzEoKZltD7kIb8RbJXtdivv360cSG1w90PNsvv48rmrm
         63worjExHfiQ1pxXV76hPObK6YGSQaVklx4JhTQt8QHcHHEqaI7vIWsddQJLnm1OWRCX
         ULqJtMZ9zqASjPYtWHZbo780KtjK5w7weMzIVMDzcXd8wfXA+mPw7aQn0IhUaNhO8qJP
         TyPoMBnP0f3TbxjL6+q+GSokGj6ge6sL6yEPSexOOvzKwnhklh5I125d3ZvCv4f1w0Ew
         ohvS/K8hSOyqhQBBulwUGSNKbDKVhZm16VF+vAcHJuTEojYCrI5GBA4hjTEPFCO+rFsE
         wx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Cnx2gu68KbGe8WjXoAgX0l76oSqBGLnV63zQqkhvBiU=;
        b=r8oJE4vIJQ1FQ8tZFiEOr9Al0R70IYxbjVvHPfLA8ozaiWVIHXItkLTstFphjhFZyS
         /lB6prGD+R4E9qGBrmJGBpTnHDdL9SXnNRcFjrwmmcck13BBHVZnSadE+bI3DqmgsZHB
         HSs9/cK0p3rUd3UvZyufv7kYS5IukYTlW0EQQl2MU0slj70J11Vfl9CyoY7zOcmhy993
         Uzc++VU5ecll9ciJJCn+AIDIJDc7XYcUYc8jPTiotST+wSXsbDfXhaYAjBV5mXikvMlv
         yI44iovoV0qIrerFP6s9oUzheUOhINLAY7HzbDr2QInM1T8hq4DQB8RGnvUT9rqRcT5i
         4tPQ==
X-Gm-Message-State: AElRT7HuuYcfo2tJqfa+nx7caFZLha9ISNwYqKcoVZjFb9cmEI0HTzWN
        GgU6Tsp4a7UJDkdhfn3dM6Y=
X-Google-Smtp-Source: AG47ELuuNHnz26UChvuA5H/RIZc939K85svl7jm3LNEGlSh+k0iA3kT+V3m4qRYi3IX0v8LBYlf2zw==
X-Received: by 10.28.74.199 with SMTP id n68mr2055773wmi.83.1520010945770;
        Fri, 02 Mar 2018 09:15:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g78sm2893121wmc.31.2018.03.02.09.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 09:15:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
        <20180302070434.GG238112@aiede.svl.corp.google.com>
        <20180302104608.GB11074@sigill.intra.peff.net>
        <xmqq1sh2e7w1.fsf@gitster-ct.c.googlers.com>
        <20180302165543.GA4616@sigill.intra.peff.net>
Date:   Fri, 02 Mar 2018 09:15:44 -0800
In-Reply-To: <20180302165543.GA4616@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 2 Mar 2018 11:55:43 -0500")
Message-ID: <xmqqo9k6csan.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That's probably a reasonable sanity check, but I think we need to abort
> and not just have a too-small DISPLAY array. Because later code like the
> hunk-splitting is going to assume that there's a 1:1 line
> correspondence. We definitely don't want to end up in a situation where
> we show one thing but apply another.

Yes, agreed completely.
