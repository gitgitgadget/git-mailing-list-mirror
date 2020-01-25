Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CFCC2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715D82072C
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eAoqtVFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgAYAq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:46:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:60491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387405AbgAYAq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579913181;
        bh=nFPTg1XJuZjQGLgFStIz03P3kIQymL5/oGww4wKmOrI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eAoqtVFKNIturT2+2xJl3Q/C4Qu93IRZ9m87xaB+hR9W8iKqfqBFFcpmnxb5aCYxe
         /56zb4cYVF8UZPsZzrH3yrati0//0wMGw7Thz9mNhKDuy6xhExSjdUHvxAYjqedZMM
         MCZOzFhObRwN6LWR6OQS3mNGSerz4j4o+dn8khM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1jAKvN3t6H-00K7Sh; Sat, 25
 Jan 2020 01:46:21 +0100
Date:   Sat, 25 Jan 2020 01:46:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bert Wesarg <bert.wesarg@googlemail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/7] remote rename/remove: handle branch.<name>.pushRemote
 config values
In-Reply-To: <9c2110eda64ab7bf0cb780dafe1f13b28fee5ca0.1579857394.git.bert.wesarg@googlemail.com>
Message-ID: <nycvar.QRO.7.76.6.2001250142560.46@tvgsbejvaqbjf.bet>
References: <cover.1579857394.git.bert.wesarg@googlemail.com> <9c2110eda64ab7bf0cb780dafe1f13b28fee5ca0.1579857394.git.bert.wesarg@googlemail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kVozraB1bSXEgufsXQ13AC64luYgUo0b8RWexHXUi5Y1xH8Yx/8
 x2SiErdF9Ahg9kg79qo94LXO7om/BW0Iu2BrVwubhxvGIrWfKQ2kVtL8uju2t9ZMGpgyM6q
 DQBJhS07ChCdryqii490k0/NpPVuDz/ehauAx0EN+vUfg0UkD9F3pVOioqo4VtgtNgl+PZI
 j1hwTA/or8yBB4bES6InQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fhid8hcYm5c=:HB0C/F8Y+vVUfJ4Lb68Bju
 +s5mDnifs71T8jCc58Cd+C415YBpa24lqedki+31o79c/haW/ounNnKf4EofQf8yzYmmE5THF
 4gBTHz/CpPrFG8XQfymJKwJ0QLlE17ElKFITtYAzB5UGIxAXncgwxceMjIPK7uzagoIG6f2RO
 /Sb9wkCct/ef3OKw+1heBLNRkB86tdKKsuZStqJ3W6+AGVhXKr+VjPBkp7xUrPqcibr3TkDVK
 KtTbxUOMZqgi5F9PzzKW3gdk484uNe28sKyQipg1bjgLcy9dPGFn8q7LEVT8uAB/6FrKpg1rt
 jsIGnZzUZBmdLdkExNgjiR18Z5ZQheWS9YRqbETr9Z9AfzF2PquB66LB3M/dN/775t0DT4D5M
 TosGoQ5HgzxMoxN8cd/7fIByIFdE6b8EcoBUjJCMwxJKglHs28r7enxzxkzmCB8CgJ0kGgRR5
 rl8wyPq7z8pWuqbTDWUcwG8snWjwbc7sHN2AheyvsNzpVUnvuiwZ5ryxw15H20znbtWDCdCei
 gFbqlCMRQgrfjfnuRQBf+K9PCEKJu9XPaCx1Wkoyt+6NhwxDNy8qHckj8/gcL8MsJypm4EV62
 T7q+h7braupm373/O6QX4RcndlcAJq9d0t+J/jPjpxBLXxaNZlRQQPnRZ5IkDf1G5Ly8vRNt4
 BKLHdV2FjxG+q2Ay+D5cy1KFuGK+pZQ43zzqigiHYavwFUOoxKoImZZina6eFPp9Nmo6p8ocw
 CMF1ZneBJ6YHL4/QWdpc/x/K0HkBrD/+I6XVm0xjjo2k8Pr4CRlQAVRk03cCPn9dDejz02hnf
 Ko48JtZ5jAD7c21RoQeiihZKdRWTxM8rR5UGM6YTqC1TGdP0fM53itR09AZe4oG7bTrTo9rLk
 lIOyrK4XuCUweLW+ssQ9oesilKl4f8W4GfxBGVtrjA89xk0tv479dD/dVLh/C2+shUnMa9vTx
 yJG61gNad3j9IWIhsS4HOeUi8qOhyXk8FBbMlVGLU4TNUNxImzKI+cco3tDykfGRP/kT7jpRb
 PVybUUDarTIOfIFAizbbMiN0/MAfmV8PENnfaeNCdag0Ei8sMRWYbvFoeIG/FwFYSLRCgwrxM
 mYMn/1qfxniVOjyuu0uc/kzIlTnXVbKK3ltni4GbSp412/Hm6B7oV/dHvpVLmisxiMDsw7Pgj
 BGCr021eaGQJz+uvsguYPARur7ntXGBaf7NboioNKTG3P16cypwML8PgoQZQ+gT47efxzk+mZ
 dFw1ImQlHoCUfGitk
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,

