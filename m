From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 00/17] Port branch.c to use ref-filter's printing options
Date: Sun, 15 May 2016 16:15:16 +0530
Message-ID: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:45:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tYP-0003Ln-A2
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbcEOKpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:45:35 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34901 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbcEOKpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:45:34 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so14275801pac.2
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=n2k9RTQKAXiTCA+ZxdHl9aL2s6ib5y1mdhZgpMMfgdM=;
        b=N92JkQ/BXp1D+2zojZfAANNHyy0pgHWZ2xetdPGPNezc36bpFL2Xlj8pTsCwJeUIn5
         uxb0g/0xKwbjlNdRENrfA5JpGRtGreS2nx2gFwlRilSUzTVNvRJ+03ssHr6mXFemBkif
         kt4RphSFiiu1vE9mHOR2Bu4XATBKx7ym9r1pNn3TymVJ/D94GunkoL1ZxRiFmCbP1T/7
         83gSgaM68v4Na0nUQkWHO70T3hw9+pvsGlROT8Tc890ax2Syb2+1fShloTinugAKUyCy
         wt4Gub6Ayy7L5e3i0TnCbjJh7mOwStWWLaI5TtA6L1BGEgmCeFAmHbLM6XRKrNo1q1Vm
         7UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n2k9RTQKAXiTCA+ZxdHl9aL2s6ib5y1mdhZgpMMfgdM=;
        b=V+Pd9vrtXItgASe1oF/ufgFCTlnmYmjzm/Li3ZQlv7/wQM30VadBS18VsuQHtab2vd
         gY3OM/d5pxIgTt05AuW12Dmo+xPMUjMW86MDsUD1+wrRPlFlUiUONWzjlWcBq6ic0Hsk
         UJKhRfnl+2LW3WaqqA6KoIQsRT4+oMTOWFIWNufegL4FSt2NtTIQFZX0x4KX0qzGwNlS
         2uQzKcAtua1Yq5dieXOEX42VqXNYsMXuVM+P2uxeZ1b2+MzjazgkTA0WyVL0v1cDWag6
         /+mbAaX8s+Lklg7lUNiUGu7w0U2UvEJ3Dm1UOO1e9LgGeJH0odSvxKRMgHDygJ4JagI5
         V+wg==
X-Gm-Message-State: AOPr4FW6LdQFYC/eEB5uEDKpELjfROoMovEBrFHF8kXhNKcUBYiGlsiB3uDWV4fFn1owPw==
X-Received: by 10.66.221.167 with SMTP id qf7mr36717998pac.94.1463309133343;
        Sun, 15 May 2016 03:45:33 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:45:32 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294650>

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

v1 can be found here: $(gmane/288342)
v2 can be found here: $(gmane/288863)
v3 can be found here: $(gmane/290299)
v4 can be found here: $(gmane/291106)
v5b can be found here: $(gmane/292467)

Changes in this version:

1. Rebased on top of f307218 (t6302: simplify non-gpg cases). This
patch ensures that we only use signed tags when GPG is installed and
effectively gets rid of the bug introduced by 01/17 (ref-filter:
implement %(if), %(then), and %(else) atoms)[1].

[1]: $(gmane/293901)

Karthik Nayak (17):
  ref-filter: implement %(if), %(then), and %(else) atoms
  ref-filter: include reference to 'used_atom' within 'atom_value'
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: move get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  ref-filter: add support for %(upstream:track,nobracket)
  ref-filter: make "%(symref)" atom work with the ':short' modifier
  ref-filter: introduce refname_atom_parser_internal()
  ref-filter: introduce symref_atom_parser() and refname_atom_parser()
  ref-filter: make remote_ref_atom_parser() use
    refname_atom_parser_internal()
  ref-filter: add `:dir` and `:base` options for ref printing atoms
  ref-filter: allow porcelain to translate messages in the output
  branch, tag: use porcelain output
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  87 +++++--
 builtin/branch.c                   | 277 +++++++---------------
 builtin/tag.c                      |   2 +
 ref-filter.c                       | 456 +++++++++++++++++++++++++++++++------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  16 +-
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  73 +++++-
 t/t6302-for-each-ref-filter.sh     |  94 ++++++++
 10 files changed, 726 insertions(+), 295 deletions(-)

-- 
2.8.2
