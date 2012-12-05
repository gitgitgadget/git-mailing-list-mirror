From: Marko Kreen <markokr@gmail.com>
Subject: Re: Exploiting SHA1's "XOR weakness" allows for faster hash calculation
Date: Wed, 5 Dec 2012 14:26:46 +0200
Message-ID: <CACMqXC+jfkvj_ot0x6La6gOHypuXE-LX41V04_yQdZ+gytSDDw@mail.gmail.com>
References: <k9n3jd$akg$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 13:27:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgE48-0005G1-0A
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 13:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab2LEM0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 07:26:47 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42828 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294Ab2LEM0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 07:26:47 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so2668860qcr.19
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sw1qH/M4zD9m/FfaoQ4i//ueQiseSiPLhz67OPppC4A=;
        b=cS/DUF8GEmuEnxQlk39F8yml3fMBLiHm6Q5fkoCmhkcJfJny2nXbfrc1GiUfpf3Us1
         TR3AjmrNdyVPaZz44L68Qj7/pYz/zz5jIZh2xt97ZGCi9pQUVmLu0C/Pw3LcX91WqxKW
         ULSKaGvnvJVEqh9jUw3Oavu0EVkirGp3Tvr3KdloDVUjEIo1pQqGLyqWcel7eqZHJNpH
         kevVcVX+AjZXl8aLKTi8ikDF6Tg24QHhH6lFKXP6GmO1rHRr3t4g9g28iAXBqUDpvcsc
         Us6uLsQOBloa7/SOB0Nx7EkTIevA39DpXoesXYBmnGEIPXWN4bEPYwOOdbjTjmxp2Utk
         +lLQ==
Received: by 10.224.179.13 with SMTP id bo13mr27924792qab.11.1354710406475;
 Wed, 05 Dec 2012 04:26:46 -0800 (PST)
Received: by 10.49.35.106 with HTTP; Wed, 5 Dec 2012 04:26:46 -0800 (PST)
In-Reply-To: <k9n3jd$akg$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211117>

On Wed, Dec 5, 2012 at 11:19 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> to say it in advance: I do not want to trigger any bogus security discussion
> here. Instead, I believe the findings from [1] allow for an up to 20% faster
> SHA1 calculation, if my brief reading of the presentation is correct. Any
> opinions on integration this optimization into Git?
>
> [1] https://hashcat.net/p12/js-sha1exp_169.pdf

Pretty cool find.  Although it's not actual cryptographic weakness, it does
show some gaps in designers thinking - as there are simple optimizations
available to crackers but not users.

It does seem unusable for real implementation - the 20% win
is available only after the data is processed properly once.
Then after changing the data a little, you can calculate next
hash faster.

There still small possibility that there is way to optimize W calculation
for the first run, but it does seem really hard, and even impossible
while trying to keep the cache usage small.

-- 
marko