On Fri, 24 Jan 2020, Bert Wesarg wrote:

> When renaming or removing a remote with
>
>     git remote rename X Y
>     git remote remove X
>
> Git already renames/removes any config values from
>
>     branch.<name>.remote =3D X
>
> to
>
>     branch.<name>.remote =3D Y
>
> As branch.<name>.pushRemote also names a remote, it now also renames
> or removes these config values from
>
>     branch.<name>.pushRemote =3D X
>
> to
>
>     branch.<name>.pushRemote =3D Y
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---

This commit seems to cause a failure in t5505:
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D27833&view=
=3Dms.vss-test-web.build-test-results-tab

Here is the excerpt of the log:

=2D- snip --
[...]
expecting success of 5505.15 'show':
	(
		cd test &&
		git config --add remote.origin.fetch refs/heads/master:refs/heads/upstre=
am &&
		git fetch &&
		git checkout -b ahead origin/master &&
		echo 1 >>file &&
		test_tick &&
		git commit -m update file &&
		git checkout master &&
		git branch --track octopus origin/master &&
		git branch --track rebase origin/master &&
		git branch -d -r origin/master &&
		git config --add remote.two.url ../two &&
		git config --add remote.two.pushurl ../three &&
		git config branch.rebase.rebase true &&
		git config branch.octopus.merge "topic-a topic-b topic-c" &&
		(
			cd ../one &&
			echo 1 >file &&
			test_tick &&
			git commit -m update file
		) &&
		git config --add remote.origin.push : &&
		git config --add remote.origin.push refs/heads/master:refs/heads/upstrea=
m &&
		git config --add remote.origin.push +refs/tags/lastbackup &&
		git config --add remote.two.push +refs/heads/ahead:refs/heads/master &&
		git config --add remote.two.push refs/heads/master:refs/heads/another &&
		git remote show origin two >output &&
		git branch -d rebase octopus &&
		test_i18ncmp expect output
	)

+ cd test
+ git config --add remote.origin.fetch refs/heads/master:refs/heads/upstre=
am
+ git fetch
=46rom /home/virtualbox/git/t/trash directory.t5505-remote/one
 * [new branch]      master     -> upstream
