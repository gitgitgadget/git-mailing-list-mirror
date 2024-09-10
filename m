Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440F38F9C
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985824; cv=none; b=a3D6YaI9zYB9BMznJ/G9Kqgc4fR13T7Pwn9Q3PnSG+RdnbTy0EY5D33V5oPnTFF5nmMHiZS317oBY9spCIzvFiCs3UKNb1bbx2HQpIQVLaBULVioGJJniCBBDYXq4wLjvFSsqL3nLC2Ok3SO57wuzy6UMBCnl958oxVbYJyxVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985824; c=relaxed/simple;
	bh=v8bNX+OiIEWlLXjDiBMFR+FDCUQB4BLS5basNJLJz/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHMBAeLC9MAkTRoxePE/lR+cGr1abWXqKPCMRnZlJAC3NfY8Jt23wAHcoMhRaNjUZJ6IYPUADXMVIBt+gtTlRSsBhB/blrn/FA5+/bJPkzOn+ENUwZqaPfAcYwt49nOBFs3pzOqRgueCRCRxPswSy6q4TWThqMCoF/7clKrwKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx5DLz6V; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx5DLz6V"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c962e5adso3263901f8f.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725985819; x=1726590619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8mVtNttxKDwv/LHXuw+vA+E1y/jTk/WyB1/p22X38E=;
        b=Gx5DLz6VgmRVyHcMh5VzPzTCuuZEI6MsOTT3QWyk8DYlZAr+GIfLN0ISqfrqjhelpA
         ZtKFhga8MgMtkcOR7a20wawcXCtopaRErmKYAy9w9gK55cCE36ILhtQssVv6akNlU4YZ
         iEwefKL1nI64QpN3ydfp1fzNqWtB4QwFhgx+2Xew1FShpmPlmznyOn2AAFtwt6FXe7Su
         GODcYcH4VwvMzZMhw6matevgtQy7SQZaP7ImNBPezDIG1ZDL2fErnRw8H5EKDKKNGIvV
         gxgWN5pys1RIpfiBokCpXItpgHxw1YDz6ZxHNMz0rCu6/Q1TsJHfTjZ7tkp6Kxv7wbSA
         ONNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985819; x=1726590619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8mVtNttxKDwv/LHXuw+vA+E1y/jTk/WyB1/p22X38E=;
        b=QDHem3q3Q8doLGdr0KmAeNgIjV/3I0REyPGSQC/0aHWO3WoYTeWIjEWtPX31SrypCT
         txjLVsszgDUAnhUPj3vzudO+l3uqRVxO9sfJBaSbgQtEQ7tNUENJz/MkrnGz4UHEWBTd
         oXlH8KsINO9jd84PKqkhkS5GWPWC861rJ3FiTDw7mI97YZ0MQTczAP4u4fz24WK5Q2ol
         OKjBoMMo8j/e3RjVr/YwCVJiSZpxfHQnmaPouDUziNeH+Y821FOEFB51jePEvfGjE+1t
         PbV0apv+OLEJRcRyz1pXpGeN+G4yNz4ewNPuNoP3RNujFjT7gm1JAP5nXStvTBHzLo2g
         YkMw==
X-Gm-Message-State: AOJu0YwoF19zZ3pqz2YL4/I0ER+NE1ZIqV0LVca+F7ToYqtK2GEidYWs
	pBn5BaYjxr9LYgVwclhCJ+NaPTr3QG27+1QyVxvpmL8wScApVtIhHFwHAA==
X-Google-Smtp-Source: AGHT+IERMygA/lSg5cZ8INOUFPJnm/Jn++VJ70dCZVv326GoBiTHAZ9M4uCE4PF9pi2BExG4nMNl6Q==
X-Received: by 2002:adf:ee8d:0:b0:36b:5d86:d885 with SMTP id ffacd0b85a97d-378a8a83a66mr2164973f8f.24.1725985817641;
        Tue, 10 Sep 2024 09:30:17 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm29897865e9.0.2024.09.10.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:30:16 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/4] Introduce a "promisor-remote" capability
Date: Tue, 10 Sep 2024 18:29:56 +0200
Message-ID: <20240910163000.1985723-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.4.g7a37e584ed
In-Reply-To: <20240731134014.2299361-1-christian.couder@gmail.com>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier this year, I sent 3 versions of a patch series with the goal
of allowing a client C to clone from a server S while using the same
promisor remote X that S already use. See:

