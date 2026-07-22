Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3974399FA
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743749; cv=none; b=TVVtd/HB8SdhndGpkhZ04dbP3DABb1fBsXfj77KAJUTTozr+37nEf/ownGiFB08LakMmexQII24Gnj92xhph53NSf9YNYvbnobQ/7DXT/K6S1UnqdTQbJaSV50QZ+Urm5+yBdR/5XykUzMUa2nMMIvH+XJgChuSxRESMMKE9k4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743749; c=relaxed/simple;
	bh=CddJHHx3C+M2kYZXddXzeaq024R12PjeHHpwahW6RyI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gLjEMYnfKybUl6wig4EIFQP1vEcg3gF0raJ/hjrenGV2H6Gx+AKDPbnNJQAlj3HwvyEtaHdftbcqFLsUjPBWktaIEMWVTClF1JzKuCAoFmhBU75qD6fzV+7VgUm0Le/PSvof32fdXNA3Xo2fSGFmECs2MbWlxIX0N13uFn9/7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR3qj81I; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR3qj81I"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so9726708a12.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784743741; x=1785348541; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/MR/cqms8tEOnrSKr0zjsdm6BQPA3+/i+HAF8xbp4CI=;
        b=IR3qj81ImweyhiAVxCX/W6iUvWVY9//rDi9iHHfozCmZ79b5CbQeede8KvKZUQLlPC
         zQ1BmLfusbyeCD2mUoapL8h4NErzv4WfvaABPhzvaYuDnLPBtjCxD/lwAnC9xdRxTmeB
         dZ7d58B+VsL5GDReZxbXu4t/Gul2p43SMThdL68UIWcKq9rHWgyXQAKE7G0DXkjgHnZS
         uGYZVENy5MGzQZ6F2/h8mqjmlaFSCJT4dmUQvYHIBeXxQUsn+VHX+acustZOQfYHXcAs
         kded+ziC7rcaKFp1+egvL6gBcRT+PP2/NEkrmFxgIoFZbJ/eziLnC6spuU7u0+v4C5q3
         pwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784743741; x=1785348541;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MR/cqms8tEOnrSKr0zjsdm6BQPA3+/i+HAF8xbp4CI=;
        b=SGElUUiJaGdohwRp7wPXVfoNkT3Qa2LwpS2obiHoluHjnyGqeEpSd9c9J2mJrjFmbE
         7/rICM9noByp2Zi4m5XB9Bp1EDwzJgAfB3vEcXe+SPrtQRqzdPk+vRFxX7uflM20hpkb
         lMg9ZIU6Ixd0k/GaINBzt63JSm0FuWaMnBwF4Zp6UHE18rtOkqrVNXDHkiy3EuLrKC0T
         tEO+MvX9BlPXgC8gwbB4tx7jz7p6ypPWzBsqenEvyQpeI/zZulPaYTIP3IL0s4pCH/cu
         BteKettWm7ERkMp87KC5GBoeJvU/20Kl+sH2SWnpHOq8frRYQkuNXfpe2omaoLVtRo6p
         ktjQ==
X-Gm-Message-State: AOJu0Yz7+lsgIQGC79f/9mjtYQH1PtyykNJmHjo0Nmfk3mUoUGRFxfX0
	lVYacKVNhGQWIVMJriOefSSvv2MLF1TMpvf2CJaOx5j4dALREn8mkH8MqXsUTSZ8
X-Gm-Gg: AR+sD12dUODr00lxgjnwAKORPeXziq7MshZkIoM2ddJ3wLLNOkmvBYsnTnHOXZum24v
	CwBmBwoCQ+69rCzCp3+1aa4w5q0lV2QvnmoGjEzMkJb4zprTqDkUlB/+5NVpxfm0vj1LoMCzhd7
	Gg2AHOV4xeDwVUlhtmSYHiGdzDBrvbSjbH4D5agxcB/Jkbi3mgCWC5CIJBxRei+Zshr/Y4cXz4G
	PSKt5WVR9Oe9NUeGHsBqRLop0nl1/PisD2zgaELeJwpJW0ttoAbpTonNQ7RmtSk3RviCqCZdFpf
	5U+Xi1NO7TziHfwVLl7kia+WliXrBIlF7DjUgKxxxpHL/vFy4pm7Rc4txP7PolN7xeaiiqgCPFW
	gW9Y9vEQ0och2HG8KJqOb5X3w712O3n5yLSdA+YncwZHkIUuZDbKmaefI1RAbmy+5ojT0JaR9yN
	AF5Gp3
X-Received: by 2002:a05:6a21:2d4b:b0:3b4:85db:1bed with SMTP id adf61e73a8af0-3c3ad9d1b96mr26931158637.45.1784743741149;
        Wed, 22 Jul 2026 11:09:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.221.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e088d3fsm11747192eec.25.2026.07.22.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:08:59 -0700 (PDT)
