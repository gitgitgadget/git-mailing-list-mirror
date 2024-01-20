Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597867F7
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705776438; cv=none; b=cblvMCGfVF/RiM5PxtWRjIeFJk8/i6w/1w7gKPLQFaGAKhOPFzvGAVEBAmyhegvbsqun16o2RCpuPxsjZmokU/KMLiXLw5OG2Iw+yyZP60qoxA7uJ6T4HltsqYqia1B0AKhp/gCT5WnA/df0WK18705RBHczUyJyjhtZZ46RkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705776438; c=relaxed/simple;
	bh=s/Lwjt/ebsGqahvEQDXf+NdQoHZE/y2Nx7+wRa1cnQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DMigS1Y/R5P7pzKwu9tAtcOklk47u9bEyO0PB60Jb2MH3Q/Z4TQHxHadyy+NPSjGR4/svsAUXQ9QRWXddv/aqka1ixCPT7VITBDS8EQPg3Pwl363t0B/Zsb6j/vy6tOFji+79PjgsPMOz/+W8cG8VfDz6MWHEqdyD+DxIlxcikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lKBHjs14; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lKBHjs14"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AB1F91A044;
	Sat, 20 Jan 2024 13:47:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=s/Lwjt/ebsGq
	ahvEQDXf+NdQoHZE/y2Nx7+wRa1cnQA=; b=lKBHjs14oDvmfoP6k+a3JrH84X8I
	495RlBF05WYofaK5+U+nxud0/B/O4l9HwBFN1IJx6l7DATF+hVvqbbOG/e4gyg/k
	1EVi8lKDg5T95fB9MibJXuEtXN4zQXbkRgAYET+7Wuj4U1lkYZFz+mZS7GorINvX
	hZeh1TsozQe+bTc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A3F001A043;
	Sat, 20 Jan 2024 13:47:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3BB871A042;
	Sat, 20 Jan 2024 13:47:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "James Touton via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  James Touton <bekenn@gmail.com>
