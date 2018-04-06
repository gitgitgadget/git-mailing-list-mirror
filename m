Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A1C1F424
	for <e@80x24.org>; Fri,  6 Apr 2018 06:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeDFGiu (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:38:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46821 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeDFGiu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:38:50 -0400
Received: by mail-pf0-f196.google.com with SMTP id h69so79756pfe.13
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4M/6Ut2WTSigvRLvJIFcdCZ9AIVlrzVP6tfppulWfoI=;
        b=YqWmD5EQLq3AFbQmmR2vg/QsqgIleG7cx2yIyldq+vbgWfMIvbH9PIZ59UxB/XegeQ
         mqeYfCKJZt77brjK9A+D1G166HFJ7BqfdEFx94ScrlaYH5/YSgILa3esItu5cPyY1jvz
         SFbu2mBNgHH0wK6KO9gBmDWjxgDDtKKH8srMOEPgd1DH+j8X4BSBqwAYy4dNIMEroG6O
         omA5D4pAsxOrIgMc3b64/ZwAbZX3TWJ1W67EKU8X/dbDGRqgvPYNvG10y/dyMGgX9fVx
         EQNxtF29RGsqUYQunS2RmQEeAtN3jgG6QKnaGzLJet6i523/eQv7Ou26B5JSZlbF8jul
         ui+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4M/6Ut2WTSigvRLvJIFcdCZ9AIVlrzVP6tfppulWfoI=;
        b=ClKscLxmsa9/bN6m06qAdvConXfkrKtQ7xCJqUlMKYUlGOWArIjfKWj3STHK78h0DY
         y8XoS5BITYtcqkn30twxJmjZXdFQDa50+zB6aI657lWg+k4OR6lbchua3lXkQhaUiZ/0
         5FEgGonKCIdtFRHxlZPgvlQN7dPjtqSuyogDjVkLjrDCvv0tj/JArE5Ltg0oWcvRKuuK
         B9aQj/c6MPr7m1BnUFKkIYWceuvdC4hsFAZQKQf9CnELGx5Q0PJ0tRO+Acr+lDUADSDo
         Z8TqJF5tL3oZdPiuOSfcjNY5StlpV19tIYdblF7yPhi4f0kKyh6JwF4wuMsP4xjaBs1o
         +RFw==
X-Gm-Message-State: AElRT7Fk2m+Vb44uGNzIC8YT62HUnvOMIEHz+oI+tRPVK5HF9AfkKLOG
        3oxPK1Ebn1yOTZ9dXQSkUUBU026Ewlg=
X-Google-Smtp-Source: AIpwx49d1IP4UIAr4HdEKUmYsQGvABPNUrrrx6IpUkL+nDzSFVSC4hCCA47+lfa3xAc2bSjMysxFVA==
X-Received: by 10.101.91.3 with SMTP id y3mr16395623pgq.299.1522996729001;
        Thu, 05 Apr 2018 23:38:49 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id z79sm18779255pfa.139.2018.04.05.23.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 23:38:47 -0700 (PDT)
Date:   Thu, 5 Apr 2018 23:38:46 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
Subject: [PATCH v6 0/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180406063846.GA2908@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328234719.595-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is v6 of this series. I have sent it in direct response to v4
correctly (since v5 was sent elsewhere by mistake).

It contains responses to Eric's feedback in [1].


Thanks,
Taylor

[1]: https://public-inbox.org/git/20180324005556.8145-1-me@ttaylorr.com/T/#mab6aee239c023445fd72693728b566cad5e0fc66

Taylor Blau (2):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: support `--type=<type>` as preferred alias for
    `--type`

 Documentation/git-config.txt | 73 +++++++++++++++++++---------------
 builtin/config.c             | 76 +++++++++++++++++++++++-------------
 t/t1300-repo-config.sh       | 29 ++++++++++++++
 3 files changed, 119 insertions(+), 59 deletions(-)

--
2.17.0
