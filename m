Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA564CB57
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993075; cv=none; b=iU4FcslQ6txw7sxkkXWCCxoYblXWivDhxRfmz8UAX5cNuo4WwsJBOHUw5soNL1J7djJ+bzhAGYsk4UBJ2G5+vCQQZ2ioCgMxrh20Lqlqudg3jyPqGxdXd3etg6ZCBfNMKXUvwMnoP4rbHK0uD7gzE271isvs3R2OTURlsuhlcLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993075; c=relaxed/simple;
	bh=SGTOrnPgE7o5fhY6B1pNP4QHoV05IkbunrqMGE6T8mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bZ6/Od71JZcrjg3wUg8/FFpmGTRrJ/oHNSzO+sEsuMcfaACkTBVHwTCxInG+18hwecwT1xhdsFYxvf8l5i+I9FJUjwtkPMKlz67b2+YTz34vBWSUrTNo6EvdFbEoVqRYvPKiN/c0NxZPveI92ZXeqm00KhLQgksgfVp7vD6IMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaX9ZyS1; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaX9ZyS1"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22a73f2d6adso1873904fac.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711993073; x=1712597873; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfirtehliszjUStJqD/PJz9p6abW4wOLgv9SUm180Aw=;
        b=NaX9ZyS1/Wy6XfK5VS9exO3dd1oujoZCi/Lz7GI5pu0PpKk/VjVkQtkJRJyRF+B7wH
         Lje7SP1F+3PogKms/lbQI78h4H9wqDePP7/mK+swI/nNJgGpPL4vKXuFeiF2q80J5teu
         s9TjaRv7q/dAqhX6RA91OanKFAUxI4QKj0TcFFo0hQm+ESbNAzhdExNLkSoCnPYo0iF2
         fcopW0VmekhwG/UepMU2syQ4vUcXi7AzArXBrX0Ru9iFo1CgH3p9Z+MpTgC9hjExE/xq
         S4P7R50mYSYh3BRd2yHCEGiHYCxkcjl7inFAByM355lkQNrdNNDWxAo7wzeaVixJQDzL
         AI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711993073; x=1712597873;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfirtehliszjUStJqD/PJz9p6abW4wOLgv9SUm180Aw=;
        b=aGOvYPeu4F/QRNEKIwPxqwWpv2zTMi1BZLQiIQQLKPre3Vmz0oQr3SxIZ7QDFdhgd1
         8uljblgo5pjQED5mkhJ8h9t3YTqEb9QstpW8XiyHxRfGi5quVA7jX/oUphIUu/d4Dt9B
         rJm+3UmLnUjLvGx7YknetExmc+DCqCy+Dr8OuP8LF3l2chsBC5wYg5mPH/O/mZ3ph0x+
         rd78C5TR71HZB/ttUt9UOhC3Y5fwFCUjZzX4UfohPCMumhYFVmiXx3pGGAdMPzUzOgrB
         7R0r5Br+6Kniv0ds3rN9jG4/qN1gWoEFQCZL+4tt6ptgZLlpTtQL1mKLwoId3anWqF/A
         z+UA==
X-Gm-Message-State: AOJu0Yy1hN6HDXojbX3ZFwNbCRb8mpaEON4VewUk942S285Z9sLCrPvs
	GUv2Isup7nyBFDSwGYUYgrnhx0kcCRRZiAUD/sAHbPAbLyANwaw/kNKi9O3FEObm6yzV5pQZ4j+
	CXVs9ro3wD3UQMBh9hNBo8kv7nWgwgdrre0HVQQ==
X-Google-Smtp-Source: AGHT+IH784+0PV9n3uFso/TFhweiuwf1XVAPf8mq6J4sTEMdR/zm14xvyTLW0x4hCgaxbL+sulyZ2vlvGXE3T38gamc=
X-Received: by 2002:a05:6871:54d:b0:229:ec6d:9fb7 with SMTP id
 t13-20020a056871054d00b00229ec6d9fb7mr11023083oal.38.1711993071424; Mon, 01
 Apr 2024 10:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEK6H9o2QQGLQQZ0=C=1CjRGg6UiD_0fv7MwQujv1Sa_v41TAw@mail.gmail.com>
In-Reply-To: <CAEK6H9o2QQGLQQZ0=C=1CjRGg6UiD_0fv7MwQujv1Sa_v41TAw@mail.gmail.com>
From: Guga Figueiredo <gugabfigueiredo@gmail.com>
Date: Mon, 1 Apr 2024 19:37:40 +0200
Message-ID: <CAEK6H9r7NbPpcTiOk7E8ZTr1W_rfarLmU_yT1etDiCs6BaERVw@mail.gmail.com>
Subject: Fwd: "reverse proxy" remote-helper
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am playing around with git remote helpers trying to write a "reverse
proxy" sort of custom helper to work with a personal server and custom
protocol.
I am doing this because git, natively, already does 99% of the work
that I need, and I would like to avoid reinventing the wheel. I just
want to create a barely customized interface for a custom server.
I know I can achieve this with hooks, but I would rather keep this
configuration out of the repos.

