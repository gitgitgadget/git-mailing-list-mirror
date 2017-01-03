Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9891FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 20:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756685AbdACUL2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 15:11:28 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34254 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdACUL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 15:11:26 -0500
Received: by mail-qt0-f169.google.com with SMTP id d45so250759260qta.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 12:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M4Z9j0plk+KxUstKLNykzW6r2IpT27lMQf2LFMjO8P4=;
        b=uPQPRTt8dtqK2H8tW0dGrWbXW6N7XV38TyJWSOP2TQMdQ0cCy245bxAkiesXxjSCq7
         PlEeAL9IqPQm9y5tml+p/79ZCQQdt/jC7xsALtxgq+CxrqmJtWKUOsM1fKkvrsCWePyA
         Kn9FA95LCSGxtspriUw/PQY0olllGmdMgw9J5j2ZwqPPd9/pwmBaINKFxDxBwpdlZFHV
         Rt1y267fZDEPb0DnDY5UaARheOj/MYmfQaPfextpg5Wb2CTOHu2hON+pfHFc6AQ8zh2D
         XafnZK9k3CN6Zxe3ineGFrXBRFbaJVEDmVtYFJgwJNUIDH0KnAqN+V7jvSgzGs71SCBB
         TAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M4Z9j0plk+KxUstKLNykzW6r2IpT27lMQf2LFMjO8P4=;
        b=ebIeqIYzCGwPzLVtQHQGo9lQVBLfHky7Wld55ed4qzCccTq9h9jPdVB2C5DUl8U0Xn
         j3pxkvxnEr5LjgMbSVSdzEiQgvBDe9wp/BhTgJd2CCh/WlUcxygFK7Dyhi2iwc6/Pp9F
         QfpPzKDq6/llwMmEJf54gtPKdcCTE9i2eVq5mNK8Ky2zdFTgxtFWUr6JSoKrTQvHfrvD
         DUXwl1ykmRVrmQjSoFaBpzpEEV1ZkUj0zNhIA3nuwdIvK0aGEW+L+bpr59ybQnKqpL3C
         ELzll7senPy7hSUzZcKZEqIuxuwwRFd1aMLPMLen7D/fYuTXFUKH6+T7lGmpLNNwAOjg
         bwiA==
X-Gm-Message-State: AIkVDXK6obqeu/koR94ESew9tb1vn+2iBMAjYdq8xwpK13qSWk0/dWLQNQ4vRzq+L1DlcAuIZWFScyWXMyLZ3LxY
X-Received: by 10.200.42.253 with SMTP id c58mr54141802qta.145.1483474285557;
 Tue, 03 Jan 2017 12:11:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 3 Jan 2017 12:11:25 -0800 (PST)
In-Reply-To: <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de>
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
 <cover.1483373635.git.johannes.schindelin@gmx.de> <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Jan 2017 12:11:25 -0800
Message-ID: <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Avoid Coverity warning about unfree()d git_exec_path()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 2, 2017 at 8:22 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Technically, it is correct that git_exec_path() returns a possibly
> malloc()ed string. Practically, it is *sometimes* not malloc()ed. So
> let's just use a static variable to make it a singleton. That'll shut
> Coverity up, hopefully.

I picked up this patch and applied it to the coverity branch
that I maintain at github/stefanbeller/git.

I'd love to see this patch upstream as it reduces my maintenance
burden of the coverity branch by a patch.

Early on when Git was new to coverity, some arguments were made
that patches like these only clutter the main code base which is read
by a lot of people, hence we want these quirks for coverity not upstream.
And I think that still holds.

If this patch is only to appease coverity (as the commit message eludes
to) I think this may be a bad idea for upstream.  If this patch fixes an
actual problem, then the commit message needs to spell that out.

Thanks,
Stefan