https://lore.kernel.org/git/20240418184043.2900955-1-christian.couder@gmail.com/

Junio suggested to implement that feature using:

"a protocol extension that lets S tell C that S wants C to fetch
missing objects from X (which means that if C knows about X in its
".git/config" then there is no need for end-user interaction at all),
or a protocol extension that C tells S that C is willing to see
objects available from X omitted when S does not have them (again,
this could be done by looking at ".git/config" at C, but there may be
security implications???)"

This patch series implements that protocol extension called
"promisor-remote" (that name is open to change or simplification)
which allows S and C to agree on C using X directly or not.

I have tried to implement it in a quite generic way that could allow S
and C to share more information about promisor remotes and how to use
them.

For now, C doesn't use the information it gets from S when cloning.
That information is only used to decide if C is OK to use the promisor
remotes advertised by S. But this could change in the future which
could make it much simpler for clients than using the current way of
passing information about X with the `-c` option of `git clone` many
times on the command line.

Another improvement could be to not require GIT_NO_LAZY_FETCH=0 when S
and C have agreed on using S.

Changes compared to version 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - In patch 1/4, fixed a typo spotted by Eric Sunshine when I sent
    this patch in a previous patch-series.

  - In patch 3/4, changed server and client behavior, so that they
    don't advertise the "promisor-remote" capability at all if they
    don't use it. Changed the doc and commit message accordingly.

  - In patch 3/4, related to the previous change, modified both
    promisor_remote_reply() and promisor_remote_info() so they return
    NULL when the "promisor-remote" capability shouldn't be advertised
    in the protocol, and the string that should appear in the
    advertisement otherwise. Adapted the callers and the doc of these
    functions accordingly.

  - In patch 3/4, fixed lack of urlencoding for remote names, as it
    looks like remote names can contain a lot of characters like ','
    and ';'. So it's just better to urlencode them in the same way
    URLs are also urlencoded. Also used url_percent_decode(), instead
    of url_decode(), to decode both names and urls, as it looks more
    suited to decode what strbuf_addstr_urlencode() encoded.

  - In patch 3/4, simplified a bit some `if` conditions in
    loops. Changed `if (sb.len)` or `if (i != 0)` to just `if (i)`.

  - In patch 3/4, improve doc and commit message to talk about the
    case of a server advertising promisor remotes which are better
    connected to the world.

  - In patch 3/4, improve doc and commit message to talk about the
    consequences for the client and the server of promisor remotes
    being advertised or accepted.

  - In patch 3/4, improve the doc to say that `pr-name` MUST be a
    valid remote name, and the ';' and ',' characters MUST be encoded
    if they appear in `pr-name` or `pr-url`.

  - In patch 3/4, changed 'pm-*' to 'pr-*' in commit message to match
    what is in the doc.

  - In patch 3/4, made a number of other minor improvements to the doc
    and commit message.

  - In patch 4/4, improve doc and commit message to add information
    about the security implications of the new "KnownName" and
    "KnownUrl" options for the "promisor.acceptFromServer" config
    variable.

Thanks to Junio, Patrick, Eric and Taylor for their suggestions.

CI tests
~~~~~~~~

See: https://github.com/chriscool/git/actions/runs/10796188005

