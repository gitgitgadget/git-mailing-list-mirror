Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA71C1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 18:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeDFSLz (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 14:11:55 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:43993 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDFSLy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 14:11:54 -0400
Received: by mail-qt0-f181.google.com with SMTP id s48so2055197qtb.10
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=knQTO9hRRKuFoVECQM+J8k1jndPR8pFbkaB6OSR3jcg=;
        b=p2xNFKM09rUX8VBo+zVNmjOvNd4hThiUeQFBmAssQ0VsrJsWbYZhr7/kdSZ9Vb+Lqf
         H0b37m5vh2MYqfyqPPh6B/qFr529DBhY7gzqF37LT9NeuhTDN83dPLq8oCQSo0zGz7F8
         bQPy2CeUclHT1THPvhi9g5GGokQqcmv+TUQShP1d0MS4mK5nU3mXV/N/hojUAxs6Czxl
         XbZh9D8JzcAPD6sMPbARR4sDyF/Tlwc1UAfvp2QY2I5gdbQrmnWY+wd5sj/qVmLIo+DN
         +sEKWcM7IRH4VhQyBhAsfuCniEdervsZ9YjDzh12zlBMCsvPAsQ2QoEz4Jsw3IHutsQE
         lxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=knQTO9hRRKuFoVECQM+J8k1jndPR8pFbkaB6OSR3jcg=;
        b=A8HMiTbRREqhRdXe3tkg6YlpKMIVSwfI7n5GB/vwMzn1Jbu1nBoiZHkI5PiYbawjep
         GjhIJzL+WwafuMORypWEGH12O1A9TIc+OS/uBdKbDPCYwXk4QYuukmPTt2+43mmp2k8P
         58XxFvA425EXVvE0N0Ef5pbShVpezU4g+ZhkN4v6Qvy6cdztkNepDKdsxZho1u3tCEnK
         kyZ9Oqy0vgdy+dtzCCrAfpNstC2ZywR2J3fmai6/vxiIbb11cbSOC1JEMHxjWItgB0kg
         FLa/9P+jsOADZajSIiJSAPThfWfBij5dtWdfaKmoVAzX4xOmrGzy4kd+VhDQb3I4nIun
         uJJA==
X-Gm-Message-State: ALQs6tAC3lMUC2o0sam1Eyo4bf7Ok52PGdm+z4/YRoKn7jQMQ09dEwxy
        stHXbYvq11huccloczFyuQwsVQ==
X-Google-Smtp-Source: AIpwx48MUq+ApGR68f7EOUwWSbgFMJzAgIUwaTimPNpDqSUnkK4kwujKwEM5/gxeg8qDceglfjVVOA==
X-Received: by 10.200.22.50 with SMTP id p47mr38824638qtj.135.1523038012444;
        Fri, 06 Apr 2018 11:06:52 -0700 (PDT)
Received: from [192.168.0.101] (70.15.201.38.res-cmts.sm.ptd.net. [70.15.201.38])
        by smtp.gmail.com with ESMTPSA id o22sm8661460qtf.59.2018.04.06.11.06.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 11:06:51 -0700 (PDT)
To:     git@vger.kernel.org
From:   Jonathan Primrose <jprimros@gmail.com>
Subject: FREAD_READS_DIRECTORIES test fails for the wrong reasons
Message-ID: <82c91eac-9dc4-834b-4648-3c4ba45af80d@gmail.com>
Date:   Fri, 6 Apr 2018 14:06:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while ago, the configure test for FREAD_READS_DIRECTORIES was changed
to (attempt to) check for a NULL result from fopen. Unfortunately, the
test will always fail - because it won't compile. The code snippet in
configure.ac translates to:

return f);

Either there's an extra ) or a missing (. A cast to int wouldn't hurt
either.

I'd supply a patch to fix this, but I'm not sure what the results of
suddenly fixing the test would be. It seems to work well on my
machine, but I don't stress git much here, and it's just one machine.
