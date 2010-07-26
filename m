From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: RFC: Between git-subtree and git-submodules
Date: Mon, 26 Jul 2010 01:02:54 -0400
Message-ID: <AANLkTim_XeoEeRBa8VCLMn=rbFb3mvKm6OJ=M7D6YJBz@mail.gmail.com>
References: <AANLkTi=tDRfgzzcbp0jV=+hQ+Cs2fhNF0vK8JL1COoFu@mail.gmail.com> 
	<AANLkTinyjinsGS2ddyMOW=3zDN1ThJcpF+dc4cBE6L9D@mail.gmail.com> 
	<AANLkTikwpruLt-D0tYn+eP5JpB1h0RD55+xr_7S+RfOa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Jul 26 07:03:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdFqV-0007a9-7X
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 07:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0GZFDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 01:03:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64647 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab0GZFDR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 01:03:17 -0400
Received: by wyf19 with SMTP id 19so1788633wyf.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 22:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EN6wW8nAZpiI0sR7LtYCSIXFKqlhgnHVn5yzOM49wuM=;
        b=xqPwm3WIfaF7f5haqKcmTPxdCLIRGDwe2Bqa7B0RUIbr7mOOMRtyD0bAR3e0yQMLoo
         EDa+quSEEZRj6MP77IQD73cLg4gq6vLHVCoKpUXcfX3uqfcVWDF0Y/Ic0ysOw43Zniea
         OGL4m9n4OIm4lzBRiR0VKO2muomI0XCN3pa1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oQFM5SrAHCUdPKXtLKmAC7sMk0LnMZrde9OEk/DhyMbqfT0q6UfDpjON/IpqB8S76c
         WccC9FyL1CfCwsGWdqCuCzVK7b8QoPhEb+f+wZvcrxPdQkCR8gCgRM0k5h4tBwtkmLqa
         7h4RCZYgeRCa3w6741r30L+SzcvSiZ5xujUX8=
Received: by 10.216.93.16 with SMTP id k16mr6910545wef.78.1280120594327; Sun, 
	25 Jul 2010 22:03:14 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Sun, 25 Jul 2010 22:02:54 -0700 (PDT)
In-Reply-To: <AANLkTikwpruLt-D0tYn+eP5JpB1h0RD55+xr_7S+RfOa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151805>

On Sat, Jul 24, 2010 at 8:28 PM, Santi B=E9jar <santi@agolina.net> wrot=
e:
>> With #3, I can see that you want something different than I do; you
>> want to silently revert your own patches out of the submodule's
>> history, when you upgrade the submodule to a new version. =A0Persona=
lly,
>> I find this concept a bit objectionable (it's like "git merge -s
>> ours"), but okay, it's pretty easy to implement, and you've submitte=
d
>> a patch to git-subtree that does it. =A0My question is: why would yo=
u
>> want this? =A0Isn't it clearer to 'git revert' the patches you don't
>> want?
>
> While writing the docs for the --prune option I've found this sentenc=
e in
> git-subtree.txt:
>
> =A0 =A0 =A0 =A0'git subtree merge --squash'
> =A0 =A0 =A0 =A0always adjusts the subtree to match the exactly
> =A0 =A0 =A0 =A0specified commit, even if getting to that commit would
> =A0 =A0 =A0 =A0require undoing some changes that were added earlier.
>
> I think this is not true, and it contradicts with what you've just sa=
id. Or I
> don't understand it correctly.

I agree that this is a bit unclear.  Basically it rewinds the *base*
of the subtree to match the commit you specify.  Patches you've
applied locally are not removed.

What it actually does is it creates a new commit that applies the
following patch:

    git diff oldbase newbase

If you've made any of your own patches that conflict with this, it'll
generate the conflict and then stop.  Otherwise it'll merge in your
changes as you might expect.

Have fun,

Avery
