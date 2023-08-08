Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEF6C04A6A
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjHHTxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjHHTxW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:53:22 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FE9C446
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691517799; x=1692122599; i=tboegi@web.de;
 bh=15Bu1GUGJbJPAZsvjnr2A26Jbne8XK6ScLTiV2MTjB0=;
 h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
 b=VYySHTdHAdw4iY3IfZnCsNoA5oGd/0qj0rLbADjVI/Nj9exoM9f3WmCGygiOWV/yJqKTkwC
 aWkO6NXGYlkdjhj3uNtMRnVrzIu+wJUBKmiDyK7a8HUjHEZXDPxYRYbM0aC8WfsdyGmufRjSv
 CpoA/NmLGgyjJ3wt7dgih01sESJuVYadWOIwugjHwWiLmwveJZqHdh3yIxqL8zbWhTk/UqwkR
 GlyPo9lsE9NDNrDuv33M44dkNMVi7Y/5wBho9ZGyIFgyK4xiuiiCy04kRU/1a4SGhuhz1fwVK
 R/KSmB6U+m44oH2G6nw7hUA/9d+UH+rlFWp2Q1yZ9hFWrFF9337w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1pfKZN1Zkc-00vBf2; Tue, 08
 Aug 2023 20:03:19 +0200
Date:   Tue, 8 Aug 2023 20:03:18 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     git@vger.kernel.org, friebetill@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
Message-ID: <20230808180318.bu5nlbrnndpfkuxt@tb-raspi4>
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
 <20230808172624.14205-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230808172624.14205-1-tboegi@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:goQfPrKz2VB3gzBa/T0u4HxowTJqh3qfrilt/zCTxveN+2XFsbV
 Tmlzs+7M7HhXUHeTS5mroP7rcZvouHX1z0T8D1q6h/M/yVB6rE5MET46ygm93TKF6khKOhi
 ak5APv6ptFVXK4Kvi+K5pKv5mLLrvk0cECw3MxlW6nk2Jnq6VvEDiM6qk04ZMhAQ4P3XUF/
 jY9Q+av07zUnlgQqhhWgQ==
UI-OutboundReport: notjunk:1;M01:P0:J6GlvZnaxYI=;j1jgDzbz1Ydzs7JChbji3dW6OK4
 BT4VEHA/nUMHMT3u0i2P7UZYaSXneHnlR9RwwkcaaZw6YBws30irb1jy4TZfXxaRIdJxfEnQK
 p2CDgxUCvY2gS2n/27v8V4oOv4WVW48fxwkGeQPpOGeXjpnBJXarlwSy8Q75vGrdt6POYeYMm
 jZnE27dAe3b4KT80n5Hfy1hjAVXdThlYkvz9iIliGlVtZQ7pEpDVwAK+StNhQafh8mjiQxpa0
 oJO0ZLtQqeRn6hNLIlEX9KY1wrOB1pptUKjMdZPTNWFUgcuZgt+XU21bO2MWFfuxdYxYuMXWz
 KsABUwQCiQGQYn6meiBmwI3H0Osq/l6xyzYDN+xKxuOxW4douumB1NW4oWiHnvJ/4hb/ui17k
 qWHP4ZfqK04uQsh7NT0+VDcEwPsFMJNC/MsNPyV81EeQOT+zWV8LifSSwi9qeZFObD4/eV5YU
 xBBtej92kOZ/EeELFYvb9w170ou0vJBXsMCvbDWtvcnqq7xlvP3aXGPgHPkr4py1rYmUGn2Kj
 RGv/dj4wElNNbjZ+65MUTldap9kiy3Yu1lZfi3dG5m/FgqZ5z8SAn2+kq4jJwuyiCO7DLBBhM
 +Soa2Etu/qCnzrt8YQDJZvBL1SNUkIqwH+raxOQHGAUGqqd1whw7iVsp5xhh6Aj25cf4nh1US
 l2kptdtnbwaIK5fW8Uq5OedqVh9B3RNmpOpmWw6C+sRykNMORVuyu4pdKx3Q04jzyiDgx82EE
 mklSk6B3+D87PUhuxjQjBu3Gy2zt1KV+aSe2NilfvNETh9VYCyx25HT8sTMLVN43yZb2vzNlk
 CwL/gXiMijSzRPSbIVKfs+u/wJeHvEAwaEN1g3lRBnqwMw+LXQd3gMMyXv43t4rOeGM3JKBFX
 gFmH+ntOqaKVG4TreDxv7rMqGmnNfOMYzjTOHaLIeEW9KfQ4bFGIGWxPeHaL6VkB+ZK/Ct/nk
 8tumztJcIkEtBGFLaBbwNrvKSzw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 07:26:24PM +0200, tboegi@web.de wrote:
> From: Torsten B=F6gershausen <tboegi@web.de>
> .

... The following sequence leads to loss of work:

I just realized that this breaks other tests:
t1092-sparse-checkout-compatibility.sh not ok 17 - diff with renames and c=
onflicts
t1092-sparse-checkout-compatibility.sh not ok 18 - diff with directory/fil=
e conflicts

However, comments are welcome:
Is it a good idea to create file called "filename.untracked" ?
