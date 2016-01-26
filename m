From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/6] Split .git/config in multiple worktree setup
Date: Tue, 26 Jan 2016 18:44:39 +0700
Message-ID: <1453808685-21235-1-git-send-email-pclouds@gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, max@max630.net,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 12:45:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO23n-0005J6-8x
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 12:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933922AbcAZLpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 06:45:15 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33511 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003AbcAZLpM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 06:45:12 -0500
Received: by mail-pf0-f195.google.com with SMTP id e65so8225544pfe.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 03:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YMN9HXjJl7qmL4sAPBBjunRZRi0txco0ES5MbsdwgVM=;
        b=JbJ7tzMs9tcin2mfzc9HsyrRvB1cYSWfI0fsKQcd5n5QVUsZgRgpJ7//U0SW3Hu9c/
         cNlytqy5L844vgVpZxhymeHeVk0kg21mRMWB0Wbpkx2IEBiPSVSMhE3ffruBhTtT7U1s
         JFlH6dBULK7G4DDNyk7MJ1eYo3mGF1KwMK80tqBeEVSzyVcAA67BMV50tbmBvB04FXeP
         PP3PMnvtfrmBo/+BQ/6ECOVC0YJ3EV3mraQ81nFeTZ4m6IfCYwB4ojxmUIcKndQFxA0Y
         O4ifUNjkDibtzJyB2RRPXK7t56CyeiYQvUsMNsU4PI54P+pl2a1YwN1p9SWOv0tVWk8k
         io2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=YMN9HXjJl7qmL4sAPBBjunRZRi0txco0ES5MbsdwgVM=;
        b=PPunTgSRqj/rOv3VbARbOea1h0R1yvtcZ+3eTkutrH1eKm0iIZABOb7kMn+chrh6VC
         H+k2xkSQMb1YUWdYGi9s+r+2g4PbcTX8fLo/osMBByylhROBVSYPlvEeG83RgSKstWoE
         Q4C1e1+VigGmxfq6KZkiYcj5UdtkY6CPh8siPIZqbOaWTbzF7uYylupBzySEga8cL2Pd
         3ExfAeO6LeuIQE3JDsDTLJG1mYx7gHa1ihCGl/iFAnzbv+oqLJpKcs+nxS4J8uObSQF0
         4Pnv56BTZ5hDxzBRqH2kNdQZli+1+K095CGaiLIVV0/4JOxbZzpyjtN3QfKc80JMxAtF
         hWPA==
X-Gm-Message-State: AG10YOR0IMBYcpc4nzPmYcxOk7p9znJ0WB9KBCG4APULgXoc5u2BDG/u1NnzdwaMf5Qk7A==
X-Received: by 10.98.16.146 with SMTP id 18mr33168630pfq.122.1453808711849;
        Tue, 26 Jan 2016 03:45:11 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id dg12sm1414308pac.47.2016.01.26.03.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 03:45:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 Jan 2016 18:45:13 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284803>

I've changed my mind. So v3 is not a polished v2. It's quite different.
And I hope it's good different.

In v2, .git/config contains both shared part and the per-worktree part
(for main worktree). It's ugly, slow and hard to work with. v3 adds a
completly new config file for sharing. ".git/config" will not be shared
any more.

=46or any worktree, the new file .git/common/config is read first, then
either .git/config or .git/worktrees/xxx/config is read after. There's
no special per-worktree var list any more. Which is great. You want to
add per-worktree config vars, use "git config --local". You want to
add per-repo config vars, use (new) "git config --repo". You put a
variable in a wrong file, you're punished for it (and it's the same
today, say if you put core.worktree to /etc/gitconfig).

The only ugly part I see is how to deal with released git binaries,
how to make it reject the new config split (because otherwise it would
read incorrectly).

A lot more explanation is in patch 04/06. The series is also
available at https://github.com/pclouds/git/tree/worktree-config

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  worktree: new repo extension to manage worktree behaviors
  path.c: new (identical) list for worktree v1
  worktree: share .git/common in v1
  worktree: new config file hierarchy
  config: select .git/common/config with --repo
  worktree add: switch to worktree version 1

 Documentation/config.txt                       |   5 +-
 Documentation/git-config.txt                   |  14 +++-
 Documentation/git-worktree.txt                 |  31 +++++++-
 Documentation/gitrepository-layout.txt         |  12 +++
 Documentation/technical/repository-version.txt |   6 ++
 builtin/config.c                               |  19 +++--
 builtin/worktree.c                             |  95 +++++++++++++++++=
+++++
 cache.h                                        |   5 +-
 config.c                                       |  14 +++-
 environment.c                                  |   1 +
 path.c                                         |  40 +++++++++-
 setup.c                                        |  40 ++++++++--
 t/t2028-worktree-config.sh (new +x)            | 104 +++++++++++++++++=
++++++++
 13 files changed, 364 insertions(+), 22 deletions(-)
 create mode 100755 t/t2028-worktree-config.sh

--=20
2.7.0.288.g1d8ad15
