Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4270F148850
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465398; cv=none; b=U4/xObvr1iY7aIdaO9lx+s0+2CkSmF/RU4C43DLuOytxMo4Is2QLST2KLWE75KH1LUmVJFZE25CFVYGCB93zZlGneAf/5bT4vAaWGQxRqp+WddEv/WfXzy/mnhGGKM16zZBdPSXhM/MJQcU73rz70M90HHh02fDSK1n4bRuL5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465398; c=relaxed/simple;
	bh=SE+t1Pq7OegtpyrtgfX35jX8ce/vCuDDWqdFemFP2/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YaBXCL9cBOLM+mH7CGZi0V/smqgbhNZueLjRhP00V3jELCJA4XMpBOmbTsMB+Gx63dOlfxd/fFCYYTyrL/LnXskCt/VZPouUMImAx9EoVBUADcYGleYyxlk75oWJde+Qf1OlMNyLH9zIkGMvCKVRSAGrq0ir2rE/NI9RzoxmNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MjX9XlOz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkT2ioZl; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MjX9XlOz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nkT2ioZl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3747F11400F4;
	Tue, 17 Dec 2024 14:56:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 17 Dec 2024 14:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734465394;
	 x=1734551794; bh=FX1VW8upDOWajjufhLj6dzVIh7bBXrjU+11X+8vCbUE=; b=
	MjX9XlOzcibMfE1R6r4mXn9/oMIxRfloV+o5c22jM0HB5paja+JL/ep4f/TRy2F6
	mVP20r/KR8mfLwsBovqfaMvEvxKhaxV2DcQPSW/MDRT3LYimnay7mvfhMkiI3pOg
	28dRZ4VkGINbuoACafIN+WGBnXiIms1zF5Z5HguAG/pam/Dv0GeU9+T5t15a8d41
	rW0DeXWim10jr39xuwwHcrT2dJt/UIRLUXDVBwKKKrjhkPBIblXsucGx/QxbFCAJ
	ZLu3QPwFzQFTFQXekcjDxR4GA2sIk0I4IiRn5mq4hXA/Wzn31Xwq0MbPgHgvqqAI
	FOvpUa7PXed8apB7+LDKXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734465394; x=
	1734551794; bh=FX1VW8upDOWajjufhLj6dzVIh7bBXrjU+11X+8vCbUE=; b=n
	kT2ioZlUdlijbTAIhFlUeWVpY3XgyNz9mZtiCjH77vBotPErPDsv4RwTy4a0MdwQ
	X9xEvD/psRi0CFTgEuEA1y3dTNC3lbJDMjnQusa2Sf9mN+yXCV3NbUqLf7wQia86
	wKHSPQvEg7rpfG7xv8xcc/XQmViCYxmPj7xjiP03vncw4WjUw2Ow2JF6kAOqK4hu
	+Thg5TOhobbI6jiDWA3psY35hq1C/uoZMfeXs/qwpmrrMAxAcTqKZQ7r1n+aNztN
	sgnGhlob7nSZcG4m2UseXDkfIOQDUzsSkvy9wyNMX1jAC3ZM7RzJmAvTsmv3Txm1
	d7BG7bRp7ncfB2Yo7Q/Zg==
X-ME-Sender: <xms:cddhZ610QT9hqxire5XH6_qpNPCCUlfGkPs__mWtC7uqUyVviEK7kQ>
    <xme:cddhZ9E3JJvQFU0GkRXUSSaVGIVIsxDvGrx9O42T21Azqq12WAjpPtLPOVwBd2cUB
    jDQJasfylNW854Ewg>
X-ME-Received: <xmr:cddhZy7inUIY18ZcUmusCrQH7vlXxDao7PoJb3eE7uQlAi7REBloo4JVxGNSQlsp8ntML0zROs4dZWZGNsj-Z1mGXtbjpispVqGy_k8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhusghhrghmrd
    hkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:cddhZ70NuuFSNBBt-Qe4hZjLpyJxJiIo8rMDElq7nHzVfjGvmcsmqg>
    <xmx:cddhZ9FrDxEZHK9VKM7QxhOWOQZpKEuKKoPAnLDSjpjmaadN3ayIkg>
    <xmx:cddhZ09KAULLVmrMR6nQplje2rUQ-1rsljKCccB3M_dlf7q1HfX5yw>
    <xmx:cddhZykvwbhFqDNhLRynYIDQ_bb9vN3XFfdcO5uYO3UbmR6JZqn7Ww>
    <xmx:ctdhZ2OitbIykEsoJSAY69bF8yYpR8TUoatiWC4QbLN_SRzF-Rk8K29W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 14:56:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
