Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71077C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 08:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjH2ITH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjH2ISm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 04:18:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9EDF
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 01:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693297106; x=1693901906; i=johannes.schindelin@gmx.de;
 bh=j59N9Y4NFVqGcA0XLQEqkja7e3xO2thh8o5u3DVGAaw=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=lypkWbOeU1mfizFzzcBw2Yh9MmPrXBSGFguePcD8M4YtirFmxIWLx6Jf7XGEQ9ZUdhgYS9L
 FefxnlKnD4j78DlX/FgBBdWGtIOdJuT3o6EPo/4OYC10LuVGxSUPy9NIBkOy0EVv7eQ3nzvdj
 6msxRa26Y5ZiQUypfiCUCaAMYPkS40+tT9qMxy9uCXRRYNoKvNa9WLk00zyntmqu2K2E2l5cO
 jd1TG8cNfgHRI7bwxG19CanJfLB9BD3J8SbOMsZPVf9aFEEldBJEVduj/PjyRv1v+49FddK3H
 CdnIUtyTtCuYqQZ2yFhHsfAK+xyGrltxiJslctRwiYEleJETtVyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.15]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1qGcQR3mZi-00LZi0; Tue, 29
 Aug 2023 10:18:26 +0200
Date:   Tue, 29 Aug 2023 10:18:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] .github/workflows: add coverity action
In-Reply-To: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
Message-ID: <6534ba5d-f4a6-71e6-5b0f-9cba2be8426e@gmx.de>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YiDWb2D5sPMk5zF73TYzvfVLBb/1fkluPFsiJeSnBJj0cME4jSn
 mVQGhjRA7+c6Rn2y70kcnw/OCFZmi5JbWRnByt3NBdUO+808GxSNJrzwAMWNRxU2M7s38tH
 0mu9P0jU/dWsIQPmNBB/EYMlaASQl4DmPMG8r4VMSfkxrehhBpcAZzPTwKrSPcCE94QxNL0
 s32C3+Bso1O+f6oj9xKSg==
UI-OutboundReport: notjunk:1;M01:P0:4811cFU4Y+0=;x9PveoQoWexlVbt7k3lLhdqnnce
 K6KGgqIZPRjC35varXNmlN0jktr0d7KQgkBJ7CcJ+6vscO+1WgxNPtSBcTZp/9R/WKxDV78wk
 XETwnolgbhL18jJa5CGj+YXvsE5iLFUaXi5aVaktoWg5aVCxrwaLrUb1UUlT7raqs27ZaoW1t
 V0ttU8mNoSINGzrVYUS4WNIBgVN9OAmt0WwEo6oN5g6/3LXdHwdcUcPz5roBTW24l5Np2y3li
 8ZY/syCyPzAOqWD2Yx4zmGdHBwn/5ZQL53zDG7NlsPwMeAwV4bFy52kQ6inP3Me3Y2WhN9koz
 EEKek5HMbklJf8XvLsNY/hCjA+X92y72AOmerFIHAskuUrHZBCG1eAaW+3M43U4CmIjiUTMQv
 Ou0TQDzKvj6u/EYyx3f/m580OJRUEDzGxY0yE3282/5RHlwl0S9uz2k+PNh8UvAfxitdyyk4/
 LbqBsHtgXkvwauECrWMCIVfJG9umHRLTvahOsl1bxF1EkerACNQnlswRotambc30NG1Sek1Ty
 Eqe++YQSeC735PdbKAcTcknvecS06npzA/roPZJYaWWXT7FQLOMUHrX72zi2kcUFnzVQ5AANO
 Rwr3R9HA2tQnbfWi2hNERYPkQQrt20KdO4qI+8RcgEl4AOT579GeePCQH3picQqpVX6LL3dRs
 HV/lzdXfH1P6kqbnoD58qKqgSI0JA7yKqN9BL7OsiyvmQXOsIsHX/sjBlMYgEXlrwvW9B1IR5
 BZ8c/sHIagFcQ5U6dcrRRlD3ttTaTPgNY9MtXBZQ22N5rIihRsHtaWu86JajwLsOEAey0Ilt3
 2ILFeq2lWa+e73omIB8LoRQikpO87nbVBTuJijhAFlENHnZViTuBmKTadbnZIiRyvcmwxguP9
 1KCrbPCHOJyMxUbqrE15EUnKRsAFfTG6fzdmnvrJLeFXYRIrACjupQE/XtC2/IJHLVlAMkjzW
 4Ga13Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Mon, 21 Aug 2023, Taylor Blau wrote:

> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity=
.yml
> new file mode 100644
> index 0000000000..26b9145d9e
> --- /dev/null
> +++ b/.github/workflows/coverity.yml
> @@ -0,0 +1,35 @@
> +name: Coverity
> +
> +on:
> +  push:
> +    branches:
> +      - master
> +    tags:
> +      - '*'

I would consider it too late to do a Coverity analysis when the version
is already tagged. Therefore, I would like to see this `tags: *' part go.

And I agree with Peff that we should activate this build for `next`, too.
And for good measure for `maint` (and maybe `maint-*`, although those
branches are typically not pushed to `git/git`).

> +
> +jobs:
> +  coverity:
> +    runs-on: ubuntu-latest
> +    env:
> +      HAVE_COVERITY_TOKEN: ${{ secrets.COVERITY_SCAN_EMAIL !=3D '' && s=
ecrets.COVERITY_SCAN_TOKEN !=3D '' }}
> +    steps:
> +      - id: check-coverity
> +        name: check whether Coverity token is configured
> +        run: |
> +          echo "enabled=3D$HAVE_COVERITY_TOKEN" >>$GITHUB_OUTPUT

The canonical output for a step that has no other outputs is called
`result`. That output name is handled by linters such as
https://rhysd.github.io/actionlint/, too, in contrast to outputs with
different names that may be set in a free-form `run:` step that is
impossible to parse by `actionlint`.

But I see a bigger problem: Contrary to what the commit message claims,
the design makes this workflow far from a no-op: There will always be the
need for a VM to be spun up, to receive the orchestration script, to
download the necessary Actions (in this instance,
`vapier/coverity-scan-action`), only to check environment variables, see
that actually nothing needs to be done, update the job's and the run's
status (claiming "success" even if nothing was sent to Coverity) and then
shut down.

We discussed this in the past, as it is a great waste of resources (even
if other people pay for it, it still costs money [*1*] and electricity),
and for some of us even more relevant: it is a great waste of time because
when you are already waiting for 20 queued jobs to be picked up, having to
wait for the next build agent to become available only to spend, I don't
know, half a minute (wall clock time)? on getting this workflow run
queued, the next build agent to become available, the job to be set up,
the first step to be run, the others to be skipped, and then to wrap it
all up by updating the run as completed. I would not fault anyone for
being frustrated with this.

Therefore, I would strongly suggest looking for alternative ways to skip
this workflow run, before applying this patch.

I see these viable alternatives, all pulling the `if:` directive from the
step level to the job level, just like the `l10n.yml` workflow does [*2*],
to avoid even starting the job unless really needed:

- Limit it to the primary repository, `git/git`:

	if: github.event.repository.fork =3D=3D false

  This is what Git for Windows does in the build that validates the
  revision to use in the `git-for-windows/setup-git-for-windows-sdk`
  Action that is used in Git's CI runs to build and test Git on Windows:
  https://github.com/git-for-windows/git-sdk-64/blob/894191270a78/.github/=
workflows/ci-artifacts.yml#L14

  While this still clutters the list of workflow runs with plenty of
  skipped runs (see https://github.com/git/git/actions/workflows/l10n.yml
  for an example how this looks), at least it avoids wasting a build agent
  on essentially only checking for the presence of two secrets.

  Developers wishing to run this workflow in their fork could always
  create a branch, edit the workflow to remove this `if:` directive, and
  push the branch to their fork.

- Limit it to `git/git` explicitly, by name:

	if: github.event.repository.owner.login =3D=3D 'git'

  This is how we run the `vs-build`/`vs-test` combo only in the
  `git-for-windows` fork:
  https://github.com/git/git/blob/v2.42.0/.github/workflows/main.yml#L150

  The advantage here is that it would be slightly more obvious what we are
  doing here than checking `fork =3D=3D false`, as the org name is mention=
ed
  explicitly.

- Limit it to `git/git` but also allow it to be triggered manually:

	if: github.event.repository.fork =3D=3D false || github.event_name =3D=3D=
 'workflow_dispatch'

  This is what Git for Windows does in the test verifying that it works in
  the "Nano Server" container image that allows for kind of a minimal
  Windows system to be run via Docker:
  https://github.com/git-for-windows/git-sdk-64/blob/894191270a78/.github/=
workflows/nano-server.yml#L7

  The advantage of allowing the workflow to be triggered via a
  `workflow_dispatch` is that developers wishing to run this workflow in
  their fork would not need to edit the GitHub workflow but could run it
  unmodified. For details, see
  https://docs.github.com/en/actions/using-workflows/manually-running-a-wo=
rkflow

- Limit it by repository "topics" (think: "repository tags"):

	if: contains(github.event.repository.topics, 'has-coverity-secrets')

  On GitHub, every repository can be annotated with "topics", i.e. a list
  of labels (which in other scenarios would be called "tags"). These
  topics can be seen by the GitHub workflow run, _before_ even starting a
  job, via the `github.event.repository` attribute.

  This is how InnoSetup does it:
  https://github.com/jrsoftware/issrc/blob/main/.github/workflows/build.ym=
l#L12
  The primary repository does not have the secrets required to run this
  workflow, and hence does not have the "has-issrc-build-env" topic as
  can be seen here: https://github.com/jrsoftware/issrc (look below the
  "About" section on the right side, where you see the topics "installer"
  and "inno-setup"). My personal fork does have them secrets, and the
  topic "has-issrc-build-env" says as much: https://github.com/dscho/issrc

  The advantage of this solution is that it is very easy to "turn on and
  off" the workflow on a repository level, simply by adding or removing
  the "has-coverity-secrets" topic. See:
  https://docs.github.com/en/repositories/managing-your-repositorys-settin=
gs-and-features/customizing-your-repository/classifying-your-repository-wi=
th-topics

  The downside is that this method is somewhat unintuitive and needs the
  developer to read documentation (*shudder*) to know what they need to
  do.

I have no strong preference as long as the job is skipped whenever the
Coverity build (read: the `coverity` GitHub workflow run) should be
skipped.

> +      - uses: actions/checkout@v3
> +        if: steps.check-coverity.outputs.enabled =3D=3D 'true'
> +      - run: ci/install-dependencies.sh
> +        env:
> +          CC: gcc
> +          CC_PACKAGE: gcc-9
> +          jobname: linux-gcc-default

How about modifying `ci/install-dependencies.sh` to introduce a new job
name, `coverity`, that is handled like `linux-gcc-default`? I.e. something
like this:

=2D- snip --
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 107757a1fea..e6a894e507d 100755
=2D-- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -74,7 +74,7 @@ Documentation)
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
 	;;
-linux-gcc-default)
+linux-gcc-default|coverity)
 	sudo apt-get -q update
 	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
 	;;
diff --git a/ci/lib.sh b/ci/lib.sh
index 1b0cc2b57db..7a196aa0d17 100755
=2D-- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -227,7 +227,7 @@ export SKIP_DASHED_BUILT_INS=3DYesPlease

 case "$runs_on_pool" in
 ubuntu-latest)
-	if test "$jobname" =3D "linux-gcc-default"
+	if test "$jobname" =3D "linux-gcc-default" ||  test "$jobname" =3D "cove=
rity"
 	then
 		break
 	fi
=2D- snap --

That would be a lot cleaner and would also allow for Coverity-specific
things in this step that won't affect `linux-gcc-default` at the same
time.

> +          runs_on_pool: ubuntu-latest
> +        if: steps.check-coverity.outputs.enabled =3D=3D 'true'
> +      - uses: vapier/coverity-scan-action@v1

In contrast to the other Actions we use in Git, this one is neither
provided by GitHub nor by the Git (or Git for Windows) project [*3*].

The recommended way to handle such third-party Actions is to pin them by
full length commit SHA:
https://docs.github.com/en/actions/security-guides/security-hardening-for-=
github-actions#using-third-party-actions

This is particularly important because we're passing secret values to that
Action.

> +        if: steps.check-coverity.outputs.enabled =3D=3D 'true'
> +        with:
> +          email: ${{ secrets.COVERITY_SCAN_EMAIL }}
> +          token: ${{ secrets.COVERITY_SCAN_TOKEN }}
> +          command: make -j8
> +

The commit message would make for a fine place to describe the role of
these `COVERITY_SCAN_*` secrets, how to obtain them, and how to configure
them (i.e. providing a link to
https://docs.github.com/en/actions/security-guides/encrypted-secrets#creat=
ing-encrypted-secrets-for-a-repository).

The reason I am suggesting that is that many a time, I have authored
commits like this one, only to puzzle about the exact steps to configure
the the thing properly when I needed it six months later, and regretting
dearly not having had the foresight to help my future self while writing
the commit message.

Another important issue that should be discussed in the commit message is
the matter of Coverity's false positives. I regularly dread going through
the new reports in Coverity (I am doing this for git-for-windows) because
of the many falsely pointed out "buffer overruns" when working e.g. with
`strvec` where Coverity assumes that its `empty_strvec` is ever written
to.

In Git for Windows, I have not had any luck with suppressing these false
reports. For what it's worth, this is the "model file" I am currently
using:

=2D- snip --
/* modelfile for git */

char strbuf_slopbuf[64];

void *malloc(size_t);
void *calloc(size_t, size_t);
void *realloc(void *, size_t);
void free(void *);

void *xrealloc(void *ptr, size_t size)
{
	void *ret =3D realloc(ptr, size);
	if (!ret) __coverity_panic__();
	return ret;
}

void *xmalloc(size_t size)
{
	void *mem =3D malloc(size);
	if (!mem) __coverity_panic__();
	return mem;
}

void xcalloc(size_t num, size_t size)
{
	void *ret =3D calloc(num, size);
	if (!ret)  __coverity_panic__();
	return ret;
}

void usage(const char *err) {
  __coverity_panic__();
}

void usagef(const char *err, ...) {
  __coverity_panic__();
}

void die(const char *err, ...)  {
  __coverity_panic__();
}

void die_errno(const char *err, ...) {
  __coverity_panic__();
}

void BUG_fl(const char *file, int line, const char *fmt, ...) {
  __coverity_panic__();
}

struct strbuf {
	size_t alloc;
	size_t len;
	char *buf;
};

void strbuf_setlen(struct strbuf *sb, size_t len)
{
        sb->len =3D len;
	sb->buf[len] =3D '\0';
}

void strbuf_grow(struct strbuf *sb, size_t amount);

void *memcpy(void *dest, const void *src, size_t n);

void strbuf_add(struct strbuf *sb, const void *data, size_t len)
{
	strbuf_grow(sb, len);
	memcpy(sb->buf + sb->len, data, len);
	sb->len =3D len;
	sb->buf[len] =3D '\0';
}

void *memmove(void *dest, const void *src, size_t n);

void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
				   const void *data, size_t dlen)
{
	if (pos > sb->len)
		die("`pos' is too far after the end of the buffer");
	if (pos + len > sb->len)
		die("`pos + len' is too far after the end of the buffer");

	if (dlen >=3D len)
		strbuf_grow(sb, dlen - len);
	memmove(sb->buf + pos + dlen,
			sb->buf + pos + len,
			sb->len - pos - len);
	memcpy(sb->buf + pos, data, dlen);
	sb->len =3D sb->len + dlen - len;
	sb->buf[sb->len + dlen - len] =3D '\0';
}
=2D- snap --

