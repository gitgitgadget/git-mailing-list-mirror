Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1E21FC44
	for <e@80x24.org>; Tue,  9 May 2017 00:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbdEIAbX (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 20:31:23 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36176 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdEIAbW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 20:31:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id 64so5136558pgb.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 17:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HERZ4YU/4GgBgywsSohSQDQ3pcMmg8BuoYstMCPv4y8=;
        b=oMR5QKVIlb2KYQWvI+DQg73jRf/2theNsnTF+VT+P6xM7VioTN1Dqdwgysx0kINFvE
         Q2bdboZjGnW4RENtnMlhxhJyAHOAPfnQZb6yQ26+OVpm2O/LB178tmLJOLZU6r/AV5Uv
         zAUSABje9OPfc/8PkYnLLFFKYhjsh2S+3ITkm5MVXOSNEejSOO1+yhuHV80/KeX7sbU6
         C6HWP6x0MMAWRQOdMyvQbe7Nj6T9AMhz8Cg5cTjciS3iPuogXFGChiEZYqm/cWe+x3A9
         jRqAyuEm/U5WBXCkfCe6cITpbWSe+zEC14LlqWV3jNemqAjbFzwlaoT1VMoEpR2cE4RU
         0pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HERZ4YU/4GgBgywsSohSQDQ3pcMmg8BuoYstMCPv4y8=;
        b=iLZFLV88sTvyMJzY1f5kiVx3Z2CZnyQRlOglisGenoEw3dR47k6urahKTAJWJJ91qz
         9NsAJzO535Laz1j0p40pXvInix+aXpUdlW14KMDAfosEMNmiRQVGlOvtpeKraVKJu7t6
         QF+Uf69WTIqwQ60K2kLgbk7novzeQk6UaP5VzfXA5pVZqu3ZraTJrNBw0w7o5SNVxBCI
         vAuoEptAJVwDpuP3re0HDMUVMul/AfUuqQz1eGcBKtwbZFVGN/hbGz4WonLXebfqSELM
         4EkXr3BtUE1jWoq75xpTRB+lAOeKvoPtyL3S0X9AKM6BJJ48KlkAGzc72cfqRTnyaPAs
         QveQ==
X-Gm-Message-State: AN3rC/6mk7MDE0/wjfvMK/c5u87BfeEYInKB2bF1IhCddEktCA2bp0iK
        Ik0URKqzFDu7fQ==
X-Received: by 10.84.213.2 with SMTP id f2mr68743937pli.22.1494289882061;
        Mon, 08 May 2017 17:31:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id x2sm25282548pfi.80.2017.05.08.17.31.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 17:31:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] Keep git clean -d from inadvertently removing ignored files
References: <20170503032932.16043-1-sxlijin@gmail.com>
        <20170505104611.17845-1-sxlijin@gmail.com>
        <xmqqh90w9do7.fsf@gitster.mtv.corp.google.com>
        <CAJZjrdVTRdTOiHXdVzVY3CLoi7KMbGozg8rDvrmJOJADMXRFuw@mail.gmail.com>
Date:   Tue, 09 May 2017 09:31:19 +0900
In-Reply-To: <CAJZjrdVTRdTOiHXdVzVY3CLoi7KMbGozg8rDvrmJOJADMXRFuw@mail.gmail.com>
        (Samuel Lijin's message of "Mon, 8 May 2017 16:37:48 -0500")
Message-ID: <xmqqh90u7two.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> What happens right now is that because (1) directories containing only
> untracked and ignored files are considered "untracked" and (2)
> read_directory_recursive() skips over untracked directories, even with
> DIR_SHOW_IGNORED_TOO set. As a result, `status --ignored` never lists
> ignored files if they're in an "untracked" directory (and this is the
> currently defined behavior per t7061).
>
> By teaching read_directory_recursive() to recurse into untracked
> directories in search of ignored files when DIR_SHOW_IGNORED_TOO is
> set, though, `status --ignored` now learns to report the existence of
> these ignored files, whereas previously it did not.

OK, if you are revisiting the design decision made by eb8c5b87
("git-status: Test --ignored behavior", 2012-12-30), we should
clearly document it in the log message of the commit that does so in
a way similar to how eb8c5b87 described the behaviour it desired.

Thanks.
