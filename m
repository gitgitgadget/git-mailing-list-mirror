Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98149195B1A
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308282; cv=pass; b=IWNJ7KWAE6E0NTudp7NBoQS2ZDWF6zG4w7DsdtWfw7uSqdSU1tX+CoTB+LuEvLhogVXKCoBfmfZTdGdmJ/RzukTWscdw/PISZklcJ0zJ2itIF1Yi+ew46Oa+hxCHumtHbmen5T6PLtscqn0FR9pDUBR/dWM9TCas4peHuvnFUas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308282; c=relaxed/simple;
	bh=bPvYkPOlCfqno+LA0dY3nU5rA8+TsEnfWJf0eJA9aSo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lXVTQmY+4hzXsIvCkPnJgNZw9CuV8oHiuCckalA+CphY4RVA6newcH1mf8W0a3wD9n9d04WfEdjzZXaDTk+XYJqzKI6O2mPdLDmNKHJna8/4QSusoPdJAaR5qoBxYnuoI84sB6IgwjzJY3IUPL4kmjnNnqOr2sd5nxayJHzYaoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sp/35ZZb; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sp/35ZZb"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba7ed32ccdso3485351e87.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 10:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791308278; cv=none;
        d=google.com; s=arc-20260327;
        b=YoWAT+9TQY636LNcOk7NFOoT6ya76gX3nBlMG1EhGA7s8bFuQlUVGNaSWDOddREIHN
         Hl+MfP3d61A66GNsASDTwFWGxR8lGlCDLNHU3v+X2QdfAhXeZkFF8ij5aZJhbLz55ky+
         V88hpBjQ/KtSGt07zmPi8yFmslhky7XiK9AWNjuBfWC1FjuY/CiD7BuIRU/6Q8pS3jFG
         JdbA0EnwV3flDGmB5wKGvHbzwXOD+6ZJIBNuice1/HzkzIwJmITY6Yu6UNiqFPZAnnOx
         yGjD+KDqg5zQTRIjGfcp2J2tcA0ILQdjfdffmKe14xKpSRJ/T/3IQoGxURm5xMTmOH/r
         VXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lbpF6yVjhDgAVA7SJNLXac5u9CwuODbv3BbxGsVKrVQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=LEymnvd3Nq9Ddqun6XFiin3HQ2f+BxE7iv+pvv2z62Dlptnp9U9hzAp7PWVIOrchpV
         s46DYJPaeUulSxxnsgTHjwa7WT9lzWJdQbiLPzqmSjNufnHIMrzNllm6TTwhr63G5WbZ
         zU9vJQnDcbwwvbpuUeioNU2mAyCLLmlcVBGGM0AGCWpJ4DXnSmQVq1hwF1bcHRVpI1Kk
         jP/HSiQLmWXskNVbR93Ttq+VeErm/lEZuHb7JQ/7l0vqC5eIRqzw8TIRrgOozZqp3Lom
         Q0J3QZZQBrck/DkHT6WhJlEh5K7Bpd21/YMUoq9lBrH1+tzUkIiaFGnDSkBbbENZun/o
         GzxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791308278; x=1791913078; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lbpF6yVjhDgAVA7SJNLXac5u9CwuODbv3BbxGsVKrVQ=;
        b=sp/35ZZbSSaklYZFy/sJkXhExrrO0prVMNN5Ap81t8yeA3E5hEgR9r1BV5rZqa9zpq
         18qYUf278GZKTyg9a4Nm7T1oIIqkbNdiz28XQrQkmjwfQcQw+8xTYKx/Xrl836vD8RiN
         82RAc13r4mn7B5+UvK8n1zxgY44fgmbvlRItrqJOxaQoJ0v7UGMzQCkNo7EJcvgknSg4
         Zu82XaNH4ICbQd5WapR8Um9WzUP5P943gxoTXDVeh/AC+qrXAlzS8ndv330JFi9rcnUs
         wcUqd3RpxX4YH7s98haiv+olWWZzY1+x9nfOYwh3C/tWmEjPBvIUJTcaJ3SA3++xGp8M
         cGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308278; x=1791913078;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbpF6yVjhDgAVA7SJNLXac5u9CwuODbv3BbxGsVKrVQ=;
        b=U6HqnvuIWPA8mJZUIsnfQ5K+B2IhLYrEL58HukUTAA36yx0/BkOy0/cKaqKuub3S2u
         f9wKOGbjx1sjzl/UBsZbs8t1sVnEYYv+7P77IVOx7utniYesNoAkVzKLgWB731ogXJAZ
         9fjeGD1jT2FQSvZqyYvNmn2y2KpLS0PCjraBgYUKEtvbH3ilxpxA4YlceGcpISFUFAy4
         Hp3eHPQePQftrjDbo7cPUcxvEL37T1nlLCdtix3akzhajo9nLGpdNla0WObHCVczXI3U
         Po2mkFF9CLKWJ8YYpCg2xvDqnvJALh9NLd7U1McnAXFYyfN+/yxr5bSsNHFh4DKBLpZq
         lBOg==
