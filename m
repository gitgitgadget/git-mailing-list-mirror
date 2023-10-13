Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC505693
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1915FC9
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 23:49:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C8E271FD7A;
	Fri, 13 Oct 2023 06:49:17 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 8C7102C34C;
	Fri, 13 Oct 2023 06:49:17 +0000 (UTC)
Date: Fri, 13 Oct 2023 08:49:16 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org
Subject: Re: -q option for git to suppress informational messages?
Message-ID: <20231013064916.GC6241@kitsune.suse.cz>
References: <20231012185308.GB6241@kitsune.suse.cz>
 <CAJoAoZ=MrjjfH6Noganejey0bAaB=d+jH_rXAqbscPG8E0m3Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJoAoZ=MrjjfH6Noganejey0bAaB=d+jH_rXAqbscPG8E0m3Pw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: C8E271FD7A
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Thu, Oct 12, 2023 at 01:46:09PM -0700, Emily Shaffer wrote:
> On Thu, Oct 12, 2023 at 11:53 AM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > Hello,
> >
> > when using git in scripts I find that many git commands insist on
> > printing informational messages, and the only way to avoid this is to
> > sent the output to /dev/null.
> 
> Michal, you might want to investigate further whether there is a
> plumbing-specific command that meets the needs you're concerned about
> instead. Those commands will not have additional human-facing output,
> and have a stronger guarantee around backwards-compatibility than the
> human-facing commands do.
> 
> Commands which count as "plumbing" can be located in `git help git` in
> the full list of subcommands; if you're not sure what alternative to
> use, I think you can feel free to describe what you're trying to do
> here and get advice on which plumbing commands to use instead of
> porcelain ones.

I want to replicate the repository data between multiple machines.

Git is 'distributed' VCS but AFAICS it supports replicating repositories
very poorly.

In one direction there is git push which has convenient --mirror option
and also can be scripted to replicate only selected references. AFAICS
there is no lower level command that can be used. There are commands for
uploading data to the remote repository but only push updates
references, no -q option.

In the other direction there is git remote. Of course there is no
cross-reference from git push, cross-references are for losers that
don't know everything about the thing. There are lower level commands
that could be used instead I suppose. Commands for downloading data are
available as well as for updating local references, and for one fetch
does provide a -q option. Also unlike push git remote cannot operate on
commandline arguments alone, it requires configuration. Rewriting it
using lower level commands might bring the benefit of not requiring
that.

However, this whole suggestion somewhat sounds along the lines
 - The shape of this chisel is not great, maybe it could be improved?
 - The other side of the hammer has an edge, maybe you could do
   without a chisel?

Thanks

Michal
