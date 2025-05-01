Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE92609C0
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135264; cv=none; b=TMI5L7Y4voqG1NmwwAWf+TlRDBYgzJkmsbJjvJfUkBlslsUQGns0Ii8Jv33OSOZovFvdwSbwzSnH875H47sDu0vPBwnwqhfAFwJXeeHH+EHwdabb/6sjIz8zWqBRd0qdfgGSeTUgnXtRZ+JfMlGeIr0LSa/rojP4oOqZd8J2ntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135264; c=relaxed/simple;
	bh=XVTtDbfKqm10rpPhI7yqiB+hki7oUUIQ6QueBJBhDzI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI00VBBCkhBdIbvlAEO3bsVmliZJL3iWqNznPuBIXKgBAPFzFPkMCww9l34S7ykUunO3ZAGaxlik1fS3TMkKwAf2TxxPmQ6cRhChICeIxc/koMPtvHGjq8rwkWAhJDpjYKOMJATWnk79nsqw5C1KkN6vFBtrKnG/MwViBB9db0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b1zgK+F7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qGZAlDre; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b1zgK+F7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qGZAlDre"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 461951140278;
	Thu,  1 May 2025 17:34:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 01 May 2025 17:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135261; x=
	1746221661; bh=2eCt1oraOhad/okKHj8frBzFeWNX4P4BPTWu3hZylvE=; b=b
	1zgK+F7Po/Or77dvKpI/i/TlXkZwgyAi0/VuGGIGblqZMIFYP0JtXSWuYYAwF47/
	lsPy+6AaEeHKsAkUPG777HxLVejDDdk4FVwtchKJGRSlF48nu4DukmOSwsaB6x+h
	P8OSicgYhRf9Ah8qV0oExklzCzpAVjnmaWrcXViD1mXXigNjtWUMeYO0RJE7JiP2
	NjPW31A7l7+mCYjNs3I+WOB9GYBjlwzxzuIWBCCY4vJHpSnBpyi6eHsEAPbpaPb/
	QMLaZZTPCkOfVdj4WFLKOmTHw9Uv0dP182yFoeD6rTb5EF3gYsATD2wFCLkjW2i3
	X09Mp726vBTzkGVFgU56Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135261; x=1746221661; bh=2eCt1oraOhad/okKHj8frBzFeWNX
	4P4BPTWu3hZylvE=; b=qGZAlDreAkmk8+C5LHZwKsrElA46z/GPSlbgd3eIdPV9
	YnXHF49MmR9yA5319l7qyzDz9z0PprIapDksa/L/f/bAuhCXyJAZuP544DFfrytC
	6nLCooPq17xRhlJH9IluRgP4O45Eg4ol2Yese3Sr+1G8IwUm5IC6jDCurKT02Dg4
	pLMYEJhuQ+T6BwFsiuVAysTSx1Bu52S2K5Y/Bk38H8KCfDAu9bEuzcZxGoND12js
	AT3+DKDHWzcbcfVPwqwqzKZeWOXPt+vF9aSlCgLLBdn62d9n6vXfkYrrDN4DhfDW
	PZ0b7GCPurk2oEFZO94FiKP1V5PJqe0Gpb/LeO1kMA==
X-ME-Sender: <xms:3egTaFXKM7cBC-_cdGwmXo3CfIuDRHYEthh3igun93Ep6ga3N6OQcQ>
    <xme:3egTaFmgJw03hpgAhEhHwFdGWXhRjvI8E29tqMFBQqam8Alr4FJac5lejOaps9qsC
    kC_kJVf4BSIhn0Hcw>
X-ME-Received: <xmr:3egTaBaUWyuWtYoegq7ZZ80SNQen3Z0_g2dk9eZpkjszc9FSq0DTbl0LpQf8BMakYzStGOnxI60_EjHTu8BS21-ShXl7mJs2IRfu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:3egTaIU9NZqjgb46Lx0qusi6gWY6RJozSA0QcShs5PZUtzETXU8Www>
    <xmx:3egTaPlz0MYtQszaT-q7BYOSDOCmIzggdWTlDI6B9agnj1uXzFhDrw>
    <xmx:3egTaFezZUcUXEXZA2GWGGmO10vSvuCtlOc23nOI_4FgPrDyNkQwew>
    <xmx:3egTaJEXP_7weoZ7xmMZmtTCiniwsIKFqRz7aL6jdPuJ3csY3RpnpA>
    <xmx:3egTaBWzjUu8KIkEXyDDj_QBvfA8p4PvcxfKF1I4ocyIZe4GSECMCpHi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:34:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/4] git-daemon doc: update mark-up of synopsis option descriptions
Date: Thu,  1 May 2025 14:34:13 -0700
Message-ID: <20250501213414.370514-4-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501213414.370514-1-gitster@pobox.com>
References: <20250501213414.370514-1-gitster@pobox.com>
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
 Documentation/git-daemon.adoc | 107 +++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-daemon.adoc b/Documentation/git-daemon.adoc
index ede7b935d6..3eb9332e55 100644
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
@@ -46,26 +46,26 @@ An `upload-archive` also exists to serve 'git archive'.
 
 OPTIONS
 -------
---strict-paths::
+`--strict-paths`::
 	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
 	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
 	'git daemon' will refuse to start when this option is enabled and no
 	directory arguments are provided.
 
---base-path=<path>::
+`--base-path=<path>`::
 	Remap all the path requests as relative to the given path.
 	This is sort of "Git root" - if you run 'git daemon' with
 	'--base-path=/srv/git' on example.com, then if you later try to pull
 	'git://example.com/hello.git', 'git daemon' will interpret the path
 	as `/srv/git/hello.git`.
 
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
2.49.0-599-g90c2cffacf