+ git checkout -b ahead origin/master
Switched to a new branch 'ahead'
Branch 'ahead' set up to track remote branch 'master' from 'origin'.
+ echo 1
+ test_tick
+ test -z
+ test_tick=3D1112911993
+ GIT_COMMITTER_DATE=3D1112911993 -0700
+ GIT_AUTHOR_DATE=3D1112911993 -0700
+ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+ git commit -m update file
[ahead 847549e] update
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
+ git checkout master
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
+ git branch --track octopus origin/master
Branch 'octopus' set up to track remote branch 'master' from 'origin'.
+ git branch --track rebase origin/master
Branch 'rebase' set up to track remote branch 'master' from 'origin'.
+ git branch -d -r origin/master
Deleted remote-tracking branch origin/master (was 9d34b14).
+ git config --add remote.two.url ../two
+ git config --add remote.two.pushurl ../three
+ git config branch.rebase.rebase true
+ git config branch.octopus.merge topic-a topic-b topic-c
+ cd ../one
+ echo 1
+ test_tick
+ test -z set
+ test_tick=3D1112912053
+ GIT_COMMITTER_DATE=3D1112912053 -0700
+ GIT_AUTHOR_DATE=3D1112912053 -0700
+ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+ git commit -m update file
[master 6329a3c] update
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
+ git config --add remote.origin.push :
+ git config --add remote.origin.push refs/heads/master:refs/heads/upstrea=
m
+ git config --add remote.origin.push +refs/tags/lastbackup
+ git config --add remote.two.push +refs/heads/ahead:refs/heads/master
+ git config --add remote.two.push refs/heads/master:refs/heads/another
+ git remote show origin two
error: src refspec refs/tags/lastbackup does not match any
+ git branch -d rebase octopus
Deleted branch rebase (was 9d34b14).
Deleted branch octopus (was 9d34b14).
+ test_i18ncmp expect output
+ test_have_prereq C_LOCALE_OUTPUT
+ save_IFS=3D

+ IFS=3D,
+ set -- C_LOCALE_OUTPUT
+ IFS=3D

+ total_prereq=3D0
+ ok_prereq=3D0
+ missing_prereq=3D
+ negative_prereq=3D
+ total_prereq=3D1
+ satisfied_this_prereq=3Dt
+ ok_prereq=3D1
+ test 1 =3D 1
+ test_cmp expect output
+ diff -u expect output
=2D-- expect	2020-01-25 00:44:41.496720000 +0000
+++ output	2020-01-25 00:44:43.513861900 +0000
@@ -5,13 +5,6 @@
   Remote branches:
     master new (next fetch will store in remotes/origin)
     side   tracked
-  Local branches configured for 'git pull':
-    ahead    merges with remote master
-    master   merges with remote master
-    octopus  merges with remote topic-a
-                and with remote topic-b
-                and with remote topic-c
-    rebase  rebases onto remote master
   Local refs configured for 'git push':
     master pushes to master   (local out of date)
     master pushes to upstream (create)
error: last command exited with $?=3D1
not ok 15 - show
#
#		(
#			cd test &&
#			git config --add remote.origin.fetch refs/heads/master:refs/heads/upst=
ream &&
#			git fetch &&
#			git checkout -b ahead origin/master &&
#			echo 1 >>file &&
#			test_tick &&
#			git commit -m update file &&
#			git checkout master &&
#			git branch --track octopus origin/master &&
#			git branch --track rebase origin/master &&
#			git branch -d -r origin/master &&
#			git config --add remote.two.url ../two &&
#			git config --add remote.two.pushurl ../three &&
#			git config branch.rebase.rebase true &&
#			git config branch.octopus.merge "topic-a topic-b topic-c" &&
#			(
#				cd ../one &&
#				echo 1 >file &&
#				test_tick &&
#				git commit -m update file
#			) &&
#			git config --add remote.origin.push : &&
#			git config --add remote.origin.push refs/heads/master:refs/heads/upstr=
eam &&
#			git config --add remote.origin.push +refs/tags/lastbackup &&
#			git config --add remote.two.push +refs/heads/ahead:refs/heads/master &=
&
#			git config --add remote.two.push refs/heads/master:refs/heads/another =
&&
#			git remote show origin two >output &&
#			git branch -d rebase octopus &&
#			test_i18ncmp expect output
#		)
#
=2D- snap --

Could you have a look to see whether the code or the test need to be
adjusted?

Thanks,
Dscho

