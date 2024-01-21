Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54135273FB
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705842944; cv=none; b=P53tlri7HLQTSILELaZQcbcu/JsfpSBNbnXkIw/pmmSF4tynzm4T+f17ozz4FAzYXPIjEd+R8bvm4fzdHQIDwSsvtgAq51tKc2+o1B1gcTY9tZxXLKtBOW03iAvxDQNZeT4mvKoUjGgLgQMIp2ow6mOUSGpuyA5lbNQhUVYcBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705842944; c=relaxed/simple;
	bh=RIrKM1bxqPPwp8VNx79iCMhcOaxz+z/j7GfhE9Q8F3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZNxHFQYTE1RrN9csOuCJmEtngtUvzZI2Odwzr0/2+UwLC+pS8NzP99lr05eOw1iCWXnnptk9QCClKochI+OEfWi0TuxsyI/mjTnSHJO7iAj1vwx+XRqeQMPUhFesAqdLJHxVjMe+WRN3JBkUTkMRMOm/e1j+c8UsrGfzAErRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFNnsSh7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFNnsSh7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so719601a12.0
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 05:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705842942; x=1706447742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sxCe2h+dbyuY7l3hFdwgnUsPGwQGpFrbIrEu9vfkeg=;
        b=FFNnsSh7RYYSBa+F4SrOMsSHMV2baeZJS9xXuPp4Bs4yxB+WXQMG12SuFqi9In7Oeb
         VrPqepbXw4l7r1w0OW2cOi5kafNIyPzXrqxSSLlYIqckR8FqAeivkRHva1+VoIZ6tkxH
         tiwWrQPQbnEW7ZSc9hZEmoMFDP+N8QgpqhMUteptHq/Z9aFbq55i2wDlcy5F3R/KJtG+
         goi4YWJaRl5Lws3u+pDcgZWmPR9UoWh5DFtNwg210teX9mchmRgqMUz03pbXwKVSxhY3
         T+et8w78jmtB1ivxMMWkQG6UnLTKY2IBNZlipWaqrpkV+bTN5z/ZI+vv9/c6S1Qomh4H
         jRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705842942; x=1706447742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sxCe2h+dbyuY7l3hFdwgnUsPGwQGpFrbIrEu9vfkeg=;
        b=CS/KDWuT9wPzwF7ZhBKEgS5cj9nN6zBSPYgGqc+i3b+a80FGeYryF+kggt3oJCt0xX
         zFiP8Ol8DbNtJXRNdP1A5DALnZqPKlqGbOjMZ/SHke0K3u9AViWs+K3aoh3RtkgRGsr+
         /pldhuLmXlogogrgh6tL7cOGJosmmd37UdAAs2RYoe8nUFuhF7CgzaEV/2qRT2RB0KoG
         rU8CjiXnppyHNsOZloaAynJMsSJQAItPY5MmJRma1CED3brF00rf1sbdRmGJ/+PvgKnd
         9YQBQ9nKjOWSNQ9QcKyiEyqUSrkBomOa79WqTjXQlViKulYDHt56fu+1Ph2kvIAFwdOb
         fYFA==
X-Gm-Message-State: AOJu0YwDK+et3Eth/tobhBEM+sx7yvv4TgbPWY4uKvoNzAyEKTB+6rPp
	hiHuWpruD8nUMt+gDgVvV+kP6IQWr+KNS4ucIM0XT3r6pY85biouRtd7CMDU
X-Google-Smtp-Source: AGHT+IHyKTBk44TrpDN6Vx2a5e8T1k+FdDxUWPYKvmdS1k9ltRhXqaNuMhXcZdU378D/tGHBiCM1jg==
X-Received: by 2002:a05:6a00:2305:b0:6db:de7c:53fe with SMTP id h5-20020a056a00230500b006dbde7c53femr53750pfh.62.1705842942348;
        Sun, 21 Jan 2024 05:15:42 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm6619005pgc.29.2024.01.21.05.15.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2024 05:15:41 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 0/6] support remote archive via stateless transport
Date: Sun, 21 Jan 2024 21:15:32 +0800
Message-Id: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

"git archive --remote=<remote>" learned to talk over the smart
http (aka stateless) transport.

# Changes since v5

Change commit messages.


# range-diff v5...v6

