Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE741F404
	for <e@80x24.org>; Tue, 27 Mar 2018 19:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbeC0T0Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 15:26:16 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33965 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeC0T0O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 15:26:14 -0400
Received: by mail-wm0-f43.google.com with SMTP id a20so22674172wmd.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BlWafB3Qj7l4gJzs/A/BQg9ySI4o+vlVY/f4de6NoMw=;
        b=spGXSzCoOuA1UGl3KUPWk/dR+gPf02XK6mAIQtlGsNZLKNntr1OMkPjN/p0t8P5roJ
         WMM6Q+Fns2qxOo+g7e98MvGa2etD1mg57G0mkM64dvPWf1wUxOYIFXGplSSw1CxRxMkQ
         2kIe+xOayB6nxtlYRD6lVUU2LBN7TxXkUNFALWMQ/5Gx0FJDKhCeIN91xlbVVX2w4j9R
         8yAS9vMBBUFCdDnvetEyubdB7Nf6zUV3R63z+kXx67WJpsOE5mjypPhUVAgrBpByvOvg
         8v+aqiRSrDnIUeCXbBRbz+hDfqUAdw3Ka7xLvMhyI8FWepNpeYSuUsPWn7n+Gsj6c0nw
         ZPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BlWafB3Qj7l4gJzs/A/BQg9ySI4o+vlVY/f4de6NoMw=;
        b=UlBw+jNQQ67IDlm2e7wYSMGGIheTUdsVd4DHVoBhOmt/SwrtChG6r7cexRFfQCWo1a
         l4iImEHVEpXEf23ZOPwXxWpn7JRmRaXRnl4L8GIwBq/sgTzeId/AHtE8d4imNkCCZFFZ
         8QLYVYCvMPmYnrE2VQpx5XrWTmt9JkWElGjUEZocddP9ufxP7kxPzjSc++LVTpBOELp8
         wwGonlGiIQNtSrH0AwL45s6w0NbKbi+ypWASy3WHqf4Owc3vSxP9vZz8vdyzHL3paBJZ
         FnC7rDw/zcA04tn7ndlkBltaKLvKz2aYg7/BdqtyuYfUR40E7k6Z31HHgP+Cnf+Mkpnb
         NlHg==
X-Gm-Message-State: AElRT7GHHL3fj5z+N4eAAbEU7pXaXX51gYc9+IM3mMh4o2TsrhvyqdBP
        osjmASW9f09C+2KKbTro0rM=
X-Google-Smtp-Source: AIpwx4+nfNaHnFwLddE5QrrZOCL7ZKY+ciU0aE/MA2mNwBhNh3KU7AOl9uuX8sxloxY1mvR7Ca6BJw==
X-Received: by 10.28.153.12 with SMTP id b12mr433640wme.104.1522178773413;
        Tue, 27 Mar 2018 12:26:13 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 134sm2832592wmm.42.2018.03.27.12.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 12:26:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Aaron Greenberg <p@aaronjgreenberg.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] branch: implement shortcut to delete last branch
References: <1522176390-646-1-git-send-email-p@aaronjgreenberg.com> <1522176390-646-2-git-send-email-p@aaronjgreenberg.com> <87tvt1wce3.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <87tvt1wce3.fsf@evledraar.gmail.com>
Date:   Tue, 27 Mar 2018 21:26:11 +0200
Message-ID: <87sh8lwca4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 27 2018, Ævar Arnfjörð Bjarmason wrote:

> [...]With that, some comments on the change below:

Also, didn't mean to gang up on you. I only saw Jonathan's E-Mail after
I sent mine, and it covered some of the same stuff.
