Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B51CF86
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57E5100
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:55:56 -0700 (PDT)
Received: (qmail 22655 invoked by uid 109); 23 Oct 2023 18:55:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Oct 2023 18:55:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14867 invoked by uid 111); 23 Oct 2023 18:55:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Oct 2023 14:55:57 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Oct 2023 14:55:55 -0400
From: Jeff King <peff@peff.net>
To: Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2] upload-pack: add tracing for fetches
Message-ID: <20231023185555.GD1537181@coredump.intra.peff.net>
References: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
 <pull.1598.v2.git.1697577168128.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1598.v2.git.1697577168128.gitgitgadget@gmail.com>

On Tue, Oct 17, 2023 at 09:12:47PM +0000, Robert Coup via GitGitGadget wrote:

> Information on how users are accessing hosted repositories can be
> helpful to server operators. For example, being able to broadly
> differentiate between fetches and initial clones; the use of shallow
> repository features; or partial clone filters.
> 
> a29263c (fetch-pack: add tracing for negotiation rounds, 2022-08-02)
> added some information on have counts to fetch-pack itself to help
> diagnose negotiation; but from a git-upload-pack (server) perspective,
> there's no means of accessing such information without using
> GIT_TRACE_PACKET to examine the protocol packets.
> 
> Improve this by emitting a Trace2 JSON event from upload-pack with
> summary information on the contents of a fetch request.
> 
> * haves, wants, and want-ref counts can help determine (broadly) between
>   fetches and clones, and the use of single-branch, etc.
> * shallow clone depth, tip counts, and deepening options.
> * any partial clone filter type.
> 
> Signed-off-by: Robert Coup <robert@coup.net.nz>
> ---
>     upload-pack: add tracing for fetches
>     
>     
>     Changes since V1
>     ================
>     
>      * Don't generate the JSON event unless Trace2 is active.
>      * Code style fix.

Thanks, the first bullet point there addressed my only concern.

The rest looks good to me overall. I think it is a useful feature to
have (as Taylor mentioned, GitHub has something similar via custom
code), but it has been long enough since I have operated a server that I
don't have opinions on what specific items should or should not be
included. :)

-Peff
