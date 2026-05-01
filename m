Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A837E30D
	for <git@vger.kernel.org>; Fri,  1 May 2026 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677319; cv=none; b=d0dJe/uThtISrK8vHCqnnYp5r96vVJc4ebhNA7Ow3LuOFwSoltE9S79N+EC5CcXj5AoFldKHZQYIFYHgPosGMReD+D/GVWXSdFxGzSNz/vLeAuvrU29U4UFzLXzOSkBgKcWjdUcubxnVFiIiMlUa3Nek0ka03i5QnAfDOxR9Sls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677319; c=relaxed/simple;
	bh=nShCIvBAt1eRu17tFMFFYomrEUCY0xnxIKrzBUjh7bs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZfkGaoxqLMsZEeXDWNv5HD/BQXxE6yXmaLY//MxKJpFzsoZszNZOC1nAgqwquVL8R+cQbZOXni1Ni+4hGgTzJzrePdMB5g0UB2u/mrQeD6MBONgfOTu7IpxqvMoyqk1AtcW5sPAMKJQkJFL/r6084FlWLnNL+7LbTvivBVU9JY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKxh7p6b; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKxh7p6b"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12de530cbf1so4047469c88.0
        for <git@vger.kernel.org>; Fri, 01 May 2026 16:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677316; x=1778282116; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07wf0fBTrwWfYP4HCv72cSPwqeyvsNOwYA1JM3tZx7g=;
        b=fKxh7p6bexzxKE5UJbnyyxK76jrHXQ8V1ulL/Dgxh7+a0WBiPbI56f/ex3oi948R+f
         zlNCNw30f1Yk041AH1EpDVLBtVQLxXeBPuUGCkthbkQDbcIXdK0qRnWHsV1/225NNLmm
         vQIDWY+PssJWvh37EotN/9OqtSpZADd4pwEb/jFkytpYIDLk5YcqDHzHDGqDQP6Pt4Rh
         +Pw6pRjx3pIn0QRF8WvZk6VoZiEKX/gJpPDWcS/7Qxp7U4yDIHcpPAwn4oYaKZbtzlF0
         N4TcqD3hjE8yvpyYwuApaxda0eDwSeMOG2hyJCNsm2bTndOtdoLP865XDg+dWlSQLmea
         7HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677316; x=1778282116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07wf0fBTrwWfYP4HCv72cSPwqeyvsNOwYA1JM3tZx7g=;
        b=f/VKHGnqBs+n4xxl1wskT0Lhlj7pAxmhbL9ONsywWFLL4SEYSu/XoXo+mg9rpCQNWk
         fIEsz0WRQFDdZRS5Yut7m4wEcp/Rckrq/b7lsqlgiBaTlY66unlQDcnjSRRUtVo0Ia/F
         KSAKzLiQdJI9eofObqBatPCzWbmuaz0Egys3hLPVPIwASBpUAW1mQNfMsNwGg1NndEfg
         uaFUnpQYi9gRb12Hsb4DZt++f58n5toFG5CTx0u6md9d0DnEe8DqEy+05Bu17AmWBsol
         1h02vs6eLvFBgYQvvq6rDVqwxDAoL6+pkv8/ecZpIQSlFtlbGcWswDIDRLu75EgzqvNj
         XB0g==
X-Gm-Message-State: AOJu0YwS+utrZp++s6kOu2DdoSNZJjHJEpcOkmlaa1n4zDeZCFcWGaa3
	RTYljnXO5Dz3hbDg2RxA6AHcfUWP+6qxDU9j+pqA9/P8Bh2OgnOoJ8bfVBy3u2bh
