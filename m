Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535942F44
	for <git@vger.kernel.org>; Mon, 27 May 2024 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716769944; cv=none; b=SG4/974EzhNfhWfSmrV8o913398kPKMopgwXz6Ig+zKHTm0Q8JeS8HQhcgVtsuXQmCvlju782E3CL40cCxAgNZLsIsMXqjvCPpASEoKbrgqc20udGRlAlTF4lXpR5pHL41WjoxWcAuyUApFgQvHLWU151KvH94nWwyGm5S2ptUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716769944; c=relaxed/simple;
	bh=ztnCmTljJwfBJ3tFhPDqS7GsURe/IXoQyy1M9stl9Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRas7IFoww9MJeQnLpj75cWEfQWWYIDtl+5M48cVDRPtZAdcotcgLG2DE8nyf+zYId04d7cvfI/ytUDCsCJJQvhOeQcb7WQn50AlcN2y0Il+iwHKBoZp1UUa1Uu9PHvsJ4PB3V86xq4VOfzhuttdwzUImnAFWbBnNxRospO3hWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eU2oI1TU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eU2oI1TU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716769942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98TkfPZOI2BsKcPPjkqplHnRFYZ2ypM6x+MrGj8jDFk=;
	b=eU2oI1TUH8SIxXpXRw6wXAxTiWSOAS497VaHY/iqw2xRteayZVpms5yPv+Y5OY0NTi0lpu
	0MuTSFhixr7tJnTCDgcCV3ZA/0n/MBHUH5tc6jCczD6mI5OeGBNSI2fwcsuRkrodNaK6Rv
	qMo7obSxljA40d422KDfkHOfkBLprZ4=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-P60NHx4nM3WRW9SAJs4W0w-1; Sun, 26 May 2024 20:32:19 -0400
X-MC-Unique: P60NHx4nM3WRW9SAJs4W0w-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4e4f030eaafso1286262e0c.3
        for <git@vger.kernel.org>; Sun, 26 May 2024 17:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716769939; x=1717374739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98TkfPZOI2BsKcPPjkqplHnRFYZ2ypM6x+MrGj8jDFk=;
        b=CgiUnxmSr8voQX/7Y1+qeudJ0xy6zyYWQS2ph5xrj7gprBjN+9uqbqvOH9jv+Ficxx
         jrQGxy7nh9no9gFtYy1V/EUDFeLtbamYUAkt2w+zH4caf9IsIB/ZpVBwZ0NvbcOW9eii
         udcWwZw4sK5NBaNmxyBedkE3ZxAEZw4F3ia0CDEoosBzlE5D2yIfjNGnLIgFncv8TgTn
         MwDkCCCmr+lwuo6y95CSolt+nnNwmjQ7YR/2eMBdIF0IIYcHRQgxZJ2GgjRwuiF54J/S
         vK+boIz1IukYbaS2NlH5NpuuWoIZWMXODJtiityGsLOo9xVLc93ScD1EzPWfDaI2kpZI
         3NtQ==
X-Gm-Message-State: AOJu0YytpPpUiafbXn+uoarb+3bQm57ztdx8BH5EOljWPX4OPLn01/qu
	JOHO/GANjRy4tgbMkcBGpMLg7PDcLjGiyrIJ+fyeHBlAjLDmtgxXU1Iq3wpKXztkdogm01q5g4x
	7z0ymQVUY1mgaqV38ImGjls7bE1EBHgnI2HZA+2TIiWy0WBbgJHjNB9A3g9z0IMs+o1+mRUhsW/
	ekmN2K7KBySTlXaCq9TOy800NSqwbnh5rOFw==
X-Received: by 2002:a05:6122:919:b0:4da:ced8:b09a with SMTP id 71dfb90a1353d-4e4f012a446mr8185068e0c.0.1716769939065;
        Sun, 26 May 2024 17:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs7nbDZzPKDR8YQ/ken2E6Tktob5I8NstUXqMtOMwdBOy840bpEyVP0MAaT8X71zOth52X9A==
X-Received: by 2002:a05:6122:919:b0:4da:ced8:b09a with SMTP id 71dfb90a1353d-4e4f012a446mr8185054e0c.0.1716769938647;
        Sun, 26 May 2024 17:32:18 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcdca88sm257509685a.66.2024.05.26.17.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 17:32:18 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v7 2/3] Documentation: alias: add notes on shell expansion
Date: Mon, 27 May 2024 10:30:48 +1000
Message-ID: <20240527003208.1565249-2-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527003208.1565249-1-iwienand@redhat.com>
References: <20240525234454.1489598-1-iwienand@redhat.com>
 <20240527003208.1565249-1-iwienand@redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing inline shell for shell-expansion aliases (i.e. prefixed
with "!"), there are some caveats around argument parsing to be aware
of.  This series of notes attempts to explain what is happening more
clearly.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 Documentation/config/alias.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 40851ef429..75f9f5e26f 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -27,3 +27,17 @@ it will be treated as a shell command.  For example, defining
   repository, which may not necessarily be the current directory.
 * `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
   from the original current directory. See linkgit:git-rev-parse[1].
+* Shell command aliases always receive any extra arguments provided to
+  the Git command-line as positional arguments.
+** Care should be taken if your shell alias is a "one-liner" script
+   with multiple commands (e.g. in a pipeline), references multiple
+   arguments, or is otherwise not able to handle positional arguments
+   appended via `"$@"`.  For example: `alias.cmd = "!echo $1 | grep
+   $2"` called as `git cmd 1 2` will be executed as 'echo $1 | grep $2
+   1 2', which is not what you want.
+** A convenient way to deal with this is to write your script
+   operations in an inline function that is then called with any
+   arguments from the command-line.  For example `alias.cmd = "!c() {
+   echo $1 | grep $2 ; }; c" will correctly execute the prior example.
+** Setting `GIT_TRACE=1` can help you debug the command being run for
+   your alias.
-- 
2.45.1

