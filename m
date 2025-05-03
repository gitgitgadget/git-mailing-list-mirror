Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76456B81
	for <git@vger.kernel.org>; Sat,  3 May 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234946; cv=none; b=Kg4HBmtubsq17nIVlswA+BXj7DMDrWoQlAVnXJ8cXWgDqM8F+BEHTsAYyQuZrwQFcw/0arP/uzKOLg9A3dyWdtK7VPCa2IW64zF4clRLK+WBbRqAuOJGoMkommXOLt1ck9lMXvpnTLCDx2c3yFmmzOAWbbW7Ic88ioS1ljj1C9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234946; c=relaxed/simple;
	bh=CVQ4oLr+T2Co3rYzqupr3eZvYLaJior4vZJmY5IUxEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+YeEH9wCJtmbRtBKmO48LxTqj4qDdC9W9RkvIU0tikQnAt9Rs7XZNFIORZlNm+UYJGxlzHEiPRVLjmnv1W+g6pWyEk1p42+cj9is5m7TO97RN2jubZZpTXQKZQ5N8EZiPclg1qmZUZoMYKiqD3H1YxxjZBV1MY3ACqEUiGhJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gNioeFAs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WnJFfHs1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gNioeFAs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WnJFfHs1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 197501380F8B;
	Fri,  2 May 2025 21:15:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 02 May 2025 21:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746234944; x=
	1746321344; bh=Sj6/gYWyn1K+ZHedyzeDeSXzlPQUIfG7k/6eY5OJT3o=; b=g
	NioeFAsaocWoQ456MIEVkFciJuG12G9IxJ2RZ8keuCvj1vV07ZySUQ2JTVD9twkX
	mp+DaJ1dpFp05ittA4KhWGg9mpznbSoYUqFjzkDWeB8qQFEFYLC9p9CJqyKjKoKA
	7XuBde86P0yDtJgSOQ9eyMFdqKgsH6UBRGT1R0sOXVHFiyMG7OkQH8UTKiRJV+Sz
	z4wOYNfOLX0+MzA6LWfDFeOaYkIPgDsFL4st9id3W1rUAdAK2bSRaeQCOv1WAgtx
	qduQFak0UT5Dtzket26ESIejctsXrpttmiJX/6D+6/je5cw8Jljz2n0u2M/nL/Ky
	FzpNpfWmKRfWAE+LUMzUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746234944; x=1746321344; bh=Sj6/gYWyn1K+ZHedyzeDeSXzlPQU
	IfG7k/6eY5OJT3o=; b=WnJFfHs1L+1QyrMQsCiqDxRGJW+hc/Zz0l/eIKOC9zMo
	rk8ONK6DqF0VBkW/xa8purScAvqLe9rqZD6GSknREphpnrX32C51AXSFff/Y4i38
	Tr5c4Bl3dErquTLMxbTYZ0A9sZVXcn7zw/mKU7c+4nnSAN0B2OFB4jc9AWqJphH3
	BWDqoSJwXCbsRK039y83NErl01/tda592SpnMHYQwGgnXb9rOe1vFPXqvU67KKSR
	UtPdYOgALxZRABgDJMeErkzQ4MWzs/JY7yvmq9N3nii/v+Cd0t6x9fvo9YLZvzYP
	AoK9o87wf2FpIS82g/rZ7Fw85vsCQe/d0HmKe4hGtQ==
X-ME-Sender: <xms:P24VaPh1aX2WpUhZ4m6TdgAxZIBriKvYmLDgK-fAaKxQt75VeCiF-g>
    <xme:P24VaMAmej719sE5pXRTBzExDAL2mEYVDP2o-60ALbsJ2RkCPRPNbTLVdYi1AOciC
    Fv4zedgFe6DBaoqQA>
X-ME-Received: <xmr:P24VaPFXM4lhBesomsUX3X8QwvedOtDdWR1JDWRH6WSfpIneiL9d17OcRpxF_64Ch3oly0o1dTq0Bil8tk84_1F8rVt6xcAmsYYF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgf
    ejudfhheetueeltdejfeejgefhgfeihffhleelvdekheekjeegtdegkeejheetnecuffho
    mhgrihhnpegvgigrmhhplhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:P24VaMRj7uD_TkLTz9R3dlXaf4TtY5djq7kewI3Njzf9Ma4m8jGoYg>
    <xmx:P24VaMxWFiD33eHDemdqteLt07tm4q_x3gHz7YwoGmJmb3s97VLZzQ>
    <xmx:P24VaC7ZdCih8edCbp_F1dG-lK-QmqQ1J8ygPoFg9TXsoXz-lEdyLQ>
    <xmx:P24VaBxe5cGdmBe1VqVcaP1IsQ7KHfTqJYKalqYq66p4KxCl30HCyg>
    <xmx:QG4VaDjs6OE7p32fH3BXV260L6ZDisb6RlRv9eYzJRPMvk3doKJvNoUO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 21:15:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 3/3] git-daemon doc: update mark-up of synopsis option descriptions
