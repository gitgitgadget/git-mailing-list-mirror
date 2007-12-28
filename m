From: adr3nald0s@gmail.com
Subject: Re: Anomalous conflicts during git rebase
Date: Fri, 28 Dec 2007 09:35:34 -0600
Message-ID: <m3odca7ry1.fsf@euroclydon.lan>
References: <m3ir2ju5ce.fsf@euroclydon.lan>
	<20071227225703.B33A25A709@dx.sixt.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: adr3nald0s@gmail.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Dec 28 16:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8HBO-0007OS-Q8
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 16:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbXL1PbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 10:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbXL1PbG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 10:31:06 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:23797 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbXL1PbE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 10:31:04 -0500
Received: by an-out-0708.google.com with SMTP id d31so614244and.103
        for <git@vger.kernel.org>; Fri, 28 Dec 2007 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:cc:subject:in-reply-to:user-agent:references:from:date:message-id:mime-version:content-type;
        bh=xEadsMTdvV6jOPif4L6bHSQpNLMHsXfmOpvvESZbTCg=;
        b=S9/hdrxLR1pIs9VU6N3cg/R7pQpbNWF8RlO4V2wApx7xKOQK5+G7jHF4AbQQx/AXSL0P1jU61esG04WKZfN55r5kkON73EudNCQNp1i0aDnhe8V5cfUFUVgez+m4G9CUEYXy0vsPmsxLcDNZF/LPX9KTzSSRB+w2bvTWNG/403M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:in-reply-to:user-agent:references:from:date:message-id:mime-version:content-type;
        b=pj6arRcufnCRcFycbl4e+pCXp2X1HTR/mEaUloKCbZqLbiXVfoNMj4csqHlqC4nyjJolSlONr+MUugoGTJjjtZ43Bfk2NKPNlQSMz3Z2zoIjCEphNPQ1thTWNBlw+XQXbid01fB1PDSVnNSM59tEYTBpNFo3lA/UD9T9vjTF9+g=
Received: by 10.100.194.17 with SMTP id r17mr11846200anf.92.1198855862900;
        Fri, 28 Dec 2007 07:31:02 -0800 (PST)
Received: from euroclydon.lan ( [66.148.187.210])
        by mx.google.com with ESMTPS id b18sm11794966ana.14.2007.12.28.07.31.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Dec 2007 07:31:02 -0800 (PST)
In-Reply-To: <20071227225703.B33A25A709@dx.sixt.local> (Johannes Sixt's message of "Thu\, 27 Dec 2007 23\:57\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69288>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> adr3nald0s@gmail.com wrote:
>> On a clone of linux-2.6:
>> 
>>     git checkout -b topic/test v2.6.15
>>     touch drivers/a-file.c
>>     git add drivers/a-file.c
>>     git commit -m 'Add a file'
>>     git checkout -b temp0 v2.6.16
>>     git rebase topic/test
>> 
>> I get the following:
>> 
>>     Applying [ACPI] handle ACPICA 20050916's acpi_resource.type rename
> ..
>>     CONFLICT (content): Merge conflict in drivers/char/hpet.c
> ..
>> Is this a bug, or is there a reason I am seeing conflicts in files
>> I've never touched?
>

I am not picking on you, Johannes, but I was expecting a response like
this:

> You are using the rebase the wrong way round.

I am very well aware of how rebase is intended to be used.  The
components of git are not always used for their semantic purpose.  As
recommended frequently on this list, it is common to bend them to your
purpose and use them in non-intuitive ways.

The purpose of the commands above is to have a git repository from
2.6.15 forward that has our code, XEN and some cherry-pick'd
back-ported fixes integrated throughout.  We will be doing a lot of
git-bisect'ing to find where various things changed that break our
code and certain edge-case usages of XEN.

So my question stands and it is not, "Adr3nalD0S, why _would_ you do
this?"  It is, "Why does git report conflicts that do not exist?"

P.S.  This isn't the first project I have run into this on.  It's just
the first one where I decided to try and do something about it.
