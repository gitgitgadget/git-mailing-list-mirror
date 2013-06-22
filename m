From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 05/16] remote: remove dead code in read_branches_file()
Date: Sat, 22 Jun 2013 13:06:34 +0530
Message-ID: <CALkWK0mYmhnOL-F+StuKWSeQ48EsQSAnS0_6u-B8KKq+RrOW5A@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
 <1371813160-4200-6-git-send-email-artagnon@gmail.com> <7v1u7vkslz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 09:37:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIO9-0006Kg-IL
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 09:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152Ab3FVHhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 03:37:16 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:62697 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3FVHhP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 03:37:15 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so21036607ieb.38
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cfG9005bISzscQP0t3sld/lZxYTM+QR+Hoa94s0CBXs=;
        b=t/e3VtLB1buDh9+h1Z8TsYsuLiTL7xVTnzwGslwlNn+DVhwOxPo/IgZZr8H065EpWx
         ab3NcHXeoIA4m+qbJVDCdnYPvLdJtY1zUD/AEbi0pBKo8ucTqonRQQ8mhbaBlDgHmwF7
         hcfzsjq2lHPuLbt/WmqUDURC6ILKper2pZVqUOsOARPCmBgTqX7BZ7rHhOLBUilCad98
         VB/xLJaQ65an2ZQM8SdlvbnYJlM1GV6e7O6o70zSxMeMkc1OADKMg3YVSSdnTYhRGm3g
         7QBM8dL8NlcDjxf0sgMYaA3L8zARio0tteIKIIpmLojoszEaSWZruzPETbanjuAloEPF
         meOA==
X-Received: by 10.50.107.65 with SMTP id ha1mr837433igb.50.1371886634466; Sat,
 22 Jun 2013 00:37:14 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 22 Jun 2013 00:36:34 -0700 (PDT)
In-Reply-To: <7v1u7vkslz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228675>

Junio C Hamano wrote:
> As far as I can tell, that valid-remote-nick was done in df93e33c
> (Validate nicknames of remote branches to prohibit confusing ones,
> 2008-02-15), and back in that version, the codepath and the feature
> that wants to see a slash and do magical things, which is described
> by this comment you are removing:

It's a bad hack, in my opinion.  When I say git fetch ../foomery, it
should catch the pattern at transport_get() and not even attempt to
look up a remote in the first place.  I will attempt to clean this up
soon.

> So it appears that back then (and througout to today), nobody uses
> that "partial URL" feature which is specific (and was a rather nice
> invention/legacy by Cogito) to .git/branches file.

It's quite a cute feature, even if a bit magical.

> Reminds me of the strategy to deprecate functionality in X (cf.
> http://lwn.net/Articles/536520/) ;-)

Leaving dead code around to confuse readers? :\