X-Gm-Message-State: AFq9FYLCzTypdTD2rvvsJZy+TazWCP1vO656ICFG0X9wX3VXBLi/CUYU
	F1/b4MxwLxBDlqbDNpVLnPxXQGUXZSWIkXSXgrnT9yE273Kn+8vU8pEk2AuxXGx4kRvzpiA6c01
	j4u3SFk3+p2LbioJIoCjDCmcz7ahQz8P7R++6yvI=
X-Gm-Gg: AYBFou1OpvfMGRBNtj59zZ3vBQf6cQfzWcSwzql3wVb+BDb9tJiyIOn7XqMvcmkeMed
	ZxooRuLSmGOUlVgbyqkSdnZI1GoYp5nLA7Ma9cOecZ7mkx6cNfLlzkHf0b48oZ/qW13XIXWVBm1
	sjCr/xynKxiHiJGY2EisQEwtLGOB5Nr0QPJwy6zG0I+wNVn1EO3k+GxdjEhBYsZ8vTNodOB6jOr
	9Qt0ftJI8CuJ9yohPaHVPREUbhk59YANRRfjZGeVFg6HHdVAMILACDgu1sGZp7z2EFrZpT5Ia6o
	e8IQMiuNrwTK4+gy7t9rVH5zZVEhaMqAx93g2YhXqoFNsuiyhZbrfvKs/N1+7VR4WeKV7aK4BgX
	ZoG8IWl34P8tIS0wEcElLGWGff8GxG8cMIPFpe257jHiFKxRvmfOuI7XbQMeNe/hXbTHodD1xIa
	8ql27gBVsFfucpHZiQGXSrY6pez/dZWjvdjJVbrlQUeahRxLAIVL2b+eCkQT0fnudpYCqTM9Tnk
	oDajSY+O4D5x5DbTzi+TpxEUOI6dxbGxjBAclrjJ8Gp2rYivq+PuwT4UXKvrKaR8usA41A5dwg=
X-Received: by 2002:a05:6512:3181:b0:5bc:ce5b:970b with SMTP id
 2adb3069b0e04-5bcce5b9ad5mr588030e87.4.1791308278257; Tue, 06 Oct 2026
 10:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SmVucyBSw7Zja2Vy?= <jens.roecker@gmail.com>
Date: Tue, 6 Oct 2026 19:37:47 +0200
X-Gm-Features: AclHuK9DeMuacfhAORwATcY0eKs6YzMQYb68P7j-BWOyBWhGZaMQg8kuYSdQ8Aw
Message-ID: <CA+tGzvYYKm=Yo88knZb4oavG9dH5smUCXnoqa-RR9-7YEBycVA@mail.gmail.com>
Subject: [BUG] push resends common history after repack during pre-push
 (2.54.0, 2.56.0)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git developers,

A push can resend common history if its pre-push hook repacks the local
object database and removes previously loose common objects. I reproduced
this with Apple Git 2.54.0 (Apple Git-157) and an unmodified build of the
current upstream Git 2.56.0 release on macOS 27.0 / arm64.

The attached inline Python script creates fresh local repositories, seeds
a bare receiver with a deterministic, incompressible 4-MiB historical blob,
and pushes one tiny text-file commit. The common base is initially loose.
The receiver uses receive.unpackLimit=1 so the added pack is measurable.
Each case starts from a separate fresh repository pair. All pushes succeed
and the receiver ends at the expected tip.

Observed added receiver pack sizes, in bytes:

                        Apple Git 2.54.0    upstream Git 2.56.0
  no hook                      300                  300
  repack in pre-push      4,196,026            4,196,026
  repack + negotiate     4,196,026            4,196,026

The repacking hook is simply:

  #!/bin/sh
  set -eu
  cat >/dev/null
  git repack -adq
  git prune-packed

Expected: the already-advertised common history should still be excluded
when its storage moves from loose objects to a newly created pack.
Actual: the historical blob is transmitted again. The receiver stores a
new pack roughly the size of the historical blob. Enabling
push.negotiate=true does not prevent the redundant transfer in this test.

Possible mechanism, based on source inspection:

In 2.54.0, send-pack.c:feed_object() drops negative OIDs when
odb_has_object(..., 0) returns false. In 2.56.0, the same quick check is in
append_negative_object(). In both versions, odb_has_object() uses
OBJECT_INFO_QUICK unless ODB_HAS_OBJECT_RECHECK_PACKED is set. A parent
process with a stale pack catalogue may therefore miss the base after the
hook removes the loose copy; the fresh pack generator then sees the new
pack and walks history without that excluded base. This is a proposed
explanation of the measured effect, not an instrumented proof of the
parent process's in-memory state.

Relevant release source:
https://github.com/git/git/blob/v2.54.0/send-pack.c
https://github.com/git/git/blob/v2.56.0/send-pack.c
https://github.com/git/git/blob/v2.56.0/odb.c

The upstream 2.56.0 binary was built from the kernel.org release tarball
with optional gettext, curl, Tcl/Tk, Perl, Python and Rust components
disabled. Neither global Git configuration nor the installed system Git
was changed. The script isolates system/global Git configuration and uses
only local transport. Measurements are receiver pack-file sizes, rather
than network-byte counters. A separate large-repository incident motivated
this test, but this report includes only synthetic fixtures.

