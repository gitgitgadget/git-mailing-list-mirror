From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 5/5] builtin/clone: support submodule groups
Date: Wed, 25 Nov 2015 18:52:04 +0100
Message-ID: <5655F544.6050003@web.de>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
 <1448415139-23675-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, ericsunshine@gmail.com,
	j6t@kdbg.org, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 18:52:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1eEw-0003zl-BX
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 18:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbbKYRwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 12:52:20 -0500
Received: from mout.web.de ([212.227.17.11]:56275 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230AbbKYRwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 12:52:17 -0500
Received: from [192.168.178.41] ([79.211.124.82]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M8zFx-1aBF1d3XNl-00COpI; Wed, 25 Nov 2015 18:52:05
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1448415139-23675-6-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:DR54l7xsNOPxTQPnfsuQpsRxbhJB8xqQ1p0edj/g6y/+QRID3P5
 vd8kld5mcxhFK2oyCvabkb7+VcqM20i3xKWDmVOmS+ZeoFEMPe5tLMf069DQtPRIQ837Ts7
 yyCLyTqGnlBFr3o+ukwrBRtV4TLfXJxKCuC+KU9NJo46a1PTu00V3EjfuEUG2B7+F62A9kl
 JhAx7PrOuAqRlOVPE6brQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hqmBaaZhvIc=:MNu4FUxzrKK+Pr5GwhMAQU
 LvjDjJXrOTQQMuMgMHVTAIg8sFyvJO9MHcw7YyxZzNxmV4tPXR6p73cU+y1rDAgFmrQn2/+5L
 dtLzifI92At8nY7wB+8am3l1SGkfu7nXqxoT0N0WHEq9Py4UXdDZR39GbukMiWfcPb2N1LKxk
 zsK04qXYhxI9NaYD5bDm9AGa2ia0n/+XnqHi68nUdLZER4btTK7Pjpj1FYUF2WcBb+C2/Ol8x
 7meiOgx2IymgcRfJtDqU78/PNblM89NLCcvZwCp8bOfBE1zyVq2OqtCU6j60xl5JeMMG5Ukpj
 YvZWYBW4CmeZ+PJqzB5suDlE2xdyDkjAUJ//BoZqe2c4J7amLq2p26sC3+D0jkWFhVOJCDSje
 qyEGVYmZC1kh6MJl14Oi813/Sx/hWE7Xjta9fqFD6YCEh966aK4qSCKNlk29FDN8gABRxNIBL
 S8B3IYoKsk832M1Es39TFtwgMUgE11K0AFa1wTykkzfuRNYSBlYqJm+OaAg171XeeuJuE3tSZ
 uqPU751wP73YJCaGWefZg9Yhl+Kd/tW4OWa03agP1vn7uGsH8HoJwQo/sPB9O/7lBSJJZK2Sm
 EhZ8bI+QKROKLapmtcVWq2xU/6lFmR7LwPIFyUR/DdvE+RFThRZbCRtGmwWr3vUPeYbsrneAE
 BUhhsZqyCb0ZhOd+n9FKhVZMndKnvtWvaXvInlIsGfGLEsui7d5YhSoskAAbLsycTTWVGXs0G
 mwV+QjMari1EV8U08q44wMd/FGE0muY4eNwqyLO2EHXK7E4K33tgfq03uTsoFguL6EIX4fHz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281721>

Am 25.11.2015 um 02:32 schrieb Stefan Beller:
> This passes each group to the `submodule update` invocation and
> additionally configures the groups to be automatically updated.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   Documentation/git-clone.txt | 11 ++++++++
>   builtin/clone.c             | 33 ++++++++++++++++++++--
>   git-submodule.sh            |  5 ++++
>   t/t7400-submodule-basic.sh  | 69 +++++++++++++++++++++++++++++++++++++++++++++
>   t/t7406-submodule-update.sh | 32 +++++++++++++++++++++
>   5 files changed, 147 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 59d8c67..fbf68ab 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -209,6 +209,17 @@ objects from the source repository into a pack in the cloned repository.
>   	repository does not have a worktree/checkout (i.e. if any of
>   	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
>
> +--group::
> +	After the clone is created, all submodules which are part of the
> +	group are cloned. This option can be given multiple times to specify
> +	different groups.

Ah, that answers my question in my response to the cover letter ;-)

> This option will imply automatic submodule
> +	updates for the groups by setting `submodule.update=groups`.

Please don't. The per-submodule update setting configures how a
submodule has to be updated, adding a global one with a completely
different meaning (what submodules should be updated?) is confusing.
Why not "submodule.groups=<groups>"?

> +	The group selection will be passed on recursively, i.e. if a submodule
> +	is cloned because of group membership, its submodules will
> +	be cloned according to group membership, too. If a submodule is
> +	not cloned however, its submodules are not evaluated for group
> +	membership.

What do you mean by the last sentence? Did the clone fail? Then you
cannot update the submodule anyway ...

>   --separate-git-dir=<git dir>::
>   	Instead of placing the cloned repository where it is supposed
>   	to be, place the cloned repository at the specified directory,
> diff --git a/builtin/clone.c b/builtin/clone.c
> index ce578d2..17e9f54 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -51,6 +51,7 @@ static struct string_list option_config;
>   static struct string_list option_reference;
>   static int option_dissociate;
>   static int max_jobs = -1;
> +static struct string_list submodule_groups;
>
>   static struct option builtin_clone_options[] = {
>   	OPT__VERBOSITY(&option_verbosity),
> @@ -95,6 +96,8 @@ static struct option builtin_clone_options[] = {
>   		   N_("separate git dir from working tree")),
>   	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
>   			N_("set config inside the new repository")),
> +	OPT_STRING_LIST('g', "group", &submodule_groups, N_("group"),
> +			N_("clone specific submodule groups")),
>   	OPT_END()
>   };
>
> @@ -723,9 +726,18 @@ static int checkout(void)
>   	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
>   			   sha1_to_hex(sha1), "1", NULL);
>
> -	if (!err && option_recursive) {
> +	if (err)
> +		goto out;
> +
> +	if (option_recursive || submodule_groups.nr > 0) {
>   		struct argv_array args = ARGV_ARRAY_INIT;
> -		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
> +		argv_array_pushl(&args, "submodule", "update", "--init", NULL);
> +
> +		if (option_recursive)
> +			argv_array_pushf(&args, "--recursive");
> +
> +		if (submodule_groups.nr > 0)
> +			argv_array_pushf(&args, "--groups");
>
>   		if (max_jobs != -1)
>   			argv_array_pushf(&args, "--jobs=%d", max_jobs);
> @@ -733,7 +745,7 @@ static int checkout(void)
>   		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
>   		argv_array_clear(&args);
>   	}
> -
> +out:
>   	return err;
>   }
>
> @@ -864,6 +876,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>   		option_no_checkout = 1;
>   	}
>
> +	if (option_recursive && submodule_groups.nr > 0)
> +		die(_("submodule groups and recursive flag are incompatible"));

