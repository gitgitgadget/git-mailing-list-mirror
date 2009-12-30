From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t 
	for greater compatibility
Date: Wed, 30 Dec 2009 02:16:59 +0100
Message-ID: <bdca99240912291716g74c35f22r7599f2c254fb1b09@mail.gmail.com>
References: <hhbldr$di8$1@ger.gmane.org> <4B3A7000.4050308@kdbg.org>
	 <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com>
	 <40aa078e0912291655m57ea0081vddf3b64bf27e1d02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 30 02:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPnBX-0007z9-QN
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 02:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbZL3BRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 20:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbZL3BRD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 20:17:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:10793 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbZL3BRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 20:17:01 -0500
Received: by fg-out-1718.google.com with SMTP id 19so4935025fgg.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 17:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vzChscsI41VNKW+z/myc9BH5Jux9cLSu3qiYublEVfs=;
        b=eXumLfC2OH3xKtynH2V4WNOWG7fbTF4lFKPAuI5xtTZFwI4wROporGUBRr6X7B2iD0
         SXRZV8wqjXZA6J4adAY8MGbNpopzkQJP+ZLmnI401v78rFL6qUuFD2phwegUhHyvGQmp
         /ipLSZ17Obc940+QzX6Cu5SHf4YRnkLCPUKoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=whIVHjnasMWV0wkDycDdDtkWFVzaxVftUUy8AJcJzQdb7+Vxib7FLQn6exNoVNCDQC
         OahCBASy/v5/1wd02YPD/eTZvmCu+ZwrZhZ7x7SFDxbHnWMq7e4y2TnY3TSortfy+gS0
         JhlxykJqcCq7QfvU2mwK3Kn2SRedi7KlSUNd0=
Received: by 10.87.73.2 with SMTP id a2mr14713414fgl.34.1262135819786; Tue, 29 
	Dec 2009 17:16:59 -0800 (PST)
In-Reply-To: <40aa078e0912291655m57ea0081vddf3b64bf27e1d02@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135849>

On Wed, Dec 30, 2009 at 01:55, Erik Faye-Lund <kusmabite@googlemail.com> wrote:

>>> Why this? Compatibility with what? What's the problem with the status quo?
>>
>> I wanted to include Hany's Dos2Unix tool (hd2u) into msysGit. h2du
>> depends on libpopt, and either of the two requires the uid_t type, I
>> do not recall which. And while adding the missing uid_t, I felt it
>> would be right to actually use uid_t / pid_t in the function
>> prototypes.
>
> Perhaps I'm missing something here... why do you need to modify the
> git-sources in order to include an external tool?

Because I'm building that external tool in the msysGit environment. As
you know, the way we include external tools (like vim, unzip etc.) to
the msysGit distribution is to create release.sh scripts that download
the sources, apply patches, and build the tool. Patching the original
hd2u sources to include compat/mingw.h was the best way that I saw to
get some required symbols, with only two symbols missing, and those
missing symbols are added by my patches.

Anyway, IMHO the correct declaration of e.g. getuid() is not "int
getuid()", but "uid_t getuid()" etc. So even if the uid_t type was not
required, it's a good change I think.

-- 
Sebastian Schuberth
