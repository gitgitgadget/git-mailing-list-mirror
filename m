Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6761F1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 08:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJSQVv (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 12:21:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36068 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJSQVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 12:21:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so36443675wrw.3
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LlpScUMvvqhcOUAozm1eytnlH/DfyM4cstYqwnGpG+k=;
        b=fjQKoHGlGhI/kzZVLKdtYCm1JyeUWkFTLaEH3yEcNl8nQzouElE5mGeBASIl+FMUey
         tALbopsixLQSaHP3WhqnLhuxJ+b9MfPukUf1cZm3FAt/v9k/tbeFND0dYhfUYKgtfqCt
         daAsydOLNgPmgjXn/8OXCuUdoRI8BwR26PSt2U3NnQziLnKQJDVYX3z2+eId2FKVb7SA
         Q0VO2tED4GypbiuADCc9VOGj37HdyETz6zXmH0VUJ802eQGnho7TlcumoEM0x2809Hn+
         HQPaHUVxTqPqe/TXcBxI9HUnjGKs2Y/Ibi+zqRMHX4pb7ARbTRiR8rTwxbSjjId1AZ2I
         aUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=LlpScUMvvqhcOUAozm1eytnlH/DfyM4cstYqwnGpG+k=;
        b=EfC8ykLJeO1m3XIfZgs0I52+mHs8HFLbiTV2x/Tt24DgaULff9reVyfmZTu7fnmPgg
         jzaXhFg+yWU+OhPcOW9nK2Z1fya+zAW8Xw6iPPvfYBiNJZsfkUxuMiEgUIxgskEJqGrE
         0Oi2sfsswvwli0/2rQzxlaOXehnnG9QC/P3Exr9YgOW/tkCKHx394FVhFGo5QglM0rRD
         t8+dXdw167zk2hAg/nMso1hQncvu2oPV8iaZ3Hy8IQZdbmrxjMXlWQ2DjQNm6LnD62Zl
         0L58ek1sp2GA3hKtrpXDVm2qJ+M28rfBHwuBnXgtezTojmzMiN88Gh4ZEP/A8py58UL+
         1PNQ==
X-Gm-Message-State: ABuFfojkC3KtOQZgg5RSalOKxIFqlrAr5BMZz8jcsI8CTH3czwbvgaa0
        yYsfTWP/jVEVeOTsF/EMbgc=
X-Google-Smtp-Source: ACcGV61JXeMJEL9OqZmjPVuA3waZRyCKwQFK7w7PymwxCtM/xzC2jUtMuP7epE0mM2AzOl4EwkdE+Q==
X-Received: by 2002:adf:d181:: with SMTP id h1-v6mr10364611wri.138.1539937008686;
        Fri, 19 Oct 2018 01:16:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d16-v6sm20245061wrw.78.2018.10.19.01.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 01:16:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH 07/15] sequencer: make sequencer_make_script() write its script to a strbuf
References: <20181007195418.25752-1-alban.gruin@gmail.com>
        <20181007195418.25752-8-alban.gruin@gmail.com>
        <20181012100101.GE19800@szeder.dev>
Date:   Fri, 19 Oct 2018 17:16:46 +0900
In-Reply-To: <20181012100101.GE19800@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 12 Oct 2018 12:01:01 +0200")
Message-ID: <xmqqzhvaz6z5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>>  		if (entry)
>> -			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
>> +			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
>>  		else
>> -			fprintf(out, "\n");
>> +			strbuf_addf(out, "\n");
>
> Please use plain strbuf_add() here.

FWIW, contrib/coccinelle/strbuf.cocci.patch gave us this:

diff -u -p a/sequencer.c b/sequencer.c
--- a/sequencer.c
+++ b/sequencer.c
@@ -4311,7 +4311,7 @@ static int make_script_with_merges(struc
 		if (entry)
 			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
 		else
-			strbuf_addf(out, "\n");
+			strbuf_addstr(out, "\n");
 
 		while (oidset_contains(&interesting, &commit->object.oid) &&
 		       !oidset_contains(&shown, &commit->object.oid)) {