Me thinks this contradicts your description of the --group option
in the man page. I don't see why such a restriction would make
sense, what incompatibility are you trying to avoid here? Maybe
we need another submodule-specific setting to tell update what
groups to use inside that submodule?

> +	if (submodule_groups.nr > 0) {
> +		int first_item = 1;
> +		struct string_list_item *item;
> +		struct strbuf sb = STRBUF_INIT;
> +		strbuf_addstr(&sb, "submodule.groups=");
> +		for_each_string_list_item(item, &submodule_groups) {
> +			strbuf_addf(&sb, "%s%s", first_item ? "" : ",", item->string);
> +			first_item = 0;
> +		}
> +		if (submodule_groups.nr > 0)
> +			string_list_append(&option_config, strbuf_detach(&sb, 0));
> +	}
> +
>   	if (!option_origin)
>   		option_origin = "origin";
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 4092a48..e3d1667 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -611,6 +611,7 @@ cmd_deinit()
>   #
>   cmd_update()
>   {
> +	groups=
>   	# parse $args after "submodule ... update".
>   	while test $# -ne 0
>   	do
> @@ -650,6 +651,9 @@ cmd_update()
>   		--checkout)
>   			update="checkout"
>   			;;
> +		--groups)
> +			groups=1
> +			;;
>   		--depth)
>   			case "$2" in '') usage ;; esac
>   			depth="--depth=$2"
> @@ -691,6 +695,7 @@ cmd_update()
>   		${update:+--update "$update"} \
>   		${reference:+--reference "$reference"} \
>   		${depth:+--depth "$depth"} \
> +		${groups:+--groups} \
>   		${jobs:+$jobs} \
>   		"$@" | {
>   	err=
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index caed4be..e8654d7 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1049,4 +1049,73 @@ test_expect_success 'submodule init --group works' '
>   	)
>   '
>
> +cat <<EOF > expected
> +submodule
> +-submodule1
> +EOF
> +
> +test_expect_success 'submodule update --groups works' '
> +	test_when_finished "rm -rf super super_clone" &&
> +	mkdir super &&
> +	pwd=$(pwd) &&
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --group groupA file://"$pwd"/example2 submodule &&
> +		git submodule add file://"$pwd"/example2 submodule1 &&
> +		git commit -a -m "create repository with 2 submodules, one is in a group"
> +	) &&
> +	git clone super super_clone &&
> +	(
> +		cd super_clone &&
> +		git config submodule.groups groupA &&
> +		git submodule init  &&
> +		git submodule update --groups &&
> +		git submodule status |cut -c1,42-52 | tr -d " " >../actual
> +	) &&
> +	test_cmp actual expected
> +'
> +
> +test_expect_success 'submodule update --init --groups works' '
> +	test_when_finished "rm -rf super super_clone" &&
> +	mkdir super &&
> +	pwd=$(pwd) &&
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --group groupA file://"$pwd"/example2 submodule &&
> +		git submodule add file://"$pwd"/example2 submodule1 &&
> +		git commit -a -m "create repository with 2 submodules, one is in a group"
> +	) &&
> +	git clone super super_clone &&
> +	(
> +		cd super_clone &&
> +		git config submodule.groups groupA &&
> +		git submodule update --init --groups &&
> +		git submodule status |cut -c1,42-52 | tr -d " " >../actual
> +	) &&
> +	test_cmp actual expected
> +'
> +
> +test_expect_success 'clone --group works' '
> +	test_when_finished "rm -rf super super_clone" &&
> +	mkdir super &&
> +	pwd=$(pwd) &&
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --group groupA file://"$pwd"/example2 submodule &&
> +		git submodule add file://"$pwd"/example2 submodule1 &&
> +		git commit -a -m "create repository with 2 submodules, one is in a group"
> +	) &&
> +	git clone --group groupA super super_clone &&
> +	(
> +		cd super_clone &&
> +		test_pause
> +		git submodule status |cut -c1,42-52 | tr -d " " >../actual
> +	) &&
> +	test_cmp actual expected
> +'
> +
> +
>   test_done
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 090891e..7e59846 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -801,4 +801,36 @@ test_expect_success 'git clone passes the parallel jobs config on to submodules'
>   	rm -rf super4
>   '
>
> +cat >expect <<-EOF &&
> +-deeper/submodule
> +-merging
> +-moved/sub module
> +-none
> +-rebasing
> +-submodule
> +-submodule1
> +EOF
> +
> +# none, merging rebasing, submodule1, submodule
> +test_expect_success 'git clone works with submodule groups.' '
> +	test_when_finished "rm -rf super5" &&
> +	(
> +		cd super &&
> +		git config -f .gitmodules  submodule.submodule.groups default &&
> +		git config -f .gitmodules  submodule.submodule1.groups "default,testing" &&
> +		git config -f .gitmodules  submodule.none.groups testing &&
> +		git commit -a -m "assigning groups to submodules"
> +	) &&
> +	git clone --group default --group testing super super5 &&
> +	(
> +		cd super5 &&
> +		git submodule status |cut -c1,43- >../actual
> +	) &&
> +	test_cmp actual expect
> +'
> +
> +test_expect_success 'git submodule update --groups' '
> +	true
> +'
> +
>   test_done
>
