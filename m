From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: fix ls command with empty path
Date: Thu, 8 Mar 2012 13:32:20 -0600
Message-ID: <20120308193220.GA27916@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308070951.GA2181@burratino>
 <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
 <CA+gfSn8bh-tV+uduM7xsuwqXQW2a57yvVmRXjXjp9JaO779bUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 20:32:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5j4n-0002ly-Uq
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 20:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758401Ab2CHTcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 14:32:32 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57642 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab2CHTcb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 14:32:31 -0500
Received: by yhmm54 with SMTP id m54so465401yhm.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 11:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vc8PfZYZZ8Vw8o7kMh4H9fTkPZ0boaYYKOG2wkVQJxY=;
        b=nc6kcNTDBrTu6pfVMg59i/jUweypArCTwcH+AQRCEFRNP+OCJ3reba0nn6hiCkZ1vn
         BYT+8oSDwAy8/w93ccrrjLp0/3hFTKeQpvTaqefY1cPc/EcqpvLgl4+mZSdCa/mXaeNa
         qNuDy0o2QA4mnIdHgZEjpNOAlGvkiulX0MH3gGy4yA89s5KbrfUdBOUocEPgSU7MlV4P
         kTrlnnLEiWUo1Tlz8G/B2zH2bgozEhKhzivNrOM3/JgG0cNl3k4W9P6J24R0TrvpwkEz
         zkr8RNdp/j/Q1StAKG4eN53l244Q8oQW3XFYG3qlUIhkXzsOxxpHrzu8NpWY8C9FU2sH
         8eVA==
Received: by 10.60.7.102 with SMTP id i6mr3088861oea.9.1331235150178;
        Thu, 08 Mar 2012 11:32:30 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q5sm1399096oef.3.2012.03.08.11.32.28
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 11:32:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+gfSn8bh-tV+uduM7xsuwqXQW2a57yvVmRXjXjp9JaO779bUg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192636>

Dmitry Ivankov wrote:

>  One more quick thought. "force the root mode to S_IFDIR" part doesn't
>  look obviously good for me.

It was just a problematic and incomplete version of what your "be
saner with temporary trees" does properly. ;-)

[...]
>  P.S. looking at [1] now I'd say the commit messages could be improved there
>
>  [1] http://thread.gmane.org/gmane.comp.version-control.git/179426

Yes, please.  Or patch 2/2 could be split into multiple patches,
perhaps along the following lines:

 - ls "" support, as in David's patch
 - ls <dataref> "" support, which requires the "be saner with
   temporaries" fix
 - D "" support, maybe.  (As you mentioned, we have deleteall so
   compatibility would dictate not supporting it unless some frontend
   is using it already by mistake in some circumstance.)
 - C "" <dest> support, as in my reply to David's patch
 - R "" <dest> support

Thanks,
Jonathan
