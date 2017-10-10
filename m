Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409D12036B
	for <e@80x24.org>; Tue, 10 Oct 2017 18:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbdJJSa0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 14:30:26 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:49310 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756558AbdJJSaX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 14:30:23 -0400
Received: by mail-pf0-f174.google.com with SMTP id l188so18108478pfc.6
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 11:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gJ762F63//JFottnZCAvOnw1k8mcow/0mt7RAIhGsU=;
        b=odKvrlytzpq/2f6LSmlVop3Al9mzfkHIY+oARaA+2v6n+LaJuFhFm4mkH+/0b0GCzt
         tBXd1B3PQHNLwVgLICMF/WFH39yIdT5p+DeuRIsxT42JLWl36bV5J11gUD4+Sgg8e+PW
         ss0MA8KJ8A/2lU7IAhp50W5J4Raaz2E7M/uBhBgAJkoepgE/KzIgTGaLnts//lSsSMQ1
         c1wIETBCZNqxRZadj9rQsef/KqSZBFaxCYzyxllKoeDrhYuPlYSt1NKL+LEhCbai6e5J
         Jl8KDZAIAgxJQrNsxDhTSRxo9SfaEB4dgv6gio51r6s6+AbdiE/YdiuzceXLr01Zv5Hl
         DAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gJ762F63//JFottnZCAvOnw1k8mcow/0mt7RAIhGsU=;
        b=XBzoC/1XPhJI5SEJ0lpMNyWCbDYuUJaIzy4QC9X2QdcIZDNwjAvNJSQV2qwiq3zaeh
         +YphUpQySKhkqQh2Ck+FUtLLEJu2kVu8TwV0I7ssrIzzpgaT+do9LkW67C+n8zBhT4A+
         zUxkwvB/ai0SXg/wC4UHkIR1j1MZiJvy06RWFkYuCuO1ENH9A7IeLIPE97vlBv8L4GaB
         AsO/XJHurr5w2HE9PpJHuZrfd3NHHJmv8I2dg71aqYSOvaKgcnSYDNfgxEBQL2DQNO5N
         vDx7+38sJN2TVjYKTnlI+8NlKtjm2HcLxDX/XFV59s6fy+dBip6PNUEPSGtEoRGc568N
         D/sQ==
X-Gm-Message-State: AMCzsaWZuWSnJ1VxdjGrfGCtRjORC7wS6eSOk3k8uGDAoNIX1zFSWhmg
        MAAYq03prejrpWpsROh3fTFiOA==
X-Google-Smtp-Source: AOwi7QCsE3mdyCBO9p7IWRHM33djc1KFz0EVGwOxk+uB9w3zOi5LBOtGv6KMAAcgs+oBrUv+0wNHqg==
X-Received: by 10.99.183.10 with SMTP id t10mr6039928pgf.128.1507660222787;
        Tue, 10 Oct 2017 11:30:22 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:961:a8fe:b03f:d840])
        by smtp.gmail.com with ESMTPSA id z86sm7113520pfk.34.2017.10.10.11.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 11:30:22 -0700 (PDT)
Date:   Tue, 10 Oct 2017 11:30:21 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 07/10] connect: tell server that the client
 understands v1
Message-Id: <20171010113021.0a23506a5d1ebaf4e8ff1f9a@google.com>
In-Reply-To: <20171003201507.3589-8-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-8-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Oct 2017 13:15:04 -0700
Brandon Williams <bmwill@google.com> wrote:

> 2. ssh://, file://
>    Set 'GIT_PROTOCOL' environment variable with the desired protocol
>    version.  With the file:// transport, 'GIT_PROTOCOL' can be set
>    explicitly in the locally running git-upload-pack or git-receive-pack
>    processes.  With the ssh:// transport and OpenSSH compliant ssh
>    programs, 'GIT_PROTOCOL' can be sent across ssh by using '-o
>    SendEnv=GIT_PROTOCOL' and having the server whitelist this
>    environment variable.

In your commit message, also mention what GIT_PROTOCOL contains
(version=?). (From this commit message alone, I would have expected a
lone integer, but that is not the case.)

Same comment for the commit message of PATCH v3 08/10.