In-Reply-To: <CAG=Um+0yFYeBQGznkVG6TJeN-U+qySbt-0EbvM6Vd-BcvSCT4g@mail.gmail.com>
	(Shubham Kanodia's message of "Tue, 17 Dec 2024 16:54:46 +0530")
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
	<Z2Emh42DJkHFGWq7@pks.im> <xmqqcyhq3ge7.fsf@gitster.g>
	<CAG=Um+1NwB=ymwg+oM62f_W8G=3Gt14UFGe+S2MM3gTOdUcuHg@mail.gmail.com>
	<CAG=Um+0yFYeBQGznkVG6TJeN-U+qySbt-0EbvM6Vd-BcvSCT4g@mail.gmail.com>
Date: Tue, 17 Dec 2024 11:56:31 -0800
Message-ID: <xmqq7c7y13tc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

> On Tue, Dec 17, 2024 at 4:51 PM Shubham Kanodia
> <shubham.kanodia10@gmail.com> wrote:
>>
>> On Tue, Dec 17, 2024 at 1:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > Patrick Steinhardt <ps@pks.im> writes:
>> >
>> > > If we want to have such a feature I'd thus claim that it would be most
>> > > sensible to make it opt-in rather than opt-out. I wouldn't want to be
>> > > surprised by remote refs vanishing after going to bed, but may be okay
>> > > with it when I explicitly ask for it.
>> > >
>> > > At that point one has to raise the question whether it is still all that
>> > > useful compared to running `git remote prune` manually every now and
>> > > then. Mostly because explicitly configuring maintenance is probably
>> > > something that only power users would do, and those power users would
>> > > likely know to prune manually.
>> >
>> > I am 100% in agreement with your reasoning.  If this thing is to
>> > exist, it has to be opt-in.  We also need to add ample warning why
>> > doing this asynchronously behind user's back while the user could be
>> > working in the same repository is prone to cause surprises in the
>> > documentation in big red letters.
>> >
>> > I however am OK with the idea of having it as an optional "task"
>> > that is disabled by default in "git maintenance".  "git maintenance"
>> > can be viewed as a platform-neutral way to set up scheduled tasks.
>> >
>> > A user may be a Git expert who knows what `git remote prune` does,
>> > and understands and accepts the risk of confusion doing so without
>> > explicit "do it now" from the end-user, but may not be a Linux or a
>> > macOS or a Windows expert to know how to write crontab or its
>> > equivalents on various schemes to define scheduled tasks.
>> >
>> > Thanks.
>>
>> Thanks for sharing your thoughts here. For some context — I currently
>> look after git performance for a very large repository (60k+ refs)
>> with a lot of active developers.
>> I've observed that while power git users keep their repository tidy
>> even without runnining maintenance, the majority of users infact don't
>> know (or execute these), and
>> run into performance issues. Easier fleet management was perhaps was
>> one of the motivations behind adding this to `git-maintenance`.
>>
>> While its pretty rare that someone relies on a `refs/remote/*`
>> reference (without creating a local copy of it in `refs/heads`), I can
>> see why it can be surprising and an opt-in
>> should be okay for me.
>>
>> Thanks,
>> Shubham K

If you want to mix a patch with other discussion, write a scissors
line (e.g. "--- >8 --- cut here --- >8 ---" and nothing else on its
own line) here before the patch begins, and tell readers that they
need to scroll 50+ lines before they can see the patch at the
beginning of your message if the leading part needs to be so long.

> From aed935055aff819cce591eecbf6697f8e8e7b99e Mon Sep 17 00:00:00 2001

Never include this line in the body of the message.

> From: Shubham Kanodia <shubham.kanodia10@gmail.com>

Having "From:" in the body of the message at the beginning of your
patch is a good way to override the author identity and set it
differently from what your MUA places on the From: header line,
when you are forwarding somebody else's patch and want to record the
author identity of the real author, but then this line would not
have your name-email.  Another use case is when your MUA cannot be
convinced to place your author identity on its From: header, but the
message I am responding to has the same name-address in the From:
header.

So in conclusion, the above line is unnecessary in the body of this
message.

> Date: Tue, 17 Dec 2024 16:05:16 +0530

Rarely it is a good idea to include this line in the body of the
message.  The Date: header records the time the general public saw
the patch for the first time, which is the author date as far as the
general public is concered, much better.

> Subject: [PATCH] maintenance: add prune-remote-refs task

Overriding "Subject:" header of the e-mail with this in-body header
is almost always needed when you are responding to an ongoing
discussion and including a patch after a scissors line.

So in short, "From/From:/Date:" should be dropped, "Subject:" kept,
and insert a scissors line before it.

> Remote-tracking refs can accumulate in local repositories even as branches
> are deleted on remotes, impacting git performance.

OK.  It usually is better to be explicit about the direction of the
"impact".  E.g., "impacting git performance negatively".

Have you considered using the reftable backend, instead of the files
backend, by the way?  It is rumored to scale much better with the
number of refs.

It is possible that the user deliberately kept stale remote-tracking
branches even after they are removed from the origin because they
used them as the bases of their topic branches, in which case it
would not be a good idea to blindly remove them, but I do not think
that needs to be said here.  These users would not be running
"git remote prune".

> While git fetch --prune
> helps clean these up, it requires a full fetch operation which is expensive
> for large repositories.

It is curious why "git fetch --prune" is mentioned here, especially
when you know "git remote prune" is much more appropriate operation
for that purpose.  The real justification this paragraph needed to
make is why it is a good idea to a new task in "git maintenance",
rather than letting the user run "git remote prune" themselves,
isn't it?

> Add a new maintenance task 'prune-remote-refs' that runs 'git remote prune'
> for each configured remote. This provides an automated way to clean up stale
> remote-tracking refs without requiring full fetches or manual intervention.

Again, "requiring full fetches or" is probably out of place.

> This task is disabled by default.

If we wanted to mention "fetch --prune", it is probably not as an
inferiour alternative to what you invented here, but as a different
way the user can work that makes the problem you are trying to solve
go away.  Perhaps near the beginning, after the "Remote-tracking
refs can accumulate and impact performance negatively", say
something like:

    ... negatively.  The user can have the "fetch.prune"
    configuration variable set to true when interacting with the
    other side, and stale remote-tracking refs will automatically
    pruned at zero cost.

Of course "remote.<name>.prune" is a more targetted way that works
per remote, but your prune-remote-refs works on all remotes,
fetch.prune is a better contrast.

In any case, stepping back a bit, for the population of user who
benefit from enabing the prune-remote-refs task, wouldn't it be an
even better solution for them to set fetch.prune?  You can tell them
to run "git remote prune" just once, set that configuration
variable, and then the remote-tracking branches will stay clean from
then on.  Any future interactions with the remote make sure stale
remote-tracking branches will be removed automatically.  Wouldn't
that be a much better option?  I am sure I must be missing a use
case where fetch.prune (or remote.<name>.prune) is not a good idea
but background prune-remote-refs task works better.

So, if we want to still add this new maintenance task, we should
explain *that* use case after the proposed addition of "you can do
with fetch.prune at zero cost" to the first paragraph.  IOW, before
starting "Add a new maintenance task ...", we need to say something
like:

    There however are cases where pruning stale remote-tracking refs
    at the "fetch" time is undesirable, yet keeping them indefinitely
    is also unacceptable.  <<HERE YOU DESCRIBE THE USE CASE WITH
    SUCH CHARACTERISTICS>>.  To help such use cases, add a new
    maintenance task ...

And if there is no such workflow where a background prune-remote-refs
task is needed and fetch.prune would not work well, then we do not
need a new task, do we?

Let me review the change (assuming that there are cases where
fetch.prune is not a good solution) below.

> +prune-remote-refs::
> + The `prune-remote-refs` task runs `git remote prune` on each remote
> + repository registered in the local repository. This task helps clean
> + up deleted remote branches, improving the performance of operations
> + that iterate through the refs. See linkgit:git-remote[1] for more
> + information. This task is disabled by default and must be enabled
> + manually.
> ++
> +NOTE: This task is opt-in to prevent unexpected removal of remote refs
> +for users of git-maintenance. It is recommended for power users who
> +are comfortable with configuring maintenance tasks and understand the
> +implications of automatic pruning. For others, running `git remote prune`
> +manually might be more appropriate.

"and must be enabled" is unnecessary---that is what "disabled by
default" means.  Also, we probably would want to add a sentence or
two to contrast this with setting fetch.prune to highlight why users
would want to consider enabling this (instead of setting fetch.prune).

Otherwise, nicely written.

>  OPTIONS
>  -------
>  --auto::
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 4ae5196aed..9acf1d2989 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -20,6 +20,7 @@
>  #include "lockfile.h"
>  #include "parse-options.h"
>  #include "run-command.h"
> +#include "remote.h"
>  #include "sigchain.h"
>  #include "strvec.h"
>  #include "commit.h"
> @@ -913,6 +914,40 @@ static int maintenance_opt_schedule(const struct
> option *opt, const char *arg,
>   return 0;
>  }
>
> +static int collect_remote(struct remote *remote, void *cb_data)
> +{
> + struct string_list *list = cb_data;
> +
> + if (!remote->url.nr)
> + return 0;
> +
> + string_list_append(list, remote->name);
> + return 0;
> +}
> +
> +static int maintenance_task_prune_remote(struct maintenance_run_opts
> *opts UNUSED,
> + struct gc_config *cfg UNUSED)
> +{
> + struct string_list_item *item;
> + struct string_list remotes_list = STRING_LIST_INIT_NODUP;
> + struct child_process child = CHILD_PROCESS_INIT;
> + int result = 0;
> +
> + for_each_remote(collect_remote, &remotes_list);
> +
> + for_each_string_list_item (item, &remotes_list) {
> + const char *remote_name = item->string;

Is the patch whitespace-damaged?  The indentation seems to be gone.
I won't comment on misindented lines and blocks in this review (i.e.
even if the original had such problems, I wouldn't be seeing them in
the message I am responding to).

> + child.git_cmd = 1;
> + strvec_pushl(&child.args, "remote", "prune", remote_name, NULL);
> +
> + if (run_command(&child))
> + result = error(_("failed to prune '%s'"), remote_name);
> + }
> +
> + string_list_clear(&remotes_list, 0);
> + return result;
> +}

