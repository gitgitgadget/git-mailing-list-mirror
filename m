Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE43385A3
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614880; cv=none; b=jkoWc9OguToD8l5wk2DdDQ2Dry/ErKc6TkaaPbZV60UKD+qn3DoecTFzT780rLBQmGGCmZCmrw9aSjtgJXMTpQtWhPnfpyiwUcJAhvRsc1NMtu4WBnFFP1VpEIXN+NvaCWLeYIoZ5f2b482PQWbLDfZgpx96jwtspLKm9yPYnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614880; c=relaxed/simple;
	bh=Kf7ltu7to/CAyJ6f6GqxTjAXtb+fXgzXv3o22g0kRn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvmNvWkjNKr9xcsyrrH5+PCcKqDZx7ZYif4luj32OXenwnOv97BUo5aS8m3ng1fX7GQNhNzxw93smy4ALF1YwXp/+dkQWg47rM1WRtIFFxCfPntmZI/4kEli8u8F7bfeKt1pVzpHchaJYrazTEg2ABNRty3ysx0M55dlnjHOUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O1kcM+Ga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZI26StN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O1kcM+Ga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZI26StN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE9217A0121;
	Mon,  5 Jan 2026 07:07:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 07:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767614876; x=1767701276; bh=xympUOIi1b
	H2hJU9QKjQPxhkaowXi2uPuw+3c3nLOWA=; b=O1kcM+GaTnQ+vup70t+QKjw8TC
	c4xoN88d0evcVTFAN0uWU977cYrKF4CuriZi4v7LcwB3uctZZdKrd/41e+nJn/Rz
	3QWNUIX7YoZTbK2ExCwgIWG4k7Uv+ryuSW/l2/30mB3yXYHwF6knbCbMn+RzGALP
	WQR+XhJ/452y1MBZ2tQKy0GM8Yxhw0vPwt+UGm9iLeYUYaZt4RU5ZYJvCPglko8k
	EQIcdOrRPoLoeQd9DLOgrcrDUQTLrKSg74Zh+RkTEd+WRD7wtUQBWED0xTd9m9Z7
	U7XmYGv12k5l/HHeS9BFlaQNT3KNtbf8WoTL4iF8t6b+rLGvEiyVMqO4Ej4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767614876; x=1767701276; bh=xympUOIi1bH2hJU9QKjQPxhkaowXi2uPuw+
	3c3nLOWA=; b=nZI26StNxM8s6BREkikVqxFktcYk4lALqDlF0CqEwmuRSWkhmT2
	RV0Z/ahcUDItuZ0rS8ZMa5Qg+FLNfJnNkQVxDB5GZWW5sw5wB3o71TaH5FifcfJv
	H9rn4rKg8/pcq/FDJvTcRPK9hm1btDBzIk81wt+zeNd3uOv4j1PXsn7E2pfIL+ok
	ualzJGEKryRC++O8sdqo2KWi99+kH9Msu22eZbLGt7ur6TJRuIj9WdD1wXj3ErXT
	9+hPrGnkXZr8LkjBFzGZusBmSBR+e/1EW2AFkKqg4Fty6qpX7pcJn+p3G0IG7HmX
	+8jfIERXYmdEfdARhaqR0hDiIA7xdJgx7Mg==
X-ME-Sender: <xms:nKlbad9sAqK5paLXuwZNYRRL079ZnUvaMgyoEH2fzezs3JPGgCDQNA>
    <xme:nKlbaZKsPpoU-tTciunBgYhEVYLDBNAmwIGJ1WuofNaUJugLVU1z3zDJlkFs5MA_1
    0eW81U0PHdSBUEF93HNe1C6hKdMTjj3xLjwqQlo4KD1BpiAgaG1Pw>
X-ME-Received: <xmr:nKlbaYau0OJpci9Ry1XdFz_heSfrJ2TXf-BJfbRP2xKZcpuibvojS0tfFaE2JXYGgi1oEDc98p_AU0fcprEYh7jK36XfQ0QOwfDbB0k3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhthh
    husgesphgruhhlihhsrghgvggvkhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nKlbabI2-Q9_KrOQNdkQJqYYpHbkh8wDvzvbLaWQct_CXLQiRMZNdQ>
    <xmx:nKlbaWCxueboB2cBY71yetJycrFmVc1-Xq8Ariwz6HPtEHUAPNQQcA>
    <xmx:nKlbaQpHfuHfXaAHWo_cISzbGyGx9MasbA8Ny6r3uvsFZiiga3m9Ug>
    <xmx:nKlbaRhFog1sTb2HSDAhzBVBbo2Bn3gujuyBLreALzD8d_y5dmns9g>
    <xmx:nKlbacmUReUwXpqmRy2X3MOo0S-5u7AP1B3GsFVYWFrqQLzwiPBAm8ok>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 07:07:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f95ffecc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 12:07:54 +0000 (UTC)
Date: Mon, 5 Jan 2026 13:07:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v4] fsmonitor: implement filesystem change listener for
 Linux
Message-ID: <aVuplzNaoCHlZG3S@pks.im>
References: <pull.2147.v3.git.git.1767099302592.gitgitgadget@gmail.com>
 <pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>

On Wed, Dec 31, 2025 at 05:41:34PM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> Implement fsmonitor for Linux using the inotify API, bringing it to
> feature parity with existing Windows and macOS implementations.
> 
> The Linux implementation uses inotify to monitor filesystem events.
> Unlike macOS's FSEvents which can watch a single root directory,
> inotify requires registering watches on every directory of interest.
> The implementation carefully handles directory renames and moves
> using inotify's cookie mechanism to track IN_MOVED_FROM/IN_MOVED_TO
> event pairs.
> 
> Key implementation details:
> - Uses inotify_init1(O_NONBLOCK) for non-blocking event monitoring
> - Maintains bidirectional hashmaps between watch descriptors and paths
>   for efficient event processing
> - Handles directory creation, deletion, and renames dynamically
> - Detects remote filesystems (NFS, CIFS, SMB, etc.) via statfs()
> - Falls back to $HOME/.git-fsmonitor-* for socket when .git is remote
> - Creates batches lazily (only for actual file events, not cookies)
>   to avoid spurious sequence number increments
> 
> Build configuration:
> - Enabled via FSMONITOR_DAEMON_BACKEND=linux and FSMONITOR_OS_SETTINGS=linux
> - Requires NO_PTHREADS and NO_UNIX_SOCKETS to be unset
> - Adds HAVE_LINUX_MAGIC_H for filesystem type detection

This would also need the below patch to support Meson. Would be great if
you include it, otherwise I can send it as a separate patch once this
topic lands. Thanks!

Patrick

-- >8 --

diff --git a/meson.build b/meson.build
index dd52efd1c8..0130d40702 100644
--- a/meson.build
+++ b/meson.build
@@ -1322,6 +1322,9 @@ endif
 fsmonitor_backend = ''
 if host_machine.system() == 'windows'
   fsmonitor_backend = 'win32'
+elif host_machine.system() == 'linux' and threads.found() and compiler.has_header('linux/magic.h')
+  fsmonitor_backend = 'linux'
+  libgit_c_args += '-DHAVE_LINUX_MAGIC_H'
 elif host_machine.system() == 'darwin'
   fsmonitor_backend = 'darwin'
   libgit_dependencies += dependency('CoreServices')