To reproduce, save the inline script as reproduce.py and run:

  python3 reproduce.py --git /path/to/git

For a Git binary built in-place, add:

  --exec-path /path/to/git/build/directory

The script requires Python 3 and Git; its default mode removes only its
own temporary test repositories when the run completes. To retain all
fixture repositories and push logs, pass --output with a new directory.

Minimal reproducer follows:

#!/usr/bin/env python3
"""Reproduce redundant push history after loose objects move into a new pack.

Uses fresh local test repositories only. Requires Python 3 and Git.
Example: python3 reproduce.py --git /path/to/git --output /new/results/path
For an uninstalled Git build, add --exec-path /path/to/build/directory.
"""

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import tempfile
import time


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--git", default=shutil.which("git"))
    parser.add_argument("--exec-path")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    binary = str(Path(args.git).resolve())
    temporary = None
    if args.output:
        root = args.output.resolve()
        root.mkdir(parents=True, exist_ok=False)
    else:
        temporary = tempfile.TemporaryDirectory(prefix="git-push-repack-repro-")
        root = Path(temporary.name)

    env = {key: value for key, value in os.environ.items()
           if not key.startswith("GIT_")}
    env.update(GIT_CONFIG_NOSYSTEM="1", GIT_CONFIG_GLOBAL=os.devnull,
               GIT_AUTHOR_DATE="2001-01-01T00:00:00+0000",
               GIT_COMMITTER_DATE="2001-01-01T00:00:00+0000")
    env["PATH"] = str(Path(binary).parent) + os.pathsep + env.get("PATH", "")
    if args.exec_path:
        env["GIT_EXEC_PATH"] = str(Path(args.exec_path).resolve())

    def git(cwd, *words):
        return subprocess.run([binary, *words], cwd=cwd, env=env,
                              text=True, capture_output=True, check=True,
                              timeout=60)

    results = []
    for mode in ("no-hook", "repack", "repack-negotiate"):
        case = root / mode
        case.mkdir()
        repo, remote = case / "repo", case / "remote.git"
        git(case, "init", "-q", "-b", "main", str(repo))
        git(case, "init", "-q", "--bare", "-b", "main", str(remote))
        for key, value in (("user.name", "Git bug reproduction"),
                           ("user.email", "test@example.invalid"),
                           ("commit.gpgsign", "false"), ("gc.auto", "0"),
                           ("core.hooksPath", str(repo / ".git/hooks"))):
            git(repo, "config", key, value)
        git(remote, "config", "gc.auto", "0")
        git(remote, "config", "receive.unpackLimit", "1")
        (repo / "history.bin").write_bytes(
            hashlib.shake_256(b"historical fixture").digest(4 * 1024 * 1024))
        git(repo, "add", "--", "history.bin")
        git(repo, "commit", "-q", "-m", "historical seed", "--", "history.bin")
        base = git(repo, "rev-parse", "HEAD").stdout.strip()
        git(repo, "push", "-q", str(remote), "HEAD:refs/heads/main")
        (repo / "change.txt").write_text("tiny change\n")
        git(repo, "add", "--", "change.txt")
        git(repo, "commit", "-q", "-m", "tiny change", "--", "change.txt")
        tip = git(repo, "rev-parse", "HEAD").stdout.strip()
        assert (repo / ".git/objects" / base[:2] / base[2:]).is_file()
        if mode != "no-hook":
            hook = repo / ".git/hooks/pre-push"
            hook.parent.mkdir(parents=True, exist_ok=True)
            hook.write_text("#!/bin/sh\nset -eu\ncat >/dev/null\n"
                            "git repack -adq\ngit prune-packed\n")
            hook.chmod(0o700)
        before = set((remote / "objects/pack").glob("*.pack"))
        config = ["-c", "push.negotiate=true"] if mode ==
"repack-negotiate" else []
        start = time.monotonic()
        result = git(repo, *config, "push", "--progress", str(remote),
                     "HEAD:refs/heads/main")
        elapsed = time.monotonic() - start
        (case / "push.log").write_text(result.stdout + result.stderr)
        packs = set((remote / "objects/pack").glob("*.pack")) - before
        remote_tip = git(remote, "rev-parse", "refs/heads/main").stdout.strip()
        assert remote_tip == tip
        results.append({"case": mode, "push_rc": result.returncode,
                        "new_remote_pack_bytes": sum(p.stat().st_size
for p in packs),
                        "elapsed_seconds": round(elapsed, 6),
                        "remote_tip_matches": True})
    report = {"git_version": git(root, "version",
"--build-options").stdout.strip(),
              "platform": {"system": platform.system(), "machine":
platform.machine(),
                           "macos": platform.mac_ver()[0]},
              "fixture_bytes": 4 * 1024 * 1024,
              "transport": "local bare repository", "results": results}
    encoded = json.dumps(report, indent=2) + "\n"
    (root / "results.json").write_text(encoded)
    print(encoded, end="")
    if temporary:
        temporary.cleanup()


if __name__ == "__main__":
    main()

Thank you.