OK.

>  /* Remember to update object flag allocation in object.h */
>  #define SEEN (1u<<0)
>
> @@ -1375,6 +1410,7 @@ enum maintenance_task_label {
>   TASK_GC,
>   TASK_COMMIT_GRAPH,
>   TASK_PACK_REFS,
> + TASK_PRUNE_REMOTE_REFS,
>
>   /* Leave as final value */
>   TASK__COUNT
> @@ -1411,6 +1447,10 @@ static struct maintenance_task tasks[] = {
>   maintenance_task_pack_refs,
>   pack_refs_condition,
>   },
> + [TASK_PRUNE_REMOTE_REFS] = {
> + "prune-remote-refs",
> + maintenance_task_prune_remote,
> + },
>  };
>
>  static int compare_tasks_by_selection(const void *a_, const void *b_)
> @@ -1505,6 +1545,8 @@ static void initialize_maintenance_strategy(void)
>   tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
>   tasks[TASK_PACK_REFS].enabled = 1;
>   tasks[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY;
> + tasks[TASK_PRUNE_REMOTE_REFS].enabled = 0;
> + tasks[TASK_PRUNE_REMOTE_REFS].schedule = SCHEDULE_DAILY;
>   }
>  }

OK.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 0ce4ba1cbe..60a0c3f835 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -446,6 +446,50 @@ test_expect_success 'pack-refs task' '
>   test_subcommand git pack-refs --all --prune <pack-refs.txt
>  '
>
> +test_expect_success 'prune-remote-refs task not enabled by default' '
> + git clone . prune-test &&
> + (
> + cd prune-test &&
> + GIT_TRACE2_EVENT="$(pwd)/prune.txt" git maintenance run 2>err &&
> + test_subcommand ! git remote prune origin <prune.txt
> + )
> +'

