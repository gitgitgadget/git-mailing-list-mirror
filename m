Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A75C1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 03:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfIWDSR (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 23:18:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34363 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfIWDSR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 23:18:17 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so30021785ion.1
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 20:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=eeVs6IlKU9BdB2bwHi3j12nuMozHIbAZTykHhR4xcBA=;
        b=K0PR7qhRMAx1p2HeWSWNHuWtWNdaTB/Oj+lVRPNVH2Wq7kC2QX8Ho+y4aEwbUxAGh+
         x134hWe9nxhIXykmOfRMNzojZ+IzQEf5p9wy51AqTeHEGeeDVr9/Yfu64/8msB6FRI5X
         zkgtPrMTUeBhEvg+JEngyE9Cbuabgt+5m/oyYkfPgJp5K9OxFhTZHiNmjGRcFQElMWVm
         h2lHclFvBS3tOlQDoCUHKLAR8AZIgeNFRV+qu8TFQ96xcAWpJK/Ze3jCx7FVN5C9rUsw
         fVM7aGobJD+FAg6q9wyI1HjrNgxPRgw9X+BxFsyBVAGqXwyL0YtujurjjfFYSlrEKWfz
         OGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=eeVs6IlKU9BdB2bwHi3j12nuMozHIbAZTykHhR4xcBA=;
        b=EHn2ybxFwHTHs5nMJh73alZhoYX7qwo/lShCCScEcJGM97ey03naVrbr7aFKKAFETZ
         JQx3WVVADv1hzwvxwKe08Ow+DubvjOk/BtokeIXN09xKomWazdOFN6+VW2Y1WBA0+ijU
         cbAapvBq40n+zNdYGgQq0tA+vJNyTzr5oxhRM/dmZU6Iz3daxUscFOoUqcUKwngTkZzq
         YAjI758ab41cgVpEPfUJEr59Vy+3VLMSi2cmPY30fSFJnOIjorJr/kdTl6C0L8aCIjqF
         d0VSL5OlHx4HItb5xNT2f3l8h/E/dHX38eqmAb0QQ1S3/xd+OZBi6I50gfeG6rDC77TX
         HsCw==
X-Gm-Message-State: APjAAAWTxRblttTxRlOT6GIg/co/Pi5BMnq0Dulr9V5pCjJ1H9LWhYnq
        la6acl/jDLgJCiYgBpwq/9D2XyD2S5Uky0982Qgh6LRFtOM=
X-Google-Smtp-Source: APXvYqwJzCjsl2yHHzCEwCHkc7J4T0d9nLrqeOgX98ZycW6m++jqbgHWVxBi9TlCYlBU03VF7hrm3KzSY4044nw0Z88=
X-Received: by 2002:a02:a999:: with SMTP id q25mr4358390jam.27.1569208696127;
 Sun, 22 Sep 2019 20:18:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 22 Sep 2019 23:17:59 -0400
Message-ID: <CAH8yC8nVBcBntJVZ6eV+YxoBpZRx+ecC2JxGuunhxNbY2cGyFQ@mail.gmail.com>
Subject: How to see command line arguments passed to program in core.sshcommand?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm working in an unusual setup on WIndows. I need to 'git clone' over
SSH, but a third party program has to handle the tunnel. It happens by
using this git configuration:

    git config --global core.sshcommand "tunnel.exe ... <path-to-public-key>"

After I execute the 'git config' command, I open ~/.gitconfig and
ensure the path is correct and quoted per Windows standards.

So far the result has been a failed authentication, which seems to
indicate something went sideways using the public key. I don't receive
an error from Git or or the tunnel program relating to a "file not
found" (or any errors for that matter until authentication fails).

I need to spy the command line arguments being passed around, but I
have not been able to do so. 'git clone -verbose' is ineffective, and
-vvv is rejected as an unknown option.

How do I see command line arguments passed to the program in core.sshcommand?

Thanks in advance.