X-Gm-Gg: AeBDieuojE9Nq7V5kUW8GFyZIIXywX+61NPmcw1N+JJ1Dz7Zz2q1apSkfI6f3IMNdmc
	e7Jc2gEBlrAFHvcgGx8TlidtLPui0d/WAO3srinyDFKfqJtXijSPYNkPwTew8RbNn6ritrvpWl3
	J1AkWaKhHitqhJipHPL58IlD/Rj6aQ29Tz6iL/L7Iiqe2eVGlrIDMwHcpuxnKSnr+ZxGLPz7Wt5
	p6x1kIUVT4j5pT55D1K3+3ZrNEOZ0gFwPQyNICdzm7rkpnKnk4fDZTOsDoTh4K8XKj9kPFSV4pD
	Qt+FFmihLGFWFvBz4bsNIIPvVTuhX7EduCrv2BnqP4fJ4YQnB+oygAjPB6VcIp0VxZsl8D7jEus
	seH5JOyxIDXHyI4SPgpX3PhieS77S8AlT/QPXUolklGNhEYo187ZB28l2RQv0E9hcrJAV/hvNHK
	zSHl6McDboM1S4ElmljRht5rQG5R1CxWxB6EbuGNboxh43EkkGTg==
X-Received: by 2002:a05:7022:2218:b0:12d:de3e:86ae with SMTP id a92af1059eb24-12dfd8808f1mr524505c88.44.1777677316079;
        Fri, 01 May 2026 16:15:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71bccsm5884768eec.11.2026.05.01.16.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:15:15 -0700 (PDT)
Message-Id: <a4153e1d2470d42d17758df727fc267a7debbc3d.1777677310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
	<pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 23:15:04 +0000
Subject: [PATCH v2 2/8] url: move url_is_local_not_ssh to url.h
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
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Move url_is_local_not_ssh from connect.c/connect.h
to url.c/url.h so that the new url_parse function
in urlmatch.c, and any future code that needs to
distinguish a local path from an scp style SSH URL,
can reuse the heuristic without depending on connect.c.

No behavior change.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 connect.c | 8 --------
 connect.h | 1 -
 remote.c  | 1 +
 url.c     | 8 ++++++++
 url.h     | 2 ++
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 46da89905e..cb145de30e 100644
--- a/connect.c
+++ b/connect.c
@@ -707,14 +707,6 @@ enum url_scheme {
 	URL_SCHEME_GIT
 };
 
-int url_is_local_not_ssh(const char *url)
-{
-	const char *colon = strchr(url, ':');
-	const char *slash = strchr(url, '/');
-	return !colon || (slash && slash < colon) ||
-		(has_dos_drive_prefix(url) && is_valid_path(url));
-}
-
 static const char *url_scheme_name(enum url_scheme scheme)
 {
 	switch (scheme) {
diff --git a/connect.h b/connect.h
index 1645126c17..8d84f6656b 100644
--- a/connect.h
+++ b/connect.h
@@ -13,7 +13,6 @@ int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
 int parse_feature_request(const char *features, const char *feature);
 const char *server_feature_value(const char *feature, size_t *len_ret);
-int url_is_local_not_ssh(const char *url);
 
 struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
diff --git a/remote.c b/remote.c
index a664cd166a..24a8118d25 100644
--- a/remote.c
+++ b/remote.c
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "remote.h"
+#include "url.h"
 #include "urlmatch.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/url.c b/url.c
index 3ca5987e90..057576042a 100644
--- a/url.c
+++ b/url.c
@@ -132,3 +132,11 @@ void str_end_url_with_slash(const char *url, char **dest)
 	free(*dest);
 	*dest = strbuf_detach(&buf, NULL);
 }
+
+int url_is_local_not_ssh(const char *url)
+{
+	const char *colon = strchr(url, ':');
+	const char *slash = strchr(url, '/');
+	return !colon || (slash && slash < colon) ||
+		(has_dos_drive_prefix(url) && is_valid_path(url));
+}
diff --git a/url.h b/url.h
index cd9140e994..39d621312f 100644
--- a/url.h
+++ b/url.h
@@ -21,6 +21,8 @@ char *url_decode_parameter_value(const char **query);
 void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
+int url_is_local_not_ssh(const char *url);
+
 /*
  * The set of unreserved characters as per STD66 (RFC3986) is
  * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
-- 
gitgitgadget

