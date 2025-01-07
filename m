Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401C18C03B
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278651; cv=none; b=mXrv5XSSVP4FWJdO+c03uIrKASvtGk4qUEWDREywRjpxjOgu95HGPXlCr9n03EcoefEzj5WQeqYUmEnyNa3c7uRdPwST6TwQIn02ikmc49b7/3C9rXE13GHtk5350CR3sq642Ed0bZcJbFfX0Nd/fB/QlTGr1G0raUoYASF/laQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278651; c=relaxed/simple;
	bh=vA7w/lLMXz4AT0OgZ2NOL1LWYa+hdVk/BWal7rZ6n/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PhxXn/PKZFRSk3jtjMPFzdABuppmZuCPq7gxfj04fAPOQHP0p1T3+vPpjS2HHm/zmX2DcOdEP4bYopYNAOHla3d11niFjvmyWYLMjfY7sBIrX6X00mrIyDaXJ81gh1zkN6krY7NgR7+5pT2ulJSSL8Jmy9jhTxCez8cpWdF52D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RMc06tCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UDhH/FW3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMc06tCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UDhH/FW3"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3652114018E;
	Tue,  7 Jan 2025 14:37:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jan 2025 14:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736278646;
	 x=1736365046; bh=ynx40kHFVLVcaNB8mFtt1YKsNBEgI/mF8+b2GsbPOUY=; b=
	RMc06tCQApAoX3L/D16lY8tWQBsk3IHra69QpG0C1JWYrWIoXsgs1gN8x1kR/qXo
	OmsENREQyi5c6/XadF0ZKHjaCvSv2W+PLQVYxTVL3GpbVqnBRNpE7COHBaJb7v2d
	w1gLpOqzf8F3w0P1n+THFieTjewTAq5ikVz/a8+hH0HtWeAPyeU2dB1Cg2vqiOkX
	ZBF4Cv3hQ1iu48QGLuiQ0ESA1Y7f5o/j6uuZbyecqGDiOS8bfaCtkCSCGh8iQX3j
	diy9FvBIbcgY+JPOWM3rgR4PDa8ZsdfQUxhvqkTJCljJhsKH3L1dQXBNUyL0NRqY
	lgsmnjVxeLrF0BgWTDyj9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736278646; x=
	1736365046; bh=ynx40kHFVLVcaNB8mFtt1YKsNBEgI/mF8+b2GsbPOUY=; b=U
	DhH/FW3bFZDK+1E45uqdz4WCy9kECmk5WfNjUnuZ6YWboGyamHx38oX/SghgGV/N
	J9myQaXhrlAk7/eH3S91+opgSXwu7ev82m8fkbsgYlPrY7Si/fADrPWH/cg2Ertc
	oQaced/NRux96s5YFKmugqv/skluTkGTpuyCitWFOXKf9zxp850T7HtYXhxWU7/O
	qP525zXRrEPNnLyuCOVyWjLqT5YBRZy9EJqwKf16rEfCs4ctdQH7WG4ET1MSFG3C
	d5f0TrSNR2ImeWSOBbNlHuCb68+kKBzO+E/gUgpnLnGIIgabVMzte2q5sg1uvFrt
	1n69AZX1kDb1fmyPRMOeQ==
X-ME-Sender: <xms:doJ9Z1HpExmnygEfwftXV_iYZGYHGYh3-menk6E2FAx20gnyzjVN-w>
    <xme:doJ9Z6U5uy3n3fxXRherKX_-_AM-kVPCiPFW4LbxnKhljr8pIkXfuqtbZgMOnBxuY
    xdsr41WxX0trWmjlA>
