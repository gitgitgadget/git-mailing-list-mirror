Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62551C25B08
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 08:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiHEI1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 04:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiHEI1F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 04:27:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3CA74CE0
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 01:27:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id tl27so3789573ejc.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=HlLlwU5noo6Jb/N67UTHpy4EtGTE3vrgzBlG7YiyRPE=;
        b=ns2qQRH5yXlY40I1yDYawhLLhEnkWyetgY6Yp+SsICneAZB40brjxTkDn6iXF2iSf+
         FD+beqAOa4NZHCyjDbWsml6DbKlAT2TWpE0xreM1EeZpXkx2LRbZiYqvqwmUU7gwyfwq
         wvUQi17X8DcIhgOt8wLJWGXJWRZNTh8187P78mKLKQHcVtW8+TCARw+kIOC+w3JgJ1hM
         VdU6V737Ul9SW4x+P2tsoO9gfep8T8sJO4flxmjjDYhon0RrhDfVYO7hFWaBtjcxR12x
         9yUHWktvd4AA7MQW9lNjlB/UxJPj4CqxhT/FodDEBpLNk1hTeW/xxfaq/g1TTVwVcwZX
         PyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=HlLlwU5noo6Jb/N67UTHpy4EtGTE3vrgzBlG7YiyRPE=;
        b=0ChZr6mJrOLBo9R0+6FHKxO29S8/CNLlJUtcZCZGL+ROu/psA+OcCaC1Npt2jbimkS
         OKl6IXdMslvHLVCKUbQvLFMNFCsO8YwjN5pV+bQ3ef+6iAEOSci8YNv3rsqgfyisXiyG
         zidXDAO19vB5I/wM4vnrk2qSv5u6GfNsuQqwGDoBnDnew7i9Fw2BNLJYagmo/Hikoj9G
         UsmlCly+e4waNE3FVlCpoHXUeJu/loV/+g0/00PhLNPIFJdhaT9iOmwxYW4lpFcRsovZ
         7Al+vK9GxykabmBJc3kzE4PqGD9aV2pCZ+9EUxXYC5j1Xnh/mRaOD6Rb+6xNvMWHLndf
         X02w==
X-Gm-Message-State: ACgBeo22mQBdBZQ3uLVCBiJb7l6Tuxh9p/crhOkQtBfDggHRLTblzUNv
        2eEzhCBRfOpJYXicVMb4TysUGWUxnPechg==
X-Google-Smtp-Source: AA6agR6nYb4esS+c2vL51SlBM1wwMiNA5y0dgrjEMfdgkWSXV0LfzYWXB7qvNvKNcJQAPqZ7Ws9mRw==
X-Received: by 2002:a17:907:6d99:b0:72e:e7b4:e9cc with SMTP id sb25-20020a1709076d9900b0072ee7b4e9ccmr4323319ejc.315.1659688022271;
        Fri, 05 Aug 2022 01:27:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b00730ad7c0d42sm1261361ejf.207.2022.08.05.01.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 01:27:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJsfd-000RkS-0R;
        Fri, 05 Aug 2022 10:27:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Ilya K <me@0upti.me>, git@vger.kernel.org
Subject: Re: [bug] Segfault in git commit when a hook has a broken shebang
Date:   Fri, 05 Aug 2022 10:24:43 +0200
References: <30015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
 <YuzML2lVGDBIK1uF@danh.dev> <220805.86pmhfru8a.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220805.86pmhfru8a.gmgdl@evledraar.gmail.com>
Message-ID: <220805.86les3rt7u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 05 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Aug 05 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
>
>> On 2022-08-05 08:45:02+0300, Ilya K <me@0upti.me> wrote:
>>> Hello! I ran into a weird bug just now that is probably easier to show =
than
>>> explain:
>>> =E2=9D=AF git init
>>> Initialized empty Git repository in /home/k900/test/.git/
>>> =E2=9D=AF echo '#!/usr/bin/oops' > .git/hooks/pre-commit
>>> =E2=9D=AF chmod +x .git/hooks/pre-commit
>>> =E2=9D=AF touch oops
>>> =E2=9D=AF git add oops
>>> =E2=9D=AF git commit -a
>>> fatal: cannot run .git/hooks/pre-commit: No such file or directory
>>> [1] =C2=A0=C2=A0=C2=A024580 segmentation fault (core dumped) =C2=A0git =
commit -a
>>> This happens consistently with git 2.37.x, and I don't think it happened
>>> with git 2.36 or earlier.
>>
>> This seems to be a side-effect of a082345372, (hook API: fix v2.36.0
>> regression: hooks should be connected to a TTY, 2022-06-07)
>>
>> Since it makes hooks run in "ungroup" manner, hence run-command will
>> pass NULL as first argument to notify_start_failure.
>>
>> This patch seems to fix the crash, however, I think we should remove
>> that clause entirely.
>
> Yes, thanks. I'm already working on a patch for this with a test, will
> send it in shortly...

