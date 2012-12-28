From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git diff --ignore-space-at-eol issue
Date: Fri, 28 Dec 2012 17:46:10 +0100
Message-ID: <CALWbr2y3BdqcD-62jhPSQsK3U=8-Dc=R-jxg8H0yqpgVfdHJXw@mail.gmail.com>
References: <BLU163-W40634B340214076467C88ECF360@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: John Moon <johnmoon77@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 17:46:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tod4o-0006w1-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 17:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab2L1QqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 11:46:13 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36497 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab2L1QqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 11:46:12 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so5202794eek.19
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=esyC/ze5u0lU70fIoe/y0a/ye5wPPs6iFqjvTnbb9g4=;
        b=jk1B/Q/uZy99IbPdLw2ILCrkxelsyt/NJstSXb4pT1Jjw94YEuE8DBPIIFVcWjKMOm
         1Vo+VcBdbkBaKErsF7RAs0yQ2/TMqFIebJvCdAThxmaOWh8dIUZHYLffiqpoByuQRCur
         gzGjX9KlcXwYyZs/FFm5/5lCk0Nq1xxG0JYRdFlKOFAt/Z9ne+TN/q/ujXsATzIFUMeC
         GoGzKTzsmWksNhnZH2+KBACVUIYHH1/VNn0Ix4wVDMBxT233Bek6bIqZQH3lSlhTmobm
         1C5qYHYW5ypGlpJKD70PHEuJg/67YrREKBuJTKyVy4YGnpFSUfeql1kFrB+WPhhVj63q
         GTGA==
Received: by 10.14.194.4 with SMTP id l4mr87500792een.42.1356713170833; Fri,
 28 Dec 2012 08:46:10 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Fri, 28 Dec 2012 08:46:10 -0800 (PST)
In-Reply-To: <BLU163-W40634B340214076467C88ECF360@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212245>

> The --ignore-space-at-eol option is ignored when used in conjunction
> with --name-status.
> It works fine otherwise.

Indeed the behavior of diff --stat, and etc has been corrected very
recently to make it more consistent across all options.
I don't know if the new behavior is exactly what you expected:

$ git diff --ignore-space-at-eol test.txt
$ git diff --ignore-space-at-eol --stat test.txt
 test.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
$ git diff --ignore-space-at-eol --name-status test.txt
M       test.txt

The idea is that even though diff doesn't show any differences, stat,
shortstat, numstat and name-status reports the file as being changed.
This is available since v1.8.1-rc0.
