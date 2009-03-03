From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 20:13:58 +0300
Message-ID: <37fcd2780903030913q4ee0e5d0t45dc3b124285f748@mail.gmail.com>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
	 <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com>
	 <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
	 <200903021530.01165.trast@student.ethz.ch>
	 <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
	 <37fcd2780903030147q7062ee47w7ce524c28a6aa347@mail.gmail.com>
	 <alpine.DEB.2.00.0903031246420.3702@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYDL-0000Hz-KI
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbZCCROF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 12:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbZCCROE
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:14:04 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:38986 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbZCCROC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 12:14:02 -0500
Received: by fxm24 with SMTP id 24so2530142fxm.37
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 09:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ia0ZaLPe4zK0wGChRadaTYVArup8hDo4gsQoqUyMj94=;
        b=LDsbAXDftCCshQhqLyO4y1D1QCfAvmTnAz0fSPIgGe0cDtjr7hOa8rE6Vh2gVnTi+E
         c6FBPqSB9PSzrKhJ7dYqIHB9FJ/EOHCZURPeUVvWkie7IdpUoxEZUwvMQfLR1rJ5p48x
         LgzxIbkvd5alKlKHdvSA1X5KBgKvk18Jtt1/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wzRN34q2B9sF+o1ZybWlhoZKRTbZndE8w+Ha81stht3LQpxRxogRRdQaANx5Yzx70l
         T61gSPEiJ9qDR3w19g8oP6xVPw+Sdu5QpuNqFDAW/FA4tq9qCe65XLZ2XoFKi4S3u67C
         bnEStzPONpZJOR4vVharCinj2vuvWvOHAQ950=
Received: by 10.86.33.10 with SMTP id g10mr3893405fgg.47.1236100439020; Tue, 
	03 Mar 2009 09:13:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0903031246420.3702@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112124>

On Tue, Mar 3, 2009 at 2:48 PM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Dmitry Potapov:
>
>> The C Standard requires that the type wchar_t is capable of representing
>> any character in the current locale. If Windows uses UTF-16 as internal
>> encoding (so, it can work with symbols outside of the BMP), it means you
>> cannot have 16-bit wchar_t and be compliant with the C standard...
>
> No, that's not quite correct. wchar_t is defined to be "an integer type
> whose range of values can represent distinct codes for all members of the
> largest extended character set specified among the supported locales". Since
> Windows defines all local character sets as Unicode-based, having wchar_t
> defined as Unicode means that it can represent everything.

No, it does not, if you have wchar_t that is only 16-bit wide, because
characters
outside of the BMP have integer values in Unicode greater than 65535...

Dmitry