FWIW this is the fix I (in parallel to yours) came up with. Currently
CI-ing it (I vaguely expect that the particularl of the test will break
on Windows).

(I see I forgot the "Reported-by", will add that to the final
version...)

-- >8 --
Subject: [PATCH] hook API: don't segfault on strbuf_addf() to NULL "out"
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Fix a logic error in a082345372e (hook API: fix v2.36.0 regression:
hooks should be connected to a TTY, 2022-06-07). When it started using
the "ungroup" API added in fd3aaf53f71 (run-command: add an "ungroup"
option to run_process_parallel(), 2022-06-07) it should have made the
same sort of change that fd3aaf53f71 itself made in
"t/helper/test-run-command.c".

The correct way to emit this "Couldn't start" output with "ungroup"
would be:

	fprintf(stderr, _("Couldn't start hook '%s'\n"), hook_path);

But we should instead remove the emitting of this output. As the added
test shows we already emit output when we can't run the child. The
"cannot run" output here is emitted by run-command.c's
child_err_spew().

So the addition of the "Couldn't start hook" output here in
96e7225b310 (hook: add 'run' subcommand, 2021-12-22) was always
redundant. For the pre-commit hook we'll now emit exactly the same
output as we did before f443246b9f2 (commit: convert
{pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22) (and
likewise for others).

We could at this point add this to the pick_next_hook() callbacks in
hook.c:

	assert(!out);
	assert(!*pp_task_cb);

And this to notify_start_failure() and notify_hook_finished() (in the
latter case the parameter is called "pp_task_cp"):

	assert(!out);
	assert(!pp_task_cb);

But let's leave any such instrumentation for some eventual cleanup of
the "ungroup" API.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 hook.c          |  7 -------
 t/t1800-hook.sh | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hook.c b/hook.c
index d113ee7faae..a493939a4fc 100644
--- a/hook.c
+++ b/hook.c
@@ -62,9 +62,6 @@ static int pick_next_hook(struct child_process *cp,
 	strvec_push(&cp->args, hook_path);
 	strvec_pushv(&cp->args, hook_cb->options->args.v);
=20
-	/* Provide context for errors if necessary */
-	*pp_task_cb =3D (char *)hook_path;
-
 	/*
 	 * This pick_next_hook() will be called again, we're only
 	 * running one hook, so indicate that no more work will be
@@ -80,13 +77,9 @@ static int notify_start_failure(struct strbuf *out,
 				void *pp_task_cp)
 {
 	struct hook_cb_data *hook_cb =3D pp_cb;
-	const char *hook_path =3D pp_task_cp;
=20
 	hook_cb->rc |=3D 1;
=20
-	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
-		    hook_path);
-
 	return 1;
 }
=20
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 210f4298872..75f72ffbf27 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -151,4 +151,19 @@ test_expect_success TTY 'git commit: stdout and stderr=
 are connected to a TTY' '
 	test_hook_tty commit -m"B.new"
 '
=20
+test_expect_success 'git hook run a hook with a bad shebang' '
+	test_when_finished "rm -rf bad-hooks" &&
+	mkdir bad-hooks &&
+	write_script bad-hooks/test-hook "/bad/path/no/spaces" </dev/null &&
+	cat >expect <<-\EOF &&
+	fatal: cannot run bad-hooks/test-hook: ...
+	EOF
+	test_expect_code 1 git \
+		-c core.hooksPath=3Dbad-hooks \
+		hook run test-hook >out 2>actual.raw &&
+	test_must_be_empty out &&
+	sed -e "s/test-hook: .*/test-hook: .../" <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