Subject: Re: [PATCH] git-p4: use raw string literals for regular expressions
In-Reply-To: <pull.1639.git.1705775149642.gitgitgadget@gmail.com> (James
	Touton via GitGitGadget's message of "Sat, 20 Jan 2024 18:25:49
	+0000")
References: <pull.1639.git.1705775149642.gitgitgadget@gmail.com>
Date: Sat, 20 Jan 2024 10:47:10 -0800
Message-ID: <xmqqr0ibetap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 529DB93A-B7C4-11EE-82F7-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"James Touton via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: James Touton <bekenn@gmail.com>
>
> Fixes several Python diagnostics about invalid escape sequences.

Thanks for noticing, but we want a bit more backstory explained here
in the proposed commit log message, outlining:

1. With what version of Python the deprecation warning started.

This will help us judge the urgency of the fix.  If I am reading the
docs.python.org/$version/howto/regex.html right, we do not see this

    In addition, special escape sequences that are valid in regular
    expressions, but not valid as Python string literals, now result
    in a DeprecationWarning and will eventually become a
    SyntaxError, which means the sequences will be invalid if raw
    string notation or escaping the backslashes isn=E2=80=99t used.

in Python 3.5's document, but Python 3.6's document starts talking
about the warning.  Python 3.6 was released at the end of 2016 so it
is 7 years old---users have lived with the warning for this many
years, so if the above reasoning is correct, this is not all that
urgent to require a maintenance release.

2. How well the new construct, used by the code after applying this
   patch, is supported by older version of Python.

This will assure us that the change will not be robbing from users
of older versions of Python to pay users of newer versions of
Python.  Again, if I am reading the documentation right, feeding r''
raw strings to regexp engine was supported even by Python 2.7, which
is what git-p4.py already requires, so we should be OK.

But we want the developers who propose a change to explain why it is
a good idea, and why it is a safe change to make, in their proposed
commit log message, instead of forcing the reviewers to do that for
them.

For other syntactic and linguistic hints on writing a proposed log
message, please check Documentation/SubmittingPatches document.

Thanks, again.

> Signed-off-by: James Touton <bekenn@gmail.com>
> ---
>     git-p4: use raw string literals for regular expressions
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1639%=
2FBekenn%2Fp4-raw-strings-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1639/Bek=
enn/p4-raw-strings-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1639
>
>  git-p4.py | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 0eb3bb4c47d..156597adb59 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -689,8 +689,8 @@ def setP4ExecBit(file, mode):
> =20
>      if not isModeExec(mode):
>          p4Type =3D getP4OpenedType(file)
> -        p4Type =3D re.sub('^([cku]?)x(.*)', '\\1\\2', p4Type)
> -        p4Type =3D re.sub('(.*?\+.*?)x(.*?)', '\\1\\2', p4Type)
> +        p4Type =3D re.sub(r'^([cku]?)x(.*)', r'\1\2', p4Type)
> +        p4Type =3D re.sub(r'(.*?\+.*?)x(.*?)', r'\1\2', p4Type)
>          if p4Type[-1] =3D=3D "+":
>              p4Type =3D p4Type[0:-1]
> =20
> @@ -701,7 +701,7 @@ def getP4OpenedType(file):
>      """Returns the perforce file type for the given file."""
> =20
>      result =3D p4_read_pipe(["opened", wildcard_encode(file)])
> -    match =3D re.match(".*\((.+)\)( \*exclusive\*)?\r?$", result)
> +    match =3D re.match(r".*\((.+)\)( \*exclusive\*)?\r?$", result)
>      if match:
>          return match.group(1)
>      else:
> @@ -757,7 +757,7 @@ def parseDiffTreeEntry(entry):
> =20
>      global _diff_tree_pattern
>      if not _diff_tree_pattern:
> -        _diff_tree_pattern =3D re.compile(':(\d+) (\d+) (\w+) (\w+) ([=
A-Z])(\d+)?\t(.*?)((\t(.*))|$)')
> +        _diff_tree_pattern =3D re.compile(r':(\d+) (\d+) (\w+) (\w+) (=
[A-Z])(\d+)?\t(.*?)((\t(.*))|$)')
> =20
>      match =3D _diff_tree_pattern.match(entry)
>      if match:
> @@ -918,9 +918,9 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b'=
, cb=3DNone, skip_info=3DFalse,
>              if len(result) > 0:
>                  data =3D result[0].get('data')
>                  if data:
> -                    m =3D re.search('Too many rows scanned \(over (\d+=
)\)', data)
> +                    m =3D re.search(r'Too many rows scanned \(over (\d=
+)\)', data)
>                      if not m:
> -                        m =3D re.search('Request too large \(over (\d+=
)\)', data)
> +                        m =3D re.search(r'Request too large \(over (\d=
+)\)', data)
> =20
>                      if m:
>                          limit =3D int(m.group(1))
> @@ -1452,7 +1452,7 @@ def wildcard_encode(path):
> =20
> =20
>  def wildcard_present(path):
> -    m =3D re.search("[*#@%]", path)
> +    m =3D re.search(r"[*#@%]", path)
>      return m is not None
> =20
> =20
> @@ -3048,7 +3048,7 @@ def stripRepoPath(self, path, prefixes):
>              # Preserve everything in relative path name except leading
>              # //depot/; just look at first prefix as they all should
>              # be in the same depot.
> -            depot =3D re.sub("^(//[^/]+/).*", r'\1', prefixes[0])
> +            depot =3D re.sub(r"^(//[^/]+/).*", r'\1', prefixes[0])
>              if p4PathStartsWith(path, depot):
>                  path =3D path[len(depot):]
> =20
> @@ -3603,7 +3603,7 @@ def importP4Labels(self, stream, p4Labels):
>                      commitFound =3D True
>                  else:
>                      gitCommit =3D read_pipe(["git", "rev-list", "--max=
-count=3D1",
> -                        "--reverse", ":/\[git-p4:.*change =3D %d\]" % =
changelist], ignore_error=3DTrue)
> +                        "--reverse", r":/\[git-p4:.*change =3D %d\]" %=
 changelist], ignore_error=3DTrue)
>                      if len(gitCommit) =3D=3D 0:
>                          print("importing label %s: could not find git =
commit for changelist %d" % (name, changelist))
>                      else:
> @@ -4182,7 +4182,7 @@ def run(self, args):
>                  if len(self.changesFile) =3D=3D 0:
>                      revision =3D "#head"
> =20
> -            p =3D re.sub("\.\.\.$", "", p)
> +            p =3D re.sub(r"\.\.\.$", "", p)
>              if not p.endswith("/"):
>                  p +=3D "/"
> =20
> @@ -4291,7 +4291,7 @@ def rebase(self):
>              die("Cannot find upstream branchpoint for rebase")
> =20
>          # the branchpoint may be p4/foo~3, so strip off the parent
> -        upstream =3D re.sub("~[0-9]+$", "", upstream)
> +        upstream =3D re.sub(r"~[0-9]+$", "", upstream)
> =20
>          print("Rebasing the current branch onto %s" % upstream)
>          oldHead =3D read_pipe(["git", "rev-parse", "HEAD"]).strip()
> @@ -4320,8 +4320,8 @@ def __init__(self):
>      def defaultDestination(self, args):
>          # TODO: use common prefix of args?
>          depotPath =3D args[0]
> -        depotDir =3D re.sub("(@[^@]*)$", "", depotPath)
> -        depotDir =3D re.sub("(#[^#]*)$", "", depotDir)
> +        depotDir =3D re.sub(r"(@[^@]*)$", "", depotPath)
> +        depotDir =3D re.sub(r"(#[^#]*)$", "", depotDir)
>          depotDir =3D re.sub(r"\.\.\.$", "", depotDir)
>          depotDir =3D re.sub(r"/$", "", depotDir)
>          return os.path.split(depotDir)[1]
>
> base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
