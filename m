From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: permissions and packed-refs?
Date: Thu, 10 Apr 2008 20:21:38 +0100
Message-ID: <320075ff0804101221n376e0c8mf9114f25dea6b2af@mail.gmail.com>
References: <320075ff0804100530s2af22cc9r43208101e46a8154@mail.gmail.com>
	 <10723DA2-555B-40DB-8428-BDF07CA2510E@manchester.ac.uk>
	 <135BAC69-9549-4E61-BD6F-A99364C27CCC@sent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robert Haines" <rhaines@manchester.ac.uk>,
	git <git@vger.kernel.org>
To: "Logan Kennelly" <logank@sent.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:29:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk2Lt-00031B-Qc
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 21:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbYDJTVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 15:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYDJTVp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 15:21:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:24151 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbYDJTVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 15:21:44 -0400
Received: by fk-out-0910.google.com with SMTP id 19so147569fkr.5
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MSg2AxUrKbpEaSUcv0IM0UuK34jHEAANF52XYjhI7yU=;
        b=VCJMoFBCOU4cIGsdkKTqXf+6hIwMZe+vkmQ2eKR6pCfTmXTu6ZNTseB7IdohoSurdo87vwf14tZE/fxFGD40qCq8gWCYyaBLcoBVidKJbShjoFxH0g8hv78Bk8rHXZXql/ibjQAvbkGfl50eDM6RRUy0gIW4F4BUCSyLiGxKbk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hHPQrJNe1UYDJpnZdmNl8A8O5vOu0e+nx4BKRdxWMj21lcjkI9gNZzJY5Tc2t5CDLCDkOyuvKGdi7bYsMlzbdQMIEEOVJ3uxj9Wby7lScC4cn9g8Ao2VSVRy1y5LJmrLERap6SubXoPh6y2R7NvJivAdsxNvcoFHgAbN5UISYCU=
Received: by 10.82.146.10 with SMTP id t10mr2893937bud.6.1207855298404;
        Thu, 10 Apr 2008 12:21:38 -0700 (PDT)
Received: by 10.82.169.1 with HTTP; Thu, 10 Apr 2008 12:21:38 -0700 (PDT)
In-Reply-To: <135BAC69-9549-4E61-BD6F-A99364C27CCC@sent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79243>

Yeah, I think that's probably what's happening. TBH it's a bit of an
ache to have to make sure umasks and things are set correctly, and
it's probably partially that the repo was set up just from a direct
copy of someone's machine.

We've reverted to using a common account user for now.

On Thu, Apr 10, 2008 at 7:19 PM, Logan Kennelly <logank@sent.com> wrote:
> On Apr 10, 2008, at 9:21 AM, Robert Haines wrote:
>
>
> > I've seen this after git gc too. Has the owner of the affected files
> changed? If so you need to make sure that git gc is run by the correct user.
> If you run it as root for example, everything it touches will end up owned
> by root!
> >
>
>  Not only that, but you must make sure that you have the appropriate umask
> set. I'm not sure if this affects the pack file, but the reflog is certainly
> rewritten in a way that prevents other users from pushing.
>
>  I've been meaning to submit a patch to make git better honor
> "core.sharedrepository" (it's probably as simple as adding a couple calls to
> adjust_shared_perm), but the workaround was so easy that I had forgotten
> about the issue.
>
>  --
>                                                         Logan Kennelly
>       ,,,
>      (. .)
>  --ooO-(_)-Ooo--
>
>
>
>
