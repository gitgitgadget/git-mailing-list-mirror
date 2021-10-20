Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF1AC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4206138D
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJTON0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:13:26 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:27626 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhJTON0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:13:26 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mdCJC-0006Mu-9p; Wed, 20 Oct 2021 15:11:10 +0100
Subject: Re: [PATCH 1/4] gitfaq: add advice on monorepos
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-2-sandals@crustytoothpaste.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <557fe5b8-36b4-a760-d2dd-02137746a37b@iee.email>
Date:   Wed, 20 Oct 2021 15:11:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211020010624.675562-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/10/2021 02:06, brian m. carlson wrote:
> Many projects around the world have chosen monorepos, and active
> development on Git is ongoing to support them better.  However, as
> projects using monorepos grow, they often find various performance
> and scalability problems that are unpleasant to deal with.
>
> Add a FAQ entry to note that while Git is attempting improvements in
> this area, it is not uncommon to see performance problems that
> necessitate the use of partial or shallow clone, sparse checkout, or the
> like, and that if users wish to avoid these problems, avoiding a
> monorepo may be best.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/gitfaq.txt | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 8c1f2d5675..946691c153 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -241,6 +241,32 @@ How do I know if I want to do a fetch or a pull?::
>  	ignore the upstream changes.  A pull consists of a fetch followed
>  	immediately by either a merge or rebase.  See linkgit:git-pull[1].
>  
> +Design
> +------
> +
> +[[monorepos]]
> +Should we use a monorepo or many individual repos?::
> +	This is a decision that is typically made based on an organization's needs and
> +	desires for their projects.  Git has several features, such as shallow clone,
> +	partial clone, and sparse checkout to make working with large repositories
> +	easier, and there is active development on making the monorepo experience
> +	better.
> ++
> +However, at a certain size, the performance of a monorepo will likely become
> +unacceptable _unless_ you use these features.  If you choose to start with a
> +monorepo and continue to grow, you may end up unhappy with the performance
> +characteristics at a point where making a change is difficult.  The performance
> +of using many smaller repositories will almost always be much better and will
> +generally not necessitate the use of these more advanced features.  If you are
> +concerned about future performance of your repository and related tools, you may
> +wish to avoid a monorepo.
> ++
> +Ultimately, you should make a decision fully informed about the potential
> +benefits and downsides, including the capabilities, performance, and future
> +requirements for your repository and related tools, including your hosting
> +platform, build tools, and other programs you typically use as part of your
> +workflow.
> +

Does this need some comparison, or link, with sub-module methods and
issues? Such as the nested sub-module problem, the distinction between
active sub-modules and quiescent sub-modules (e.g. libraries Vx.y.z)?

As an aside, I don't think we provide any background to the Git
philosophy that frames some of these issues.

-- 
Philip

