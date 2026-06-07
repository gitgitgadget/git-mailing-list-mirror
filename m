Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33771334C2E
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780842982; cv=none; b=G/N4drXXCSZFJwDUTY8CcdzqCyOhoZT2s7H94U4AE0tD5U+jXzj/1WWNSZNe29cYECcZ6sPD8MJsEVlqozVCtND05p+2Eyds3BcRebUz2KHLmefS+jie6InN18xSXlfQKT0vJ3kSVlYGqeaUf9tVoFhETIl1+NwxFD3nfTmJ4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780842982; c=relaxed/simple;
	bh=5qNKRur7r7P8B6kgVauvDNSaoWER5higYJv1cotoft8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ObBUPnqrDpiN1K8ZMzA2XBcZq2RqFFO8Bf1NjNRtR7Ev2WhxpZ96/f81iD7MlSG6nB4UjNiMi0F5kSwqXdew7Fc1k2YHl2gtf8Cp8qLmWLTZjuQqfn6vDvdWc74mOkamUpFH+oleyADMg9X6ffjek/PjgeROqGKCxMM3w21j9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=WDp5UvH5; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="WDp5UvH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780842976; x=1781447776;
	i=johannes.schindelin@gmx.de;
	bh=+XiF+FFG4pb2rG6jpz9sh1SrnsIoMoAzA8ITZkvQNA8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WDp5UvH5+YIZfGcjQgr80pH9nPhJgMRzm2FUY+nSsJJ+HtuD97cmCxCqysQXcDLG
	 kurDVgwhv+922GwiS6LeEKp22Xjoc3nfj/yldISCXqHdBgkXCB28aVw/irG303c+V
	 Pv59Z6BTGEeUq9vVATc6l34aC9T7Ah4FUipnWAD027/VMhkBT1VpQMyaqMoeD6u4Q
	 WVDQOOYy2wSMK55CdlIrqKIrwYSCSW/fSMwtYt9fYZMQXi3WicNJimh2vQR9ZqWU1
	 q91OqNd3mbr5ukvSsOAnSyaXeFQpcYI+V6uNxXiInwCrHScVfFMqneb5cToa32+nT
	 Xs5oGWEIzlziIJD4ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1xEkTa33KM-017PGn; Sun, 07
 Jun 2026 16:36:16 +0200
Date: Sun, 7 Jun 2026 16:36:15 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>, 
    Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 4/6] diff: add long-running diff process via
 diff.<driver>.process
In-Reply-To: <d044fa0ee5c9cda7dfe4f663f34443103521ef43.1780087700.git.gitgitgadget@gmail.com>
Message-ID: <c7987f11-9181-3975-552c-14e74abb2c97@gmx.de>
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com> <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com> <d044fa0ee5c9cda7dfe4f663f34443103521ef43.1780087700.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:oysVmpq7wla0FjlsGg9aVMFYzwFyrHd8iLjiBPuEeoqUr/IqpL+
 ZpKRtuqU3ZNqqQOiYigY8YXSaj2EVRWcOF8suJHdjzWiKN9K3ESKJn3jEij81nUKkzk566l
 g4JnpO0s5neGuZfdGLffWxXyUyktFDUVWwzY08t8PedI6+o25wn45XMy8qwwjOx8GPKYIjE
 RCcqO76blUmxoghir8pGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QzgfRJirjiM=;v0ZrU8l07XVON/j2zqSAF2XkYIt
 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
 0DPDpr6Bi5/cAIySBc=
Content-Transfer-Encoding: quoted-printable

Hi Michael,

I stumbled about this patch when it broke CI in Git for Windows, where we
do _not_ use `NO_PYTHON`, even though Python is unavailable in the
build/test CI jobs. The existing tests handle this situation gracefully,
this here patch does not:

On Sun, 7 Jun 2026, Michael Montalbo via GitGitGadget wrote:

> diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
> new file mode 100755
> index 0000000000..f159cd86d8
> --- /dev/null
> +++ b/t/t4080-diff-process.sh
> @@ -0,0 +1,538 @@
> +#!/bin/sh
> +
> +test_description=3D'diff process via long-running process'
> +
> +. ./test-lib.sh
> +
> +if test_have_prereq PYTHON
> +then
> +	PYTHON_PATH=3D$(command -v python3) || PYTHON_PATH=3D$(command -v pyth=
on)

When neither `python3` nor `python` are available (which is the case in
the minimal Git for Windows SDK used in Git's CI runs), this fails under
`set -e`. Before even running the first test case. Resulting in an
unexpected TAP format error.

Now, we could "fix" this by imitating what `lib-p4` does (see
https://github.com/dscho/git/commit/bd0b5570c744f678911a67a62da63f30655f20=
d8
which demonstrates that it is indeed a work-around on Windows):

=2D- snip --
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index fdf6da1c341e67..bd22c247ff3856 100755
=2D-- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -4,9 +4,10 @@ test_description=3D'diff process via long-running process=
'
=20
 . ./test-lib.sh
=20
-if test_have_prereq PYTHON
+if ! test_have_prereq PYTHON || ! test -x "$PYTHON_PATH"
 then
-	PYTHON_PATH=3D$(command -v python3) || PYTHON_PATH=3D$(command -v python=
)
+	skip_all=3D'python interpreter not available'
+	test_done
 fi
=20
 #
=2D- snap --

Of course, this uncovers _another_ problem with the Python script: It uses
Python3-only `f"..."` format strings, which cannot be handled by the
Python2 to which the `PYTHON_PATH` variable in `linux-TEST-vars` points.
So this requires _another follow-up (see also
https://github.com/dscho/git/commit/c12a9f4c80e5ce8db0fe370fac46fb45be2b77=
5f):

=2D- snip --
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index bd22c247ff3856..ba14682a9086e4 100755
=2D-- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -39,7 +39,8 @@ setup_backend () {
=20
 	def write_pkt(line):
 	    data =3D (line + "\n").encode()
-	    sys.stdout.buffer.write(f"{len(data)+4:04x}".encode() + data)
+	    hdr =3D "{:04x}".format(len(data) + 4).encode()
+	    sys.stdout.buffer.write(hdr + data)
 	    sys.stdout.buffer.flush()
=20
 	def write_flush():
@@ -98,7 +99,8 @@ setup_backend () {
 	    new =3D read_content()
 	    old_first =3D old.split(b"\n")[0].decode(errors=3D"replace") if old =
else ""
 	    new_first =3D new.split(b"\n")[0].decode(errors=3D"replace") if new =
else ""
-	    log(f"command=3D{cmd} pathname=3D{pathname} old=3D{old_first} new=3D=
{new_first}")
+	    log("command=3D{} pathname=3D{} old=3D{} new=3D{}".format(
+	        cmd, pathname, old_first, new_first))
=20
 	    if mode =3D=3D "error":
 	        write_flush()
@@ -130,7 +132,7 @@ setup_backend () {
 	        else:
 	            ol =3D old.count(b"\n")
 	            nl =3D new.count(b"\n")
-	            write_pkt(f"hunk 1 {ol} 1 {nl}")
+	            write_pkt("hunk 1 {} 1 {}".format(ol, nl))
 	        write_flush()
 	        write_pkt("status=3Dsuccess")
 	        write_flush()
=2D- snap --

And this is still not enough to make it work with Python2, see
https://github.com/dscho/git/actions/runs/27091523842/job/79955895737:

=2D- snip --
[...]
+ git -c diff.cdiff.process=3D./diff-process-backend --mode=3Dfixed-hunk d=
iff boundary.c
  Traceback (most recent call last):
    File "/__w/git/git/t/trash directory.t4080-diff-process/diff-process-b=
ackend.py", line 45, in <module>
      assert read_pkt() =3D=3D "git-diff-client"
    File "/__w/git/git/t/trash directory.t4080-diff-process/diff-process-b=
ackend.py", line 4, in read_pkt
      hdr =3D sys.stdin.buffer.read(4)
  AttributeError: 'file' object has no attribute 'buffer'
=2D- snap --

I have experienced similar patterns in my career, where a single decision
required multiple follow-up fixes _just_ to avoid having to revert that
decision. This kind of doubling down has never ended well.

Therefore I would like to take a step back, and ask: Is it _really_ a good
idea to use Python here? Are we certain that we want to _require_ Python
to run this test and skip it if Python isn't available (as is the case in
the Windows-related parts of Git's very own CI) even if Python has nothing
at all to do with the feature that is being tested?

I don't want to be doomed to repeat history, and we can very well learn
e.g. from prior art in this very project, where the tests for the
clean/smudge filters (which _also_ want to speak pkt-line over stdio)
needlessly incurred Perl as a requirement to run the tests. It was
Matheus's heroic work in 52917a998ef3a (t0021: implementation the
rot13-filter.pl script in C, 2022-08-14) and 4d1d843be7a15 (tests: use the
new C rot13-filter helper to avoid PERL prereq, 2022-08-14) that avoided
that unnecessary prerequisite.

Likewise, there is `test-tool pkt-line` intended for driving the pkt-line
protocol via simple shell scripts.

So the conscious project direction has been: fold pkt-line test backends
into `test-tool` and drop the scripting-language prereq. Reintroducing the
same shape in Python would walk this back.

Patrick's careful effort in 27bd8ee311719 (Merge branch 'ps/fewer-perl',
2025-04-29) has been another clear sign that the Git project is actively
_removing_ scripting-language dependencies from the build and test
infrastructure, not adding new ones.

The clear prior art in Git's own tests for what t4080 wants to do, as of
today, is `t/helper/test-rot13-filter.c`, which could be imitated here
instead of (re-)introducing a dependency on a scripting language other
than Unix shell in Git's test suite.

The `PYTHON` prereq exists in exactly five files today, all `git p4`
related (where Python is an intrinsic prerequisite given that `git-p4.py`
_is_ written in Python): `t/lib-git-p4.sh`, `t/t9802-git-p4-filetype.sh`,
`t/t9810-git-p4-rcs.sh`, `t/t9835-git-p4-metadata-encoding-python2.sh`,
and `t/t9836-git-p4-metadata-encoding-python3.sh`.

After 7cdbff14d482 (remove merge-recursive-old, 2006-11-20), this here
patch would be the first one, after almost 20 years, to re-introduce
Python as a dependency outside `git p4`.

And it would also be the first ever to embed a Python script as a heredoc:

> +fi
> +
> +#
> +# A single parametric diff process.
> +# Usage: diff-process-backend --mode=3D<mode> [--log=3D<path>]
> +#
> +# Modes:
> +#   whole-file  - report all lines as changed (default)
> +#   fixed-hunk  - always report hunk 5 2 5 2
> +#   bad-hunk    - report out-of-bounds hunk 999 1 999 1
> +#   bad-sync    - report hunk with mismatched unchanged totals
> +#   overlap     - report two overlapping hunks
> +#   no-hunks   - return no hunks (files considered equivalent)
> +#   error       - return status=3Derror for every request
> +#   abort       - return status=3Dabort for every request
> +#   crash       - read one request then exit without responding
> +#
> +setup_backend () {
> +	cat >"$TRASH_DIRECTORY/diff-process-backend.py" <<-\PYEOF
> +	import sys, os
> +
> +	def read_pkt():
> +	    hdr =3D sys.stdin.buffer.read(4)
> +	    if len(hdr) < 4: return None
> +	    length =3D int(hdr, 16)
> +	    if length =3D=3D 0: return ""
> +	    data =3D sys.stdin.buffer.read(length - 4)
> +	    return data.decode().rstrip("\n")
> +
> +	def write_pkt(line):
> +	    data =3D (line + "\n").encode()
> +	    sys.stdout.buffer.write(f"{len(data)+4:04x}".encode() + data)
> +	    sys.stdout.buffer.flush()
> +
> +	def write_flush():
> +	    sys.stdout.buffer.write(b"0000")
> +	    sys.stdout.buffer.flush()
> +
> +	def read_content():
> +	    chunks =3D []
> +	    while True:
> +	        hdr =3D sys.stdin.buffer.read(4)
> +	        if len(hdr) < 4: break
> +	        length =3D int(hdr, 16)
> +	        if length =3D=3D 0: break
> +	        chunks.append(sys.stdin.buffer.read(length - 4))
> +	    return b"".join(chunks)
> +
> +	mode =3D "whole-file"
> +	logfile =3D None
> +	for arg in sys.argv[1:]:
> +	    if arg.startswith("--mode=3D"):
> +	        mode =3D arg[7:]
> +	    elif arg.startswith("--log=3D"):
> +	        logfile =3D open(arg[6:], "a")
> +
> +	def log(msg):
> +	    if logfile:
> +	        logfile.write(msg + "\n")
> +	        logfile.flush()
> +
> +	# Handshake
> +	assert read_pkt() =3D=3D "git-diff-client"
> +	assert read_pkt() =3D=3D "version=3D1"
> +	read_pkt()
> +	write_pkt("git-diff-server")
> +	write_pkt("version=3D1")
> +	write_flush()
> +	while True:
> +	    p =3D read_pkt()
> +	    if p =3D=3D "": break
> +	write_pkt("capability=3Dhunks")
> +	write_flush()
> +
> +	log("ready")
> +
> +	while True:
> +	    cmd =3D None
> +	    pathname =3D None
> +	    while True:
> +	        p =3D read_pkt()
> +	        if p is None: sys.exit(0)
> +	        if p =3D=3D "": break
> +	        if p.startswith("command=3D"): cmd =3D p.split("=3D",1)[1]
> +	        if p.startswith("pathname=3D"): pathname =3D p.split("=3D",1)[=
1]
> +	    if cmd is None: sys.exit(0)
> +	    old =3D read_content()
> +	    new =3D read_content()
> +	    old_first =3D old.split(b"\n")[0].decode(errors=3D"replace") if ol=
d else ""
> +	    new_first =3D new.split(b"\n")[0].decode(errors=3D"replace") if ne=
w else ""
> +	    log(f"command=3D{cmd} pathname=3D{pathname} old=3D{old_first} new=
=3D{new_first}")
> +
> +	    if mode =3D=3D "error":
> +	        write_flush()
> +	        write_pkt("status=3Derror")
> +	        write_flush()
> +	        continue
> +
> +	    if mode =3D=3D "abort":
> +	        write_flush()
> +	        write_pkt("status=3Dabort")
> +	        write_flush()
> +	        continue
> +
> +	    if mode =3D=3D "crash":
> +	        sys.exit(1)
> +
> +	    if cmd =3D=3D "hunks":
> +	        if mode =3D=3D "fixed-hunk":
> +	            write_pkt("hunk 5 2 5 2")
> +	        elif mode =3D=3D "bad-hunk":
> +	            write_pkt("hunk 999 1 999 1")
> +	        elif mode =3D=3D "bad-sync":
> +	            write_pkt("hunk 1 2 1 1")
> +	        elif mode =3D=3D "overlap":
> +	            write_pkt("hunk 1 5 1 5")
> +	            write_pkt("hunk 3 2 3 2")
> +	        elif mode =3D=3D "no-hunks":
> +	            pass
> +	        else:
> +	            ol =3D old.count(b"\n")
> +	            nl =3D new.count(b"\n")
> +	            write_pkt(f"hunk 1 {ol} 1 {nl}")
> +	        write_flush()
> +	        write_pkt("status=3Dsuccess")
> +	        write_flush()
> +	    else:
> +	        write_flush()
> +	        write_pkt("status=3Derror")
> +	        write_flush()
> +	PYEOF

The existing pattern is to provide larger scripts as fixtures in
associated `t/tNNNN/` directories, not as heredoc, see e.g.
`t/t1509/prepare-chroot.sh`. Writing scripts, especially lengthy ones, in
heredoc strings makes it virtually impossible to use static code analysis
or syntax highlighting to fend off banal errors.

Given the complexity of what t4080 tries to test (error, abort, crash,
bad-sync, no-hunks, multiple files in one session, capability
negotiation), it would unfortunately be infeasible to use `test-tool
pkt-line` from a shell script implementing that `diff.*.process` protocol.

So I've spiked a demo how the `test-tool diff-process-backend` could look
like (letting Opus do the menial typing, so that I can enjoy at least part
of a sunny Sunday outside), which also passes the CI build and test:
https://github.com/dscho/git/commit/b6e3c93381b00929476c3a00155f7cf7334a22=
e6

That commit is of course not intended to be used as-is; Feel free to pick
code parts of it and integrate them into your topic branch. Or write your
own test-tool helper from scratch if that's more your jam.

Ciao,
Johannes

> +	write_script diff-process-backend <<-SHEOF
> +	exec "$PYTHON_PATH" "$TRASH_DIRECTORY/diff-process-backend.py" "\$@"
> +	SHEOF
> +}
> +
> +BACKEND=3D"./diff-process-backend"
> +
> +test_expect_success PYTHON 'setup' '
> +	setup_backend &&
> +	echo "*.c diff=3Dcdiff" >.gitattributes &&
> +	git add .gitattributes &&
> +
> +	# boundary.c: 10 lines, changes at 5-6 and 9-10.
> +	# Used by: hunk boundaries, error fallback, crash, bad hunks, overlap.
> +	cat >boundary.c <<-\EOF &&
> +	line1
> +	line2
> +	line3
> +	line4
> +	OLD5
> +	OLD6
> +	line7
> +	line8
> +	OLD9
> +	OLD10
> +	EOF
> +	git add boundary.c &&
> +
> +	# worddiff.c: single-line function, value changes 1 -> 999.
> +	# Used by: word-diff, --diff-algorithm, --no-ext-diff, --stat.
> +	cat >worddiff.c <<-\EOF &&
> +	int value(void) { return 1; }
> +	EOF
> +	git add worddiff.c &&
> +
> +	# newfile.c: single-line function, value changes 42 -> 99.
> +	# Used by: new file, --exit-code, multiple drivers.
> +	cat >newfile.c <<-\EOF &&
> +	int new_func(void) { return 42; }
> +	EOF
> +	git add newfile.c &&
> +
> +	# logtest.c: single-line function for log/format-patch tests.
> +	# Needs two commits so log -1 has a diff.
> +	cat >logtest.c <<-\EOF &&
> +	int logfunc(void) { return 1; }
> +	EOF
> +	git add logtest.c &&
> +
> +	# two.c/one.c: two-file pair for error/abort/startup-failure tests.
> +	cat >one.c <<-\EOF &&
> +	int first(void) { return 1; }
> +	EOF
> +	cat >two.c <<-\EOF &&
> +	int second(void) { return 2; }
> +	EOF
> +	git add one.c two.c &&
> +
> +	git commit -m "initial" &&
> +
> +	# Second commit for logtest.c (so log -1 has something to show).
> +	cat >logtest.c <<-\EOF &&
> +	int logfunc(void) { return 2; }
> +	EOF
> +	git add logtest.c &&
> +	git commit -m "change logtest.c" &&
> +
> +	# Working tree modifications (not committed).
> +	cat >boundary.c <<-\EOF &&
> +	line1
> +	line2
> +	line3
> +	line4
> +	NEW5
> +	NEW6
> +	line7
> +	line8
> +	NEW9
> +	NEW10
> +	EOF
> +
> +	cat >worddiff.c <<-\EOF &&
> +	int value(void) { return 999; }
> +	EOF
> +
> +	cat >newfile.c <<-\EOF &&
> +	int new_func(void) { return 99; }
> +	EOF
> +
> +	cat >one.c <<-\EOF &&
> +	int first(void) { return 10; }
> +	EOF
> +
> +	cat >two.c <<-\EOF
> +	int second(void) { return 20; }
> +	EOF
> +'
> +
> +#
> +# Core behavior: the tool controls which lines are marked as changed.
> +#
> +
> +test_expect_success PYTHON 'diff process hunk boundaries affect output'=
 '
> +	# The file has changes at lines 5-6 and 9-10, but fixed-hunk
> +	# only reports lines 5-6 as changed.  Lines 9-10 should not
> +	# appear as changed in the output.
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Dfixed-hunk" \
> +		diff boundary.c >actual &&
> +	test_grep "^-OLD5" actual &&
> +	test_grep "^-OLD6" actual &&
> +	test_grep "^+NEW5" actual &&
> +	test_grep "^+NEW6" actual &&
> +	test_grep ! "^-OLD9" actual &&
> +	test_grep ! "^-OLD10" actual &&
> +	test_grep ! "^+NEW9" actual &&
> +	test_grep ! "^+NEW10" actual
> +'
> +
> +test_expect_success PYTHON 'diff process works with new file' '
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> +		diff -- newfile.c >actual 2>stderr &&
> +	test_grep "return 99" actual &&
> +	test_grep "pathname=3Dnewfile.c" backend.log &&
> +	test_must_be_empty stderr
> +'
> +
> +test_expect_success PYTHON 'diff process works with added file (empty o=
ld side)' '
> +	cat >added.c <<-\EOF &&
> +	int added(void) { return 1; }
> +	EOF
> +	git add added.c &&
> +
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> +		diff --cached -- added.c >actual 2>stderr &&
> +	test_grep "added" actual &&
> +	test_grep "pathname=3Dadded.c" backend.log &&
> +	test_must_be_empty stderr
> +'
> +
> +test_expect_success PYTHON 'diff process skipped for binary files' '
> +	printf "\\0binary" >binary.c &&
> +	git add binary.c &&
> +	git commit -m "add binary" &&
> +	printf "\\0changed" >binary.c &&
> +
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> +		diff -- binary.c >actual &&
> +	test_grep "Binary files" actual &&
> +	test_path_is_missing backend.log
> +'
> +
> +test_expect_success PYTHON 'diff process not consulted for unmatched dr=
iver' '
> +	echo "not tracked by cdiff" >unmatched.txt &&
> +	git add unmatched.txt &&
> +	git commit -m "add unmatched.txt" &&
> +
> +	echo "modified" >unmatched.txt &&
> +
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> +		diff -- unmatched.txt >actual &&
> +	test_grep "modified" actual &&
> +	test_path_is_missing backend.log
> +'
> +
> +test_expect_success PYTHON 'multiple drivers use separate processes' '
> +	echo "*.h diff=3Dhdiff" >>.gitattributes &&
> +	git add .gitattributes &&
> +
> +	cat >multi.h <<-\EOF &&
> +	int header(void) { return 1; }
> +	EOF
> +	git add multi.h &&
> +	git commit -m "add multi.h" &&
> +
> +	cat >multi.h <<-\EOF &&
> +	int header(void) { return 2; }
> +	EOF
> +
> +	rm -f backend-c.log backend-h.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend-c.log" \
> +	    -c diff.hdiff.process=3D"$BACKEND --log=3Dbackend-h.log" \
> +		diff -- newfile.c multi.h >actual 2>stderr &&
> +	test_grep "pathname=3Dnewfile.c" backend-c.log &&
> +	test_grep "pathname=3Dmulti.h" backend-h.log &&
> +	test_must_be_empty stderr
> +'
> +
> +test_expect_success PYTHON 'diff process works alongside textconv' '
> +	write_script uppercase-filter <<-\EOF &&
> +	tr "a-z" "A-Z" <"$1"
> +	EOF
> +
> +	cat >textconv.c <<-\EOF &&
> +	hello world
> +	EOF
> +	git add textconv.c &&
> +	git commit -m "add textconv.c" &&
> +
> +	cat >textconv.c <<-\EOF &&
> +	goodbye world
> +	EOF
> +
> +	rm -f backend.log &&
> +	git -c diff.cdiff.textconv=3D"./uppercase-filter" \
> +	    -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> +		diff -- textconv.c >actual 2>stderr &&
> +	# The diff process receives textconv-transformed (uppercase) content.
> +	test_grep "pathname=3Dtextconv.c" backend.log &&
> +	test_grep "old=3DHELLO WORLD" backend.log &&
> +	test_grep "new=3DGOODBYE WORLD" backend.log &&
> +	test_must_be_empty stderr
> +'
> +
> +#
> +# Downstream features: word diff, log, equivalent files, exit code.
> +#
> +
> +test_expect_success PYTHON 'diff process with --word-diff' '
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> +		diff --word-diff worddiff.c >actual 2>stderr &&
> +	test_grep "\[-1;-\]" actual &&
> +	test_grep "{+999;+}" actual &&
> +	test_grep "pathname=3Dworddiff.c" backend.log &&
> +	test_must_be_empty stderr
> +'
> +
> +test_expect_success PYTHON 'diff process works with git log -p' '
> +	# With no-hunks mode, the tool says the files are equivalent,
> +	# so log -p should show the commit but no diff content.
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Dno-hunks --log=3Dbacken=
d.log" \
> +		log -1 -p -- logtest.c >actual 2>stderr &&
> +	test_grep "change logtest.c" actual &&
> +	test_grep ! "return 2" actual &&
> +	test_grep "command=3Dhunks pathname=3Dlogtest.c" backend.log &&
> +	test_must_be_empty stderr
> +'
> +
> +test_expect_success PYTHON 'diff process no hunks suppresses diff outpu=
t' '
> +	cat >nohunks.c <<-\EOF &&
> +	int zero(void) { return 0; }
> +	EOF
> +	git add nohunks.c &&
> +	git commit -m "add nohunks.c" &&
> +
> +	cat >nohunks.c <<-\EOF &&
> +	int zero(void) { return 999; }
> +	EOF
> +
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Dno-hunks" \
> +		diff nohunks.c >actual &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success PYTHON 'diff process no hunks with --exit-code retu=
rns success' '
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Dno-hunks" \
> +		diff --exit-code nohunks.c
> +'
> +
> +test_expect_success PYTHON 'diff process with --exit-code and hunks ret=
urns failure' '
> +	test_expect_code 1 git -c diff.cdiff.process=3D"$BACKEND" \
> +		diff --exit-code newfile.c
> +'
> +
> +#
> +# Bypass mechanisms: flags and commands that skip the diff process.
> +#
> +
> +test_expect_success PYTHON 'diff process bypassed by --diff-algorithm' =
'
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> +		diff --diff-algorithm=3Dpatience worddiff.c >actual &&
> +	test_grep "return 999" actual &&
> +	test_path_is_missing backend.log
> +'
> +
> +test_expect_success PYTHON 'diff process not used by --stat' '
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> +		diff --stat worddiff.c >actual &&
> +	test_grep "worddiff.c" actual &&
> +	test_path_is_missing backend.log
> +'
> +
> +#
> +# Error handling and fallback.
> +#
> +
> +test_expect_success PYTHON 'diff process fallback on tool error status'=
 '
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Derror --log=3Dbackend.l=
og" \
> +		diff boundary.c >actual 2>stderr &&
> +	# Fallback produces the full builtin diff (both change regions).
> +	test_grep "^-OLD5" actual &&
> +	test_grep "^+NEW5" actual &&
> +	test_grep "^-OLD9" actual &&
> +	test_grep "^+NEW9" actual &&
> +	# Tool was contacted (it replied with error, not crash).
> +	test_grep "command=3Dhunks pathname=3Dboundary.c" backend.log &&
> +	test_grep "diff process.*failed" stderr
> +'
> +
> +test_expect_success PYTHON 'diff process error keeps tool available for=
 next file' '
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Derror --log=3Dbackend.l=
og" \
> +		diff -- one.c two.c >actual 2>stderr &&
> +	# Unlike abort, error keeps the tool available: both files
> +	# are sent to the tool (and both fall back).
> +	test_grep "pathname=3Done.c" backend.log &&
> +	test_grep "pathname=3Dtwo.c" backend.log &&
> +	test_grep "return 10" actual &&
> +	test_grep "return 20" actual
> +'
> +
> +test_expect_success PYTHON 'diff process abort disables for session' '
> +	rm -f backend.log &&
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Dabort --log=3Dbackend.l=
og" \
> +		diff -- one.c two.c >actual &&
> +	# Both files should still produce diff output via fallback.
> +	test_grep "return 10" actual &&
> +	test_grep "return 20" actual &&
> +	# The tool aborts on the first file and git clears its
> +	# capability.  The second file never contacts the tool.
> +	test_grep "pathname=3Done.c" backend.log &&
> +	test_grep ! "pathname=3Dtwo.c" backend.log
> +'
> +
> +test_expect_success PYTHON 'diff process fallback on tool crash' '
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Dcrash" \
> +		diff boundary.c >actual 2>stderr &&
> +	test_grep "^-OLD5" actual &&
> +	test_grep "^+NEW5" actual &&
> +	test_grep "^-OLD9" actual &&
> +	test_grep "^+NEW9" actual &&
> +	# Crash is a communication failure, so a warning is emitted.
> +	test_grep "diff process.*failed" stderr
> +'
> +
> +test_expect_success PYTHON 'diff process startup failure only warns onc=
e' '
> +	git -c diff.cdiff.process=3D"/nonexistent/tool" \
> +		diff -- one.c two.c >actual 2>stderr &&
> +	# Both files produce diff output via fallback.
> +	test_grep "return 10" actual &&
> +	test_grep "return 20" actual &&
> +	# Sentinel prevents repeated warnings: only one, not one per file.
> +	test_grep "diff process.*failed" stderr >warnings &&
> +	test_line_count =3D 1 warnings
> +'
> +
> +test_expect_success PYTHON 'diff process fallback on bad hunks' '
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Dbad-hunk" \
> +		diff boundary.c >actual 2>stderr &&
> +	test_grep "^-OLD5" actual &&
> +	test_grep "^+NEW5" actual &&
> +	test_grep "^-OLD9" actual &&
> +	test_grep "^+NEW9" actual &&
> +	# Invalid hunks are caught by xdiff validation, not the
> +	# protocol layer, so no warning is emitted.
> +	test_must_be_empty stderr
> +'
> +
> +test_expect_success PYTHON 'diff process fallback on mismatched unchang=
ed totals' '
> +	cat >synctest.c <<-\EOF &&
> +	line1
> +	line2
> +	line3
> +	EOF
> +	git add synctest.c &&
> +	git commit -m "add synctest.c" &&
> +
> +	cat >synctest.c <<-\EOF &&
> +	line1
> +	changed
> +	line3
> +	EOF
> +
> +	# bad-sync reports hunk 1 2 1 1: marks 2 old lines and 1 new
> +	# line as changed, leaving 1 unchanged old vs 2 unchanged new.
> +	# The synchronization invariant fails and git falls back.
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Dbad-sync" \
> +		diff synctest.c >actual 2>stderr &&
> +	test_grep "changed" actual
> +'
> +
> +test_expect_success PYTHON 'diff process fallback on overlapping hunks'=
 '
> +	# boundary.c has 10 lines, so both hunks are in bounds
> +	# but they overlap at lines 3-5, triggering the ordering check.
> +	git -c diff.cdiff.process=3D"$BACKEND --mode=3Doverlap" \
> +		diff boundary.c >actual 2>stderr &&
> +	test_grep "NEW5" actual
> +'
> +
> +test_done
> diff --git a/userdiff.h b/userdiff.h
> index 51c26e0d41..a98eabe377 100644
> --- a/userdiff.h
> +++ b/userdiff.h
> @@ -3,6 +3,7 @@
> =20
>  #include "notes-cache.h"
> =20
> +struct diff_subprocess;
>  struct index_state;
>  struct repository;
> =20
> @@ -33,6 +34,8 @@ struct userdiff_driver {
>  	int textconv_want_cache;
>  	const char *process;
>  	char *process_owned;
> +	struct diff_subprocess *diff_subprocess;
> +	unsigned diff_process_failed : 1;
>  };
>  enum userdiff_driver_type {
>  	USERDIFF_DRIVER_TYPE_BUILTIN =3D 1<<0,
> --=20
> gitgitgadget
>=20
>=20
>=20
