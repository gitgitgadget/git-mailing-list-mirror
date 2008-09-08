From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: git-p4 and keyword expansion
Date: Mon, 8 Sep 2008 10:27:02 +0200
Message-ID: <1a6be5fa0809080127h5db71093o364aade2fb955acc@mail.gmail.com>
References: <554296.48174.qm@web95003.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "GIT SCM" <git@vger.kernel.org>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 10:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcc6Y-0002wS-ML
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 10:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYIHI1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 04:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbYIHI1G
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 04:27:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:28212 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbYIHI1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 04:27:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1400967fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZVP+mRZJTOqqroY7/rOyt6F52oHODBZvQeY1l9sASEs=;
        b=MDON2n9KlUd1MUUvGM9cU4kZchD5a+Be1iQ/MwowmiO5m98Xk6GrDuY6GBdXIRfeZB
         /L41bCbSDtobmV4C0cEX5yW5E0V3jAwmBHWT428bP//eU1sIxyo8Tn9MnHsfKHP8AC43
         1DkYrp8i2HCiOI2GCoABp8hMN/OVToN0YCg3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KllWakTQ8FIpoxAmMR9Gck4C7NgmtGHvEU/HRn7S1cZz9UOWeNU0RcXfY4MvhDHjx1
         ThRGxr7QpZygH55Jr8TLqbYsZK38loky57PtmjtZgNx51Xq2EBDHQ4m15rpdrrEq4eJ4
         zke9WLWTEheGbEl2nPe38cYNKi0XHM3lwMJ4A=
Received: by 10.86.98.14 with SMTP id v14mr11035481fgb.74.1220862422698;
        Mon, 08 Sep 2008 01:27:02 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Mon, 8 Sep 2008 01:27:02 -0700 (PDT)
In-Reply-To: <554296.48174.qm@web95003.mail.in2.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95229>

Hi,

On Mon, Sep 8, 2008 at 6:25 AM, dhruva <dhruva@ymail.com> wrote:
> Hi,
>  The git-p4 script unexpands all p4 keywords before feeding it to git fastimport. When there is a new version, it records only the diffs minus the keyword contents at it unexpands and then feeds to fastimport. When trying to submit back to perforce, applying a patch on top of the latest file in p4 with the keyword expanded fails because we have not tracked that difference. Patch applying fails and expects you to manually (out of git) to do a 'p4 submit' and get back and do 'git-p4 submit --continue'.
>  Removing the keyword unexpanding code in 'git-p4' with the following patch makes it work:

Yes, I have also experienced this problem, and haven't yet come up
with a solution to it. Your solution seems to solve the problem with
submitting to p4, but it would also mean that files cloned from p4
would have diffs in the git database whenever the p4 headers changed.
This does not seem nice to me. Are all the keyword expansions
reproducable? I mean... could we store them in git as before
(unexpanded), and make some logic to recreate them upon submitting to
p4? That might work...

I think, at least, that although this is a nice initiative, we should
find a nicer solution.

-Tor Arvid-
