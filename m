From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t0090: mark add-interactive test with PERL prerequisite
Date: Tue, 18 Nov 2014 10:43:47 -0800
Message-ID: <20141118184347.GE6527@google.com>
References: <20141118172231.GA16387@peff.net>
 <20141118174309.GB31672@peff.net>
 <20141118183838.GD6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:43:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqnkl-00009n-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbaKRSnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 13:43:47 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:41815 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbaKRSnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:43:46 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so1500006igb.17
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2cx5mR/UmwOK4rANXjlMumCctpSdPdGonIKQb37e+Lk=;
        b=i7LNkjpA+SWo+f8A83gPDx5LUQqpN8tTh8X/6PI3PWt8GwmGPMGIknYCYCic+B9d8m
         dkKbqd2XtPok2Ye7cD8fTsy6Wg8ojI3Xiff5pCWJgFqwLUVT5GkgdgddwGW0g/h0mAdt
         hyZmcI6qxzb1Agj0Ax/xM2AoezOMPf5Xh//sQlLo+QXAQ32vjXkOKJoWN/k9Qy1ZQXK6
         Rd9FwUZQAaZe1k/nHnHk1J26Bp8wKCIsyYpOAUFAoGFg566uU8+EjECRU4xoSeHAzqPB
         CyfjQeTeZXkxYjH5bNMRWUCpXffPubhtVPhnkBGRII5Q7raPcWLN4FPJ9WGYkwDfRlA0
         CTuQ==
X-Received: by 10.43.127.73 with SMTP id gz9mr35686931icc.6.1416336226188;
        Tue, 18 Nov 2014 10:43:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id c8sm8109139igl.1.2014.11.18.10.43.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 10:43:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118183838.GD6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Jeff King wrote:

>> Subject: Makefile: have perl scripts depend on NO_PERL setting
> [...]
>> ---
>>  Makefile | 3 +++
>>  1 file changed, 3 insertions(+)
>
> Gah.  Good catch.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

... and here's a patch on top to give git-p4 the same treatment.

-- >8 --
Subject: Makefile: have python scripts depend on NO_PYTHON setting

Like the perl scripts, python scripts need a dependency to ensure they
are rebuilt when switching between the "dummy" versions that run
without Python and the real thing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 8f980e0..7482a4d 100644
--- a/Makefile
+++ b/Makefile
@@ -1736,6 +1736,9 @@ $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PERL
 
+# This makes sure we depend on the NO_PYTHON setting itself.
+$(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
+
 ifndef NO_PYTHON
 $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
 $(SCRIPT_PYTHON_GEN): % : %.py
-- 
2.1.0.rc2.206.gedb03e5
