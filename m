From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v3 0/7] diff stat calculation adjustments
Date: Mon, 16 Apr 2012 03:44:48 -0700
Message-ID: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucian Poston <lucian.poston@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 12:46:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjRr-0008Cj-0S
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab2DPKqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 06:46:12 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:58989 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab2DPKqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:46:09 -0400
Received: by dake40 with SMTP id e40so6754418dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=brB9jKRGh7Wdul/lqqrO1W1GkvEtFguMXHkDeXoB8dY=;
        b=WLfBajJeIh3c7HECPa6julVFq7YIz1HLRMvLil9RCS9qLeDrg7oECxFYxpaFyHcalt
         2laiWaVlYjTFyAlwfYbdZCgIG+pm/Xt7rVfh5WA76d87xL4zi5wCr0yiRtdrgcYxa0o4
         0Jt5S0crquuj4eWn1f2sEP1VcM0+HpYRvmpZHjhKLVSV0fttCaVTihB0V27vRlAMUD/M
         3r7s9jcXl4nKTLX/PKwtkXTfcCUlPm/kdOCDoVucJQDceshsw8JGeeb20eyKeYWZhIWc
         LPg69nd4kAXCRZAZXjkEqR/nzTCiyhtN4uHA5HBu78Aic8G0t+SYJ6d0bWdN5JfvO7f2
         G8RQ==
Received: by 10.68.220.65 with SMTP id pu1mr27711497pbc.32.1334573165540;
        Mon, 16 Apr 2012 03:46:05 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id oh2sm10793051pbb.45.2012.04.16.03.46.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 03:46:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195611>

I broke the patch series up into smaller patches. Hopefully this makes =
the
intent of the changes easier to follow.

Zbigniew's tests were added as PATCH 1/7.

The order of the options->stat_graph_width test was reverted back to th=
e
original order as per Zbigniew's feedback. There remains an issue where
name_width (or graph_width) could be set to a value greater than
stat_name_width (or stat_graph_width). This patch doesn't address the i=
ssue --
v2 had a partial fix, but it resulted in other problems anyway.

Lucian Poston (6):
  Add output_prefix_length to diff_options
  Adjust stat width calculations to take --graph output into account
  t4052: Adjust --graph --stat output for prefixes
  t4052: Add tests to illustrate issues with restrictive COLUMNS
  Prevent graph_width of stat width from falling below min
  t4052: Adjust --stat output for minimum graph_width

Zbigniew J=C4=99drzejewski-Szmek (1):
  t4052: test --stat output with --graph

 diff.c                 |    8 ++-
 diff.h                 |    1 +
 graph.c                |    3 +
 t/t4052-stat-output.sh |  122 ++++++++++++++++++++++++++++++++++++++++=
++++++--
 4 files changed, 128 insertions(+), 6 deletions(-)

--=20
1.7.3.4
