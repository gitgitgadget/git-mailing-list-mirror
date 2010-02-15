From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Mon, 15 Feb 2010 08:48:06 +0100
Message-ID: <4B78FC36.1090108@gnu.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>	 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>	 <20100213223733.GP24809@gibbs.hungrycats.org>	 <20100214011812.GA2175@dpotapov.dyndns.org>	 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>	 <20100214024259.GB9704@dpotapov.dyndns.org>	 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>	 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>	 <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de>	 <alpine.DEB.1.00.1002142025160.20986@pacific.mpi-cbg.de> <37fcd2781002141156n7e2b9673s1eb6c12869facdb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 08:48:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngvgq-0006Nd-Sy
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 08:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab0BOHsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 02:48:15 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:43360 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab0BOHsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 02:48:14 -0500
Received: by fxm27 with SMTP id 27so307728fxm.25
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=totagHjktK7B3JTAbVt18d4nuLY78QmrD/i+1kGyYEY=;
        b=R+IUOAgXYF1n77OMNxF9Qrn+HV1epscAGOKBtLFNQIvbmJTSYA5DnhjeDmMqSFQjjC
         lbGAN5zgrQ1+flRtCVHsf15dX1/9djuS3mQUpzRaGTfZcEf8on7zX1gViYCv12Aa04rr
         OiIIdvRIwpNEoF65uIMcVThh1UNkyXcCpcZmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QhQIAyiNakaz+MI3fbA5Lo5+jP2OUL0VfSUZyHsIk+UA1BSxp2tNJNbVM1/0wfQcpj
         b40mnHyeZj64FjoKXLo8w4WpHzHiU3GdOz1lmISrju8IENxfVNktmo9Y0b2FTdiMZqq2
         SGi/dOE1MsfGDy2bweF+6FZNdzgYcxr5A3iv8=
Received: by 10.223.5.82 with SMTP id 18mr5481080fau.79.1266220093097;
        Sun, 14 Feb 2010 23:48:13 -0800 (PST)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id z15sm9595640fkz.6.2010.02.14.23.48.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 23:48:11 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <37fcd2781002141156n7e2b9673s1eb6c12869facdb2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139992>

On 02/14/2010 08:56 PM, Dmitry Potapov wrote:
> It may not work without enough swap space

No, the kernel will use the file itself as "swap" if it has to page out 
the memory (since the mmap is PROT_READ).

Paolo
