Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668782D876B
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757750; cv=pass; b=h4c11V0wO5hCIFaqfWSg95Wy48tdj4vXzjS/hJwRufZGZNq0mmuIBAG6oobUhF2vxVVldunLdK53b9enqPki8JYAwk5ZmqPFSmg0qWoZHaIOI434rfvd76QNuZxljNGIvPAMN3kvszC0WvBqlrPZH9+J1N900muDRsOB/dqwk+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757750; c=relaxed/simple;
	bh=oi9YohCSwjv8PkgInIF8g+VohmjT6CiqATcfNwZ7LZA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jcHsyxuGJKLGUn4qZUMAIznhV1orTxDo3ynDhq6Gpq+yKwmOTq6jsKoQWZ9V/WVoKAulUSYMpnff7C9wELJD2k/fnSRTdhZid/sZmeBUmDvDBoA5bybHxql8DOZy9twqDhq1K79J8MI8yoJKYWwFF964/8oUCiM8BxW1y1VWn64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM/4Os/r; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM/4Os/r"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65faaa8b807so6592256a12.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 16:42:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772757744; cv=none;
        d=google.com; s=arc-20240605;
        b=C0hzVaIqGEGZ7mrr/ccMAlFNqpEMyOSfZNdNM8uaK7RoM5sfkz4zaRF+ZpfMUkUPog
         5yXRtQeMuL+zLBeybtlyRlg7W3pg7U+j92eel1fMVU6/7NBGsv5msjdMO1NE1Y4T0K3M
         W2fQih8Yb9QlxiDANxp3p/f/prhe+Y27crXQ7jUyonTA1knm9EfmvAEjeK2Ldr+kJ2pW
         UfagFGGDhlqF702q1G+yl/N3NrWivwkLZqce2dy6MC1wzGwF1kLIYr+YkFzACScAHu71
         9tmzBQ8/QuX2ne4TC3OyNOSMhNODyMe9G6NdtPi+CExDoUYS99lqSZ0Qz5l5KKdnUt6B
         oF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PtQZZgPkM2K47YIHw5BOlo3er03PfUjyVz12CMQkAHo=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=MLuEVwSMmDMCuRCiFSgp/JtL4IlpWF0vrnrn0wDmQ2Ea/lkZbYw7z/ODnhf+mOiJcr
         PTlQiK359nSr/1elNqig/uxXYq75rdeLS6aIcZcR6La6yFr7LcBVXkfRB304pkN5AzMS
         PM+In6lCkxfJl0tjwXK7v2Wx3bbu37NfG7j9A6xhkzjTipGH5/zg8kY+dz8LeL5NWdW3
         y7Un9NLn5JLG6oCoeDySlO2KeOIbj44zmyuE2yoNma9hQ/86yPJOhkUUNevq0vbA349l
         dpMkVVUfWNDFsXpdh5PkSlmnLD0HyFbfvbbufehLnwMV+7Bug1jD0OJ//M0N5dRf1L/n
         u8NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757744; x=1773362544; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PtQZZgPkM2K47YIHw5BOlo3er03PfUjyVz12CMQkAHo=;
        b=PM/4Os/rCtTdfMugkSvupGeBWQnfyDMQ9AAGSPKAbTvUAPPEt1F3Uf0XGFvi4vFWhh
         tpRPbnRBlUNIeyYJs6nfrz0uR95Ewfn0+qvRNjbEpjV0F7DxmVk6C8QzapRVzU2M9WfG
         FKTrXn/bRXjU5gOBA6HtB0CFtGEgTHicCXyH2Tg6LK+V7MNOwZXeTmuVz0Qxpx5kK8H+
         i8KudZga7PXV29x7eqONrzVrIriMXGSiE3a2/GSZWnt/CAGAtU7mT4qKPxpr8JBik+Bv
         93nvEldTBJVIJUl27IHruHJV72X5q7yY4QW53tD2jwA9Zvl0bBYx8UvsGmM6hVHVEoPH
         PiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757744; x=1773362544;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtQZZgPkM2K47YIHw5BOlo3er03PfUjyVz12CMQkAHo=;
        b=u+QOuxnviZCtt6x3AAOd40c406aDqb2jCwS/UVxq0H0FBRHZFY8De9pWUzPvDTUF1t
         br4dOn3YiqYVpA0VvVtKw4xTRBw1YWQ7AlK12Ge2C278P7Nfd0uSw9ABBs1kF81N6+2b
         3IapifQK0hazPErlEbfkqYi0pYGLRD0Qd1AwEJTOFB4PPtrZ4GhvlwS9ldaI0TWy7roF
         2TmXa2O3IXww+DJmhp8towrbQIPJPxx3DvlnMJwXwMXkc31v0BIAf/KMDLW5Zu+O1Xqk
         tNjvtB2LF5T9gjvs73K3SYMk3+fRn7cfS6wMovHo0I+TmTAopqC6VmDMcyL8+8+c+CWM
         Ceow==
