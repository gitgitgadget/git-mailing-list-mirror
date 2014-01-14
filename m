From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Tue, 14 Jan 2014 09:54:56 -0500
Message-ID: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 14 15:55:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W35Ot-0003wr-DO
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 15:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbaANOzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 09:55:24 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:63843 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbaANOzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 09:55:19 -0500
Received: by mail-wg0-f51.google.com with SMTP id z12so474339wgg.18
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=fCz248PuRi0cTWij7tTos8a8lIKt5eTd8Ij2b4Wxk54=;
        b=mJkD2Y9VUWGdIb40+q7/qrR3PI7mPV5oTFWKC/3eHFR4XefkD/eQuMgJfQXqqzgTKd
         600z8o2pWpgiLuHHIt2y53GzQ12GWaFJeVIETiB7HJhtSCChGscCldQlGT4VW4HF09QO
         fCYvRF6YChGQCu6yLzZLGhk8vw1zssBWuqbUpS+YFTmqAH6yy9B1yKq2H/OQQJfYbH6X
         xnJ8EZt1qbJJQvIKHPSleRt/n8Qa/Ej12ALYkD4VtIDhwttN3Kx5c7iYunlPz6j4It3I
         5tr6Uj4bITVPuBVMASYqRXYS9a8oz14mbb+ruIGdRdQF9zUgDuE+UZ219HGkhXvs3Kpc
         I2dg==
X-Received: by 10.180.39.43 with SMTP id m11mr20684350wik.8.1389711316159;
 Tue, 14 Jan 2014 06:55:16 -0800 (PST)
Received: by 10.216.64.66 with HTTP; Tue, 14 Jan 2014 06:54:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240399>

hi folks,

I have a git server which gets pushes of data (not code) from a couple
hundred VMs every hour. Every round of pushes leaves two stray .keep
files, so I am guessing two clients are having problems completing the
push. The contents being pushed are reports of a puppet run.

Is there a handy way to list the blobs in a pack, so I can feed them
to git-cat-file and see what's in there? I'm sure that'll help me
narrow down on the issue.

Are there other ways to try diagnose this?

Does the server-side record anything if a push fails? There are a
number of problems I am familiar with, and they always require
collaboration from the "client" side to spot and diagnose

 - a ref is not up to date and the server rejects non-ft
 - perms issues over objects or refs
 - ENOSPC
 - ... catchable signals (ETERM?)

AFAIK, I think it doesn't, and maybe it should, even if it's as simple
as trying to spawn a pipe to ""/usr/bin/logger -t git-server" and
attach it to stderr...

This has veered a bit off topic, but I think it's important for large
git server installations.

cheers,


m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
