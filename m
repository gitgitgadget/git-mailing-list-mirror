From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/3] --dirstat: In case of renames, use target filename
 instead of source filename
Date: Tue, 12 Apr 2011 07:59:21 -0700
Message-ID: <BANLkTinHcDug0A+n9N4hkApF_xBU+nEkBw@mail.gmail.com>
References: <7vtye834al.fsf@alter.siamese.dyndns.org> <7vwrj0sap3.fsf@alter.siamese.dyndns.org>
 <201104121122.56870.johan@herland.net> <201104121124.35128.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:00:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9f53-0007oD-EY
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 17:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab1DLPAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 11:00:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57136 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756774Ab1DLPA1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 11:00:27 -0400
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3CExhpf024132
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 12 Apr 2011 07:59:43 -0700
Received: by iyb14 with SMTP id 14so6704818iyb.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 07:59:41 -0700 (PDT)
Received: by 10.231.34.4 with SMTP id j4mr6991497ibd.83.1302620381097; Tue, 12
 Apr 2011 07:59:41 -0700 (PDT)
Received: by 10.231.33.199 with HTTP; Tue, 12 Apr 2011 07:59:21 -0700 (PDT)
In-Reply-To: <201104121124.35128.johan@herland.net>
X-Spam-Status: No, hits=-103.481 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171395>

On Tue, Apr 12, 2011 at 2:24 AM, Johan Herland <johan@herland.net> wrote:
> This changes --dirstat analysis to count "damage" toward the target filename,
> rather than the source filename. For renames within a directory, this won't
> matter to the final output, but when moving files between diretories, the
> output now lists the target directory rather than the source directory.

Ack. I think the use of the source filename was actually a bug.

The original dirstat code used the "struct diffstat_file_t *" pointer,
and took the name from the ->name field of that. And that actually
defaults to the target name (see diffstat_add()). But then commit
c04a7155a03e changed it to use "struct dirstat_file" and picked the
name for that from the source.

                        Linus
