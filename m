From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] hooks--update: new, required, config variable: hooks.envelopesender,
Date: Fri, 23 Mar 2007 12:58:31 +0000
Message-ID: <200703231258.34339.andyparkins@gmail.com>
References: <874poc88ix.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jim Meyering <jim@meyering.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 13:58:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUjLv-0005Tz-Hk
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 13:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422862AbXCWM6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 08:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422870AbXCWM6k
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 08:58:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:20498 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422862AbXCWM6j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2007 08:58:39 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1991567nfa
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 05:58:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UvBWUJflRsuQncDWQSQgA26+soXwRRgxtjuzzMj1hSqAdR35lMPuiJ3SkZMMR9fkVoiSuRLcSsniw6gMHE7z1EwgdVF9Y+ChcXjgjimExJzZkpxNIDahttTKZ14ELkhaQWy8dsuA16Od8RNc0adeyhn+gMO1il0Nb8ACGYf/tu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CsZEtwXX9poOCGXSn82Jkq5hhcaiAT6dFBEdwI1sYw2Fg5HWCbqunyS33CxhIbzl27ImiXADvFt4QDGIByIDFAAQD5vSsjvCIs4ZTKNXMqNHSUw9hEk6NhK+N8vAB2X1Vu8D2NOtWcIDNOjNG1NPPch0ush/KiqgPOIjcuRfzTs=
Received: by 10.78.185.16 with SMTP id i16mr1518308huf.1174654717771;
        Fri, 23 Mar 2007 05:58:37 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id l27sm11510416nfa.2007.03.23.05.58.36;
        Fri, 23 Mar 2007 05:58:37 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <874poc88ix.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42928>

On Friday 2007 March 23 12:11, Jim Meyering wrote:
> This change adds a new, required, config variable: hooks.envelopesender,
> and use that with sendmail's -f option.  This is important in order
> to avoid relying on sendmail's "guess" at an appropriate envelope
> sender address.  Without this, and in the presence of strict servers,
> it is far too easy not ever to be notified, or (more insidious) never
> to receive bounce email.

Won't work.

>From "man sendmail" (although my sendmail is actually exim)

"Set  the address of the sender of a locally-generated message. This option 
can normally be used only by root or the Exim user or by one of the con-              
figured trusted users. However, anyone may use it when testing a filter file 
with -bf or when testing or verifying addresses using the -bt  or  -bv
options.  In  other  cases, the sender of a local message is always set up as 
the user who ran the exim command, and -f is ignored, with one exception."

The hook scripts run under the identity of the user doing the push; so "-f" 
won't have an effect.

I'm not sure why you would even need it; as the above quote says, the sender 
is set up as the user who ran the command.

I've only tested this with exim; perhaps it's different for other mailers.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