Date: Fri,  2 May 2025 18:15:37 -0700
Message-ID: <20250503011537.3035416-4-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250503011537.3035416-1-gitster@pobox.com>
References: <20250501213414.370514-1-gitster@pobox.com>
 <20250503011537.3035416-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unify mark-up used in our documentation to a newer convention,
started by 22293895 (doc: apply synopsis simplification on git-clone
and git-init, 2024-09-24), update the documentation of 'git daemon'
to

 * use [synopsis], not [verse] in the SYNOPSIS section
 * enclose `--option=<value>` in backquotes

Also, split '--[no-]option' into '--option' and '--no-option'
to make it easier to grep for them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-daemon.adoc | 119 +++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 59 deletions(-)

diff --git a/Documentation/git-daemon.adoc b/Documentation/git-daemon.adoc
index ede7b935d6..bc3f77405e 100644
--- a/Documentation/git-daemon.adoc
+++ b/Documentation/git-daemon.adoc
@@ -7,21 +7,21 @@ git-daemon - A really simple server for Git repositories
 
 SYNOPSIS
 --------
-[verse]
-'git daemon' [--verbose] [--syslog] [--export-all]
-	     [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]
-	     [--strict-paths] [--base-path=<path>] [--base-path-relaxed]
-	     [--user-path | --user-path=<path>]
-	     [--interpolated-path=<pathtemplate>]
-	     [--reuseaddr] [--detach] [--pid-file=<file>]
-	     [--enable=<service>] [--disable=<service>]
-	     [--allow-override=<service>] [--forbid-override=<service>]
-	     [--access-hook=<path>] [--[no-]informative-errors]
-	     [--inetd |
-	      [--listen=<host-or-ipaddr>] [--port=<n>]
-	      [--user=<user> [--group=<group>]]]
-	     [--log-destination=(stderr|syslog|none)]
-	     [<directory>...]
+[synopsis]
+git daemon [--verbose] [--syslog] [--export-all]
+	   [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]
+	   [--strict-paths] [--base-path=<path>] [--base-path-relaxed]
+	   [--user-path | --user-path=<path>]
+	   [--interpolated-path=<pathtemplate>]
+	   [--reuseaddr] [--detach] [--pid-file=<file>]
+	   [--enable=<service>] [--disable=<service>]
+	   [--allow-override=<service>] [--forbid-override=<service>]
+	   [--access-hook=<path>] [--[no-]informative-errors]
+	   [--inetd |
+	     [--listen=<host-or-ipaddr>] [--port=<n>]
+	     [--user=<user> [--group=<group>]]]
+	   [--log-destination=(stderr|syslog|none)]
+	   [<directory>...]
 
 DESCRIPTION
 -----------
@@ -32,7 +32,7 @@ that service if it is enabled.
 It verifies that the directory has the magic file "git-daemon-export-ok", and
 it will refuse to export any Git directory that hasn't explicitly been marked
 for export this way (unless the `--export-all` parameter is specified). If you
-pass some directory paths as 'git daemon' arguments, the offers are limited to
+pass some directory paths as `git daemon` arguments, the offers are limited to
 repositories within those directories.
 
 By default, only `upload-pack` service is enabled, which serves
@@ -46,26 +46,26 @@ An `upload-archive` also exists to serve 'git archive'.
 
 OPTIONS
 -------
---strict-paths::
+`--strict-paths`::
 	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
 	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
-	'git daemon' will refuse to start when this option is enabled and no
+	`git daemon` will refuse to start when this option is enabled and no
 	directory arguments are provided.
 
---base-path=<path>::
+`--base-path=<path>`::
 	Remap all the path requests as relative to the given path.
-	This is sort of "Git root" - if you run 'git daemon' with
-	'--base-path=/srv/git' on example.com, then if you later try to pull
-	'git://example.com/hello.git', 'git daemon' will interpret the path
-	as `/srv/git/hello.git`.
+	This is sort of "Git root" - if you run `git daemon` with
+	`--base-path=/srv/git` on `example.com`, then if you later try
+	to pull from `git://example.com/hello.git`, `git daemon` will
+	interpret the path as `/srv/git/hello.git`.
 
---base-path-relaxed::
-	If --base-path is enabled and repo lookup fails, with this option
+`--base-path-relaxed`::
+	If `--base-path` is enabled and repo lookup fails, with this option
 	'git daemon' will attempt to lookup without prefixing the base path.
-	This is useful for switching to --base-path usage, while still
+	This is useful for switching to `--base-path` usage, while still
 	allowing the old paths.
 
---interpolated-path=<pathtemplate>::
+`--interpolated-path=<pathtemplate>`::
 	To support virtual hosting, an interpolated path template can be
 	used to dynamically construct alternate paths.  The template
 	supports %H for the target hostname as supplied by the client but
@@ -75,48 +75,48 @@ OPTIONS
 	After interpolation, the path is validated against the directory
 	list.
 
