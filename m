Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEEFD1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeBVUkm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:40:42 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:45147 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeBVUkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:40:41 -0500
Received: by mail-wr0-f174.google.com with SMTP id p104so11893101wrc.12
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=doDo+Rgf1mNnimM9XaprqAWs8ybPYn/J08zEIYVjklA=;
        b=jlW7eQAzJPkyfUe5AMJ40BQ3hpK6bE4q11S40l9Zhzl1Ev0GetOoQzvEv9CPTdtBoa
         eY4a0Wv1arf/SqPG/yo9ldWFe0z8+8TGX/deTgUwqLa4wclCoCLP298CYZdismzBnt8D
         LDfRsnV/9dNEUtJqIcIqSkyusroUDtzhdNm6zGPWm1w2KCxbXJj4mIuNjOb9z/2qXcyd
         Ri4cOzBvSut0+Em4PZyqT2lOpkSjrR3dRdYFXvzoqzru8ynHEP6nVB2GSk7dPPO7s3J7
         iQfVKil5caadzB1LuvGFC4Fjd1LwAx8o3YUYxMtyw9X9kzHMmOCdK0WamnNbuzPI/LXK
         8ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=doDo+Rgf1mNnimM9XaprqAWs8ybPYn/J08zEIYVjklA=;
        b=XHWMfE1/Qn+2tG1x46CI/0Ap/IfyI3BrvFfYvnN6CSFwVza7RURNH+ei5f8mCK14jE
         Lu2ezPsR61xXEsNDpIYwipq+OySGm6AHBb/aufMsqqGWLuUlqxHw459zdmazn8E4NCFu
         HmDMAB76MToPqXJldthajjxAJSkaQo+JPVy5vp0d4j2EIaxzlnhebmHNeGqW1YcjrqXG
         DYiUpKv165ThYbbN8M9+EGWH9WHyuT1dW/gEa+CKGBwX3oudRWDV/uEMdralG0C8bU0U
         zRDqp2yAy7jdJ87rcPn/S1dgXCiYFAS0A/2ggW1aIKP5epQL7hUQjWdN4m/nmmYZFAkd
         vs8w==
X-Gm-Message-State: APf1xPDdOSHdjxscr8/O6UrO4n8j+G9/FP5bKTyxwZEjtebbfiWAHjlH
        YlY95+vrjBsduuleqLnXWAGIql4AMCdRQVwMgC2DAA==
X-Google-Smtp-Source: AH8x225Dh8D8j80XUmojuaALSmdxrtinAXsU9uFvlAiLN7P6a0aLz+fkVyH1snxLKSO+7Jyzull9mX3fzHcpxGdLTpc=
X-Received: by 10.223.160.125 with SMTP id l58mr7132451wrl.264.1519332039848;
 Thu, 22 Feb 2018 12:40:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.179.2 with HTTP; Thu, 22 Feb 2018 12:40:39 -0800 (PST)
In-Reply-To: <20180207011312.189834-12-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-12-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 12:40:39 -0800
Message-ID: <CAGZ79kbrm2Ei=spoDbjrwVFoF+mi0AAsXNLDBgCozFVoXM6+1w@mail.gmail.com>
Subject: Re: [PATCH v3 11/35] test-pkt-line: introduce a packet-line test helper
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:

> +static void pack_line(const char *line)
> +{
> +       if (!strcmp(line, "0000") || !strcmp(line, "0000\n"))

From our in-office discussion:
v1/v0 packs pktlines twice in http, which is not possible to
construct using this test helper when using the same string
for the packed and unpacked representation of flush and delim packets,
i.e. test-pkt-line --pack $(test-pkt-line --pack 0000) would produce
'0000' instead of '00090000\n'.
To fix it we'd have to replace the unpacked versions of these pkts to
something else such as "FLUSH" "DELIM".

However as we do not anticipate the test helper to be used in further
tests for v0, this ought to be no big issue.
Maybe someone else cares though?
