From: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
Subject: Inverting the --committer option to git-log with v1.7.5.4
Date: Sun, 26 Aug 2012 18:30:40 -0400
Message-ID: <CAPRhCbuOsiHNOHJUTN8Na9qEqoTAbCb-G41WFscjYhDppKOLGg@mail.gmail.com>
References: <CAPRhCbtfx+kA8BbPwSYcYfvg5S0b6yWP5TqJHD_LCN-CMFw75w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 00:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5lM0-0004VZ-E1
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 00:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681Ab2HZWam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 18:30:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37882 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab2HZWal (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 18:30:41 -0400
Received: by ialo24 with SMTP id o24so6924549ial.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 15:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=vWkdi1Y7aIJZdGWWaJWtpteMjiuOPuvx9Juwol6zaNY=;
        b=hogz1n7GMPGUDulZ3o1OsrpnM4lRltvrkvwriAFRRI76noszWbHGjmBPr1ZAKAoKKz
         CSwzFFhnFYCXCTEGy6Q1FPHojKw/tnzf38sK2JD28Rdxugs1q18s0SPmAiCpf/8l7grH
         eVh+uSKfcTK4CRU6E9Iwd4lx4kPAJKT3GFfxRGMGaDsVbUhs8OFUJ4V4hcggtwHTQ353
         frlRvbd4mdLJ8qTLVAGeg1RsB5hic7uBT2oxwjYkyPtp88xqicCkVY3d4k6BGx6RP/oh
         rzi9uieq4XOvqQQU+BSnhqi8UMHjAQ4bcdEKrrt4Wd/VNb6lmTqMCAGJ9EqdqaYpn3Ez
         1AKw==
Received: by 10.50.190.170 with SMTP id gr10mr8366998igc.29.1346020240745;
 Sun, 26 Aug 2012 15:30:40 -0700 (PDT)
Received: by 10.231.6.90 with HTTP; Sun, 26 Aug 2012 15:30:40 -0700 (PDT)
X-Originating-IP: [74.107.73.157]
In-Reply-To: <CAPRhCbtfx+kA8BbPwSYcYfvg5S0b6yWP5TqJHD_LCN-CMFw75w@mail.gmail.com>
X-Google-Sender-Auth: DuoTVSCb5-vjz7nQFv0623RYaJU
X-Gm-Message-State: ALoCoQkBJGYOEmFDQP1pxQRAv7EBFhvaEeEGMDDJN2O3JM9aBPlaoBQWONcjZXVpHtQPojCJ1oZD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204315>

I wanted to search a repository for all commits that were *not*
committed by a particular person. While I eventually managed to build
a regular expression that worked for my limited use case, it seems
like there ought to be a more sensible way to find the data I'm
looking for.

As an example, this didn't work:

    git log --format=fuller --not --committer="Foo Bar"

Apparently, the --not flag doesn't invert the grep for committer; it
only inverts the revision specifiers. It seems like there should be
something that works like grep's --invert-match option, but I couldn't
find it.

On the other hand, this will work, but is painful and error-prone to
build if you have a lot of committers:

    # Assuming the address is foo.bar@example.com
    git log --format=fuller --committer='[^r]@'

Is there currently a better way to request logs for "everyone but
committer x" in Git? If not, is this a feature that someone who
understands the Git source might find useful enough to add in?
