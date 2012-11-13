From: Kevin <ikke@ikke.info>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Tue, 13 Nov 2012 16:45:30 +0100
Message-ID: <CAO54GHCzeWv41Bu5By0JOzbBHGuzXV=krdDr0U=QsMBun7PF7A@mail.gmail.com>
References: <20121111232820.284510@gmx.net> <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
 <20121112202413.GD4623@sigill.intra.peff.net> <CAM9Z-nkuHj8MWLfWsvY=EqHXCUS+Pk5Ezv6m5J+cnh7cQHNc_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, glpk xypron <xypron.glpk@gmx.de>,
	git <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:50:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIkt-0004u9-S0
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab2KMPpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:45:52 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:64526 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab2KMPpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:45:51 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so746442iay.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Lol38ibyX1AKiFhLQ0IsZncS3HU9UiW66Zaw7SgcSN4=;
        b=UX4FpaXVeBz5Ob62hHuuCVnmXUCRlsapxEjS6fMYX7JvTvduipoGdf1iAZ95h1aK3L
         Gq2YHCEgTkMUrrtpbR0ipEtB4Z/ZmtoCkHwn+tPn51CwgvG9CKNP77UPDWWs/FPbhPfE
         1RNkSYWNEoNkOMFSIH45omWckLcnYK9COEOPy2NCVWZHMiNQOL7a9JL2E/oVkeiP7L3/
         PeG66qHB2mRs/8Y2Tc8HrdHAgmtnr+OanGpAfvLpESwkAbI6rnPguQvvp+QBj5Jc9Mzx
         rOaDhLbhNTjHZ/Yz/C8b4lMi76HD+xRifSx+DSNKNQ8eGuMrYZZBzTHCoX8XkAwVOfpb
         koew==
Received: by 10.50.193.170 with SMTP id hp10mr1221373igc.63.1352821550958;
 Tue, 13 Nov 2012 07:45:50 -0800 (PST)
Received: by 10.231.78.8 with HTTP; Tue, 13 Nov 2012 07:45:30 -0800 (PST)
In-Reply-To: <CAM9Z-nkuHj8MWLfWsvY=EqHXCUS+Pk5Ezv6m5J+cnh7cQHNc_g@mail.gmail.com>
X-Google-Sender-Auth: kliXQXNDq5oPZAI5oa8w2hcfVHk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209625>

The problem with input filtering is that you can only filter for one
output scenario. What if the the input is going to be output in a wiki
like environment, or to pdf, or whatever? Then you have to unescape
the data again, and maybe apply filtering/escaping for those
environments.

You only know how to escape data when you are going to output it, so
then is the the best moment to escape it.