Message-Id: <pull.2358.v4.git.git.1784743738.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
References: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 18:08:56 +0000
Subject: [PATCH v4 0/2] remote: url-based pushRemote with renamed remotes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Fix git status not showing the push branch after remotes are renamed, when
branch.<name>.pushRemote is a URL matching exactly one configured remote.

Changes in v4:

 * Match configured remotes by effective push URL, preferring pushurl over
   url.
 * Update the documentation and rationale to describe where the remote would
   push.

Changes in v3:

 * Revamp commit messages to clarify motivation.

Changes in v2:

 * Clarify that URL push destinations already work and that this change only
   restores their tracking information.
 * Document URL values for branch.<name>.pushRemote and their @{push}
   behavior.

Harald Nordgren (2):
  remote: pass repository to push tracking helper
  remote: find tracking branches for URL push destinations

 Documentation/config/branch.adoc |   1 +
 Documentation/revisions.adoc     |   3 +
 remote.c                         |  54 ++++++++++--
 remote.h                         |   2 +
 t/t5505-remote.sh                | 144 +++++++++++++++++++++++++++++++
 transport.c                      |   5 +-
 6 files changed, 203 insertions(+), 6 deletions(-)


base-commit: 5d2e7709234afea1b6ddb25cd4f60d3d5fb3c200
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2358%2FHaraldNordgren%2Fremote-resolve-url-push-tracking-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2358/HaraldNordgren/remote-resolve-url-push-tracking-v4
Pull-Request: https://github.com/git/git/pull/2358

Range-diff vs v3:

 1:  b1ac49de87 = 1:  494287bade remote: pass repository to push tracking helper
 2:  a343af9d50 ! 2:  08c432a2d4 remote: find tracking branches for URL push destinations
     @@ Commit message
          "git status" cannot show the push branch, and an up-to-date push can
          leave its tracking information stale.
      
     -    When exactly one configured remote uses the push destination URL, use
     -    that remote for push tracking. Continue to push to the URL so the
     -    configured remote's push settings do not change existing behavior. Keep
     -    the current behavior when no remote matches or multiple remotes match.
     +    When exactly one configured remote would push to the same URL, use that
     +    remote for push tracking. Continue to push to the URL so the configured
     +    remote's push settings do not change existing behavior. Keep the current
     +    behavior when no remote matches or multiple remotes match.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/revisions.adoc: some output processing may assume ref names in UTF
         `git push` were run while `branchname` was checked out (or the current
         `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
         the remote-tracking branch that corresponds to that branch at the remote.
     -+  If the push destination is a URL and exactly one configured remote has
     -+  that URL among its `remote.<name>.url` values, '@\{push}' reports that
     -+  remote's remote-tracking branch.
     ++  If the push destination is a URL and exactly one configured remote uses
     ++  that URL for pushing, '@\{push}' reports that remote's remote-tracking
     ++  branch.
       +
       Here's an example to make it more clear:
       +
      
       ## remote.c ##
     +@@ remote.c: struct strvec *push_url_of_remote(struct remote *remote)
     + 	return remote->pushurl.nr ? &remote->pushurl : &remote->url;
     + }
     + 
     ++static bool remote_has_push_url(struct remote *remote, const char *url)
     ++{
     ++	const struct strvec *push_urls = push_url_of_remote(remote);
     ++
     ++	for (size_t i = 0; i < push_urls->nr; i++) {
     ++		if (!strcmp(push_urls->v[i], url))
     ++			return true;
     ++	}
     ++	return false;
     ++}
     ++
     + void ref_push_report_free(struct ref_push_report *report)
     + {
     + 	while (report) {
      @@ remote.c: const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
       	return branch->merge[0]->dst;
       }
     @@ remote.c: const char *branch_get_upstream(struct branch *branch, struct strbuf *
      +
      +		if (!candidate || candidate == remote ||
      +		    !remote_is_configured(candidate, 0) ||
     -+		    !remote_has_url(candidate, check_url))
     ++		    !remote_has_push_url(candidate, check_url))
      +			continue;
      +		if (first_match)
      +			return remote;
     @@ t/t5505-remote.sh: test_expect_success 'rename a remote renames repo remote.push
      +	EOF
      +'
      +
     ++test_expect_success 'configured pushurl makes URL-valued pushRemote trackable' '
     ++	setup_url_pushremote &&
     ++
     ++	(
     ++		cd client &&
     ++		git remote rename origin upstream &&
     ++		git remote add -f origin ../fork.git &&
     ++		git remote set-url --push origin "$fork_url"
     ++	) &&
     ++
     ++	check_status <<-EOF
     ++	On branch topic
     ++	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     ++
     ++	Your branch is up to date with ${SQ}origin/topic${SQ}.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++'
     ++
      +test_expect_success 'pushInsteadOf URL pushRemote is trackable' '
      +	setup_url_pushremote &&
      +	(

-- 
gitgitgadget
