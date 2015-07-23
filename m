From: Thibault Kruse <tibokruse@googlemail.com>
Subject: git branch -v output ambiguous for parser
Date: Thu, 23 Jul 2015 15:29:53 +0200
Message-ID: <CAByu6UVzsoK=OHkYv_zBCYf2YnBqx268TZ+_pi98N6pMt_NSgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 15:30:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIGZS-0003lv-7q
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 15:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbbGWN3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 09:29:55 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33643 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbbGWN3x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 09:29:53 -0400
Received: by oige126 with SMTP id e126so165092554oig.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/17/mGhVUbn5/5qXh5PDQ3b+BnekTI/Wj+dYQcDGpDs=;
        b=l2pe0GpuPm5VgQzeOxj1K6alGg0/AcUA/R3P+YLfj/Icf9AC7XfRhkmtgyBMdTaOM6
         vFJC+XGiG+FdQYMO+XYJww9nFqjvfqFQdnXOgu2b0z7MlRNCZaXwINAFG02IZr3oxrl1
         LLXzB0O1Ykpj8ZUDDWEmTul2yW5V+i6QASTXFtBfxLxPaYOdaTrs1ZlHK325M7P/CKGU
         ettmkQnTLlaHCOZbgFtYfNmN7eWZfIE8RhFy58jx/935DjgQIkzUuW17uJ88CrwZwneL
         5GWjOTVVkwQ4VUC3na615Bq3DR3M7bNP8zhm4tkSKPeUab4FY7D1SK5GYehMKhuZm6gv
         YtJg==
X-Received: by 10.202.230.70 with SMTP id d67mr7919906oih.14.1437658193135;
 Thu, 23 Jul 2015 06:29:53 -0700 (PDT)
Received: by 10.182.241.65 with HTTP; Thu, 23 Jul 2015 06:29:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274495>

Hi,

trying to write a git wrapper, I wanted to parse the output of git branch -v

However, I realized that the output prints the last commit message at
the end of the line, without any disambigution char, or hyphens.
This makes it possible to have these outputs:

  foo                 6d29736 [foo/bar] test123
  master              9726de6 [ahead 2, behind 2] line 1 line 2 line 3

where foo is a branch that does not track another branch, and the last
commit message on branch foo is '[foo/bar] test123'.
The opening brackets '[' are even aligned in the output, making that
distinction also difficult for the human eye.

So as a small improvement I would suggest some separating char or
hyphens around the commit message, e.g.:

  foo                 6d29736 '[foo/bar] test123'
  foo                 6d29736 | [foo/bar] test123

regards,
  Thibault Kruse
