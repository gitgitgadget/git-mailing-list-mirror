Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6ACE1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933715AbeBVSZN (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:25:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35954 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933711AbeBVSZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:25:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id f3so175283wmc.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w6tmx6g7MPCJDtvnERU7r/5lYVUp5tABkWr0+ZV2Bbc=;
        b=Fbx8FzqzHhbnJ+hynYJLdbAJlTUCszUdwBR90pQVcIuzLp4TJaLqBtMMopbtsvTYac
         3Mm+Pk908TSzfrQXriSs6G+9C7IFuGcejEDQgukE6L9JvnPBOoUO/kleAxPHI+RlpY3C
         mOszj3DUohMpwHUHafiwhmwDbGSBHWyyDMcHyd3/zFFb7pTpJU3f5BKn4fAZlxbTNlal
         sHNn3gVy6oBNweFXFRPYzHPyHx0DSOg/h78UtTZgdkUhM18/cwOEP/XJ7SecwT6dndVf
         AAmD90ech0XSEalKGLW3++WRe1hXEx9i0SlfL77KryR43ZX4vu+xcgmgk1ziZAiMVFZ0
         7N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w6tmx6g7MPCJDtvnERU7r/5lYVUp5tABkWr0+ZV2Bbc=;
        b=bUQCvkIXykGY/H3LXevGq/d5grz+kELGJwq+92DisvSsc3ygbpleHNUTYY/cDHzXMP
         p4Jfog0L04HxL7J2ig604+c/q6LiRqjAWwrJ94KhW3OmpWaQpH0NkvSTbSVmxG59ihVt
         TV1/herPFysdForQmsSTBscU1dQQvblWXR1nfIzbwWiTlVa8IPYs8OGTWGJU1rjKNhoN
         71EDAv3qnmFWKQKru02uk8FGuoM+uSZ/PXa1oEL2bquNqgqPYTmX8/ERzHeDZj6lPQQI
         byfIvO2G9i5Y2cIeSvafpcrYNz6x3o35kF/L0u7C0AJ9c+1VrjGH5G0VPLWriKUzbosO
         5wPg==
X-Gm-Message-State: APf1xPCJ3Od+LT92toTKlovix8zrOWBT054uGCBVzMYVywwySqe/HfVa
        jb/Ukp7vTWSuGeFitFzXlKo=
X-Google-Smtp-Source: AG47ELtQKwW/OVNiLUWqlMIw4ZrIq2+bOLuP+oZAkVIpgmftWVATjB2hExQJAe3oBZYs9Q11xHMEDg==
X-Received: by 10.28.9.140 with SMTP id 134mr74144wmj.23.1519323911295;
        Thu, 22 Feb 2018 10:25:11 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s80sm802642wrc.93.2018.02.22.10.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:25:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 06/13] commit-graph: implement git commit-graph read
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-7-git-send-email-dstolee@microsoft.com>
        <xmqq371uyufx.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 22 Feb 2018 10:25:10 -0800
In-Reply-To: <xmqq371uyufx.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 21 Feb 2018 12:11:14 -0800")
Message-ID: <xmqqo9kgx4op.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> +'read'::
>> +
>> +Read a graph file given by the graph-head file and output basic
>> +details about the graph file.
>> ++
>> +With `--file=<name>` option, consider the graph stored in the file at
>> +the path  <object-dir>/info/<name>.
>> +
>
> A sample reader confusion after reading the above twice:
>
>     What is "the graph-head file" and how does the user specify it?  Is
>     it given by  the value for the "--file=<name>" command line option?

This confusion is somewhat lightened with s/graph-head/graph-latest/
(I just saw 07/13 to realize that the file is renamed).

Perhaps describe it as "Read the graph file currently active
(i.e. the one pointed at by graph-latest file in the object/info
directory) and output blah" + "With --file parameter, read the
graph file specified with that parameter instead"?
