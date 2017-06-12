Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A305E1F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 14:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbdFLOd7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 10:33:59 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33163 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdFLOd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 10:33:57 -0400
Received: by mail-pg0-f48.google.com with SMTP id f185so46054054pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:disposition-notification-to
         :mime-version:content-transfer-encoding;
        bh=M528chuKHH5S1n5V4zEn5Ht9bm7Qptwe9u4c9uD6NYg=;
        b=EAMoWlElQAX743XVJw4ysY9pFBM0O+Q2UgYyxptYEwfd8b36SqgYW8+V4DgRva/ARb
         Q/2wia7ujdXeSWguSmG21ZeJWongigjv/hWxoxi7b7BaDUnmHD+JbyyEXYNr6VxykLkb
         3JL2ihGZlamCyCDi1mNEufd7D9e+L7TYM28giIJcDH5ZVS9KpetNPUuqfV3ikMCtrWsu
         7u+ttSDSWeT7oGoUKCj1+rdyB+TMzayC++3uaFa8Qc6t4I1jAvHZttPmDGX5lSy4NzM+
         r+Gz6LpMRRIyMphlXw4qd9rKwq7t8RQd6EA2x37sMkKJwuauqJh5EHIVTVsFiNZXRjdO
         jjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=M528chuKHH5S1n5V4zEn5Ht9bm7Qptwe9u4c9uD6NYg=;
        b=suE/Ko4N9mHoZHg+3cPZQZ2oepwLE5Pndjp9tBsCd/Oh39S/EAgG5P3AQR1tU9R4St
         uq1e9UBiaJepKb22iLlQOA5shjyReZwQSKARpThq7H7tquy/Bi1yUnFHkbzqlTGaMv3F
         rsgAOCe50Xf0IRBBymxyjE2a6x8+9qXZyN8zDCUD8wzX602LAuzk9HMMxS0PM15U4Wpm
         JhKXnoLxTpHT8oW5CA9HcmmxCc04tGLpMnxJ/uJYb0IM48mQAoW2lEQ6WHAh5T61jhP4
         oD79nvqtRT82JxQxT39TuJChKlMpIQ+pogvgBZkVj1BpfO/zlYp/4nGHqzPumgt9G0rc
         hB1Q==
X-Gm-Message-State: AODbwcAYKmX+qBYAKHba5wbJjYpiSLWKYlpKHb/5stcb4UyKM/vuasQh
        /9kuC0Lsdmn9ut9qZwk=
X-Received: by 10.98.166.18 with SMTP id t18mr41164087pfe.66.1497278036492;
        Mon, 12 Jun 2017 07:33:56 -0700 (PDT)
Received: from unique-pc ([2405:205:8100:7f26:2f1e:ad3f:8899:445e])
        by smtp.googlemail.com with ESMTPSA id 15sm19600251pfk.115.2017.06.12.07.33.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Jun 2017 07:33:55 -0700 (PDT)
Message-ID: <1497278015.7302.13.camel@gmail.com>
Subject: Small issue with "add untracked" option of 'git add -i'
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Mon, 12 Jun 2017 20:03:35 +0530
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

There seems to be a small issue with the output of the "add untracked"
option of 'git add -i'. Consider the following scenario,

* A user makes a change to a tracked file
* His repo has a few untracked files which he has left it in that way
intentionally
* He chooses to use 'git add -i' to stage changes
* He chooses option 4, accidentally, instead of option 5. He is shown
the following menu,

> *** Commands ***
>   1: status	  2: update	  3: revert	  4: add
> untracked
>   5: patch	  6: diff	  7: quit	  8: help
> What now> 4
>   1: test-file
> Add untracked>> 

* He exits by hitting return but he is shown this weird message found
below.

> No untracked files.

* He is surprised on seeing this.

Why is that message shown when "there are untracked files" but the user
doesn't add them to the staging area ? If that message is relative to
the staging area shouldn't it be made more explicit? Further in that
case it doesn't seem to be consistent with the another output shown in
the scenario in which the developer chooses the 'add untracked' option
when he really doesn't have any untracked files in his working
directory.

> *** Commands ***
>   1: status	  2: update	  3: revert	  4: add
> untracked
>   5: patch	  6: diff	  7: quit	  8: help
> What now> 4
> No untracked files.
> 


-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
