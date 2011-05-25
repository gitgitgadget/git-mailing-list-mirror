From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Why does adding an existing repo as a submodule modify .git/config?
Date: Tue, 24 May 2011 21:06:52 -0400
Message-ID: <4DDC562C.2000204@gmail.com>
References: <irbq5a$h38$1@dough.gmane.org> <4DDAAAD2.1010708@web.de> <4DDB0786.5020006@gmail.com> <4DDB58D9.2090701@cdwilson.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Christopher Wilson <cwilson@cdwilson.us>
X-From: git-owner@vger.kernel.org Wed May 25 03:07:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP2Yz-0002PJ-6S
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 03:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664Ab1EYBG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 21:06:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49501 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932686Ab1EYBG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 21:06:58 -0400
Received: by vws1 with SMTP id 1so5428926vws.19
        for <git@vger.kernel.org>; Tue, 24 May 2011 18:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6pQ6ss2SaD+DcB5M/UmwDSa7f+oLNWFuLlYBa5Vb4R8=;
        b=TjxlHZloBCI6IFjtaUXbQzYf4eMfuvQQpboxCFJ/rReNAQY2/xOXavl8Rb0le9W+Yb
         oM2SzZPOJ1+RD2i946COy/+/f2KwVH4BsyVtFOzUvAj5wJqdumBHAeSr7KBtA8l4PYKp
         bOV8WEvvMlq15weeT9wu4OX1gSPRZLg8mx3GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=Z6PvaoX+GkeDBmFR7GaTwLc6mZfXj7PqcnKNEqbViPEaUO1I+KgR8Lo5I0tzQ02Yy5
         jAkRY6nqSUvUGb69JRwsq+s6BqgeN4Sb4qi6D3CapVijeEcXMX+anI2RC48ruRglCBGM
         Pniq/8oyjZrTs6QhVYEu39GXa5GwhPssWbsbU=
Received: by 10.52.175.6 with SMTP id bw6mr6228253vdc.210.1306285615038;
        Tue, 24 May 2011 18:06:55 -0700 (PDT)
Received: from mark-laptop.lan (pool-108-28-57-40.washdc.fios.verizon.net [108.28.57.40])
        by mx.google.com with ESMTPS id br11sm133561vdb.1.2011.05.24.18.06.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 18:06:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b2 Thunderbird/3.1.10
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4DDB58D9.2090701@cdwilson.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174365>

On 05/24/2011 03:06 AM, Christopher Wilson wrote:
>>
>> Mark
>
>
> Q: Can you elaborate on why a 2 step "git submodule add" + "git
> submodule init" wasn't sufficient?  What is the reason for adding this
> functionality into the "git submodule add" command, when "git submodule
> init" does the same job?
>

git-submodule.sh has evolved considerably over the last couple of years, 
and the behaviour of submodule-init on an already existing module may 
well be different.

However, while you could then change submodule-add to not register the 
submodule, you would now have the condition of having a submodule that 
is checked out in the current tree but *not* registered in .git/config. 
This is the key: .git/config is modified to include all submodules that 
are checked out in your current tree. If you add a remote submodule, 
that submodule is not checked out in your current tree so no entry is 
created in .git/config, while adding one that is already checked out in 
place does modify .git/config. I see no inconsistency here.

Mark
