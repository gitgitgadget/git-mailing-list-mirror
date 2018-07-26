Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AF441F597
	for <e@80x24.org>; Thu, 26 Jul 2018 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbeGZTdB (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 15:33:01 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:33940 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbeGZTdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 15:33:01 -0400
Received: by mail-yb0-f173.google.com with SMTP id e9-v6so1012032ybq.1
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcEnTEUln8oOemxK8Y29GRpS53yajLnuPq26lKCCAUA=;
        b=CNG7QTN42smpm1XW5ATkeuLTshF4Wjlcjgc/nAkFrYl4GUiVj4V+c5fkc5bAc6tuE/
         I4YQDtdZh+16ZFtt389QAdxSZhwaAVsNsYQiFv7Xt/DbwOpEIAPdJ1Tw+ilY8pf6Nbfe
         BvpWEA7Ff4wPmWsPi8TzOrM3t5kAgdG/G/90sXOuPRNrlxzOVvURLIBw6jbgX7fbrNiq
         s1V1B1WVj4xiOMMszfYz5vM2hg0hcTM8vUR9GErY9f32y2wXOvx6djl/tuzwDuIWzGNQ
         yLMo24n3QRxAvzxxEDlc/K5DtNRpEs6ooaUfo3Un+S+q2LyD8bXE4VMr86jW7d57O6eT
         YYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcEnTEUln8oOemxK8Y29GRpS53yajLnuPq26lKCCAUA=;
        b=jxdkIyKjDtF2txDYizZxL92FX8P2z2pn6asEBDcyIS1CFu7dAGlFXsUgVV5WAjw00D
         ifrMSSUWjjQOq1/alnJVR3CA2DqOrN35KCe+eqytTwC/H9YiYtqMITE1fJkmSyKMCEKB
         4Hi7aH40qpcmCbdUDsuXcyRrUi0qUvstx6Si8SEAUH+v5dGHfSmxRSDH6Q2/p7Xy+dol
         jcFyEsGmx6VqMyB6a4meFP36hDUSeno7nl1gSBcM3gD6eFaiZHiLBSgGQy2kTqp01OF7
         e4bMfYs8ti7jnL9qm13nf6XF20opBimEV0p4gFbI4B+9gKrEhixcoOrRVeWHNcuEPbQY
         vTzg==
X-Gm-Message-State: AOUpUlGVqTGBb63QB4jXPebvLW3f1Q9KFMcdtvxown4lVv5HGVwoxCzu
        dLxmEC5BhoKPT5Zs+TECshn6dKXFkLeHYjuy2vMcOQ==
X-Google-Smtp-Source: AAOMgpcOb9jqTXIRnJhHJsm3ejoZZ5/YDnv8hZ2gq/ifxXAaRTpc0ikewyKB4OfwZQVVkjtEOP0mOf4gXnoBa0ku0qI=
X-Received: by 2002:a25:b091:: with SMTP id f17-v6mr1643366ybj.167.1532628902815;
 Thu, 26 Jul 2018 11:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180717002654.120375-1-sbeller@google.com> <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com> <nycvar.QRO.7.76.6.1807261238160.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807261238160.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Jul 2018 11:14:52 -0700
Message-ID: <CAGZ79kbqLene9x2Pp27LxXbavP6hRLnBrsXJ49X4WQewJWxSzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> To allow me to protest in a timely manner, I wanted to teach GitGitGadget
> (which is the main reason I work on range-diff, as you undoubtedly suspect
> by now) to warn me about such instances.

I did not suspect that GGG is the prime motivation for range diff; as it proves
useful (a) on its own, e.g. looking at the updates in pu and (b) is helping the
current workflow very much.
