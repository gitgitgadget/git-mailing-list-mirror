Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E707A203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 17:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbcGZRYr (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 13:24:47 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37673 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648AbcGZRYq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 13:24:46 -0400
Received: by mail-it0-f48.google.com with SMTP id f6so22361152ith.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 10:24:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D0NBG9qMYVoeD/k4fxIJ3MYXpxp1gZV1oMHjXx+eVEU=;
        b=MJwyoXfcdt+LHpB/Mq5QSvTh3ZcBxmk82dJRSZWJCR0g+oC1rFw7euH8DOXwpzaZYy
         rY75DWvYaHkKKnkB3AJFDBPRd3HtEVKBTjDLDZ1MTLjEzFYfkcECyhUkdK8pa9PdycQ0
         rzYcK2aFYLSk9D3EQ5BtBqXIRBW7+o8RDf9G2b+UrQdiITHdrAO7q16IA+LOGe6qIXEz
         7jMjz1yMyceDAXj0yt5VVE7iwkoRtnMjvLyYumwVxYaeIM3Y4D7wvlDzgywy0tNXuBfh
         PWlq/oLVnsZtyKH+Kfh2sJoefAwWYBDorGfN/l1jyTZN1QAtrZKzWRa9kHbtuIpR2x5T
         8NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D0NBG9qMYVoeD/k4fxIJ3MYXpxp1gZV1oMHjXx+eVEU=;
        b=cTPdx/QdniICapX7y+Pnme7WqS97ZGcCslRQIpMdNCl++iU3UtCjed014x+xWNlEiu
         xIqfOwTaqcrJLteL0RDgyOEn5zz2jRS5WNlmijHKT1obG1U+xQZe/6b6qfyAsLU7eJ+e
         SuFPdg+ke3mqaNwELAfLS6EYFSE+3h1JvAB76uiQXFF+Hal4qyVU0hs4oP5khxYJT05u
         lr/G1VRFcOTZr0VpEyW1CKlLewb+m/a+2/gKyrceVCrf7G5qM5I5mzoL02gesLqmHTCh
         lK8MdiGetnGHPM0XZ3aCBe4Sx1WEf1AdlPaTI6lxwkQUDf3e70pSHX6aJRyQgtn6eDN3
         fFqQ==
X-Gm-Message-State: AEkoouu9gej0v3L8MHfaYi4/4J/7fKqtuYo1FuVmYXlpQXt4wCtc3oPmPwvLYyNJRmte5eTkd7rak2I1QjZcbycL
X-Received: by 10.36.127.7 with SMTP id r7mr27527577itc.49.1469553885159; Tue,
 26 Jul 2016 10:24:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 26 Jul 2016 10:24:44 -0700 (PDT)
In-Reply-To: <20160726094925.GB3347@book.hvoigt.net>
References: <578E7A07.8080006@web.de> <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de> <20160725143706.GA4872@sandbox> <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
 <20160726094925.GB3347@book.hvoigt.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 26 Jul 2016 10:24:44 -0700
Message-ID: <CAGZ79kZ4YKxGapve0rrzP7ZUtYtgwz7e6Zh0HirmLOYp1tr3BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule-config: combine error checking if clauses
To:	Heiko Voigt <hvoigt@hvoigt.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 2:49 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> So we have less return handling code.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

Thanks,
Stefan
