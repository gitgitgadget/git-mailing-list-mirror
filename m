Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B70BC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 01:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344295AbiCOB1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344288AbiCOB1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 21:27:12 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43561A3AA
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:26:01 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h21so4421427ila.7
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=ZwKwt37MV8j2Zuwvw/dN8adQWdJvBKciimVNdY9auqg=;
        b=q2NbHHbU56M3IVpFLNX2x/qGyqvuf8hvJNKeySXudUoMltljf1Uq+fy1o6CmRCyXAT
         pFpEKI4jcGxMfDgNIpIwRDyyJ9bvsCwR+s8nOuk7+iFktmZrReD4WiO9F4a7BKaoJOyC
         aSO4vq9yziRwvSvv4AVb1CvXlFDyce0rEJwmUfwp9tlvQiGM1vGXu+lWg5TTwb2MK5ld
         x7RuUXElHFSrWhXZDs9FH50pzLcZdfsHbMxiP2yHZYztI8c/iIze4Onw+dIC1ZgrruHj
         foHZDJAqdsRRiy0Ns0whE/2FjHlYIsW2VIC6VTWLezVRfBL6uddzaS+e7TUINQxEdGXH
         L1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=ZwKwt37MV8j2Zuwvw/dN8adQWdJvBKciimVNdY9auqg=;
        b=pSLQc4+lHt8KL3XwNKdAVI44ICofg/G6TZGl7pXcQx9Y2cOfw9eFi1C5T7ZEV+pT5i
         qOPHM5D1JqrZ5Rn+OFeGGx6Kol7xu80/A17XkBZh97JSNB1klIaL/O7Xil8JhtvrWBRw
         nOIpHtpg+jNW24KjMd4oHg2wLXmiwuJYrjBJT2fBXQ8cHuyQcX0MVgbxmSoN08ErRQgI
         Lz4xOC0k+aZSADvn1SzzpZf+nmtWH36BGe0L6B92w6qTq8jYnxs4PetcPGKokWKZURku
         u3mW0A5S1uqK8LyKdh5jyS/s9a2aoOZHI/R8TOSZd+hl/S8A9N07JttnSjOzHEi73hZi
         qa4g==
X-Gm-Message-State: AOAM531xkENaSAjHb24gWz0I8EUpw+oFQnDCmuzLJnwrFWqivBZCogk1
        bifxBmepQiCfGfdxdqby/9A=
X-Google-Smtp-Source: ABdhPJwtLZvokMcPN2ZwlV1PLo8JRrf0pkhi9m7RvbzVVNgZK7o6UaepuGRp5tXoTGQtSY07/74U1w==
X-Received: by 2002:a92:ccc2:0:b0:2c7:8cb1:8b76 with SMTP id u2-20020a92ccc2000000b002c78cb18b76mr11391426ilq.89.1647307560992;
        Mon, 14 Mar 2022 18:26:00 -0700 (PDT)
Received: from EPIC51148 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id l14-20020a056e0205ce00b002c782f5e905sm5615556ils.74.2022.03.14.18.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:26:00 -0700 (PDT)
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
 <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>
 <01f201d836e5$89247c30$9b6d7490$@nexbridge.com> <87v8whap0b.fsf@gmail.com>
 <01f301d836eb$5c7a6810$156f3830$@nexbridge.com> <87r175amw2.fsf@gmail.com>
 <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email>
 <87ilsha2b7.fsf@gmail.com> <xmqqtuc1tpdj.fsf@gitster.g>
 <697d8717-bd3f-0871-d5b3-e6303c4ed726@iee.email>
User-agent: mu4e 1.7.9; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
Date:   Mon, 14 Mar 2022 20:23:57 -0500
In-reply-to: <697d8717-bd3f-0871-d5b3-e6303c4ed726@iee.email>
Message-ID: <87y21c2ehl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Philip Oakley <philipoakley@iee.email> writes:
> A broader issue for the corporate email mailbox systems is those that
> are allocated to roles. So you may have Traning1@corp.com thru
> Training9@corp.com (we had) and if that training includes practical low
> hanging fruit examples from a project, it's difficult to disambiguate
> those commits. More likely is say, having TestPC1 - TestPC9 that
> included debug commits, perhaps even with pair programming test & debug
> sessions, so allocation to individuals (rather than mailbox) becomes a
> real problem. Hopefully that's rare in Sean's case.

Yep, this wouldn't happen for us.  Lots of other processes depend on
there being an individual making the commit.

I'd also be surprised if this didn't cause process problems for other
folks, too.

--
Sean Allred
