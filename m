From: Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [RFC/PATCH 0/2] Commits with ancient timestamps
Date: Fri, 3 Feb 2012 12:53:32 -0200
Message-ID: <CAFQ2z_Nb-3gai8aXRv+03N0YrAYOJ_sDPn+jruGCvYkTQAr-Pg@mail.gmail.com>
References: <1328218903-5681-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 15:54:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtKWV-0001Ke-04
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 15:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581Ab2BCOxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 09:53:54 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58818 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab2BCOxx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 09:53:53 -0500
Received: by qcqw6 with SMTP id w6so2118052qcq.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 06:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-system-of-record:content-type:content-transfer-encoding;
        bh=1cz7TVuSkw5K+OhzDZYja4K9BGkt/R6ZtC3xH5yczRU=;
        b=r6mRAwoLsBJdxq6COTvzlwafNyAiQJS1yvXQzJC7EJ/Zjv69+3jg2K45nGjcZe03Gy
         5UHqd3AtKrWQx/A/rctt+Q3d8vyOb0/bPnsv0jph1IfJz3t/gag2Gm/XibPyTmC7Ij9p
         XVxUSD/fcyLpBv5f+Ynr/33f1B1kY6GpeOuWM=
Received: by 10.229.136.79 with SMTP id q15mr2839739qct.149.1328280832848;
        Fri, 03 Feb 2012 06:53:52 -0800 (PST)
Received: by 10.229.136.79 with SMTP id q15mr2839728qct.149.1328280832671;
 Fri, 03 Feb 2012 06:53:52 -0800 (PST)
Received: by 10.229.101.158 with HTTP; Fri, 3 Feb 2012 06:53:32 -0800 (PST)
In-Reply-To: <1328218903-5681-1-git-send-email-gitster@pobox.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189779>

On Thu, Feb 2, 2012 at 7:41 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Result of conversion of ancient history from other SCMs, and output f=
rom
> other third-party tools, can record timestamps that predates inceptio=
n of
> Git. They can cause "git am", "git rebase" and "git commit --amend" t=
o
> misbehave, because the raw git timestamp e.g.
>
> =A0 =A0 =A0 =A0author <a.u.thor@example.com> 1328214896 -0800
>
> are read from the commit object and passed to parse_date() machinery,

As a bit of context: we have some internal tools at Google that create
administrative commits that should have no timestamp.  I am using "0"
and "1" as a deterministic timestamps in these cases (ie. the start of
the epoch). While this works well in general, there are some git
subcommands that barf on this, causing user-unhappiness.

This patch will hopefully resolve these breakages.

--=20
Han-Wen Nienhuys
Google Engineering Belo Horizonte
hanwen@google.com