OK.

> +test_expect_success 'prune-remote-refs task cleans stale remote refs' '
> + test_commit initial &&
> +
> + # Create two separate remote repos
> + git clone . remote1 &&
> + git clone . remote2 &&
> +
> + git clone . prune-test-clean &&
> + (
> + cd prune-test-clean &&
> + git config maintenance.prune-remote-refs.enabled true &&
> +
> + # Add both remotes
> + git remote add remote1 "../remote1" &&
> + git remote add remote2 "../remote2" &&
> +
> + # Create and push branches to both remotes
> + git branch -f side2 HEAD &&
> + git push remote1 side2 &&
> + git push remote2 side2 &&
> +
> + # Rename branches in each remote to simulate a stale branch
> + git -C ../remote1 branch -m side2 side3 &&
> + git -C ../remote2 branch -m side2 side4 &&
> +
> + GIT_TRACE2_EVENT="$(pwd)/prune.txt" git maintenance run
> --task=prune-remote-refs &&
> +
> + # Verify pruning happened for both remotes
> + test_subcommand git remote prune remote1 <prune.txt &&
> + test_subcommand git remote prune remote2 <prune.txt &&
> + test_must_fail git rev-parse refs/remotes/remote1/side2 &&
> + test_must_fail git rev-parse refs/remotes/remote2/side2
> + )
> +'

OK.

Other than that it is not clear if we want it, the change looks
cleanly done and was a pleasant read (other than whitespace damages
on the patch text).

Thanks.
