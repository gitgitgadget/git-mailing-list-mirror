From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSoC microproject] Add XDG support to the credential-store helper
Date: Fri, 06 Mar 2015 18:28:57 +0100
Message-ID: <vpqa8zq9grq.fsf@anie.imag.fr>
References: <20150305215146.394caa71@gentp.lnet>
	<CAP8UFD3kHKsUWqmfr3mEtTYwVFwGGqMF_wJgVQyoaH=2i9Ge=A@mail.gmail.com>
	<20150306001534.06882282@gentp.lnet>
	<20150306004139.2dac2502@gentp.lnet>
	<CACRoPnR3i3pTyqcxm0iELP0uR9cL2kvm9fd7BQPVpbLB0UBNVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luis Ressel <aranea@aixah.de>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 18:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTw3n-0003p3-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 18:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbbCFR3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 12:29:08 -0500
Received: from mx1.imag.fr ([129.88.30.5]:34667 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbbCFR3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 12:29:07 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t26HStN0016369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Mar 2015 18:28:55 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t26HSvtp028864;
	Fri, 6 Mar 2015 18:28:57 +0100
In-Reply-To: <CACRoPnR3i3pTyqcxm0iELP0uR9cL2kvm9fd7BQPVpbLB0UBNVw@mail.gmail.com>
	(Paul Tan's message of "Fri, 6 Mar 2015 16:04:39 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Mar 2015 18:28:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t26HStN0016369
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426267740.82505@xk8WK94HFHe31z4cm5TROA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264943>

Paul Tan <pyokagan@gmail.com> writes:

> Hi Luis,
>
> On Fri, Mar 6, 2015 at 7:41 AM, Luis Ressel <aranea@aixah.de> wrote:
>> Okay, I've had a look at Paul's patch for this. Sorry again for the
>> dupe, I must've missed it before. I guess I'll attempt another
>> microproject.
>>
>> However, I feel like my patch is really all that's neccessary; I don't
>> think we should try to use both files if they exist -- I consider
>> Paul's approach to be a bit overcomplicated.
>>
>> My patch still uses ~/.git-credentials as a default location, which
>> should be sufficient for compability.
>
> Indeed, that was my initial plan for implementation as well[1]. Matthieu,
> however, wanted the behavior to follow that of git-config[2].

The fact that I suggested doing it this way does not mean it _has_ to be
done this way. Decisions are taken by trying to reach a consensus with
discussion, so everyone is welcome to argue.

I don't remember all the discussions we had about the ~/.gitconfig, but
one issue with considering only one file is if you create
~/.git/config/foo and initially make sure you don't have ~/.gitfoo, and
then one tool creates ~/.gitfoo (either an old Git, or another tool
trying to edit the config file), then you totally break your
configuration.

I argued for not taking backward compatibility too much into account in
another thread, but that was about precedence of one file over the other
which is far less important. Here, any tool creating even an empty home
file would break your configuration.

That also breaks the least surprise principle if you have a ~/.gitfoo
file that you forgot about: edit ~/.config/git/foo, nothing is taken
into account, at all (or the other way around, depending on the
precedence you choose). I remember loosing some time with two vlc
configuration files like this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