X-ME-Received: <xmr:doJ9Z3Ih_t8WFdCDVriIqnQCBGIUAV_Q0LDi0RAV2DrhBiY1TP5yuEsFOigoEmaVXzDA4UylG-sY0a-ms7Y7du3mpOtn2EcLcvHt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepiedtjedugfetvdelkeetgeeffeetveev
    keevheeuudeludeffeegudfgveekkedvnecuffhomhgrihhnpehgihhtlhgrsgdrtghomh
    dpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtoh
    epfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgtvghplhestggvphhlrdgv
    uhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:doJ9Z7EVPKf9OR9_zxmTpSfN4ash0vhfFHgs41Apuw1D3IJ8SOXkLA>
    <xmx:doJ9Z7UGgunlQbJHgNO7jA2_iSuW4QAZZJ0Rat-wb51ZbCllIcBUWQ>
    <xmx:doJ9Z2MVJuSyovcHnYpjpaquGYfbb1k83UjHGBgDSZh7zw2WZ6-DHA>
    <xmx:doJ9Z62eT19KELDq752T8VnzOeHDhhz7GlcYM521ncNk_ZKwRtxQ1g>
    <xmx:doJ9Z2SkKIrimX2rJzjcxdaTz-0o4UiKXP7z9k3ZcNS_DRvTUKeT_DCD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 14:37:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] RFC: git-request-get maintainer receiving from
 git-request-pull
In-Reply-To: <20250107185716.1562311-1-mcepl@cepl.eu> (=?utf-8?Q?=22Mat?=
 =?utf-8?Q?=C4=9Bj?= Cepl"'s message
	of "Tue, 7 Jan 2025 19:56:35 +0100")
References: <20250107185716.1562311-1-mcepl@cepl.eu>
Date: Tue, 07 Jan 2025 11:37:24 -0800
Message-ID: <xmqqcygys9e3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Matěj Cepl <mcepl@cepl.eu> writes:

> This should be fulfilment of my comment on the GitLab bug [1] from 2016-05-01:
>
>> Well, the minimal solution would be a parser for the
>> git-request-pull(1), which would check every comment and if recognized
>> the comment as the pull request, it would add button for the owner of
>> the repo (e.g., [Create Pull Request]). After pressing that (so it is
>> constantly under the control of the owner repo), gitlab would setup
>> new remote (if doesn't exist still), fetch it, and create a merge
>> request.
>
> In the end, the best UI I could come up with is to pull all
> commits to the new review branch and send all of them via
> git-send-email(1) to the review email list.
>
> The script can either receive git-request-pull(1) output on
> stdin, or it can be driven by the command line arguments with URL
> and (optionally) branch names for all those “I have some commits
> on SOMEWHERE, but I don’t want to fiddle with git-send-email(1)
> just because of that.”
>
> [1] https://gitlab.com/gitlab-org/gitlab/-/issues/14116
> ---
>
> I would like to get these types of comments (before I finalize
> a proper commit for git):
>
> * whether the idea of the script makes sense at all (or
>   suggestions on the UI improvement),

You'd have much better chance if you made the patch standalone,
instead of discouraging those who might be interested by forcing
them to first visit an external website for 8-year old "bug" that
may or may not be interesting to them.  From the above, I am not
sure if people can guess what problem is being solved, and without
knowing that, they cannot judge if script makes sense in the first
place.

> * a general code review

There are a handful of scripts written in Perl still in our
codebase; study the way how their sources are written (e.g., notice
that they all end with ".perl") and are made into executables by
Makefile rules, and mimick them.

> * advice how to proceed with testing before rewriting it into the
>   proper git test harness: is there only way to add those ugly
>   `if test -z "$DEBUG"` constructs everywhere, or there is some
>   better way?

Also send the e-mailed patch to yourself, and then run "git am" to
make sure it applies cleanly.  It seems the patch is creating a new
Makefile, but our project already has one, so I do not see how this
patch would apply.

Thanks for your interest in our project.

> Thank you for any reply,
>
> Matěj
>
>  Makefile        |   8 +++
>  git-request-get | 186 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 194 insertions(+)
>  create mode 100644 Makefile
>  create mode 100755 git-request-get
>
> diff --git a/Makefile b/Makefile
> new file mode 100644
> index 0000000..4d686f5
> --- /dev/null
> +++ b/Makefile
> @@ -0,0 +1,8 @@
> +export DEBUG := true
> +export WANT_REMOTE := 1
> +
> +test:
> +	./git-request-get < gitk-email.mbx 2>&1 | \
> +	grep -e "ensure_remote: getting REMOTE = j6t and URL = https://github.com/j6t/gitk.git" \
> +		-e "make_branch: getting BRANCH_NAME = mcepl-07012025 and HEAD = master" \
> +		-e "main: DEST_ADDR= ~mcepl/git-test@lists.sr.ht, AUTHOR=Matěj Cepl <mcepl@cepl.eu>, BASE=c18400c6bb04f4e8875c1930db72ddd9b94649ca, HEAD=master"
> diff --git a/git-request-get b/git-request-get
> new file mode 100755
> index 0000000..1f6edfa
> --- /dev/null
> +++ b/git-request-get
> @@ -0,0 +1,186 @@
> +#!/bin/sh
> +# Requires: perl, sed, awk
> +set -eux
> +
> +# Initialize internal variables
> +DEBUG="${DEBUG:-}"
> +WANT_REMOTE="${WANT_REMOTE:-"$(git config get --type int --default=0 git-request-get.wantRemote)"}"
> +BASE=""
> +HEAD=""
> +DEST_ADDR=""
> +
> +usage() {
> +    echo "usage: $(basename "$0") [-t ADDRTO] [-s] [-h] URL [HEAD] [BASE]" >&2
> +    echo "Generate git-send-email messages from remote URL or from the email message"
> +    echo "formatted by git-request-pull"
> +    echo
> +    echo "-t ADDRTO send emails to this email address"
> +    exit 1
> +}
> +
> +die() {
> +    echo "$1" >&2
> +    if test $# -gt 1
> +    then
> +        exit "$2"
> +    else
> +        exit 1
> +    fi
> +}
> +
> +log() {
> +    echo "$1" >&2
> +}
> +
> +parse_message() {
> +    STR="$(perl -pe 'use MIME::QuotedPrint; $_=MIME::QuotedPrint::decode($_);')"
> +    # Collect URL of the incoming repo
> +    USTR="$(echo "$STR" | sed -n -e '/^are available in the Git repository at:/{n;n;p}')"
> +    U="$(echo "$USTR" | awk '{print $1}')"
> +
> +    # Find the tip of the offered branch
> +    # for you to fetch changes up to 102cd4d5c1818ecb5926dd538962f8b42c43b022:
> +    B="$(echo "$STR" | awk '/^The following changes since commit / { print $NF }' | sed -e 's/[=:]*$//')"
> +
> +    E="$(echo "$USTR" | awk '{print $2}')"
> +    if test -z "$E"
> +    then
> +        E="$(echo "$STR" | awk '/^for you to fetch changes up to / { print $NF }' | sed -e 's/[=:]*$//')"
> +    fi
> +    printf "%s^%s^%s" "$U" "$B" "$E"
> +}
> +
> +ensure_remote () {
> +    URL="$1"
> +    REMSTR="$(git remote -v | awk -v url="$1" '(NR%2 == 1) && index($0, url) {print $1, $2}')"
> +
> +    if test -n "$REMSTR"
> +    then
> +        log "REMSTR found: ${REMSTR}\n"
> +        REMOTE="$(echo "$REMSTR"|cut -d ' ' -f 1)"
> +    else
> +        # try to generate some good name for the remote
> +        case "$URL" in
> +        *github.com*|*gitlab.com*)
> +            REMOTE="$(echo "$URL"|cut -d/ -f 4)"
> +            ;;
> +        *sr.ht*)
> +            REMOTE="$(echo "$URL"|awk -F'[~/]' '{print $5}')"
> +            ;;
> +        *)
> +            REMOTE="_4review"
> +            ;;
> +        esac
> +        if test -z "$DEBUG"
> +        then
> +            git remote add "$REMOTE" "$URL"
> +            git remote update "$REMOTE"
> +        else
> +            printf "ensure_remote: getting REMOTE = %s and URL = %s\n" "$REMOTE" "$URL" >&2
> +        fi
> +    fi
> +
> +    printf "%s" "$REMOTE"
> +}
> +
> +#### main
> +while getopts ":dht:" arg ; do
> +    case $arg in
> +        h)
> +            usage
> +            ;;
> +        t)
> +            DEST_ADDR="$OPTARG"
> +            ;;
> +        ?)
> +            die "Invalid option: -${OPTARG}." 5
> +            ;;
> +    esac
> +done
> +
> +shift $((OPTIND - 1))
> +
> +MASTER="master"
> +if git rev-parse -q --verify main >/dev/null 2>&1
> +then
> +    MASTER="main"
> +fi
> +
> +if test $# -lt 1
> +then
> +    PARSED_STR="$(parse_message)"
> +    test -n "$PARSED_STR" || die "Not enough arguments and no message in stdin!" 2
> +    URL="$(echo "$PARSED_STR"|cut -d '^' -f 1)"
> +    BASE="$(echo "$PARSED_STR"|cut -d '^' -f 2)"
> +    HEAD="$(echo "$PARSED_STR"|cut -d '^' -f 3)"
> +# Ignore all command line arguments when stdin parsed
> +else
> +    if test $# -ge 1
> +    then
> +        URL="$1"
> +    fi
> +
> +    if test -z "$URL"
> +    then
> +        die "Insufficient input: no parseable input or command line arguments." 3
> +    fi
> +
> +    if test $# -ge 2
> +    then
> +        HEAD="$2"
> +    else
> +        HEAD="FETCH_HEAD"
> +    fi
> +
> +    # find the base commit where PR roots in the default branch
> +    if test $# -ge 3
> +    then
> +        BASE="$3"
> +    fi
> +fi
> +
> +if test "$WANT_REMOTE" -eq 1
> +then
> +    REMOTE="$(ensure_remote "$URL")"
> +    if test -n "$HEAD" && ! git rev-parse -q --verify "$HEAD"
> +    then
> +        git rev-parse -q --verify "$REMOTE/$HEAD" || die "Cannot find $HEAD branch on the remote $REMOTE!" 4
> +        HEAD="${REMOTE}/${HEAD}"
> +    fi
> +
> +    BRANCH_NAME="$(git log --pretty="%aL" -1)-$(date '+%d%m%Y')"
> +
> +    if test -z "$DEBUG"
> +    then
> +        git branch "$BRANCH_NAME" "$HEAD"
> +    else
> +        printf "make_branch: getting BRANCH_NAME = %s and HEAD = %s\n" "$BRANCH_NAME" "$HEAD" >&2
> +    fi
> +else
> +    git fetch "$URL"
> +fi
> +
> +if test -z "$DEST_ADDR"
> +then
> +    DEST_ADDR="$(git config --default='' sendemail.to)"
> +    test -z "$DEST_ADDR" && die "Unknown destination for the emails" 4
> +fi
> +
> +test "$HEAD" = "FETCH_HEAD" && HEAD="$(git rev-parse -q --verify FETCH_HEAD)"
> +
> +ROOT="$(git merge-base "$MASTER" "$HEAD")"
> +
> +# commit is not part of our tree
> +test "$ROOT" = "$HEAD" && die "Final commit cannot be included in our tree" 4
> +
> +test -z "$BASE" && BASE="$ROOT"
> +
> +test "$BASE" = "$HEAD" && die "No change observed" 1
> +
> +AUTHOR="$(git log --pretty="%an <%ae>" -1)"
> +if test -z "$DEBUG"
> +then
> +    git send-email --to="$DEST_ADDR" --from="$AUTHOR" --no-annotate --no-cc --no-bcc --no-identity --quiet "${BASE}..${HEAD}"
> +else
> +    printf "main: DEST_ADDR= %s, AUTHOR=%s, BASE=%s, HEAD=%s\n" "$DEST_ADDR" "$AUTHOR" "$BASE" "$HEAD" 
> +fi