conceptually, the command call flow should be something like this:
```
git <cmd> custom::<repo-url>
=E2=94=94=E2=94=80=E2=94=80>git-remote-custom <repo-url> <cmd>
    =E2=94=94=E2=94=80=E2=94=80>git <native-remote-helper> <repo-url> <cmd>
```

I have been able to implement a git remote helper in go that works on
locally stored remotes following this article by rovaugn and the git
documentation on helpers.

And have stripped it down to bare essentials to try to invoke the
native/builtin remote-helpers directly:
```go
package main

import (
    "errors"
    "fmt"
    "log"
    "net/url"
    "os"
    "os/exec"
    "regexp"
)

func Main() (er error) {

    if len(os.Args) < 3 {
       return fmt.Errorf("Usage: git-remote-custom remote-name remote-url")
    }

    remoteName :=3D os.Args[1]
    remoteUrl :=3D os.Args[2]

    scheme, err :=3D parseRemoteURL(remoteUrl)
    if err !=3D nil {
       return fmt.Errorf("Invalid remote URL %s: %v", remoteUrl, err)
    }

    // do custom stuff here ...

    // proxy through to native git remote helper
    cmd :=3D exec.Command("git", fmt.Sprintf("remote-%s", scheme),
remoteName, remoteUrl)
    cmd.Stdin =3D os.Stdin
    cmd.Stdout =3D os.Stdout
    if err :=3D cmd.Run(); err !=3D nil {
       return err
    }

    return nil
}

func main() {
    if err :=3D Main(); err !=3D nil {
       log.Fatal(err)
    }
}

func parseRemoteURL(remoteUrl string) (string, error) {
    if u, err :=3D url.Parse(remoteUrl); err =3D=3D nil && u.Scheme !=3D ""=
 {
       return u.Scheme, nil
    }

    // Check for SCP-like SSH URLs first because they don't have a "scheme:=
//"
    scpRe :=3D regexp.MustCompile(`^[a-zA-Z0-9._@/+~-]+@[a-zA-Z0-9._@/+~-]+=
:[a-zA-Z0-9._@/+~-]+(\.git)?$`)
    if scpRe.MatchString(remoteUrl) {
       return "ssh", nil
    }

    return "", errors.New("invalid Git URL scheme")
}
```

and this worked for http(s):
```
$ GIT_TRACE=3D1 git clone custom::https://github.com/rovaughn/git-remote-gr=
ave.git
11:17:52.117674 git.c:455               trace: built-in: git clone
custom::https://github.com/rovaughn/git-remote-grave.git
Cloning into 'git-remote-grave'...
11:17:52.120021 run-command.c:668       trace: run_command: git
remote-custom origin https://github.com/rovaughn/git-remote-grave.git
11:17:52.121757 git.c:742               trace: exec: git-remote-custom
origin https://github.com/rovaughn/git-remote-grave.git
11:17:52.121792 run-command.c:668       trace: run_command:
git-remote-custom origin
https://github.com/rovaughn/git-remote-grave.git
11:17:52.666930 run-command.c:668       trace: run_command: git
index-pack --stdin -v --fix-thin '--keep=3Dfetch-pack 21547 on pop-os'
--check-self-contained-and-connected
remote: Enumerating objects: 71, done.
11:17:52.669349 git.c:455               trace: built-in: git
index-pack --stdin -v --fix-thin '--keep=3Dfetch-pack 21547 on pop-os'
--check-self-contained-and-connected
remote: Total 71 (delta 0), reused 0 (delta 0), pack-reused 71
Receiving objects: 100% (71/71), 48.92 KiB | 1.11 MiB/s, done.
Resolving deltas: 100% (28/28), done.
11:17:52.716950 run-command.c:668       trace: run_command: git
rev-list --objects --stdin --not --all --quiet --alternate-refs
'--progress=3DChecking connectivity'
11:17:52.718721 git.c:455               trace: built-in: git rev-list
--objects --stdin --not --all --quiet --alternate-refs
'--progress=3DChecking connectivity'
```

but `ssh` doesn't have a corresponding remote-ssh helper.

Is there a plug and play way to wrap/proxy the `ssh` protocols in a
similar way with a remote-helper? Or are there better approaches to
achieve this?

Any feedback is appreciated,
Kind regards

Guga
