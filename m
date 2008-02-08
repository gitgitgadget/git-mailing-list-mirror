From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a file
Date: Fri, 8 Feb 2008 17:25:52 +0000
Message-ID: <e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com>
References: <20080208174654.2e9e679c@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:26:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNWzp-0006ED-FG
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 18:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763086AbYBHRZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 12:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758297AbYBHRZz
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 12:25:55 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:53122 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758568AbYBHRZx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 12:25:53 -0500
Received: by py-out-1112.google.com with SMTP id u52so5577653pyb.10
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 09:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=17TPTwE7gOWJvmWZbBYNjb28BG8rPlNVrvizVqw1j9M=;
        b=KC+QrncAgsPI6MIlHsa939TGt7OPeJaI0ZR1qWP7dtpTPZHklWUkTyEP6BiYVm8o58bov7SOGWglEgY4VhFQz/QouRoFRxhyaFkGB6KRicQC5Q111t5Ew0NrD5x5gRKY5K56kpSPDY/i3P3xuOXpPT6PGLNT66KbTOQdVsGLEdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IN4XNaXlH0wH6KJPOj9PIU4Rs09LdzKmEAjb7aOjm6iLDD5xFDgWZfW8oR2Beo58ofv4Q4K/Cco4Ihp017UnN9lnwZFE/SWay/vXcoYXYzwXoF69t3MVOd3QQu6vrHsaD/Kww26wRyfBFU0iKkCrOhtmb4cN7enYpq32oCk3NPs=
Received: by 10.141.168.7 with SMTP id v7mr8679959rvo.118.1202491552092;
        Fri, 08 Feb 2008 09:25:52 -0800 (PST)
Received: by 10.141.19.11 with HTTP; Fri, 8 Feb 2008 09:25:52 -0800 (PST)
In-Reply-To: <20080208174654.2e9e679c@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73116>

On Feb 8, 2008 4:46 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> HP-UX allows directories to be opened with fopen (path, "r"), which
> will cause some translations that expect to read files, read dirs
> instead. This patch makes sure the two fopen () calls in remote.c
> only open the file if it is a file.
>
> Signed-off-by: H.Merijn Brand <h.m.brand@xs4all.nl>

Many thanks, this is also required for AIX. I had got some way to
tracking it down, but I thought it was an issue with strbuf. So...

Tested-by: Mike Ralphson <mike.ralphson@gmail.com>

Your other fix there [- if (!strbuf_avail(sb)) / + if
(strbuf_avail(sb) < 64) ] is, guess what, also required on AIX.

Thanks again.
