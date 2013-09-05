From: John Szakmeister <john@szakmeister.net>
Subject: Re: Zero padded file modes...
Date: Thu, 5 Sep 2013 13:13:40 -0400
Message-ID: <CAEBDL5UiEurFeZg1AuNUKEvBMDs3K3D5ZiF5rB-dYWjp5nvrEA@mail.gmail.com>
References: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
	<20130905153646.GA12372@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 19:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHd7p-0007aX-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 19:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab3IERNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 13:13:42 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:60033 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3IERNl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 13:13:41 -0400
Received: by mail-wg0-f52.google.com with SMTP id m14so2027464wgh.7
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=awHUgp3UuGKAElW8Nu0NFIt4qaUnXvkMFUo1wxehUW0=;
        b=EfMhdzSBPAr+zyfjP3LHyvVg7RtsnihvtTg50Rx58kqkmZEfNmBoDmCMGObqAM1G46
         cUs4NEa1qRuuOrP4JkADu8y+pAnvMn5AsTD/C/S8geNfWTwFzC9o3P4LnewBEylSPEpw
         zy/Hpfc/Snf3K+6iyQwBVDs9ED8Rs4x7MJn+h/nPvg9ySclV51XKud1IkBKTyqOpSCAS
         yX1gRUOl5xIv/gJ5Q/DjoJ4UvCx6cU94FumcDBqL0VpKVPSWjIXNXvILgns0WCaVoOpW
         zTrELhGTo7inOsyZrFV/OC2ZwHOX8AIhlGyxI34y87Rv3ND4BY1HAn8aPII9DNwTubAx
         vZPg==
X-Received: by 10.181.12.104 with SMTP id ep8mr7127552wid.54.1378401220282;
 Thu, 05 Sep 2013 10:13:40 -0700 (PDT)
Received: by 10.180.90.105 with HTTP; Thu, 5 Sep 2013 10:13:40 -0700 (PDT)
In-Reply-To: <20130905153646.GA12372@sigill.intra.peff.net>
X-Google-Sender-Auth: jnHzuhGEWEI41D_SwoS0PKDyTSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233971>

On Thu, Sep 5, 2013 at 11:36 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 05, 2013 at 10:00:39AM -0400, John Szakmeister wrote:
>
>> I went to clone a repository from GitHub today and discovered
>> something interesting:
>>
>>     :: git clone https://github.com/liebke/incanter.git
>>     Cloning into 'incanter'...
>>     remote: Counting objects: 10457, done.
>>     remote: Compressing objects: 100% (3018/3018), done.
>>     error: object 4946e1ba09ba5655202a7a5d81ae106b08411061:contains
>> zero-padded file modes
>>     fatal: Error in object
>>     fatal: index-pack failed
>
> Yep. These were mostly caused by a bug in Grit that is long-fixed.  But
> the objects remain in many histories. It would have painful to rewrite
> them back then, and it would be even more painful now.

I guess there's still the other side of the question though.  Are
these repositories busted in the sense that something no longer works?
 I doesn't appear to be the case, but I've not used it extensively say
I can't say for certain one way or another.  In the sense that the
content is not strictly compliant, transfer.fsckObjects did its job,
but I wonder if fsck needs to be a little more tolerant now (at least
with respect to transfer objects)?

I can certainly cope with the issue--it's not a problem for me to flip
the flag on the command line.  I think it'd be nice to have
transer.fsckObjects be the default at some point, considering how
little people run fsck otherwise and how long these sorts of issues go
undiscovered.  Issues like the above seem to stand in the way of that
happening though.

-John
