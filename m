From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit RFC] Make "stg branch -l" faster by getting all git config information in one call
Date: Thu, 13 Dec 2007 14:04:26 +0000
Message-ID: <b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com>
References: <20071213133653.13925.89254.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Dec 13 15:04:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ogG-0008I6-Az
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 15:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbXLMOEa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 09:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbXLMOEa
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 09:04:30 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:57450 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbXLMOE3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 09:04:29 -0500
Received: by rv-out-0910.google.com with SMTP id k20so575017rvb.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XoSsN6XQhjU0SYcmsD8mLp8+JrJKlZmvRwJ0MFu62Bk=;
        b=jIv6IhxwUoKxgsFTfGUfLjOxJiDHhwc/XRvfjPBY9LcCP2t/L6vdXD8rNVhF339Big+koWjGRVGFq3p13hPQs1ddlIAGNQDmyPlq6jG4MZDmrBltBZhyVR5qn9q4etVuTCgL11gHK1S7CBgHfR1VV0YdXpgOhEsqs3O6LFeP6qU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b7MudF0ibIm3c+faXVLkW8p+YC+qrAlDkb9u90zRj6IYL4pPunIvvdQTUz/F3UHUUpp8gsTrvIkqFQ/pZpChrNwSLTeUVDeMWQwT1jFnVJwtZy673gVcyBa9VNrSDOTtmx/Ceq4wzpyamZpr6HnWvcXHUxXTKq/ivZaLno35VY8=
Received: by 10.141.20.7 with SMTP id x7mr1098620rvi.255.1197554666999;
        Thu, 13 Dec 2007 06:04:26 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Thu, 13 Dec 2007 06:04:26 -0800 (PST)
In-Reply-To: <20071213133653.13925.89254.stgit@krank>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68157>

On 13/12/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> I have a fair amount of branches, and I noticed that "stg branch -l"
> takes ridiculously long to finish.

I have the same problem.

> Maybe someone can help me find a quicker replacement for the
> get_protected call?

We can have the standard --list command which ignores the protected
flag or even the stgit.formatversion. Just a simple listing of the
branches (that's what I need most of the time). To get the
description, the 's' and 'p' flags, we could use --list-full or
something similar and wait a bit longer. This would also improve the
bash completion of commands taking branch names as arguments.

We had a similar issue in the past with 'series' as it was checking
whether the patch is empty. We ended up adding a '--empty' option for
this case.

--=20
Catalin