X-Gm-Message-State: AOJu0YzMJ4mEjk8LrmVAoOLDfm+hu9ETxWeFOeoVXuP0fO1BHvYHS3xK
	z7kKV+XZwnNoeppkc3xQfA8IEYXKAeiWuEB9xRlNaMBN/XzmDhUT3Sqy7TfKZ55PLjG488Du7Kl
	iDgV58H9M0qY2Qsoi8XMDtHksrZTrKuBL6WoRGWU=
X-Gm-Gg: ATEYQzzOcBDRlcm1LAZnH2k1lv58LVDv7fgWLlQWy2Ds0QhS6XWGBoylgu0WKpSLPi8
	J2Xd15CHCndZ3BhRoc4J4pHSC7nPdw3mpkMN3v//532bPo608/nFkx+MD2cQZbO16cbgYPdBV6f
	OSACoBh/52LMHR46ktXXplFpqZ6b62IfpuGqb1dEaqeHkz6Hc1NhFDiPtItfs/kEJ7Na6pORzp0
	hjOBcfWwbpHVmFlpovcnAPSVq6RcFGWyomT3QIuGWPf02Z0jrNfYfVexBf3ueCi3A+Ip7hufa87
	4FQKeFKTSv1Hw+2LOoG3hmo6Pgd4zx8XDifW7zXQ5LEX9B6JP3to10uyuE34fjxSIwE7ASuaCpi
	HXtpTgqdITj9hDvVidDDDKsM6
X-Received: by 2002:a17:907:720e:b0:b93:5b12:7b92 with SMTP id
 a640c23a62f3a-b942df9dfb0mr10328566b.40.1772757743570; Thu, 05 Mar 2026
 16:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Ivanov <qmastery16@gmail.com>
