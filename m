From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: How to import bzr repository into git
Date: Tue, 16 Nov 2010 19:22:58 -0500
Message-ID: <4CE32062.6010308@gmail.com>
References: <AANLkTinVrwkOvYgGFX3S2530jfWnrAP28gVm4te1B4sC@mail.gmail.com> <AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitri Pissarenko <dmitri.pissarenko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 01:23:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIVnt-00029i-74
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 01:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759535Ab0KQAXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 19:23:05 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49534 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759534Ab0KQAXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 19:23:03 -0500
Received: by qyk4 with SMTP id 4so1423765qyk.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 16:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=51sUDdibUy5R54RjjMz9shgUIMIucOrIAF46W4x9hRU=;
        b=Gv4X2usBkw66SH7Q1K1KEqMsrWPRaDuniIZtT6sgkWkpEBL9EbcuWUIJ3t8yzKCb5k
         artYrbXXaMdA9n8sNtlD0K2WSjqk4U50DtQuaLTTiD5HuR2XY+++YKjQ0U+eUtgIwDym
         FIeKTC+ad5dncly3BZPlQSI3rXczj5Lu4stkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=EgOvx0JzGEcGXmkcM3nQ+/aSG7lMfY6+uJRISSaerfvlzXToi7Poqj/a6LRTF1+Niq
         tft5tknR9B9NJFDEUFk6GsHPLo3OYPgPi3aFzjLgdi339FY7TCAraOhPOg+T/wuyABia
         WO5ML6kshfkbhskBwbhK4BghxxjFg/dikqXZA=
Received: by 10.224.11.147 with SMTP id t19mr5593450qat.166.1289953381536;
        Tue, 16 Nov 2010 16:23:01 -0800 (PST)
Received: from [192.168.2.207] (dsl-147-180.aei.ca [66.36.147.180])
        by mx.google.com with ESMTPS id m7sm1149231qck.37.2010.11.16.16.22.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 16:23:00 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.15) Gecko/20101030 Iceowl/1.0b1 Icedove/3.0.10
In-Reply-To: <AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161593>

On 11/16/2010 02:57 PM, Dmitri Pissarenko wrote:
> Hello!
> 
> I want to migrate one of my projects from Bazaar to git, preserving the history.
> 
> How can I do that in Windows (import an existing Bazaar project into a
> new/empty git repository) ?
> 

Have a look at "bzr-fastimport" [1]. it's a Bazaar plugin that can help
you to transform the bzr history into a git one.

[1]: https://launchpad.net/bzr-fastimport

I haven't done a lot of testing with shared-tree Bazaar repositories (a
repository with multiple branches in it) but I suspect it would not work
very well with such a layout.. If you're doing a one-time conversion of
a one-branch repository, it works pretty well.

Once Bazaar and the bzr-fastimport plugin are installed, you mostly need
to run those commands :

    git init project
    cd project
    bzr fast-export --export-marks=../bzr.mark /path/to/old/bzr/project
| git-fast-import --export-marks=../git.mark

you now have, in the new git project, a "master" branch with all the
history from the bzr repository and all tags.

-- 
Gabriel Filion