---export-all::
+`--export-all`::
 	Allow pulling from all directories that look like Git repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
 	do not have the 'git-daemon-export-ok' file.
 
---inetd::
-	Have the server run as an inetd service. Implies --syslog (may be
-	overridden with `--log-destination=`).
-	Incompatible with --detach, --port, --listen, --user and --group
-	options.
+`--inetd`::
+	Have the server run as an inetd service. Implies `--syslog` (may
+	be overridden with `--log-destination=`).
+	Incompatible with `--detach`, `--port`, `--listen`, `--user` and
+	`--group` options.
 
---listen=<host-or-ipaddr>::
+`--listen=<host-or-ipaddr>`::
 	Listen on a specific IP address or hostname.  IP addresses can
 	be either an IPv4 address or an IPv6 address if supported.  If IPv6
-	is not supported, then --listen=<hostname> is also not supported and
-	--listen must be given an IPv4 address.
+	is not supported, then `--listen=<hostname>` is also not supported
+	and `--listen` must be given an IPv4 address.
 	Can be given more than once.
 	Incompatible with `--inetd` option.
 
---port=<n>::
+`--port=<n>`::
 	Listen on an alternative port.  Incompatible with `--inetd` option.
 
---init-timeout=<n>::
+`--init-timeout=<n>`::
 	Timeout (in seconds) between the moment the connection is established
 	and the client request is received (typically a rather low value, since
 	that should be basically immediate).
 
---timeout=<n>::
+`--timeout=<n>`::
 	Timeout (in seconds) for specific client sub-requests. This includes
 	the time it takes for the server to process the sub-request and the
 	time spent waiting for the next client's request.
 
---max-connections=<n>::
+`--max-connections=<n>`::
 	Maximum number of concurrent clients, defaults to 32.  Set it to
 	zero for no limit.
 
---syslog::
+`--syslog`::
 	Short for `--log-destination=syslog`.
 
---log-destination=<destination>::
+`--log-destination=<destination>`::
 	Send log messages to the specified destination.
-	Note that this option does not imply --verbose,
+	Note that this option does not imply `--verbose`,
 	thus by default only error conditions will be logged.
 	The <destination> must be one of:
 +
@@ -135,8 +135,8 @@ none::
 The default destination is `syslog` if `--inetd` or `--detach` is specified,
 otherwise `stderr`.
 
---user-path::
---user-path=<path>::
+`--user-path`::
+`--user-path=<path>`::
 	Allow {tilde}user notation to be used in requests.  When
 	specified with no parameter, a request to
 	git://host/{tilde}alice/foo is taken as a request to access
@@ -145,23 +145,23 @@ otherwise `stderr`.
 	taken as a request to access `<path>/foo` repository in
 	the home directory of user `alice`.
 
---verbose::
+`--verbose`::
 	Log details about the incoming connections and requested files.
 
---reuseaddr::
+`--reuseaddr`::
 	Use SO_REUSEADDR when binding the listening socket.
 	This allows the server to restart without waiting for
 	old connections to time out.
 
---detach::
-	Detach from the shell. Implies --syslog.
+`--detach`::
+	Detach from the shell. Implies `--syslog`.
 
---pid-file=<file>::
+`--pid-file=<file>`::
 	Save the process id in 'file'.  Ignored when the daemon
 	is run under `--inetd`.
 
---user=<user>::
---group=<group>::
+`--user=<user>`::
+`--group=<group>`::
 	Change daemon's uid and gid before entering the service loop.
 	When only `--user` is given without `--group`, the
 	primary group ID for the user is used.  The values of
@@ -179,30 +179,31 @@ may also want to set and export `HOME` to point at the home
 directory of `<user>` before starting the daemon, and make sure any
 Git configuration files in that directory are readable by `<user>`.
 
---enable=<service>::
---disable=<service>::
+`--enable=<service>`::
+`--disable=<service>`::
 	Enable/disable the service site-wide per default.  Note
 	that a service disabled site-wide can still be enabled
 	per repository if it is marked overridable and the
 	repository enables the service with a configuration
 	item.
 
---allow-override=<service>::
---forbid-override=<service>::
+`--allow-override=<service>`::
+`--forbid-override=<service>`::
 	Allow/forbid overriding the site-wide default with per
 	repository configuration.  By default, all the services
 	may be overridden.
 
---[no-]informative-errors::
+`--informative-errors`::
+`--no-informative-errors`::
 	When informative errors are turned on, git-daemon will report
 	more verbose errors to the client, differentiating conditions
 	like "no such repository" from "repository not exported". This
 	is more convenient for clients, but may leak information about
 	the existence of unexported repositories.  When informative
 	errors are not enabled, all errors report "access denied" to the
-	client. The default is --no-informative-errors.
+	client. The default is `--no-informative-errors`.
 
---access-hook=<path>::
+`--access-hook=<path>`::
 	Every time a client connects, first run an external command
 	specified by the <path> with service name (e.g. "upload-pack"),
 	path to the repository, hostname (%H), canonical hostname
-- 
2.49.0-601-ga5925c3955

