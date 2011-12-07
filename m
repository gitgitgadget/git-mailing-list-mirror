From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] revert: make commit subjects in insn sheet optional
Date: Wed, 7 Dec 2011 01:02:24 -0600
Message-ID: <20111207070223.GC11737@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 08:02:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYBWV-0005ft-V0
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 08:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab1LGHCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 02:02:30 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44909 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1LGHCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 02:02:30 -0500
Received: by ghbz2 with SMTP id z2so209520ghb.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 23:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O4dQNVYG+iFO5//UTx75GetjHz5V3Rw9Zi18d/2sncw=;
        b=TMey3krLjkvAM4HKWow3k64ocIIidAzdzB98CJEm0rle+qrLXdFOA2E0vNX+Ys1m0E
         qLQ+XpugZ6/xidYhvSNrh8msZKRQxEOqfT/f+DY4uYTBMYzLAJd4CWXPIPMU+soPdMEU
         Tz4zz5qb0f6V2r9HDWhlRV7nuBD8MXZQZ2bqc=
Received: by 10.236.200.194 with SMTP id z42mr24798068yhn.70.1323241349777;
        Tue, 06 Dec 2011 23:02:29 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q52sm1620650yhh.3.2011.12.06.23.02.28
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 23:02:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323239877-24101-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186433>

Ramkumar Ramachandra wrote:

> Change the instruction sheet format subtly so that the subject of the
> commit message that follows the object name is optional.  As a result,
> an instruction sheet like this is now perfectly valid:
>
>   pick 35b0426
>   pick fbd5bbcbc2e
>   pick 7362160f
>
> While at it, also fix a bug: currently, we use a commit-id-shaped
> buffer to store the word after "pick" in '.git/sequencer/todo'.  This
> is both wasteful and wrong because it places an artificial limit on
> the line length.  Eliminate the need for the buffer altogether, and
> add a test demonstrating this.
>
> [jc: simplify parsing]

Reading the above does not make it at all obvious that I should want
to apply this patch because otherwise my prankster friend can cause my
copy of git to crash or run arbitrary code by putting a long commit
name in .git/sequencer/todo in our NFS-mounted shared checkout.

(Yes, I know there are other problems with such a setup, especially if
.git/hooks or .git/config is writable by untrusted people.  So it is
not actually a security bug, but a robustness one.)
