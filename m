From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/8] Resurrect rr/svn-export
Date: Fri, 16 Jul 2010 05:13:52 -0500
Message-ID: <20100716101352.GA14374@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 12:14:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZhwU-000444-Sp
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 12:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923Ab0GPKOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 06:14:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37289 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936153Ab0GPKOq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 06:14:46 -0400
Received: by iwn7 with SMTP id 7so1981485iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FHmeBxfbahDU5qnkjByA0xSm1dis67YVDFi8rticSxY=;
        b=x3L7a+eBc3kkYWohRYtwRkq6cI4yd/ZXrjRr+1zNTEuXt+dJFwUQz3LFz1OtQyq6vM
         1BHAvZrGOd+9qrO3xdL+APnmoNWsZXdLn1HDnpK9xetWk9jymxVzQ5yH5FEde3256TK1
         hDa3xnD5lUNflnIEeeU9eQmWV4+ED2HGg8ve0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RXPVTeLhdY31qZ1QupVDbgxZwVxoqdpXWe7A/3ov1w3LuzAxiE6Sa6YkPfdQdzI/71
         gvsvtry+seliCcCeoWDXocEoCVb36pzsGOGaqjOwTno2mvJUZNnAZQeRxoXiywEayY99
         OPSvAsmZftvBXUfKKKsHkT5qCMpZvZk9IgCnE=
Received: by 10.231.36.13 with SMTP id r13mr714125ibd.75.1279275286118;
        Fri, 16 Jul 2010 03:14:46 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm9009094ibk.3.2010.07.16.03.14.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 03:14:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151144>

Hi,

While Ram travels halfway across the globe, I have rerolled at his
request.  You can find the result at
  git://repo.or.cz/git/jrn.git rr/svn-fe

The main difference from the version sent already is the addition of
tests and a small tweak to the treap implementation to make them
pass.  I will send the two patches with new tests as replies to this
message.  Thoughts welcome, as always.

David Barr (5):
  Add memory pool library
  vcs-svn: Add string-specific memory pool
  Add stream helper library
  Add infrastructure to write revisions in fast-export format
  Add SVN dump parser

Jason Evans (1):
  Add treap implementation

Jonathan Nieder (3):
  Export parse_date_basic() to convert a date string to timestamp
  Introduce vcs-svn lib
  Add a sample user for the svndump library

 .gitignore                |    2 +
 Makefile                  |   14 ++-
 cache.h                   |    1 +
 contrib/svn-fe/.gitignore |    4 +
 contrib/svn-fe/Makefile   |   64 +++++++++
 contrib/svn-fe/svn-fe.c   |   15 ++
 contrib/svn-fe/svn-fe.txt |   68 +++++++++
 date.c                    |   14 +-
 t/t0080-vcs-svn.sh        |  101 ++++++++++++++
 test-obj-pool.c           |  116 ++++++++++++++++
 test-treap.c              |   65 +++++++++
 vcs-svn/LICENSE           |   33 +++++
 vcs-svn/fast_export.c     |   75 ++++++++++
 vcs-svn/fast_export.h     |   14 ++
 vcs-svn/line_buffer.c     |   91 +++++++++++++
 vcs-svn/line_buffer.h     |   12 ++
 vcs-svn/obj_pool.h        |   61 +++++++++
 vcs-svn/repo_tree.c       |  331 +++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/repo_tree.h       |   26 ++++
 vcs-svn/string_pool.c     |  101 ++++++++++++++
 vcs-svn/string_pool.h     |   12 ++
 vcs-svn/svndump.c         |  289 +++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.h         |    8 +
 vcs-svn/trp.h             |  223 ++++++++++++++++++++++++++++++
 vcs-svn/trp.txt           |   98 +++++++++++++
 25 files changed, 1829 insertions(+), 9 deletions(-)
 create mode 100644 contrib/svn-fe/.gitignore
 create mode 100644 contrib/svn-fe/Makefile
 create mode 100644 contrib/svn-fe/svn-fe.c
 create mode 100644 contrib/svn-fe/svn-fe.txt
 create mode 100755 t/t0080-vcs-svn.sh
 create mode 100644 test-obj-pool.c
 create mode 100644 test-treap.c
 create mode 100644 vcs-svn/LICENSE
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h
 create mode 100644 vcs-svn/obj_pool.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt

-- 
1.7.2.rc2
