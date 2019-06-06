Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DB71F462
	for <e@80x24.org>; Thu,  6 Jun 2019 12:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfFFMKe (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 08:10:34 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:41057 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfFFMKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 08:10:34 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id YrDxh78tkniZTYrDxhAysa; Thu, 06 Jun 2019 13:10:30 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=cm27Pg_UAAAA:8 a=zM4gqt3LEnJwM65h1vQA:9
 a=-t08PQZ5qw_vDj-n:21 a=QFOw3XsfVx9SVvDM:21 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22
Subject: Re: [PATCH v3 01/14] commit-graph: document commit-graph chains
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
 <pull.184.v3.git.gitgitgadget@gmail.com>
 <b184919255bfc9e0d57e1a5ca12fb76957879c61.1559577826.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <6a6a0b72-e503-1fdd-e67e-2a84d825f89b@iee.org>
Date:   Thu, 6 Jun 2019 13:10:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b184919255bfc9e0d57e1a5ca12fb76957879c61.1559577826.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfJIiV2LY5aQxgIaqBDW+Cfk8ewgUjb+xdci6EcKcMPBTzh6MExoWTzOoUR8/viTJ7kE6+RDzwax+018OX7RqeRjMAbgpPzanuahHgBggoDP+ikwk89e8
 eoLxuk7NtHSw4eRt5mGa6UuXe7blBOV4ZkejzUmMz3o5wW84dgbSRrU/svzimT7cnlfidlxlT6+3Afwm/s5ijmxvzYO7RNM0X7vxMXNo8aA6Fi0zvlPi9wSk
 znRjuFMCWkrvJwI7XGHNMzk+cb3UwQ3ux/fh+ZbKzhSZuauJ2A0X4WTipNl7P4hyeow1Q6sB3UushWaIMEeGmkFhR9XxWqCm+m21QuPfYKYlQstwHnSmnP2b
 7WPFJYZliULMoo4Nf0WJqdPZyh38gRxfdWoPsBYLny8ThrKvfHJLHdO6p6vK8n6xwtm0AUPa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick ,

On 03/06/2019 17:03, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add a basic description of commit-graph chains.
Not really your problem, but I did notice that we don't actually explain 
what we mean here by a commit graph (before we start chaining them), and 
the distinction between the generic concept and the specific implementation.

If I understand it correctly, the regular DAG (directed acyclic graph) 
already inherently contains the commit graph, showing the parent(s) of 
each commit. Hence, why do we need another? (which then needs explaining 
the what/why/how)

So, in one sense, another commit chain is potentially duplicated 
redundant data. What hasn't been surfaced (for the reader coming later) 
is probably that accessing the DAG commit graph can be (a) slow, (b) one 
way (no child relationships), and (c) accesses large amounts of other 
data that isn't relevant to the task at hand.

So the commit graph (implementation) is [I think] a fast, compact, 
sorted(?), list of commit oids that provides two way linkage through the 
commit graph (?) to allow fast queries within the Git codebase.

The commit graph is normally considered immutable, however the DAG 
commit graph can be extended by new commits, trimmed by branch deletion, 
rebasing, forced push, etc, or even reorganised via 'replace' or grafts 
commits, which must then be reflected in the commit graph (implementation).

It just felt that there is a gap between the high level DAG, explained 
in the glossary, and the commit-graph That perhaps the 
technical/commit-graph.txt ought to summarise.

--
Philip
>   More details about the
> feature will be added as we add functionality. This introduction gives a
> high-level overview to the goals of the feature and the basic layout of
> commit-graph chains.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   Documentation/technical/commit-graph.txt | 59 ++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> index fb53341d5e..1dca3bd8fe 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -127,6 +127,65 @@ Design Details
>     helpful for these clones, anyway. The commit-graph will not be read or
>     written when shallow commits are present.
>   
> +Commit Graphs Chains
> +--------------------
> +
> +Typically, repos grow with near-constant velocity (commits per day). Over time,
> +the number of commits added by a fetch operation is much smaller than the
> +number of commits in the full history. By creating a "chain" of commit-graphs,
> +we enable fast writes of new commit data without rewriting the entire commit
> +history -- at least, most of the time.
> +
> +## File Layout
> +
> +A commit-graph chain uses multiple files, and we use a fixed naming convention
> +to organize these files. Each commit-graph file has a name
> +`$OBJDIR/info/commit-graphs/graph-{hash}.graph` where `{hash}` is the hex-
> +valued hash stored in the footer of that file (which is a hash of the file's
> +contents before that hash). For a chain of commit-graph files, a plain-text
> +file at `$OBJDIR/info/commit-graphs/commit-graph-chain` contains the
> +hashes for the files in order from "lowest" to "highest".
> +
> +For example, if the `commit-graph-chain` file contains the lines
> +
> +```
> +	{hash0}
> +	{hash1}
> +	{hash2}
> +```
> +
> +then the commit-graph chain looks like the following diagram:
> +
> + +-----------------------+
> + |  graph-{hash2}.graph  |
> + +-----------------------+
> +	  |
> + +-----------------------+
> + |                       |
> + |  graph-{hash1}.graph  |
> + |                       |
> + +-----------------------+
> +	  |
> + +-----------------------+
> + |                       |
> + |                       |
> + |                       |
> + |  graph-{hash0}.graph  |
> + |                       |
> + |                       |
> + |                       |
> + +-----------------------+
> +
> +Let X0 be the number of commits in `graph-{hash0}.graph`, X1 be the number of
> +commits in `graph-{hash1}.graph`, and X2 be the number of commits in
> +`graph-{hash2}.graph`. If a commit appears in position i in `graph-{hash2}.graph`,
> +then we interpret this as being the commit in position (X0 + X1 + i), and that
> +will be used as its "graph position". The commits in `graph-{hash2}.graph` use these
> +positions to refer to their parents, which may be in `graph-{hash1}.graph` or
> +`graph-{hash0}.graph`. We can navigate to an arbitrary commit in position j by checking
> +its containment in the intervals [0, X0), [X0, X0 + X1), [X0 + X1, X0 + X1 +
> +X2).
> +
>   Related Links
>   -------------
>   [0] https://bugs.chromium.org/p/git/issues/detail?id=8

