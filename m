From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Clone from shallow bundle bug
Date: Thu, 2 Apr 2015 07:33:11 +0700
Message-ID: <CACsJy8Cew0t9EZ5aVSCa-BehWz+ABRhDbtLR2cJ2K9c38QeGsA@mail.gmail.com>
References: <551B0D37.5070407@ubuntu.com> <xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com>
 <551B5E64.9070906@ubuntu.com> <xmqqtwx0mka8.fsf@gitster.dls.corp.google.com>
 <CACsJy8AiOsSJ7QsOmpy5Ss_fKaDK1G4ONgi=jDqM_+Vrv++pkA@mail.gmail.com> <xmqqh9szn4t3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 02:33:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdT4s-0002Wc-HZ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 02:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbbDBAdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 20:33:42 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35364 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbDBAdm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 20:33:42 -0400
Received: by igcau2 with SMTP id au2so63471882igc.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 17:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CoJlQJgWzwRpQ4jNbtFEwfuJadjlPAmOTjuZVhQYWXU=;
        b=YLogOkzgLEBzw2aSGrVeHeptwIfMJkNpkkWRG0P/qPn6pUUQhupuiSrk9dt43ekdQR
         ZJYY7tWIwkM4WtXTUchid/a7CRaoIpp9Prn9PPziMIFakvq2Kwi3a5o81dQCkPyyORQX
         AaZNsNvzt7nya02sl7jhZcQUXnZCqxYBEbQ48XTxcZ7X9LTFL/vsmUi8QlLQdGJJguii
         V0f5OSHyUBdq4J0y6P7P3Vn4yJTAOUcaoMuHMlihHMN0c025g249zTen5q4t/l1m74rj
         he2YnMDHXWk7ka8CLQ2fJVHitL2zSomR4AGYAMwE+DlFEEhdD734rROKlnXkITX93mb2
         /92g==
X-Received: by 10.50.122.5 with SMTP id lo5mr16032270igb.37.1427934821338;
 Wed, 01 Apr 2015 17:33:41 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Wed, 1 Apr 2015 17:33:11 -0700 (PDT)
In-Reply-To: <xmqqh9szn4t3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266625>

On Thu, Apr 2, 2015 at 12:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Alternatively, we can record SHA-1 in the shallow file as refs whose
>> name is always ".shallow". This way "unbundle" can recreate the
>> shallow file if it wants.
>
> Wouldn't the extracting end care about such a name ".shallow" being
> duplicates (if you have multiple boundaries) or not check-ref-format
> kosher?

I think we are careful to ignore funny ref names, so it should not be
a problem. But I haven't tested this.

> I was hoping we will have a solution for a new bundle command to
> create a bundle out of a shallow repository that is somehow usable
> by existing 'git bundle' implementations.  You may take a bundle out
> of a shallow repository to preserve your work on top since you made
> the shallow clone originally, and then send it to your friend with
> existing 'git bundle' implementation to extract it into his full
> clone to sneaker-net.

OK two additional options on top of what we already have:

 - save .have and add extra prerequisite SHA-1.
 - create a bundle that does not hit shallow boundary in the first
place, roughly speaking it's "max depth minus one". This one does not
have extra .have or prerequisites
-- 
Duy
