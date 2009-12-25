From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/4] clone: use --progress to mean -v
Date: Sat, 26 Dec 2009 01:12:02 +0800
Message-ID: <1261761126-5784-1-git-send-email-rctay89@gmail.com>
References: <18831.46833.862.196815@hungover.brentg.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 25 18:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NODiG-0002S5-Ba
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 18:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347AbZLYRMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 12:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbZLYRMX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 12:12:23 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:34685 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255AbZLYRMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 12:12:22 -0500
Received: by ywh6 with SMTP id 6so9018585ywh.4
        for <git@vger.kernel.org>; Fri, 25 Dec 2009 09:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:references;
        bh=KtGR818TM5EajgBvVPshCxePOAd92EkA5cO+amP9NtE=;
        b=s9xjtao6TsQhCESpHWH+Q2WWaPOKC5tpL+dz45NsAvX1NCYew0ksKzxJGKmqNJF1xa
         6pQD/Pi5jT0+MVP9u4RXNbnU5erZL4TGCBnvKdvtPDRMGUqKeB7OiLbdOuj6kWJFAp7E
         Z7RcupNpq0GYalbLdKPKDyCUe2hh8oAwkk0Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:references;
        b=bwsmKzthQHQr//T1gfN3gotLEfE6YRjOlCT77MeOz41nu8/0DOPjS8UqyvlCj0BwqF
         DDS7eoJoQh+Ih9UZpcp1x+zKrNVURbewTG5BPutRflE8Rqnd/zghjl+P6Na6jBmY4vV3
         3u9KBEqDXogpZ4L287Ffnu5iD1JlpDTG6Rp94=
Received: by 10.91.151.14 with SMTP id d14mr4876184ago.20.1261761141278;
        Fri, 25 Dec 2009 09:12:21 -0800 (PST)
Received: from localhost.localdomain (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 14sm4629570gxk.2.2009.12.25.09.12.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Dec 2009 09:12:20 -0800 (PST)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135676>

This series makes git-clone follow the "argument convention" of
git-pack-objects, where the option --progress is used to force
reporting of reporting. This was previously done with -v/--verbose.

This in effect ensures a single consistent convention regarding
progress reporting for git commands. Having two conventions may
potentially confuse users.

On a related note, Brent wrote a patch a while back [1]. This series is
not as ambitious his and does not deal with the main git options. In
fact, only the last patch effects the titular change. If a consensus is
reached on this though, I don't rule out a separate patch/series to
set the convention at the main git level.

PS. If someone can enlighten me on the proper noun for the git
    executable (I said "main git"), I would be very thankful.

PPS. Merry Christmas and happy holidays. :)

Tay Ray Chuan (4):
  check stderr with isatty() instead of stdout when deciding to show
    progress
  git-clone.txt: reword description of progress behaviour
  clone: set transport->verbose when -v/--verbose is used
  clone: use --progress to force progress reporting

 Documentation/git-clone.txt |   12 +++++++++---
 builtin-clone.c             |    6 ++++++
 t/t5702-clone-options.sh    |    3 ++-
 transport-helper.c          |    2 +-
 transport.c                 |    2 +-
 transport.h                 |    2 +-
 6 files changed, 20 insertions(+), 7 deletions(-)

Footnotes:
[1] http://marc.info/?l=git&m=123415527432713

--
Cheers,
Ray Chuan