>
> Changes since v3:
>
>  * handle also 'git remote remove'
>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/remote.c  | 22 +++++++++++++++++++++-
>  t/t5505-remote.sh | 16 +++++++++++++++-
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 9ee44c9f6c..a2379a14bf 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -250,6 +250,7 @@ struct branch_info {
>  	char *remote_name;
>  	struct string_list merge;
>  	enum rebase_type rebase;
> +	char *push_remote_name;
>  };
>
>  static struct string_list branch_list =3D STRING_LIST_INIT_NODUP;
> @@ -267,7 +268,7 @@ static int config_read_branches(const char *key, con=
st char *value, void *cb)
>  	char *name;
>  	struct string_list_item *item;
>  	struct branch_info *info;
> -	enum { REMOTE, MERGE, REBASE } type;
> +	enum { REMOTE, MERGE, REBASE, PUSH_REMOTE } type;
>  	size_t key_len;
>
>  	if (!starts_with(key, "branch."))
> @@ -280,6 +281,8 @@ static int config_read_branches(const char *key, con=
st char *value, void *cb)
>  		type =3D MERGE;
>  	else if (strip_suffix(key, ".rebase", &key_len))
>  		type =3D REBASE;
> +	else if (strip_suffix(key, ".pushremote", &key_len))
> +		type =3D PUSH_REMOTE;
>  	else
>  		return 0;
>  	name =3D xmemdupz(key, key_len);
> @@ -315,6 +318,11 @@ static int config_read_branches(const char *key, co=
nst char *value, void *cb)
>  		 */
>  		info->rebase =3D rebase_parse_value(value);
>  		break;
> +	case PUSH_REMOTE:
> +		if (info->push_remote_name)
> +			warning(_("more than one %s"), orig_key);
> +		info->push_remote_name =3D xstrdup(value);
> +		break;
>  	default:
>  		BUG("unexpected type=3D%d", type);
>  	}
> @@ -682,6 +690,11 @@ static int mv(int argc, const char **argv)
>  			strbuf_addf(&buf, "branch.%s.remote", item->string);
>  			git_config_set(buf.buf, rename.new_name);
>  		}
> +		if (info->push_remote_name && !strcmp(info->push_remote_name, rename.=
old_name)) {
> +			strbuf_reset(&buf);
> +			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
> +			git_config_set(buf.buf, rename.new_name);
> +		}
>  	}
>
>  	if (!refspec_updated)
> @@ -783,6 +796,13 @@ static int rm(int argc, const char **argv)
>  					die(_("could not unset '%s'"), buf.buf);
>  			}
>  		}
> +		if (info->push_remote_name && !strcmp(info->push_remote_name, remote-=
>name)) {
> +			strbuf_reset(&buf);
> +			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
> +			result =3D git_config_set_gently(buf.buf, NULL);
> +			if (result && result !=3D CONFIG_NOTHING_SET)
> +				die(_("could not unset '%s'"), buf.buf);
> +		}
>  	}
>
>  	/*
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 883b32efa0..082042b05a 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -737,12 +737,14 @@ test_expect_success 'rename a remote' '
>  	git clone one four &&
>  	(
>  		cd four &&
> +		git config branch.master.pushRemote origin &&
>  		git remote rename origin upstream &&
>  		test -z "$(git for-each-ref refs/remotes/origin)" &&
>  		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" =3D "refs/remot=
es/upstream/master" &&
>  		test "$(git rev-parse upstream/master)" =3D "$(git rev-parse master)"=
 &&
>  		test "$(git config remote.upstream.fetch)" =3D "+refs/heads/*:refs/re=
motes/upstream/*" &&
> -		test "$(git config branch.master.remote)" =3D "upstream"
> +		test "$(git config branch.master.remote)" =3D "upstream" &&
> +		test "$(git config branch.master.pushRemote)" =3D "upstream"
>  	)
>  '
>
> @@ -784,6 +786,18 @@ test_expect_success 'rename succeeds with existing =
remote.<target>.prune' '
>  	git -C four.four remote rename origin upstream
>  '
>
> +test_expect_success 'remove a remote' '
> +	git clone one four.five &&
> +	(
> +		cd four.five &&
> +		git config branch.master.pushRemote origin &&
> +		git remote remove origin &&
> +		test -z "$(git for-each-ref refs/remotes/origin)" &&
> +		test_must_fail git config branch.master.remote &&
> +		test_must_fail git config branch.master.pushRemote
> +	)
> +'
> +
>  cat >remotes_origin <<EOF
>  URL: $(pwd)/one
>  Push: refs/heads/master:refs/heads/upstream
> --
> 2.24.1.497.g9abd7b20b4.dirty
>
>
