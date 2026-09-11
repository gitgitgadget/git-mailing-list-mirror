Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA34756D6
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130006; cv=none; b=cZs9of9wjyGVYJd65vaNIvw0NqO4qQKmbOsMPBw2qxNhAmDAGbMn5bZJnEgnOkEjr3NXs/qv8ByQPF/QYT1An69TpKbv7aS/+58Ui2dDiWsV/trRZA8AMKWsoo6GcHYUZa/4IfwceoQ3QbKD9VVEAJZ2i2+yTfYUZc0rzRJOiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130006; c=relaxed/simple;
	bh=tRt7UZUHzQr1YPhJsPLRNB4+SUVnCbfSn78swnpV6Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxvfhX3Nv1cmCqO+r2pkcEfRl9MwqH5T+U6JMBqCGSOP5Y3BHhYoLFJoR6kbpAIlNaA/rH5p5q3kX/PLN4quFmI3DK7XX0OEsaHE0Y/yxcz3imYY4+wjsr17SfDIQojd9kcJbQZUVt9sR3BRNUa4qM9udfA5z4w6VK1O6IkfplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZa6QFuz; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZa6QFuz"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8565d77c277so8279187b3.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789130001; x=1789734801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q9L57N96J4fa/btcOFgL1Mpnfv4QjrW5SmamYwrYwgI=;
        b=eZa6QFuzUXSYAOCzKjBowgZeyGl68OurF2SxZZ/S3wev6UVDqdz8mFu3NbdVMTS8PY
         ois2HTSngGBE96R6l283XNRsUF3AtnL2mZYmjt3pAG/jQC+LEn/6OH+o9w0SjsWt64IR
         Xa/uep+FaNqTQYUoNbgw5idmKiPiiY5QW9Q1QJGK4T+MT52fh0bmcDuxV5YwFPOnQpbV
         tsJj2RMPDTXSvVY5YKpBy+Qg5LejXcT8yjm3eFXy7x1qJOOLr8oz/+Z+trhLjhk0vd7o
         XoIvr2b+YY7KsadmCRNyLPs3HlOBPRDEj5Mh3JAfvhyfTbOIM/hlXr2bfCjmfWd/c4gE
         nnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130001; x=1789734801;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9L57N96J4fa/btcOFgL1Mpnfv4QjrW5SmamYwrYwgI=;
        b=Jc8ulmqPB+9xfZEe3puJkn9wKKRLtTbYcfsDb41o3BM1fWgTLrMlaBHIoQTn35SuVz
         e+DJVs8pENfj8R0Y6hyMeV8K3JZoqZt665HHz89etBLoKIRz0Euxi9QVzywUcI5NLEvd
         G9UGEGMYL8Roqbz2gzf9ezFyxhG1UbIK7iRgYNxJATaEzYXEDj+GPf/8b6670GT0rM/u
         oiMAEvTZb4wLCzyjdT4AWV06akyl+Asu0alI6B54nHe/DYZlsklbUKR9G6Qnjb+R7F3u
         ib6gMd1NXsELGqmiKUf8oviTOS93ksPGyDWjCjhQD7IjeW8wh71MXMuW0ur+DPSrmghN
         ULyg==
X-Gm-Message-State: AFuF++mpSulEQKkCue4mdG/Lohd48nDIrfTWtgplYzR33fc+uIDeaRPN
	v/3iL/yQgbcyyWhztl8PRWpQMXy3y07DY+fL6wtBZG4JyGg/Ekym4KTp/P3iKQ==
X-Gm-Gg: AYBFou2sLGY/LfsbvQGtCh2SJ541+jI3jhshLYzdtE/wF7sQfrDkA2vK18ysdpFHtK+
	Sep2Hgz1vjt7U6i0fnx+swp23Ei76jfTCj1ppxzzMK2980e4M+Isoy2lPBEZjT9o0exC44xEACk
	GNUzfaK78qzNqEgyS/qrJeq82rEbRtXHObadWF02y/g+PqTx2tjZWf/Zf2CYaR9O5n7d1oXiD0L
	ETyfSgzoNHSID41jPjWPmnVlDEECReKPwf6z4XP5A7n71mm4GNGb9jZsZVA7a00lX1rem3DnLQU
	cxFFfC2rQOXoLJOZaY3xZF9EsjSAi5n4UzWN83MMqazPs/Q1OG/bShgd34BgE4gLzV9PwkfGJYh
	FQtxYveN+dpLkv3hAD1l7VUk015J0mKstz2ezvC2fMAfLtLarhtg+jmKGJLVHOrQDtwfKja12ug
	NlrgMFYZ6QtRS4yfqx+IEF3vQD1whvi9L+67CndBk5i2NZEExTQx661gBhp+DQ+pjf4U4RtNkPB
	4/kYqTfT3ty3ArmevXi6UV6G6B3R6XnbOUhF3E4VnxJspvEt54R7Et2uq0GbPy+dG+D84H23Yju
	A4uYNbgcilEHHJLpkgSywQ==