Date: Fri, 6 Mar 2026 03:42:12 +0300
X-Gm-Features: AaiRm519NCxDzVpLuNx0hLXhKT-7ljj3syM0rgbW6_JFV1zF0ixD87PFI-jPbao
Message-ID: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
Subject: Test "t0300-credentials" is failing on Arch/Artix: asks to enter the
 Username/Password in an infinite loop
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good day! While trying to rebuild git for Arch/Artix, I run into the
following problem: shortly after "*** prove (shell & unit tests) ***"
I get asked the Username/Password in an endless loop. Below are the
full logs, as well as the contents of
./test-results/t0300-credentials.out file, hope this is helpful for
debugging. Please note that I have all the dependencies installed,
even the optional ones like Apache HTTPD (some online manuals
suggested doing that, but didn't help to pass this test)

==> Starting check()...
    GEN git-difftool--helper
    GEN git-filter-branch
    GEN git-merge-octopus
    GEN git-merge-one-file
    GEN git-merge-resolve
    GEN git-mergetool
    GEN git-quiltimport
    GEN git-request-pull
    GEN git-submodule
    GEN git-web--browse
    GEN git-archimport
    GEN git-cvsexportcommit
    GEN git-cvsimport
    GEN git-cvsserver
    GEN git-send-email
    GEN git-svn
    GEN git-p4
    GEN git-instaweb
    GEN git-mergetool--lib
    GEN git-sh-i18n
    GEN git-sh-setup
    SUBDIR git-gui
    SUBDIR gitk-git
    SUBDIR templates
    GEN perl/build/lib/Git.pm
    GEN perl/build/lib/Git/I18N.pm
    GEN perl/build/lib/Git/IndexInfo.pm
    GEN perl/build/lib/Git/LoadCPAN.pm
    GEN perl/build/lib/Git/Packet.pm
    GEN perl/build/lib/Git/SVN.pm
    GEN perl/build/lib/Git/LoadCPAN/Error.pm
    GEN perl/build/lib/Git/SVN/Editor.pm
    GEN perl/build/lib/Git/SVN/Fetcher.pm
    GEN perl/build/lib/Git/SVN/GlobSpec.pm
    GEN perl/build/lib/Git/SVN/Log.pm
    GEN perl/build/lib/Git/SVN/Migration.pm
    GEN perl/build/lib/Git/SVN/Prompt.pm
    GEN perl/build/lib/Git/SVN/Ra.pm
    GEN perl/build/lib/Git/SVN/Utils.pm
    GEN perl/build/lib/Git/LoadCPAN/Mail/Address.pm
    GEN perl/build/lib/Git/SVN/Memoize/YAML.pm
make -C t/ all
make[1]: Entering directory '/home/username/artix_git/src/git/t'
rm -f -r 'test-results'
*** prove (shell & unit tests) ***
Username for 'http://example.com':
Password for 'http://example.com':
Username for 'http://example.com':
Password for 'http://example.com':

/src/git/t$ cat ./test-results/t0300-credentials.out
Initialized empty Git repository in /dev/shm/git-test/trash
directory.t0300-credentials/.git/
expecting success of 0300.1 'setup helper scripts':
    cat >dump <<-\EOF &&
    whoami=$(echo $0 | sed s/.*git-credential-//)
    echo >&2 "$whoami: $*"
    OIFS=$IFS
    IFS==
    while read key value; do
        echo >&2 "$whoami: $key=$value"
        if test -z "${key%%*\[\]}"
        then
            key=${key%%\[\]}
            eval "$key=\"\$$key $value\""
        else
            eval "$key=$value"
        fi
    done
    IFS=$OIFS
    EOF

    write_script git-credential-useless <<-\EOF &&
    . ./dump
    exit 0
    EOF

    write_script git-credential-quit <<-\EOF &&
    . ./dump
    echo quit=1
    EOF

    write_script git-credential-verbatim <<-\EOF &&
    user=$1; shift
    pass=$1; shift
    . ./dump
    test -z "$user" || echo username=$user
    test -z "$pass" || echo password=$pass
    EOF

    write_script git-credential-verbatim-cred <<-\EOF &&
    authtype=$1; shift
    credential=$1; shift
    . ./dump
    echo capability[]=authtype
    echo capability[]=state
    test -z "${capability##*authtype*}" || exit 0
    test -z "$authtype" || echo authtype=$authtype
    test -z "$credential" || echo credential=$credential
    test -z "${capability##*state*}" || exit 0
    echo state[]=verbatim-cred:foo
    EOF

    write_script git-credential-verbatim-ephemeral <<-\EOF &&
    authtype=$1; shift
    credential=$1; shift
    . ./dump
    echo capability[]=authtype
    test -z "${capability##*authtype*}" || exit 0
    test -z "$authtype" || echo authtype=$authtype
    test -z "$credential" || echo credential=$credential
    echo "ephemeral=1"
    EOF

    write_script git-credential-verbatim-with-expiry <<-\EOF &&
    user=$1; shift
    pass=$1; shift
    pexpiry=$1; shift
    . ./dump
    test -z "$user" || echo username=$user
    test -z "$pass" || echo password=$pass
    test -z "$pexpiry" || echo password_expiry_utc=$pexpiry
    EOF

    write_script git-credential-cntrl-in-username <<-\EOF &&
    printf "username=\\007latrix Lestrange\\n"
    EOF

    PATH="$PWD:$PATH"

ok 1 - setup helper scripts

expecting success of 0300.2 'credential_fill invokes helper':
    check fill "verbatim foo bar" <<-\EOF
    protocol=http
    host=example.com
    --
    protocol=http
    host=example.com
    username=foo
    password=bar
    --
    verbatim: get
    verbatim: protocol=http
    verbatim: host=example.com
    EOF

--- expect-stdout    2026-03-06 00:33:02.009338195 +0000
+++ stdout    2026-03-06 00:33:07.569338321 +0000
@@ -1,4 +1,4 @@
 protocol=http
 host=example.com
-username=foo
-password=bar
+username=
+password=
not ok 2 - credential_fill invokes helper
#
#        check fill "verbatim foo bar" <<-\EOF
#        protocol=http
#        host=example.com
#        --
#        protocol=http
#        host=example.com
#        username=foo
#        password=bar
#        --
#        verbatim: get
#        verbatim: protocol=http
#        verbatim: host=example.com
#        EOF
#

expecting success of 0300.3 'credential_fill invokes helper with credential':
    check fill "verbatim-cred Bearer token" <<-\EOF
    capability[]=authtype
    protocol=http
    host=example.com
    --
    capability[]=authtype
    authtype=Bearer
    credential=token
    protocol=http
    host=example.com
    --
    verbatim-cred: get
    verbatim-cred: capability[]=authtype
    verbatim-cred: protocol=http
    verbatim-cred: host=example.com
    EOF

--- expect-stdout    2026-03-06 00:33:07.581338322 +0000
+++ stdout    2026-03-06 00:33:08.191338336 +0000
@@ -1,5 +1,4 @@
-capability[]=authtype
-authtype=Bearer
-credential=token
 protocol=http
 host=example.com
+username=
+password=
not ok 3 - credential_fill invokes helper with credential
#
#        check fill "verbatim-cred Bearer token" <<-\EOF
#        capability[]=authtype
#        protocol=http
#        host=example.com
#        --
#        capability[]=authtype
#        authtype=Bearer
#        credential=token
#        protocol=http
#        host=example.com
#        --
#        verbatim-cred: get
#        verbatim-cred: capability[]=authtype
#        verbatim-cred: protocol=http
#        verbatim-cred: host=example.com
#        EOF
#

expecting success of 0300.4 'credential_fill invokes helper with
ephemeral credential':
    check fill "verbatim-ephemeral Bearer token" <<-\EOF
    capability[]=authtype
    protocol=http
    host=example.com
    --
    capability[]=authtype
    authtype=Bearer
    credential=token
    ephemeral=1
    protocol=http
    host=example.com
    --
    verbatim-ephemeral: get
    verbatim-ephemeral: capability[]=authtype
    verbatim-ephemeral: protocol=http
    verbatim-ephemeral: host=example.com
    EOF
