Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C618F200E0
	for <e@80x24.org>; Wed, 28 Dec 2016 01:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755888AbcL1Bew (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 20:34:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36402 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbcL1Bev (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 20:34:51 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so59721755wma.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 17:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=qPMTuf271NgEgSLWdSRV4uN63zmHt9iFUQFa5JocDZo=;
        b=JivKA7PvhB1JSaRiNadvr2i6rUUgT9wcmdSMU1u9AKWOvzVtkAGcV/qZVFDardzb4T
         MmEF12q49C4ODnYCli2kQhdrInhmQoqk63r+cEYbE2AjtF9REfryH8C6pEvpOOHDdVxp
         mm72vnFq9kGaVTRL9wasV6X85g342YxuiFkDft3tjNAvrDAbi+Aaq46WaKJp9fjQhRae
         wxXJUmMfi8nGSIAS/q+cLvIYTj/RAxr2mJsMo3LwHMCax+Yws3Qmc9AvrgGZW5wRgkM0
         wxDKV20JDYU+quwgBA3l58qCd7T9tihJjMSujcFSFFLQgz+sYkkkYaxvx6Tf9yVN5xId
         axkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=qPMTuf271NgEgSLWdSRV4uN63zmHt9iFUQFa5JocDZo=;
        b=boJPl8OQZGel0Tj8X3ROXyLUOG3kXCNcr6GBnhP6348+IOP/Lr+KrVVRAZRFGdC/Fz
         yG0ghSFNyA8LCQDs6IzqXAmA6pxVoD1s9pbb7we2VKXQtjPL8U6FdG5a4rGmgKrycEmF
         nXIqpo2qEdfo+WYyEMbOHllE9EGXt0PnAREbK3yQJ3C/Vw6niksL1/yQ8kvusbO+Uxr/
         kLQDC6cMxEkClkTmfzOgetiw8pnV4qJB8c++C0tptf941e68KszZ2xBpnLQX4IY6y3BC
         owiyJ2NL3WlpYiz40JccijxuyF/GjvrH7iwJFkGhuOHxPaMfFOeJBEi2IQ2tvvABxcz5
         uJnw==
X-Gm-Message-State: AIkVDXLkIW2BaZ7oGY5ULKaGFeYvsTo3K64kqOFdwIz3l8P7trslYWSbEIa1RkK1LsdWMQ==
X-Received: by 10.28.31.23 with SMTP id f23mr34537728wmf.94.1482888889125;
        Tue, 27 Dec 2016 17:34:49 -0800 (PST)
Received: from [192.168.0.213] (88-111-149-57.dynamic.dsl.as9105.com. [88.111.149.57])
        by smtp.gmail.com with ESMTPSA id 14sm58473530wmk.1.2016.12.27.17.34.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 17:34:48 -0800 (PST)
To:     git@vger.kernel.org
From:   "John P. Hartmann" <jphartmann@gmail.com>
Subject: HowTo distribute a hook with the reposity.
Message-ID: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com>
Date:   Wed, 28 Dec 2016 01:34:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would like a hook in .got/hooks to be made available to all who clone 
or pull a particular project.  I'd also like the hook to be under git 
control (changes committed &c).  I added a hook, but git status does not 
show it.  Presumably git excludes its files in .git/ from version 
control lest there be a chiken-and-egg situation.

Is there a way to achieve this?  Or a better way to do it?

Thanks,  j.