1:  f3fef46c05 ! 1:  d75e6d27ac transport-helper: no connection restriction in connect_helper
    @@ Commit message
     
         Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
         2018-03-15) added a way for a transport without the ".connect" method
    -    to establish a "stateless" connection in protocol-v2, where
    +    to establish a "stateless" connection in protocol v2, where
         process_connect_service() was taught to handle the ".stateless_connect"
         method, making the old protection too strict. But commit edc9caf7 forgot
    -    to adjust this protection accordingly.
    +    to adjust this protection accordingly. Even at the time of commit
    +    b236752a, this protection seemed redundant, since
    +    process_connect_service() would return 0 if the connection could not be
    +    established, and connect_helper() would still die() early.
     
    -    Remove the restriction in the "connect_helper()" function and give the
    -    function "process_connect_service()" the opportunity to establish a
    -    connection using ".connect" or ".stateless_connect" for protocol v2. So
    -    we can connect with a stateless-rpc and do something useful. E.g., in a
    -    later commit, implements remote archive for a repository over HTTP
    -    protocol.
    +    Remove the restriction in connect_helper() and give the function
    +    process_connect_service() the opportunity to establish a connection
    +    using ".connect" or ".stateless_connect" for protocol v2. So we can
    +    connect with a stateless-rpc and do something useful. E.g., in a later
    +    commit, implements remote archive for a repository over HTTP protocol.
     
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Linus Arver <linusa@google.com>
2:  6be331b22d ! 2:  320526dc56 remote-curl: supports git-upload-archive service
    @@ Commit message
     
         Add new service (git-upload-archive) support in remote-curl, so we can
         support remote archive over HTTP/HTTPS protocols. Differences between
    -    git-upload-archive and other serices:
    +    git-upload-archive and other services:
     
          1. The git-archive program does not expect to see protocol version and
             capabilities when connecting to remote-helper, so do not send them
             in remote-curl for the git-upload-archive service.
     
    -     2. We need to detect protocol version by calling discover_refs(),
    +     2. We need to detect protocol version by calling discover_refs().
             Fallback to use the git-upload-pack service (which, like
             git-upload-archive, is a read-only operation) to discover protocol
             version.
     
    +    Helped-by: Linus Arver <linusa@google.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## remote-curl.c ##
3:  aabc8e1a2a ! 3:  72e575d28a transport-helper: protocol-v2 supports upload-archive
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    transport-helper: protocol-v2 supports upload-archive
    +    transport-helper: protocol v2 supports upload-archive
     
    -    We used to support only git-upload-pack service for protocol-v2. In
    +    We used to support only git-upload-pack service for protocol v2. In
         order to support remote archive over HTTP/HTTPS protocols, add new
    -    service support for git-upload-archive in protocol-v2.
    +    service support for git-upload-archive in protocol v2.
     
    +    Helped-by: Linus Arver <linusa@google.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## transport-helper.c ##
4:  fdab4abb43 = 4:  390d13c074 http-backend: new rpc-service for git-upload-archive
5:  6ac0c8e105 ! 5:  1c9f7755d3 transport-helper: call do_take_over() in connect_helper
    @@ Commit message
         After successfully connecting to the smart transport by calling
         process_connect_service() in connect_helper(), run do_take_over() to
         replace the old vtable with a new one which has methods ready for the
    -    smart transport connection. This will fix the exit code of git-archive
    +    smart transport connection. This fixes the exit code of git-archive
         in test case "archive remote http repository" of t5003.
     
         The connect_helper() function is used as the connect method of the
    @@ Commit message
         do_take_over(), it may fail to call transport_disconnect() in
         run_remote_archiver() of "builtin/archive.c". This is because for a
         stateless connection and a service like "git-upload-archive", the
    -    remote helper may receive a SIGPIPE signal and exit early. To have a
    -    graceful disconnect method by calling do_take_over() will solve this
    -    issue.
    +    remote helper may receive a SIGPIPE signal and exit early. Call
    +    do_take_over() to have a graceful disconnect method, so that we still
    +    call transport_disconnect() even if the remote helper exits early.
     
         Helped-by: Linus Arver <linusa@google.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
6:  423a89c593 = 6:  18bc8753df transport-helper: call do_take_over() in process_connect

---

Jiang Xin (6):
  transport-helper: no connection restriction in connect_helper
  remote-curl: supports git-upload-archive service
  transport-helper: protocol v2 supports upload-archive
  http-backend: new rpc-service for git-upload-archive
  transport-helper: call do_take_over() in connect_helper
  transport-helper: call do_take_over() in process_connect

 http-backend.c         | 13 ++++++++++---
 remote-curl.c          | 14 +++++++++++---
 t/t5003-archive-zip.sh | 34 ++++++++++++++++++++++++++++++++++
 transport-helper.c     | 29 +++++++++++++----------------
 4 files changed, 68 insertions(+), 22 deletions(-)

-- 
2.43.0

