From: Nix <nix@esperi.org.uk>
Subject: Re: [PATCH] Support sizes >=2G in various config options accepting 'g' sizes.
Date: Mon, 05 Sep 2011 00:49:29 +0100
Message-ID: <87fwkbool2.fsf@spindle.srvr.nix>
References: <CA+Jd1rGjkiabc9VePMmY6+8vhiGr7MgdwSNFToMsC0oBFNL6+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzdtt@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 01:49:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0MRY-0000OR-Tp
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 01:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab1IDXte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 19:49:34 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:48962 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab1IDXtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 19:49:33 -0400
Received: from esperi.org.uk (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.4/8.14.3) with ESMTP id p84NnT2W002952;
	Mon, 5 Sep 2011 00:49:29 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.14.4/8.12.11/Submit) id p84NnTOA004193;
	Mon, 5 Sep 2011 00:49:29 +0100
Emacs: why choose between a word processor and a Lisp interpreter when you could have neither instead?
In-Reply-To: <CA+Jd1rGjkiabc9VePMmY6+8vhiGr7MgdwSNFToMsC0oBFNL6+g@mail.gmail.com>
	(Clemens Buchacher's message of "Mon, 5 Sep 2011 00:20:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-DCC-wuwien-Metrics: spindle 1290; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180705>

On 4 Sep 2011, Clemens Buchacher uttered the following:

> On Sep 4, 2011 11:25 PM, "Nix" <nix@esperi.org.uk> wrote:
>>
>> I haven't tried to fix things on 32-bit platforms, because there
>> is no real point setting any values to >2G on such platforms
>> anyway, and minimal likelihood that anyone would try.
>
> I absolutely would not count on that.

I was just operating under the assumption that since nobody had spotted
this in years... OK, OK, perhaps that's a bad idea.

>> The only
>> real fix possible would be a diagnostic warning of an attempt to
>> set a ridiculously high value, unless we want to use 'long long'
>> everywhere, which I doubt.
>
> I think an error message would be appropriate. Best if we die immediately
> when that option is read.

Yeah. None of the affected options impact the pack format (as, say,
pack.depth does) so there is no danger of 32-bit users being barred from
reading packs created by 64-bit users with high values for these
settings.

(We have no way of guaranteeing that we can even report this, though:
 we can only even read in a >32-bit number if NO_STRTOULL is not
 defined. Still, I agree that if we *can* report this, we should.)

>                           We wouldn't want e.g. clone to die when it just
> finished downloading. And some documentation for those limits would be
> great, while you're at it. :-)

I'll send a new patch tomorrow.

... hm, pack.packsizelimit is also affected. I'll plug that too.

-- 
NULL && (void)
