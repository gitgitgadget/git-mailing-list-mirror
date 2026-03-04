Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB33E0C50
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648273; cv=none; b=vCa61ktVDLC+hJrc7cqnx0xaq+HvJfL9BRDwMqZnuQJP5RMuBY2M3u9/gOL2Spr+/Zj/6A2LEFmlZ+/UkIVJvRLILHJGVqX7s6GxxTGvBRqd7pUVbJCR9Nhtv4vSfv7xbrKDot3eRcyzlQ0IQ4db4KQgfa9VrWC9POqLNCJQ1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648273; c=relaxed/simple;
	bh=bvP5m1nHMW/gsX3A0puzPdmxNJFzZiURsX6Gun+GXo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8C1zgmqSmKo5dVqz8Tn6CF2xYrvR6p/jcGWqOQ5WQkqIlY0wnqpuch/L+rn1SV8YVlJCWJWm8nlG8g+FluPweUD1gUSPXZ/eLyBVWeRsfgKYLFkU1AM172BAT0e3Tx4MkXNGIlx0fcgVTWWm4WJY0LGik9nLAmavI8TvBWMzYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGeBUsOr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGeBUsOr"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82735a41985so4265833b3a.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648272; x=1773253072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1coggGjAP7Flk6Wc5s9cQMTiCh+vhBPsn7PmSpLJwg=;
        b=XGeBUsOryoVgpVbnHk8mZ2qkUc10B8ZIuB9WVCqRLttHlW3UBbdwyViAT3AdsAjLxE
         13MGb0nLpptjrwRwpO/eaxp3n1P/O99EYQR3rw1f0wROTz/Y0SiN54XJSkou9MwYs28g
         GTiIkIqFJ0l++NtJrX5Cc6HI5mamA+0A5GO9VIC6dJllf2uOxp5oEGPqyO4vKbE/Ljpw
         gaBgopU3WUWR6KVKRVCchE5EZSslOv6RkkFENj2U6dkhQQ5QOjFc9NocZHqPKdf7avfU
         zrm8sa0RNiVrdI5uFM4B53J0RnJD1dhmQqpqX3KARKPsshTgPbeiWJrK58SW5bk3xXpF
         8shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648272; x=1773253072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1coggGjAP7Flk6Wc5s9cQMTiCh+vhBPsn7PmSpLJwg=;
        b=Rd1eqxkDFzHBtXsGKKfcJudOtIkblpr9WSge1cpkTxaIU3XvXDyHB9a3LRBZ+ahiZr
         YZjpmcsn2ntHfGOQtYEm8lYNn8JvHLboK2B930UOgGrl51pzUZIdwNK6Pw92fEB+FvoO
         4aVcWsnaXIQIBhmTN4crJ/QN7M9ZhCH0Sw+zHo9+sinmyU7qRoMIrQf5lAreL6qYXcvL
         50ZQw1h97okNxi6FHMCM3n4SiR0Q0JjHVihu9V+yeBETamLvJeclnzsXSb7larD4MEFa
         vPhxQeH2X2+r/Et68IqxLRfTVOME28JHiC1Lcjfjd6H2j+dHf+NsHElqRuajJvLXDcNG
         l++Q==
X-Gm-Message-State: AOJu0YxDHz9OZ6p2e+Pph67KB6UCOAeEWUhUff4146JM9vSaEVKuxmiW
	8zxh0z5D+9N2s5xV+HbEMGRuR13rDWYwJeMhAELImq4e15tPpSh9HOhaoO+zBA==
X-Gm-Gg: ATEYQzz++Ju5zZaEOicW600fxae63rYP6Ni9O//+extzjJXwxqS9ocJQz5LeECDzkA7
	0Kh3hpFfMBpyXhyZy0fdGMQRGWn35/wfyeluMZOSiO2hGX+k0RvgR5eyPmIYvtyD7Xm8CX1dX0q
	a4jvUz3jVTeCqtj292/WFRaVmdlNUCIZCYLbM1N2AAhzMLbObeUVzIr6Ibxvxk251JTiWigQ5KE
	Onnst7gDSxEkBaxnV5XwXkHvfE/J5RP0fu+253nl4AsflSNrytT+T6BYSOpEPf0DvwDTzyrgGrK
	sjNFn0TSnvzkJiBe+IxldYCbg0IYWDsstjaadPsmQWtVWcX+bMENtf+tdVOnrR4pYh27EMMTWxr
	k/CkVwy9B27q9TN/5AVfm8sAPSJNOD9N/25vqB0/bU7t6h7v6kkdcy8EKOY91S5EhjWxkcCqk1C
	Br+SFadiKwBl/eSW8erxMwLm0qCctE48roL6/wmeg3rb2oCqkK1YdYuG0oXr6U1tw/1cM8VQ1Uy
	h5d64mnhQ==
X-Received: by 2002:a05:6a00:460a:b0:81d:d666:72e1 with SMTP id d2e1a72fcca58-8297292e7a2mr2228290b3a.10.1772648272032;
        Wed, 04 Mar 2026 10:17:52 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8297af34b66sm1340515b3a.20.2026.03.04.10.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:17:51 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v7 07/10] fsmonitor: implement filesystem change listener for Linux
Date: Wed,  4 Mar 2026 11:17:50 -0700
Message-ID: <20260304181750.25730-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aafii97SoHS96rkA@pks.im>
References: <aafii97SoHS96rkA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Patrick Steinhardt wrote:
> I saw that this define is only wired up for CMake. I guess we should
> also add it to our Makefile (probably via config.mak.uname) and Meson
> (probably via compiler.has_header()).

It's already wired up in all three:

  - config.mak.uname line 78: BASIC_CFLAGS += -DHAVE_LINUX_MAGIC_H
  - meson.build: compiler.has_header('linux/magic.h') check
  - CMakeLists.txt: add_compile_definitions(HAVE_LINUX_MAGIC_H)

While looking at CMakeLists.txt I noticed the GIT-BUILD-OPTIONS
string replacements were hardcoded to "win32" for both
FSMONITOR_DAEMON_BACKEND and FSMONITOR_OS_SETTINGS. Fixed that to
use the CMake variables so Linux/macOS builds get the right values.

> This selection looks rather interesting to me. Why wouldn't we include
> common filesystems like ext4 and the like? Certainly hints that the
> function needs better documentation, and potentially a better name.

It's only used as a fallback when /proc/mounts isn't available. Since
we only care about naming the remote/special filesystems that
is_remote_fs() flags as incompatible, there's no need for ext4 etc.
Updated the comment in v8 to make this clearer. Also removed
V9FS_MAGIC from this function since 9p is used for local VM/container
host mounts where fsmonitor works fine, and it's not in is_remote_fs().

> Sorry, but I still don't quite understand what we're doing here. Isn't
> the longest matching mount point always the one that statfs(3p) gave us?
> Why do we have to scan "/proc/mounts"?

statfs(2) gives us f_type (magic number) and f_fsid but not the
human-readable filesystem type string. We need the type name (e.g.
"nfs", "cifs") for the fs_info.typename field, which check_uds_volume()
compares against strings like "msdos" and "ntfs". /proc/mounts has that
string, and we match on f_fsid to find the right entry.

Also fixed a redundant statfs() call: find_mount() was calling
statfs(path, ...) again even though the caller already had the result.
Changed it to take a const pointer to the caller's statfs instead.
