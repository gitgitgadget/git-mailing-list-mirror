From: Tzu-Jung Lee <roylee17@gmail.com>
Subject: Re: Do we have a convenient way to refer to a specific commit in an
 already filtered rev-list?
Date: Tue, 4 Oct 2011 01:19:35 +0800
Message-ID: <CAEvN+1gODnGy2v2=d6NXJ8b1nBJgpqj+BkDm2eQC1xqyTKXhEg@mail.gmail.com>
References: <CAEvN+1jPD53-e8a31g+iz6vMB0-e2LECjouBELkBOXBV5=oGBg@mail.gmail.com>
	<20110927213517.GB5176@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 19:19:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAmB4-0001Ec-IQ
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 19:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963Ab1JCRTj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 13:19:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54185 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab1JCRTh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 13:19:37 -0400
Received: by bkbzt4 with SMTP id zt4so5528121bkb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Xr6X8jsEEtNP0+TqPX2xCt2Wuis0mSC59MU2DPL1/8Y=;
        b=ZUFBNxT2EfECqpeqNwpShtb8fwIvh0iPFE0SJjT2tpB2cCbaEF0rodTk9aJmGRr2vy
         5CmEAn/tvHRZjLhzTHU9MEb1mb1R5i65TIo5M05x+Qt2CFwSw13vJufYp1Ky7tk0uTeY
         6MUsE5l/KnjF4kYU5FZS59ckunOFMqh2YgOF4=
Received: by 10.204.153.23 with SMTP id i23mr120849bkw.128.1317662375886; Mon,
 03 Oct 2011 10:19:35 -0700 (PDT)
Received: by 10.204.153.22 with HTTP; Mon, 3 Oct 2011 10:19:35 -0700 (PDT)
In-Reply-To: <20110927213517.GB5176@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182674>

On Wed, Sep 28, 2011 at 5:35 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 25, 2011 at 12:46:20AM +0800, Tzu-Jung Lee wrote:
>
>> Do we have a convenient/symbolic way to refer =A0to a specific commi=
t of
>> an already filtered rev-list? For example, I'm interested in the
>> commits with some constraints:
>>
>> =A0 =A0 git log somepath --author=3Dsomeone
>>
>> Without gui/tui tools, I have to frequently CUT & PASTE the commit-I=
D
>> for further manipulation (show, cherry-pick, ...), and possibly repe=
at
>> the parsing couple of times if I didn't save the output. I wonder if
>> we have a convenient way to refer to the discrete commits? like
>> HEAD~4, HEAD@{3} or something magic.
>
> Use the shell:
>
> =A0git rev-list --author=3Dsomeone HEAD >saved-query
> =A0git log --no-walk --stdin <saved-query
> =A0git cherry-pick `cat saved-query`
>
> or even:
>
> =A0q=3D`git rev-list --author=3Dsomeone HEAD`
> =A0git log --no-walk $q
> =A0git cherry-pick $q
>
> -Peff
>

Cool, this does record and replay.


How about adding a command or teaching some existing one an option
like --saved=3D<ref_name>, which put the saved-list to
refs/saved/<ref_name> ?
And also teach the rev-list to parse or interpret the 'saved' refs diff=
erently.
So we can have the following use case:

   git log branch_foo --author=3Dsome_one -S some_string --saved=3Dcach=
ed_ref
   git log cached_ref
   git cherry-pick cached_ref~4
   git format-patch cached_ref~6..cached_ref~2

I often have such use cases. not sure others would be benefited from
such feature.
Just asking for comment. :)

Regards,
Roy
