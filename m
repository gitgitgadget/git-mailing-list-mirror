Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026902EFD90
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240828; cv=none; b=psZ/L1YrymwhSdH2sJ5jcaiDSRwpIVg/QnKVJ1Xh+EAoQQm5w77TSnp1zrzMKykPm2ahPJ4xvJrQRsK8EGzCQ/8z/XhUL0GTvzGG7IwbeKS6W3kbMdTZQGTWupF+QipaeWvpM9rCuPLNem3nywoTXv6ooO7tLf7YipK8QbAUM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240828; c=relaxed/simple;
	bh=h42A5F+svHWllZupcnEl6Ue8CZbDpIr4Bpj40Op6izQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LFKEY7U4eQd4MMJSydppkf1IaK65rZGAvD9yToOwAY6BaP8+kG3XTGC84oswvdKCOIWORvFu6eCnisvK9sM4zvEqM7CNMPYsLXQpcgxddDBESjfTYu5HlVua6eyseedYvodHMiudLBvbkoCJNvbPxbSXrqqC3ZyiKbHQOdWqJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvks3flx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvks3flx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so37874715e9.3
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756240825; x=1756845625; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbPZLe4bXvNkKgapLTmi7aq5VHREZYJT9E5HZDC6cZI=;
        b=Hvks3flxx/QMwUqf7/Usk6OxwU5PTe8zjXLh/vfGiqHi6TG/bhmbOiu8vDJb/m/Ni+
         BjH1K0Q2qP6QjOtIs28CTjruhHQQY4sr0uwl/Mgd6ZJR4kaPLeOcrcIGr+An7HLsjMTh
         DE+ZJXFo315AVlg7vCn9I09BwaC53u7s6Lmc1PcFJTcplGOXYy7wtuKOGOoVY8fa19zX
         SLLugLsFAl15mp8zeAzTowvTLp/kPj7hTlB1pPBPNQuJE9a4YOceuygeYZODmG+xt7AS
         2/FZrYMeq0cxoUu5/XEg10VtpRZlRuJtV0sqojzonZCMA/voSDy8ovHABLCKCw5gR7I7
         5F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240825; x=1756845625;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbPZLe4bXvNkKgapLTmi7aq5VHREZYJT9E5HZDC6cZI=;
        b=MMwHrPD25Gri3q6WVMfDvdsVjjcPMyQBd43TpT2qcexqVKb94tRDqW9SX7hThAWZc2
         OAC+zLCLa2w38JUVfSJj+ixKXtkxfqXCDeszbhfp4Dv5zlbX8xlWcv0DRFU1ZuJ1c3dr
         154DVEHNqru5gpUAZuEYjrvLkav0JckzJ2cO27d3hkTGi8sTFMnHFOM8Gnr6HSsS/Ejb
         BZreoley1q8R9aKzKOutXiyYhqtGPBNi3f8r/zveEabG+FA4f/J9ygjYeqJj8nMM3r1I
         8n5Umx9cihaFPDmDfS8Ye5uGW3nkzNSPk4kCST7Yi5UcHiZg76GCzTDPdf4OIKui+HcU
         XKhw==
X-Gm-Message-State: AOJu0YwZ7hfwRNpJmxBurFII6UMMwtG58d2aDKIHiUOwsQhOmC2IGggc
	cKgBm9M74vOYoLUF8skLWVCjNqbwvxASmj7lTpA/UngxFQX13QDQCcqoyz/x+A==
X-Gm-Gg: ASbGnctc4d2nJ5UbS/6xLCk5F8CKwdu5A4b22Z7JGQBDDokyN9XKXtDkOVZVlZFmaBM
	JhmmDsYFGSCaWSR+tNo3B0IHXVCkmMeNDLh+wIIecLLxmSkOQMMlSXAbajLB7T+xVxM62W+vLjR
	KYjoxFH0vrnICjpj0+wj5kKrVZFZghlP31x0mrezyE5Tj+S2JuVwFfxWLaT66/sLETgV0I7EAST
	+sw+Cii6trrJKea8sAmgnsypDrUvk024YuH6/PjmT9x8lahlcrxofNu523ckSOx0DpBeKCGcyAm
	OXPPCStB1Dq15z4wN6jFjL4XSKQwqXd63P6BhlH0n5KtGG70k3dTNT1M7PrjlUM6VNMUdQP6GNI
	S5Z3As6Mf6J+1b63bVqaZxzaQMSM=
X-Google-Smtp-Source: AGHT+IE5hMEJf0JajNy4dcLqLy5W+FJrfIUn4LmlFH1TlGHlFWW0s4uPt8AcjEhAewUTd+jIBJ0Ckw==
X-Received: by 2002:a05:600c:4e90:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-45b517cb8b3mr135667225e9.21.1756240824732;
        Tue, 26 Aug 2025 13:40:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306bffsm1071895e9.16.2025.08.26.13.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:40:24 -0700 (PDT)
Message-Id: <2fa98fb5cae78b8872d0b864ee246ba619ef631b.1756240823.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 20:40:19 +0000
Subject: [PATCH 1/4] doc: git-push: update intro
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Users don't understand what a "ref" is, expand it
- Remove "complete the given refs" (that phrase is confusing to many
  users, and it's obvious that pushing a branch involves sending the
  new code)
- Move down the reference to hooks, it's less important than the
  command's basic usage

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index d1978650d60a..e73b64f61fd0 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -19,12 +19,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Updates remote refs using local refs, while sending objects
-necessary to complete the given refs.
-
-You can make interesting things happen to a repository
-every time you push into it, by setting up 'hooks' there.  See
-documentation for linkgit:git-receive-pack[1].
+Updates one or more branches, tags, or other references in a remote
+repository from your local repository.
 
 When the command line does not specify where to push with the
 `<repository>` argument, `branch.*.remote` configuration for the
@@ -44,6 +40,9 @@ corresponding upstream branch, but as a safety measure, the push is
 aborted if the upstream branch does not have the same name as the
 local one.
 
+You can make interesting things happen to a repository
+every time you push into it, by setting up 'hooks' there.  See
+documentation for linkgit:git-receive-pack[1].
 
 OPTIONS[[OPTIONS]]
 ------------------
-- 
gitgitgadget

