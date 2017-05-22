Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A84B1FF30
	for <e@80x24.org>; Mon, 22 May 2017 03:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756855AbdEVDNP (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 23:13:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36225 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdEVDNO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 23:13:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so16744357pfb.3
        for <git@vger.kernel.org>; Sun, 21 May 2017 20:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dTybzAvjcIoOiCaXUpbfBIt130tcdi3yUs7TByriDsQ=;
        b=naR3NtLTZaOtUZx/w2UTlpJ0ox1PwYB/kzJ1ZsA8gCrb0/JksuauNUSemRc/MtSoV1
         HtMlCQWUazGelUcVIOTO+yaYNq8kBMh7EogHJ1EQx0qF5NtAHAs/3+rY8QurcW5pHfYB
         RvpwYFGKvFGh/D8Ju6F0ZNzcDycKL54PyTBPr/0LGRJgPpYIHtsMO1ISnL9dNtlgB1Wy
         7Fk7zfzDN0uy+SludwnZaGJC3/1Y6azpiy4a0TxZL379Z1PocIeL1cBKNl5oE3T0QKsd
         nytOWVS9edp5EkaUwTtoYHLHYU7jOnMyG9CA7TVPmYmqgFGHMrDjkT0/AkHfTDiYDeLt
         VAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dTybzAvjcIoOiCaXUpbfBIt130tcdi3yUs7TByriDsQ=;
        b=RWYtfKMf/2NBxTR8kQGRCc+mZ1bJAXlWslMVS0Bb1R+gMt4ISlEJviJ0QGtNUnv0/M
         +6poA1g9bcMesHv8MQLrkRsA8gO/45v0jzv3Fz9dsy0ux0Ierx3cabpeqq13g7pKH0Zh
         Jc06DXPamcXiIojZ6xUT0S4mxHRBMK2OIEvoiXFN5C0My0ucERZxcqpo07ESbxoeZ4ob
         VWI5ynJU0bd5/FHRKBzOMhpFxl79T5/d2NCjWv7WPeNxG/UKf2i08W8ST/S5CpqHj5sK
         T5pPXlCdRRJjJNVTmg7UGfoxGe+3S9plXsVYw2gfVKSkpg5GfMfewtB2mhjBgJBpX6L0
         O3hQ==
X-Gm-Message-State: AODbwcDzyQEcsdm/wADQLCUC5YWuRvqKTwul+LZg21WGYnEiCRS99Ypk
        Q9ystzDweLQLq6OEjug=
X-Received: by 10.98.14.131 with SMTP id 3mr23110336pfo.23.1495422794003;
        Sun, 21 May 2017 20:13:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id b68sm3706087pfe.18.2017.05.21.20.13.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 20:13:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dir: hide untracked contents of untracked dirs
References: <20170518082154.28643-1-sxlijin@gmail.com>
        <20170516073423.25762-1-sxlijin@gmail.com>
        <20170518082154.28643-5-sxlijin@gmail.com>
Date:   Mon, 22 May 2017 12:13:11 +0900
In-Reply-To: <20170518082154.28643-5-sxlijin@gmail.com> (Samuel Lijin's
        message of "Thu, 18 May 2017 04:21:52 -0400")
Message-ID: <xmqq37bxpos8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> +
> +	/* if DIR_SHOW_IGNORED_TOO, read_directory_recursive() will also pick
> +	 * up untracked contents of untracked dirs; by default we discard these,
> +	 * but given DIR_KEEP_UNTRACKED_CONTENTS we do not
> +	 */

No need to resend only to fix this, as I'll fix it up while queuing,
but for the next time, 

        /*
         * Our multi-line comments have their opening slash-aster
         * and closing aster-slash on their own lines, like this.
         */