X-Received: by 2002:a05:690c:6607:b0:873:5c6b:a2ff with SMTP id 00721157ae682-884b2bce41emr13281567b3.45.1789130001316;
        Fri, 11 Sep 2026 05:33:21 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8848701e82fsm9785247b3.22.2026.09.11.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:33:20 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 1/3] meson: expose knob for xmlto relative links in manuals
Date: Fri, 11 Sep 2026 08:32:27 -0400
Message-ID: <d612de6c2de615f368b5985f200c5ea8e3116c08.1789129924.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699.dirty
In-Reply-To: <cover.1789129924.git.ben.knoble@gmail.com>
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1789129924.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Makefile-based builds have had this knob for most of the project's life,
since a479a564dc (Documentation/Makefile: allow
man.base.url.for.relative.link to be set from Make, 2009-12-03).

Meson, however, hard-codes the equivalent of $prefix/$mandir, which is
not really where all the HTML docs are stored in most distro builds.
Plus, this value is missing a trailing slash, so links come out broken,
like this in git.1:

        1. Git User’s Manual
           /usr/share/manuser-manual.html

Of course we can do better:

1. Change the default to match Make: use file://$(htmldir)/ (with
   trailing slash!) to form a local URL pointing at the HTML docs. This
   is safe because all current uses of link:<relative> point at HTML
   docs:

      git grep 'link:[[:alnum:]]' Documentation | grep -ve html -e http

   produces only a single result (Documentation/howto/howto-index.sh)
   which can be ignored. Since nothing else [*] in the normal build sets
   MAN_BASE_URL, this seems like the right default.

2. Provide a configurable knob, just like the Makefile, so distributions
   that build with Meson (like Gentoo) can decide where to make the
   links if they need to. Those that set htmldir probably won't need to
   tweak this any further, though.

[*]: Well, Git's todo branch has a script dodoc.sh to build and archive
     docs for kernel.org; these docs are pulled by Homebrew
     installations, for example. It sets MAN_BASE_URL to "git_htmldocs",
     so the equivalent note on macOS + Homebrew is

        1. Git User’s Manual
           git-htmldocs/user-manual.html

     which is not functional either, but that's a problem for
     downstream. In any case, users can recover the right path with
     "git --html-path".

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---

Notes (benknoble/commits):
    This patch is mostly because I noticed the link I added in a later patch
    didn't come out right.
    
    I did an internet search for "MAN_BASE_URL" and got no real hits, so I'm
    not sure if any distros today actually use it, but that's not a proper
    audit in that I didn't look at any distro _code_ besides Gentoo (which,
    as noted, uses Meson).

 Documentation/meson.build | 7 ++++++-
 meson_options.txt         | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..cfa9c67609 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -379,13 +379,18 @@ foreach manpage, category : manpages
       output: fs.stem(manpage) + '.xml',
     )
 
+    man_base_url = 'file://' + htmldir + '/'
+    if get_option('man_base_url') != ''
+      man_base_url = get_option('man_base_url')
+    endif
+
     doc_targets += custom_target(
       command: [
         xmlto,
         '-m', '@INPUT0@',
         '-m', '@INPUT1@',
         '--stringparam',
-        'man.base.url.for.relative.links=' + get_option('prefix') / get_option('mandir'),
+        'man.base.url.for.relative.links=' + man_base_url,
         'man',
         manpage_xml_target,
         '-o',
diff --git a/meson_options.txt b/meson_options.txt
index dc88f130d7..d590c21648 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -111,6 +111,8 @@ option('default_help_format', type: 'combo', choices: ['man', 'html', 'platform'
   description: 'Default format used when executing git-help(1).')
 option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto'], value: 'auto',
   description: 'Which backend to use to generate documentation.')
+option('man_base_url', type: 'string', value: '',
+  description: 'The base URL to use for relative links in manuals')
 
 # Testing.
 option('benchmarks', type: 'feature', value: 'auto',
-- 
2.55.0.1003.g10538fe699.dirty

