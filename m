From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 00/10] ref-filter: use parsing functions
Date: Thu, 12 Nov 2015 01:14:26 +0530
Message-ID: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbJh-0005ub-1P
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbbKKToV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:21 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33343 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbbKKToU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:20 -0500
Received: by padfb7 with SMTP id fb7so5385470pad.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tTy5/iinfFBJpNQHUIQUdHwRfZIdiqCpgR4jG1jp1ZM=;
        b=TCza7BqhBzEpd6Go0DbiOwuCiVsE7MriWb0FLnIcpPHdQ8K5wQlGQXQVRjrIKFNPrU
         dhVgLwrjohcqyun5Kf36q9KlHehJQ3mLWTtq2SwI0c46fpW418t0o4Tx0C65MFm5qpOs
         Z4K0va2YCRsNUcSX+qSab77dB2Q/uuWNzqu1yBi/xFQLErlZ6JRJq7t+50MZm++Gjt7u
         R2kGUPe1bCw1HN2Ek7o9FKZEX8mx82tfNJdiGLuHb8T1c/Vh8/9LHWMf2+PtauNbUwlm
         kVFiR7hd6ao/jwHpOWAGds6HijnaMmLyo+XQXb4F9lok3ckQPUNdVhfkms5pKpq+BihR
         YHiQ==
X-Received: by 10.66.234.101 with SMTP id ud5mr17018499pac.136.1447271060010;
        Wed, 11 Nov 2015 11:44:20 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:18 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281180>

Carried over
http://thread.gmane.org/gmane.comp.version-control.git/279226/focus=279352. Where
we were talking about pre-parsing most of the atoms so that we do not
have to parse them in ref-filter:populate_value(), where we could now
instead only fill in necessary values. This series aims to introduce
parsing functions for atoms so that they maybe parsed before hand and
the necessary values maybe stored the introduce used_atom structure.

Karthik Nayak (10):
  ref-filter: introduce a parsing function for each atom in valid_atom
  ref-filter: introduce struct used_atom
  ref-fitler: bump match_atom() name to the top
  ref-filter: skip deref specifier in match_atom_name()
  ref-filter: introduce color_atom_parser()
  strbuf: introduce strbuf_split_str_without_term()
  ref-filter: introduce align_atom_parser()
  ref-filter: introduce remote_ref_atom_parser()
  ref-filter: introduce contents_atom_parser()
  ref-filter: introduce objectname_atom_parser()

 Documentation/git-for-each-ref.txt |  18 +-
 ref-filter.c                       | 483 ++++++++++++++++++++++---------------
 strbuf.c                           |  17 +-
 strbuf.h                           |  14 +-
 t/t6302-for-each-ref-filter.sh     |   4 +-
 5 files changed, 328 insertions(+), 208 deletions(-)

-- 
2.6.2
