Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2DAC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 03:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJKDQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 23:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJKDQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 23:16:09 -0400
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 20:16:04 PDT
Received: from box.elsiehupp.com (box.elsiehupp.com [104.131.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A174DC7
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 20:16:03 -0700 (PDT)
Received: from authenticated-user (box.elsiehupp.com [104.131.30.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by box.elsiehupp.com (Postfix) with ESMTPSA id 4457AFC07B
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 23:06:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elsiehupp.com;
        s=mail; t=1665457593;
        bh=HSC2jRCdtBd3/p4qrtLJjtj9RD3CbCm32XA2yVujiuc=;
        h=From:Subject:Date:To:From;
        b=DDuA5ULJETzGvdg7EzwtmlyHxJ2PuL6wX12HybrpqQFueKd2mldg7n5230hLIDVlj
         RJT3c6l8tsSyBUAqqstp6lJU5IxIN/FNIL0qkK2M77JE+tEXwG7KHqD/QOk3yxkMF5
         jbyW96VwK14StIRCyuGl3zhfZ+wdF0XJoqRknohiT9RUjpJv1Ya1oedx6dYOcVyUha
         oGhnxP8BlvRhEGyPbAWkNgpv/ftGYDLFL1O0I6s6iQrhw7intYRDLJY53v8kqi9r5d
         5Ex92mYx4EvHOb3xUNJGHewGCCIhQ8Ub5ZiXUTUo5QfcK56oHIubTFnVyxVff8OICC
         dK/G0IQAyH1XQ==
From:   Elsie Hupp <git@elsiehupp.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Multiple --global config workspaces?
Message-Id: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
Date:   Mon, 10 Oct 2022 23:06:32 -0400
To:     git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Mailing List,

The way I personally use Git has a slight inconvenience: as far as I can =
tell, there is no way to define multiple git config --global workspaces =
in a single Unix account.=20

I structure my cloned repositories based on the remote host, e.g.:

~/Repositories/github/cloned-repository-name
~/Repositories/gitlab/other-cloned-repository-name

=E2=80=A6and I sign my git commits for each remote host using an email =
address and signing key specific to that host.

I imagine many people have similar arrangements for the purpose of =
separating, say, work projects from personal projects.

Before I started using this workspace arrangement, I was able to do the =
following:

$ git config --global user.name "Elsie Hupp"
$ git config --global user.email "elsiehupp@example.com"

However, now that I use different signing identities for different =
remote hosts, I have to set up my Git identity every single time I clone =
a repository, and this repetitiveness is the slight inconvenience I =
refer to above.

What might possibly help in this situation could be if I could have the =
global ~/.gitconfig somehow delegate to separate .gitconfig files in =
each of the workspace folders I have set up, e.g.:

~/Repositories/github/.gitconfig
~/Repositories/gitlab/.gitconfig

=E2=80=A6and then have git config --global in, e.g., =
~/Repositories/github/cloned-repository-name apply to all cloned =
repositories in ~/Repositories/github but not to cloned repositories in =
~/Repositories/gitlab.

(Obviously there are other ways this could be implemented, but this is =
the one that immediately came to mind.)

How feasible would it be to implement multiple --global config =
workspaces with functionality along these lines? And what other =
considerations and issues might there be with doing so?

Anyway, thank you for your time and attention.

Sincerely,
Elsie Hupp=