It is getting a bit ridiculous at this point, the size of it and the
meager benefit it reaps. But it is better than nothing, I guess.

The reason I would really like to see an extensive discussion about this
in the commit message is that this place would be _the_ most logical
habitat for such a description, to help developers who want to set up
their own Coverity coverage (either in their own Git fork, or even in a
separate project) trying to learn from the Git project.

Ciao,
Johannes

Footnote *1*: In case it was unclear: Build agents are essentially virtual
machines. Those virtual machines are destroyed after every run, and
recreated to a pristine state before picking up the next job. To avoid
having to wait for a virtual machine to be created whenever a job needs to
be run, there is a pool of virtual machines ready to run. There have been
times when we ran so many jobs in the Git project that we drained that
pool and had to wait, painfully, for the virtual machines to be created
which, let me tell you, is not a matter of a mere couple of seconds.

This complexity is reflected in the pricing you can see at
https://docs.github.com/en/billing/managing-billing-for-github-actions/abo=
ut-billing-for-github-actions

Just to put things into perspective: In our security work, we have to run
our GitHub workflow in a private repository, where GitHub Actions are not
provided free of cost by GitHub. We have a very nice donation from GitHub
in the form of 50,000 build minutes we can use every month. If we spent
all of those minutes running on Linux (i.e. the cheapest option), GitHub
would essentially donate $400 to us. That's what we usually spend in a
matter of days preparing for security releases: The workflow run to
validate v2.39.3, for example, while taking "only" 36 minutes and 1 second
wall clock time, used up over 12 hours of those 50,000 build minutes, and
every time we iterated, we pushed 11 branches and 11 tags. Three
iterations in, we were out of build minutes.

All this is to say: We, the Git project, are not exactly cautious when it
comes to spending GitHub Actions build minutes. I really would love to see
us all to become a lot more mindful on this matter.

Footnote *2*:
https://github.com/git/git/blob/v2.42.0/.github/workflows/l10n.yml#L13

Footnote *3*: We do already use a third-party Action in `l10n.yml`:
`mshick/add-pr-comment@v1`. As you can verify easily, this is not pinned
by full length commit SHA. But then, this step only gets the
`GITHUB_TOKEN` secret, which only has the permission to write to the Pull
Request (i.e. add a comment), not to write to the repository.

Still, we will probably want to pin that Action at some stage, better safe
'n sorry. #leftoverbits
