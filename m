From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Tue, 14 Jan 2014 12:10:31 -0500
Message-ID: <CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com>
References: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 14 18:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W37Vx-0005hz-Bv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 18:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaANRKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 12:10:54 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:42121 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaANRKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 12:10:52 -0500
Received: by mail-wg0-f53.google.com with SMTP id y10so676575wgg.20
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=/MuPaC3KpsykKY/SU3FSiyiGHvaLj1AGBebRLEbZVSs=;
        b=xik+O4UvPYtd2gM98CNMTgIpBtsW8cI99tQMWg02yu2BXBnwEoDulI2NvNp6e91rN7
         bdYXFUrPVzG1dJLkJ0lnOWTFVVOjVNqgZZXi+pDR+ZHz+KaRIzOhC7xd62bhGy7H78YN
         4vUsTPClCPgVy4VhWQE8fnxAu0ol1Z6n+Cl7eT/Nhai5PIAFnc0yYj4aXLRPdDjm0jXs
         OCYr79fdkdm3MZTNGpA0Zua8LPb51tFCdjUKZLX1TA51QsXl8YlLE3hvcGkTD0FELXsu
         EtYH6f9745olKoqUmeRV51+NU53FJZlcQ6tOqqWuc01946paRcbmpHo60c5Nc/mh6hoI
         rGGw==
X-Received: by 10.180.19.165 with SMTP id g5mr3964586wie.31.1389719451426;
 Tue, 14 Jan 2014 09:10:51 -0800 (PST)
Received: by 10.216.64.66 with HTTP; Tue, 14 Jan 2014 09:10:31 -0800 (PST)
In-Reply-To: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240402>

On Tue, Jan 14, 2014 at 9:54 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Is there a handy way to list the blobs in a pack, so I can feed them
> to git-cat-file and see what's in there? I'm sure that'll help me
> narrow down on the issue.

git show-index  <
/var/lib/ppg/reports.git/objects/pack/pack-22748bcca7f50a3a49aa4aed61444bf9c4ced685.idx
|
cut -d\  -f2 | xargs -iHASH git --git-dir  /var/lib/ppg/reports.git/
unpack-file HASH

After a bit of looking at the output, clearly I have two clients, out
of the many that connect here, that have the problem. I will be
looking into those clients to see what's the problem.

In my use case, clients push to their own head. Looking at refs/heads
shows that there are stale .lock files there. Hmmm.

This is on git 1.7.1 (RHEL and CentOS clients).

cheers,


m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
