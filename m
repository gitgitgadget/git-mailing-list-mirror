Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC232023D
	for <e@80x24.org>; Thu, 18 May 2017 09:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754641AbdERJlB (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 05:41:01 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35774 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbdERJlA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 05:41:00 -0400
Received: by mail-it0-f53.google.com with SMTP id c15so96683500ith.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eWwqbpvVvJgHm4SR1/HliK1T1V0ZjdUveIjFi2U4OiE=;
        b=N7yhVKkjWntQTl1wujnRxxXCziburDSyGk5fHe4DFt0pD/3rrktcjQ5wlVR9rBbpan
         yAox0AoSGJ6E7VTVMRbP7VkMkw8wgBvc3wreFE7JF0O7iRsGDnV+q26cjiPOFP48oY2H
         keyT2UnHGMpo/B3f6xO3GbQcERnzPAL+4luB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eWwqbpvVvJgHm4SR1/HliK1T1V0ZjdUveIjFi2U4OiE=;
        b=n/1srf2PDRllxWSts3jgUrxYzVs9EDhCI/obNGcd7ji+lus0mhT0PHNuxqK+jJdEdf
         pIAa5RNbYkYeIZ5J2ZELsyr+QTVoq3R77HYRUYgTQcqiQohb8C/QO8ZlprAI8zlKTqrt
         gR5JyLFltpANcbXlG+0DsNYW2guALxcUpq3oAOA+0QapQNUbliaTF3Mc16mM6fp7PLHV
         LNZgtlDkBheZnVu/929WfHq0z3SbZx84/qWwxScjKGcoQm8ejhP3cAy5QA4BChuv2HwE
         vwd0Mn9w5qzHfveGZ9CK9O38Xy+IjRO7G6FtYvnMvC2pDKVd4e9ZzwPCu1CkU4IZZAbd
         9oOw==
X-Gm-Message-State: AODbwcAJHGZnMCakrXjIvnoG9SOpTrTdRW5zK4cQRZNpJUdsnHe0O9P4
        m2ec/DrgzSjauFk7RWn/8RNO5QECXpR7
X-Received: by 10.36.125.80 with SMTP id b77mr10658642itc.108.1495100459796;
 Thu, 18 May 2017 02:40:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.10.131 with HTTP; Thu, 18 May 2017 02:40:59 -0700 (PDT)
In-Reply-To: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
References: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 18 May 2017 15:10:59 +0530
Message-ID: <CAKohpo=eFcf=VqCOvRJvQacUgMycZ1axvjbsNs2GeUGHzq4_Fg@mail.gmail.com>
Subject: Re: [Query] Override sendemail.tocmd
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2017 at 12:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> I have a use case and wanted help from you guys..
>
> I have set the sendemail.tocmd option in my kernel's .git/config
> file and that works very well. But sometimes I want to avoid that
> (for example sending the patch to someone without the list and
> maintainers).
>
> The suppress-cc=all option works quite well to avoid almost
> everything (including running --cc-cmd), but it doesn't suppress
> --to-cmd.
>
> Are there any specific reasons why it is being done that way?
>
> Currently I need to go edit my .git/config file and remove tocmd
> before sending any such patches and it sucks :)

Ping !!
