From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Unused (assigned but not read) option in diff_no_index
Date: Fri, 28 Oct 2011 17:08:24 +0200
Message-ID: <CAA01Csruo+PPbgWMjTdkOeCEVx_Hgr=_tN-pTOiWxRfCd3nbyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 28 17:08:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJo2t-0002b9-83
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 17:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab1J1PI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 11:08:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39570 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab1J1PI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 11:08:27 -0400
Received: by bkbzt4 with SMTP id zt4so525651bkb.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=0guXr8zIwT1rfUPYQIs03FpwCfrcGW4qVIXc7nMBv9s=;
        b=eqaV7uJDLGlpWakiaYGXKotDEjFP29G8NelgVuhN1W/VFXr8Bj3nfwehFIhy4S8kEx
         cIfSThrD1U4wdSDKihg32RK41y6HUzUXoL6VM2G1pUmbx+FZ2zn6LaYqs7D2nYueEfMr
         qmn65UAxL9x6vFv/vh5WS1oWlx/vR5G6EIiXw=
Received: by 10.182.51.67 with SMTP id i3mr667101obo.32.1319814504957; Fri, 28
 Oct 2011 08:08:24 -0700 (PDT)
Received: by 10.182.112.4 with HTTP; Fri, 28 Oct 2011 08:08:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184410>

Hi,

I noticed that "options" variable in diff-no-index.c:diff_no_index()
is modified when "-q" is passed but not used (not read) at all. So
either it can be removed or it should be used. "-q" is not described
in git-diff man page.

This code was introduced in 0569e9b8 "git diff": do not ignore index
without --no-index" - it was moved from builtin-diff.c (where it was
used) but the code was refactored so I can't say if it should still
be.

$ grep -E -2 '\boptions\b' diff-no-index.c
	int i;
	int no_index = 0;
	unsigned options = 0;

	/* Were we asked to do --no-index explicitly? */
--
			i++;
		else if (!strcmp(argv[i], "-q")) {
			options |= DIFF_SILENT_ON_REMOVED;
			i++;
		}

-- 
Piotr Krukowiecki