Range diff compared to version 1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1:  6260022d20 ! 1:  0d9d094181 version: refactor strbuf_sanitize()
    @@ Commit message
         While at it, let's also make a few small improvements:
           - use 'size_t' for 'i' instead of 'int',
           - move the declaration of 'i' inside the 'for ( ... )',
    -      - use strbuf_detach() to explicitely detach the string contained by
    +      - use strbuf_detach() to explicitly detach the string contained by
             the 'sb' strbuf.
     
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## strbuf.c ##
2:  ff1246b07c = 2:  fc53229eff strbuf: refactor strbuf_trim_trailing_ch()
3:  cb7250d06e ! 3:  5c507e427f Add 'promisor-remote' capability to protocol v2
    @@ Metadata
      ## Commit message ##
         Add 'promisor-remote' capability to protocol v2
     
    -    When a server repository S borrows some objects from a promisor remote X,
    -    then a client repository C which would like to clone or fetch from S might,
    -    or might not, want to also borrow objects from X. Also S might, or might
    -    not, want to advertise X as a good way for C to directly get objects from,
    -    instead of C getting everything through S.
    +    When a server S knows that some objects from a repository are available
    +    from a promisor remote X, S might want to suggest to a client C cloning
    +    or fetching the repo from S that C should use X directly instead of S
    +    for these objects.
     
    -    To allow S and C to agree on C using X or not, let's introduce a new
    -    "promisor-remote" capability in the protocol v2, as well as a few new
    -    configuration variables:
    +    Note that this could happen both in the case S itself doesn't have the
    +    objects and borrows them from X, and in the case S has the objects but
    +    knows that X is better connected to the world (e.g., it is in a
    +    $LARGEINTERNETCOMPANY datacenter with petabit/s backbone connections)
    +    than S. Implementation of the latter case, which would require S to
    +    omit in its response the objects available on X, is left for future
    +    improvement though.
    +
    +    Then C might or might not, want to get the objects from X, and should
    +    let S know about this.
    +
    +    To allow S and C to agree and let each other know about C using X or
    +    not, let's introduce a new "promisor-remote" capability in the
    +    protocol v2, as well as a few new configuration variables:
     
           - "promisor.advertise" on the server side, and:
           - "promisor.acceptFromServer" on the client side.
     
         By default, or if "promisor.advertise" is set to 'false', a server S will
    -    advertise only the "promisor-remote" capability without passing any
    -    argument through this capability. This means that S supports the new
    -    capability but doesn't wish any client C to directly access any promisor
    -    remote X S might use.
    +    not advertise the "promisor-remote" capability.
    +
    +    If S doesn't advertise the "promisor-remote" capability, then a client C
    +    replying to S shouldn't advertise the "promisor-remote" capability
    +    either.
     
         If "promisor.advertise" is set to 'true', S will advertise its promisor
         remotes with a string like:
     
    -      promisor-remote=<pm-info>[;<pm-info>]...
    +      promisor-remote=<pr-info>[;<pr-info>]...
     
    -    where each <pm-info> element contains information about a single
    +    where each <pr-info> element contains information about a single
         promisor remote in the form:
     
    -      name=<pm-name>[,url=<pm-url>]
    +      name=<pr-name>[,url=<pr-url>]
     
    -    where <pm-name> is the name of a promisor remote and <pm-url> is the
    -    urlencoded url of the promisor remote named <pm-name>.
    +    where <pr-name> is the urlencoded name of a promisor remote and
    +    <pr-url> is the urlencoded URL of the promisor remote named <pr-name>.
     
         For now, the URL is passed in addition to the name. In the future, it
         might be possible to pass other information like a filter-spec that the
    @@ Commit message
         use when retrieving objects from X.
     
         It might also be possible in the future for "promisor.advertise" to have
    -    other values like "onlyName", so that no URL is advertised.
    +    other values. For example a value like "onlyName" could prevent S from
    +    advertising URLs, which could help in case C should use a different URL
    +    for X than the URL S is using. (The URL S is using might be an internal
    +    one on the server side for example.)
     
    -    By default or if "promisor.acceptFromServer" is set to "None", the
    -    client will not accept to use the promisor remotes that might have been
    -    advertised by the server. In this case, the client will advertise only
    -    "promisor-remote" in its reply to the server. This means that the client
    -    has the "promisor-remote" capability but decided not to use any of the
    -    promisor remotes that the server might have advertised.
    +    By default or if "promisor.acceptFromServer" is set to "None", C will
    +    not accept to use the promisor remotes that might have been advertised
    +    by S. In this case, C will not advertise any "promisor-remote"
    +    capability in its reply to S.
     
    -    If "promisor.acceptFromServer" is set to "All", on the contrary, the
    -    client will accept to use all the promisor remotes that the server
    -    advertised and it will reply with a string like:
    +    If "promisor.acceptFromServer" is set to "All" and S advertised some
    +    promisor remotes, then on the contrary, C will accept to use all the
    +    promisor remotes that S advertised and C will reply with a string like:
     
    -      promisor-remote=<pm-name>[;<pm-name>]...
    +      promisor-remote=<pr-name>[;<pr-name>]...
     
    -    where the <pm-name> elements are the names of all the promisor remotes
    -    the server advertised. If the server advertised no promisor remote
    -    though, the client will reply with just "promisor-remote".
    +    where the <pr-name> elements are the urlencoded names of all the
    +    promisor remotes S advertised.
     
         In a following commit, other values for "promisor.acceptFromServer" will
    -    be implemented so that the client will be able to decide the promisor
    -    remotes it accepts depending on the name and URL it received from the
    -    server. So even if that name and URL information is not used much right
    -    now, it will be needed soon.
    +    be implemented, so that C will be able to decide the promisor remotes it
    +    accepts depending on the name and URL it received from S. So even if
    +    that name and URL information is not used much right now, it will be
    +    needed soon.
     
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/config/promisor.txt ##
    @@ Documentation/config/promisor.txt
     +promisor.advertise::
     +  If set to "true", a server will use the "promisor-remote"
     +  capability, see linkgit:gitprotocol-v2[5], to advertise the
    -+  promisor remotes it is using if any. Default is "false", which
    -+  means no promisor remote is advertised.
    ++  promisor remotes it is using, if it uses some. Default is
    ++  "false", which means the "promisor-remote" capability is not
    ++  advertised.
     +
     +promisor.acceptFromServer::
     +  If set to "all", a client will accept all the promisor remotes
     +  a server might advertise using the "promisor-remote"
    -+  capability, see linkgit:gitprotocol-v2[5]. Default is "none",
    -+  which means no promisor remote advertised by a server will be
    -+  accepted.
    ++  capability. Default is "none", which means no promisor remote
    ++  advertised by a server will be accepted. By accepting a
    ++  promisor remote, the client agrees that the server might omit
    ++  objects that are lazily fetchable from this promisor remote
    ++  from its responses to "fetch" and "clone" requests from the
    ++  client. See linkgit:gitprotocol-v2[5].
     
      ## Documentation/gitprotocol-v2.txt ##
     @@ Documentation/gitprotocol-v2.txt: retrieving the header from a bundle at the indicated URI, and thus
    @@ Documentation/gitprotocol-v2.txt: retrieving the header from a bundle at the ind
     +promisor-remote=<pr-infos>
     +~~~~~~~~~~~~~~~~~~~~~~~~~~
     +
    -+The server may advertise some promisor remotes it is using, if it's OK
    -+for the server that a client uses them too. In this case <pr-infos>
    -+should be of the form:
    ++The server may advertise some promisor remotes it is using or knows
    ++about to a client which may want to use them as its promisor remotes,
    ++instead of this repository. In this case <pr-infos> should be of the
    ++form:
     +
     +  pr-infos = pr-info | pr-infos ";" pr-info
     +
     +  pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
     +
    -+where `pr-name` is the name of a promisor remote, and `pr-url` the
    -+urlencoded URL of that promisor remote.
    ++where `pr-name` is the urlencoded name of a promisor remote, and
    ++`pr-url` the urlencoded URL of that promisor remote.
     +
    -+In this case a client wanting to use one or more promisor remotes the
    -+server advertised should reply with "promisor-remote=<pr-names>" where
    -+<pr-names> should be of the form:
    ++In this case, if the client decides to use one or more promisor
    ++remotes the server advertised, it can reply with
    ++"promisor-remote=<pr-names>" where <pr-names> should be of the form:
     +
     +  pr-names = pr-name | pr-names ";" pr-name
     +
    -+where `pr-name` is the name of a promisor remote the server
    -+advertised.
    ++where `pr-name` is the urlencoded name of a promisor remote the server
    ++advertised and the client accepts.
    ++
    ++Note that, everywhere in this document, `pr-name` MUST be a valid
    ++remote name, and the ';' and ',' characters MUST be encoded if they
    ++appear in `pr-name` or `pr-url`.
     +
    -+If the server prefers a client not to use any promisor remote the
    -+server uses, or if the server doesn't use any promisor remote, it
    -+should only advertise "promisor-remote" without any value or "=" sign
    -+after it.
    ++If the server doesn't know any promisor remote that could be good for
    ++a client to use, or prefers a client not to use any promisor remote it
    ++uses or knows about, it shouldn't advertise the "promisor-remote"
    ++capability at all.
     +
     +In this case, or if the client doesn't want to use any promisor remote
    -+the server advertised, the client should reply only "promisor-remote"
    -+without any value or "=" sign after it.
    ++the server advertised, the client shouldn't advertise the
    ++"promisor-remote" capability at all in its reply.
     +
     +The "promisor.advertise" and "promisor.acceptFromServer" configuration
     +options can be used on the server and client side respectively to
     +control what they advertise or accept respectively. See the
     +documentation of these configuration options for more information.
    ++
    ++Note that in the future it would be nice if the "promisor-remote"
    ++protocol capability could be used by the server, when responding to
    ++`git fetch` or `git clone`, to advertise better-connected remotes that
    ++the client can use as promisor remotes, instead of this repository, so
    ++that the client can lazily fetch objects from these other
    ++better-connected remotes. This would require the server to omit in its
    ++response the objects available on the better-connected remotes that
    ++the client has accepted. This hasn't been implemented yet though. So
    ++for now this "promisor-remote" capability is useful only when the
    ++server advertises some promisor remotes it already uses to borrow
    ++objects from.
     +
      GIT
      ---
    @@ connect.c: static void send_capabilities(int fd_out, struct packet_reader *reade
        }
     +  if (server_feature_v2("promisor-remote", &promisor_remote_info)) {
     +          char *reply = promisor_remote_reply(promisor_remote_info);
    -+          packet_write_fmt(fd_out, "promisor-remote%s", reply ? reply : "");
    -+          free(reply);
    ++          if (reply) {
    ++                  packet_write_fmt(fd_out, "promisor-remote=%s", reply);
    ++                  free(reply);
    ++          }
     +  }
      }
      
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +  }
     +}
     +
    -+void promisor_remote_info(struct repository *repo, struct strbuf *buf)
    ++char *promisor_remote_info(struct repository *repo)
     +{
     +  struct strbuf sb = STRBUF_INIT;
     +  int advertise_promisors = 0;
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +  git_config_get_bool("promisor.advertise", &advertise_promisors);
     +
     +  if (!advertise_promisors)
    -+          return;
    ++          return NULL;
     +
     +  promisor_info_vecs(repo, &names, &urls);
     +
    ++  if (!names.nr)
    ++          return NULL;
    ++
     +  for (size_t i = 0; i < names.nr; i++) {
    -+          if (sb.len)
    ++          if (i)
     +                  strbuf_addch(&sb, ';');
    -+          strbuf_addf(&sb, "name=%s", names.v[i]);
    ++          strbuf_addstr(&sb, "name=");
    ++          strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
     +          if (urls.v[i]) {
     +                  strbuf_addstr(&sb, ",url=");
     +                  strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +  }
     +
     +  strbuf_sanitize(&sb);
    -+  strbuf_addbuf(buf, &sb);
     +
     +  strvec_clear(&names);
     +  strvec_clear(&urls);
    ++
    ++  return strbuf_detach(&sb, NULL);
     +}
     +
     +enum accept_promisor {
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +          struct strbuf **elems;
     +          const char *remote_name = NULL;
     +          const char *remote_url = NULL;
    ++          char *decoded_name = NULL;
     +          char *decoded_url = NULL;
     +
     +          strbuf_trim_trailing_ch(remotes[i], ';');
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +                                  elems[j]->buf);
     +          }
     +
    -+          decoded_url = url_decode(remote_url);
    ++          if (remote_name)
    ++                  decoded_name = url_percent_decode(remote_name);
    ++          if (remote_url)
    ++                  decoded_url = url_percent_decode(remote_url);
     +
    -+          if (should_accept_remote(accept, remote_name, decoded_url))
    -+                  strvec_push(accepted, remote_name);
    ++          if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url))
    ++                  strvec_push(accepted, decoded_name);
     +
     +          strbuf_list_free(elems);
    ++          free(decoded_name);
     +          free(decoded_url);
     +  }
     +
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +
     +  filter_promisor_remote(the_repository, &accepted, info);
     +
    -+  strbuf_addch(&reply, '=');
    ++  if (!accepted.nr)
    ++          return NULL;
     +
     +  for (size_t i = 0; i < accepted.nr; i++) {
    -+          if (i != 0)
    ++          if (i)
     +                  strbuf_addch(&reply, ';');
    -+          strbuf_addstr(&reply, accepted.v[i]);
    ++          strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
     +  }
     +
     +  strvec_clear(&accepted);
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +
     +  for (size_t i = 0; accepted_remotes[i]; i++) {
     +          struct promisor_remote *p;
    ++          char *decoded_remote;
     +
     +          strbuf_trim_trailing_ch(accepted_remotes[i], ';');
    -+          p = repo_promisor_remote_find(r, accepted_remotes[i]->buf);
    ++          decoded_remote = url_percent_decode(accepted_remotes[i]->buf);
    ++
    ++          p = repo_promisor_remote_find(r, decoded_remote);
     +          if (p)
     +                  p->accepted = 1;
     +          else
     +                  warning(_("accepted promisor remote '%s' not found"),
    -+                          accepted_remotes[i]->buf);
    ++                          decoded_remote);
    ++
    ++          free(decoded_remote);
     +  }
     +
     +  strbuf_list_free(accepted_remotes);
    @@ promisor-remote.h: void promisor_remote_get_direct(struct repository *repo,
                                int oid_nr);
      
     +/*
    -+ * Append promisor remote info to buf. Useful for a server to
    -+ * advertise the promisor remotes it uses.
    ++ * Prepare a "promisor-remote" advertisement by a server.
    ++ * Check the value of "promisor.advertise" and maybe the configured
    ++ * promisor remotes, if any, to prepare information to send in an
    ++ * advertisement.
    ++ * Return value is NULL if no promisor remote advertisement should be
    ++ * made. Otherwise it contains the names and urls of the advertised
    ++ * promisor remotes separated by ';'
     + */
    -+void promisor_remote_info(struct repository *repo, struct strbuf *buf);
    ++char *promisor_remote_info(struct repository *repo);
     +
     +/*
     + * Prepare a reply to a "promisor-remote" advertisement from a server.
    ++ * Check the value of "promisor.acceptfromserver" and maybe the
    ++ * configured promisor remotes, if any, to prepare the reply.
    ++ * Return value is NULL if no promisor remote from the server
    ++ * is accepted. Otherwise it contains the names of the accepted promisor
    ++ * remotes separated by ';'.
     + */
     +char *promisor_remote_reply(const char *info);
     +
    @@ serve.c: static int agent_advertise(struct repository *r UNUSED,
     +static int promisor_remote_advertise(struct repository *r,
     +                               struct strbuf *value)
     +{
    -+       if (value)
    -+         promisor_remote_info(r, value);
    -+       return 1;
    ++  if (value) {
    ++          char *info = promisor_remote_info(r);
    ++          if (!info)
    ++                  return 0;
    ++          strbuf_addstr(value, info);
    ++          free(info);
    ++  }
    ++  return 1;
     +}
     +
     +static void promisor_remote_receive(struct repository *r,
    @@ serve.c: static struct protocol_capability capabilities[] = {
      
      void protocol_v2_advertise_capabilities(void)
     
    - ## t/t5555-http-smart-common.sh ##
    -@@ t/t5555-http-smart-common.sh: test_expect_success 'git upload-pack --advertise-refs: v2' '
    -   fetch=shallow wait-for-done
    -   server-option
    -   object-format=$(test_oid algo)
    -+  promisor-remote
    -   0000
    -   EOF
    - 
    -
    - ## t/t5701-git-serve.sh ##
    -@@ t/t5701-git-serve.sh: test_expect_success 'test capability advertisement' '
    -   object-format=$(test_oid algo)
    -   EOF
    -   cat >expect.trailer <<-EOF &&
    -+  promisor-remote
    -   0000
    -   EOF
    -   cat expect.base expect.trailer >expect &&
    -
      ## t/t5710-promisor-remote-capability.sh (new) ##
     @@
     +#!/bin/sh
4:  bcb884ee16 ! 4:  1c2794f139 promisor-remote: check advertised name or URL
    @@ Commit message
     
         In case of "KnownName", the client will accept promisor remotes which
         are already configured on the client and have the same name as those
    -    advertised by the client.
    +    advertised by the client. This could be useful in a corporate setup
    +    where servers and clients are trusted to not switch names and URLs, but
    +    where some kind of control is still useful.
     
         In case of "KnownUrl", the client will accept promisor remotes which
         have both the same name and the same URL configured on the client as the
    -    name and URL advertised by the server.
    +    name and URL advertised by the server. This is the most secure option,
    +    so it should be used if possible.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ Documentation/config/promisor.txt: promisor.advertise::
      promisor.acceptFromServer::
        If set to "all", a client will accept all the promisor remotes
        a server might advertise using the "promisor-remote"
    --  capability, see linkgit:gitprotocol-v2[5]. Default is "none",
    --  which means no promisor remote advertised by a server will be
    --  accepted.
    -+  capability, see linkgit:gitprotocol-v2[5]. If set to
    -+  "knownName" the client will accept promisor remotes which are
    -+  already configured on the client and have the same name as
    -+  those advertised by the client. If set to "knownUrl", the
    -+  client will accept promisor remotes which have both the same
    -+  name and the same URL configured on the client as the name and
    -+  URL advertised by the server. Default is "none", which means
    -+  no promisor remote advertised by a server will be accepted.
    +-  capability. Default is "none", which means no promisor remote
    +-  advertised by a server will be accepted. By accepting a
    +-  promisor remote, the client agrees that the server might omit
    +-  objects that are lazily fetchable from this promisor remote
    +-  from its responses to "fetch" and "clone" requests from the
    +-  client. See linkgit:gitprotocol-v2[5].
    ++  capability. If set to "knownName" the client will accept
    ++  promisor remotes which are already configured on the client
    ++  and have the same name as those advertised by the client. This
    ++  is not very secure, but could be used in a corporate setup
    ++  where servers and clients are trusted to not switch name and
    ++  URLs. If set to "knownUrl", the client will accept promisor
    ++  remotes which have both the same name and the same URL
    ++  configured on the client as the name and URL advertised by the
    ++  server. This is more secure than "all" or "knownUrl", so it
    ++  should be used if possible instead of those options. Default
    ++  is "none", which means no promisor remote advertised by a
    ++  server will be accepted. By accepting a promisor remote, the
    ++  client agrees that the server might omit objects that are
    ++  lazily fetchable from this promisor remote from its responses
    ++  to "fetch" and "clone" requests from the client. See
    ++  linkgit:gitprotocol-v2[5].
     
      ## promisor-remote.c ##
    -@@ promisor-remote.c: void promisor_remote_info(struct repository *repo, struct strbuf *buf)
    -   strvec_clear(&urls);
    +@@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
    +   return strbuf_detach(&sb, NULL);
      }
      
     +/*
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      
        remotes = strbuf_split_str(info, ';', 0);
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    +           if (remote_url)
    +                   decoded_url = url_percent_decode(remote_url);
      
    -           decoded_url = url_decode(remote_url);
    - 
    --          if (should_accept_remote(accept, remote_name, decoded_url))
    -+          if (should_accept_remote(accept, remote_name, decoded_url, &names, &urls))
    -                   strvec_push(accepted, remote_name);
    +-          if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url))
    ++          if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
    +                   strvec_push(accepted, decoded_name);
      
                strbuf_list_free(elems);
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,


Christian Couder (4):
  version: refactor strbuf_sanitize()
  strbuf: refactor strbuf_trim_trailing_ch()
  Add 'promisor-remote' capability to protocol v2
  promisor-remote: check advertised name or URL

 Documentation/config/promisor.txt     |  27 +++
 Documentation/gitprotocol-v2.txt      |  54 ++++++
 connect.c                             |   9 +
 promisor-remote.c                     | 244 ++++++++++++++++++++++++++
 promisor-remote.h                     |  36 +++-
 serve.c                               |  26 +++
 strbuf.c                              |  16 ++
 strbuf.h                              |  10 ++
 t/t5710-promisor-remote-capability.sh | 192 ++++++++++++++++++++
 trace2/tr2_cfg.c                      |  10 +-
 upload-pack.c                         |   3 +
 version.c                             |   9 +-
 12 files changed, 620 insertions(+), 16 deletions(-)
 create mode 100755 t/t5710-promisor-remote-capability.sh

-- 
2.46.0.4.g7a37e584ed

