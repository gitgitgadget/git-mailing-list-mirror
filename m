Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0DB1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 14:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbcH3OHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 10:07:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32958 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbcH3OHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 10:07:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id i6so1246123pfe.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVpXvcuu+W7aIqZU4u0toBQ0xsX1wlQwsz8XkIhTG8A=;
        b=0ZhOflDP4Fn6ppoUt2jjGYLN4njM3VveV7py9OEOQPx0zOeije8LzTM30Ehc8ns/kX
         Kjtcze8AldMCgZ/Q1Cl12fkhmpvTNyQjj/Jm6CJnFUTnoq1vFJ92hSci8YnX1QNa0mGd
         kcSEfuWzNUDp/o8/AWeabsGgXtBk8x8EWEEb5wUn8ifqoLAx5gRRtqZcEe8fo/D0oKM0
         hCEPdfL+SCBepolyG8s0NJ5cn01lklMogh9l8HEfH+87kKouAfYOOZ+nyq9834gXhVcl
         xiU+xxpR1x7AYewxTd6r591VsjFpMO3XR7Vu0qstXyoBtkkh+IvJ6AJyG6aLPu9gdUbe
         aBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVpXvcuu+W7aIqZU4u0toBQ0xsX1wlQwsz8XkIhTG8A=;
        b=Ocgob954i9c7xjLc+g8f4jzHSxPzrD2wo04SHkmsyxltwG8y3ZalCMVjATgDgxSEfq
         x8jIFjdvt0HAwHsVlRWXBuJ243n+aak9GSppVlYjYVXsUVcNuo+PnSbELOAuq6k1q+4l
         jJJf6V5dZ8jOu41wfLsrKL8ihg3rEMcQAyTS0PNViu0phCZ8AgbSTZ1eJCj2O64Zxk0c
         72uoR3IJS/vKgiBBi6aPwJEjgWufA2MGlEsiDpek/LzEd/FsC/T+GskBumOtsFhrteHe
         r0uapjpfnsv1GXcRC6qPUX0BaTxTGnWF3KEt4lbYctfuKrNhGsU/jOZqUGurcJTA2gR/
         cJYA==
X-Gm-Message-State: AE9vXwMhcHbJhtWGQ5p8SsmgqvUA4w49rekkph9hihMoGh89QTg3k8Y2IH9m7pMHroNDIQ==
X-Received: by 10.98.64.193 with SMTP id f62mr6524265pfd.141.1472566057004;
        Tue, 30 Aug 2016 07:07:37 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id j2sm57711654paa.46.2016.08.30.07.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Aug 2016 07:07:36 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v4 0/3] diff-highlight: add support for --graph option
Date:   Tue, 30 Aug 2016 07:07:11 -0700
Message-Id: <20160830140714.19048-1-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <xmqq4m638ded.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m638ded.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 02:37:46PM -0700, Junio C Hamano wrote:
> Brian Henderson <henderson.bj@gmail.com> writes:
>
> > How does this look?
> >
> > Drawing the graph helped me a lot in figuring out what I was
> > actually testing. thanks!
>
> Yeah, I also am pleased to see the picture of what is being tested
> in the test script.
>
> With your sign-off, they would have been almost perfect ;-).

doh. fixed.

I left the subject as v4, probably mostly because I have this weird aversion to
increasing version numbers :) but I justified it by thinking that the actual
patch set isn't changing, I just added the sign-off (and updated the commit
messages per Jeff.) Hope that's ok.

thanks everyone for all your help!


Brian Henderson (3):
  diff-highlight: add some tests
  diff-highlight: add failing test for handling --graph output
  diff-highlight: add support for --graph output

 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/diff-highlight            |  19 +-
 contrib/diff-highlight/t/Makefile                |  22 +++
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 223 +++++++++++++++++++++++
 4 files changed, 263 insertions(+), 6 deletions(-)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100755 contrib/diff-highlight/t/t9400-diff-highlight.sh

-- 
2.9.3

