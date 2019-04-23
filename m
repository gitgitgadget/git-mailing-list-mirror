Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60BAA1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 02:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfDWCkh (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 22:40:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55320 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfDWCkg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 22:40:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so16616010wmf.5
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XStfA8keLfoIEK8+gDlFJ/95RhOS394PFRYu5oI91Ls=;
        b=jmhfbrvQTmngl8jcBpb7NqWGvHZ8GgS9/FWhbWo4y0zN0YtbS4SWtXikAnZ/nGatbj
         MlmNgr06vbWY9FLCi8QO4uwR8p75V981Tct2iNgKTqJyIlvvYP8gTpLwA6XpRm25IRTE
         XWs4UHHjemVFlODW2vu6ES3jp+1X4p5BqaWydrEu9b9Px6XeaWowXB0oz+EWcpdbR19Z
         vL/btPD9hoPhFiLi1P+aaDvF5cSMDXhBHGu39ZTI3snbCEKtGG5V2fyLJlORQj/C6Tvy
         KsAxO/HftL8Ce12IkcQ6gF3wYzdbhaBoRGz5J8XFKCzfiijMaqqv40UFHT7zozp9y6my
         u+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XStfA8keLfoIEK8+gDlFJ/95RhOS394PFRYu5oI91Ls=;
        b=YYJ+W/67TTx9HnoIPE8uJXpjEE05oZY2l9UgJ87OlKgDCn7Si3u8d604R7O+5wy3JP
         eGnFllfQT6s7f+/2jjiXj620YNtbyUg6cJNiLp0GU9Gn4jHUE8hGdWjE9q4YQCJ+wtJ4
         KOn3VnASkJCLwtN/Gn8WL6fHVTZKhqWHMK1/R5WUXcN7rhyghFc1inNUOAlwiq5mxyAA
         IkeMQuebmJpYoSn9Fv1OLCC2ZVC7zXHp9GIfYQQUDgWW5hp7gK51eLOH/hBbvIygO4YY
         iBgNt07cqwpMgJUBpxqkJpfDRgrfBKtY+gkIkEIFOHECkNBSO1kj6YOg4l3Pilfbyvg8
         j88Q==
X-Gm-Message-State: APjAAAVrnmu/NVF6x+oYrvqyn4C7Co/1iXo0zmYOYOhPCrtSEETHLokY
        6Mc38lAauJOdRz2fKNFQzpk=
X-Google-Smtp-Source: APXvYqzvu9Eq7z7wR63VvfUP5HBEfNJ1wztK6DwMI7m8T+4m7fXtWp6aZcIbMhuXF9vDknZJbYThRg==
X-Received: by 2002:a1c:4056:: with SMTP id n83mr346083wma.146.1555987234759;
        Mon, 22 Apr 2019 19:40:34 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g17sm3239843wrw.43.2019.04.22.19.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 19:40:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] p5302: create the repo in each index-pack test
References: <259296914.jpyqiltySj@mfick-lnx>
        <20190420035825.GB3559@sigill.intra.peff.net>
        <16052712.dFCfNLlQnN@mfick-lnx>
        <20190422205653.GA30286@sigill.intra.peff.net>
        <20190422211952.GA4728@sigill.intra.peff.net>
        <xmqqef5t7cil.fsf@gitster-ct.c.googlers.com>
        <20190423020749.GB16369@sigill.intra.peff.net>
        <xmqqv9z55udl.fsf@gitster-ct.c.googlers.com>
        <20190423023651.GD16369@sigill.intra.peff.net>
Date:   Tue, 23 Apr 2019 11:40:33 +0900
In-Reply-To: <20190423023651.GD16369@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Apr 2019 22:36:51 -0400")
Message-ID: <xmqqr29t5tr2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Is it? I thought the issue was specifically when there were spaces. I
> get:
>
>   $ bash
>   $ file=ok
>   $ echo foo >$file
>   $ file='not ok'
>   $ echo foo >$file
>   bash: $file: ambiguous redirect

OK, so I misremembered.  Then we are good.  Thanks.
