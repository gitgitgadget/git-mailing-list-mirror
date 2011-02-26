From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PULL svn-fe] fast-import 'ls', line-buffer changes
Date: Sat, 26 Feb 2011 05:44:42 -0600
Message-ID: <20110226114435.GB12231@elie>
References: <20101224080505.GA29681@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 12:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtIa0-0002R2-UL
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 12:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab1BZLov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 06:44:51 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52469 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab1BZLou (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 06:44:50 -0500
Received: by vxi39 with SMTP id 39so2072895vxi.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 03:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4v8dGxQAgDbncJeLM/j2sha3d7t1VfYZRDPzlJCv7rU=;
        b=fbFBC0Bn4oaPdAQueN45H9m1DX7yx0861tlfizsORbGPUtattoRAYkvCiHpGmdSSRn
         t73pfxaRRubFQ+B7vws4ZxtRN5C3/1KvO4Kz+3WnxRagwjrQ/JPgbiI8r+56CzpExwlq
         lSZk7DRSyAzGZfACiKBX08M3wMzex8TZoQZP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IooeZJH5C4WRDStYweoZPhFcGeeiN4cnNfOMJkCxk8kBmYQOkHL89KDCaDTM/lPX71
         X7OhRIbFrLI51syR1GEDTkndp/oAtRsB4UJDLn+m48n6GPTyBqPE7x6BJHme4YyXtQSb
         5sJQ9YvNgg8qlhoJpNDjzou5bcfYawZzUuzQQ=
Received: by 10.52.171.170 with SMTP id av10mr127626vdc.256.1298720687915;
        Sat, 26 Feb 2011 03:44:47 -0800 (PST)
Received: from elie ([69.209.60.106])
        by mx.google.com with ESMTPS id e20sm1215888vbz.8.2011.02.26.03.44.46
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 03:44:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101224080505.GA29681@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167979>

Hi Junio,

Please pull

  git://repo.or.cz/git/jrn.git svn-fe

to get the following changes on top of master + the old jn/svn-fe.

These are patches from the threads $gmane/164146 and $gmane/167536,
providing some plumbing to support incremental import in svn-fe.  They
are probably far from perfect but they seem to work okay so far, and
I'd be fine with putting any fixes on top of them.

Thoughts, suggestions, etc welcome as always.

David Barr (1):
      fast-import: add 'ls' command

Jonathan Nieder (13):
      vcs-svn: eliminate global byte_buffer
      vcs-svn: replace buffer_read_string memory pool with a strbuf
      vcs-svn: collect line_buffer data in a struct
      vcs-svn: teach line_buffer to handle multiple input files
      vcs-svn: make test-line-buffer input format more flexible
      tests: give vcs-svn/line_buffer its own test script
      vcs-svn: tweak test-line-buffer to not assume line-oriented input
      t0081 (line-buffer): add buffering tests
      vcs-svn: add binary-safe read function
      vcs-svn: allow character-oriented input
      vcs-svn: allow input from file descriptor
      vcs-svn: teach line_buffer about temporary files
      Merge commit 'jn/svn-fe' of git://github.com/gitster/git into svn-fe

 Documentation/git-fast-import.txt |   63 +++++++++++-
 fast-import.c                     |  162 +++++++++++++++++++++++++++++-
 t/t0080-vcs-svn.sh                |   54 ----------
 t/t0081-line-buffer.sh            |  201 +++++++++++++++++++++++++++++++++++++
 t/t9010-svn-fe.sh                 |    1 +
 t/t9300-fast-import.sh            |   92 +++++++++++++++--
 test-line-buffer.c                |   90 +++++++++++++----
 vcs-svn/fast_export.c             |    6 +-
 vcs-svn/fast_export.h             |    5 +-
 vcs-svn/line_buffer.c             |  105 +++++++++++++-------
 vcs-svn/line_buffer.h             |   33 +++++--
 vcs-svn/line_buffer.txt           |   36 ++++++-
 vcs-svn/svndump.c                 |   23 +++--
 13 files changed, 722 insertions(+), 149 deletions(-)
