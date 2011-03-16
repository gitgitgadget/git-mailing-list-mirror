From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/6] run-command: initialize failed_errno to 0
Date: Wed, 16 Mar 2011 06:36:52 -0500
Message-ID: <20110316113652.GD15739@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
 <4D807E66.40504@viscovery.net>
 <20110316094639.GA8180@elie>
 <4D8088C1.5050901@viscovery.net>
 <20110316105709.GC8277@elie>
 <20110316113540.GB15739@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:37:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzp2O-0001Nu-KI
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab1CPLhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 07:37:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39713 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab1CPLg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:36:57 -0400
Received: by gwaa18 with SMTP id a18so610324gwa.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wH7c8J21HIRzGPdDgn++zown+eeNxrSUT8DXLhIMtcw=;
        b=CUp3IxSZjpf4dutsWhWMwHH03/jS0uba2sOH6cOz3fbiImHqAvi3PhWa0LcTracxne
         YAZ2oWNt2ga/e8AwfHBFvCSoN8LJlHZ0ihOlZ2TSGclPdDVWWc7aSpJtoJ1A+FnWLcBU
         k2oixFvJa2KhnioEoslAOTc9dmQA8xwJVVHf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M4RjVn7SBlGi5LHrqvUBSljmRI3U06tyc7HUJG1rrnNw77FsCKxXYULg09rNEOJVw/
         AMfnyMUJLFmPx6RsNZYKNjCpJxzfdtrjF4qb1AVi0AogaHEY7PyCS1BQ3urWciBkiC8I
         b1UKXEh/L8WGGmUsQGiuKXTVDpCOIagLXR2hI=
Received: by 10.150.172.17 with SMTP id u17mr2953ybe.33.1300275416949;
        Wed, 16 Mar 2011 04:36:56 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id w19sm3496033ybe.10.2011.03.16.04.36.55
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 04:36:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316113540.GB15739@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169143>

It is much better to report "Success" than a seemingly random error
message based on an uninitialized value.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 run-command.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index f4fb936..8bb4d62 100644
--- a/run-command.c
+++ b/run-command.c
@@ -139,7 +139,7 @@ int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
-	int failed_errno;
+	int failed_errno = 0;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
-- 
1.7.4.1
