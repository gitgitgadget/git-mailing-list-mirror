From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: gitk - error in git repo on cygwin
Date: Wed, 04 Jul 2007 21:58:33 -0400
Message-ID: <468C5049.9040403@gmail.com>
References: <468BA1B8.4010406@gmail.com> <18060.12148.313090.53861@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 03:58:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6GcM-0007jC-Ke
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 03:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbXGEB6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 21:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbXGEB6i
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 21:58:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:31138 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbXGEB6h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 21:58:37 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2218472wxd
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 18:58:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SYoDPsyz0XEBjAcsuh9vnuTfqx1Yj4lzXJkn9JUQq+8Bieo1Un/58Gdljb0p/NMZGZmf3AJYybp4yoDHndfLH0TR+tfyGBgYH4e4ndQNcUVRnCxIRUwWAMPUFLSLzURgGaPjJ40FKFZ00QcWQLvvNv80xBXJoH/WioVmSdtV2S0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bFCfuLKpDkbBhi01/K+1SpNcioyptMGN81IYv1tHaXASc0UorbFhm7A5PlB0zDP8istJn6n8KXb2SJKi5aE5oGR8WLs5uQkH8sCSiIJC+Xx49mzVZVN21ry2U8B+4ia6BNERJpZdVha16MqUOvnHvo4NHM+2euxG5MCLajBktVg=
Received: by 10.70.130.19 with SMTP id c19mr11900267wxd.1183600716160;
        Wed, 04 Jul 2007 18:58:36 -0700 (PDT)
Received: from ?192.168.100.117? ( [72.66.70.164])
        by mx.google.com with ESMTP id 71sm4905014wry.2007.07.04.18.58.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jul 2007 18:58:34 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <18060.12148.313090.53861@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51652>

Paul Mackerras wrote:
> I don't think anything like that has changed.  I think it is probably
> due to the commits being batched up differently in getcommitlines.
> I'll look into it.
>
> Paul.
>
>   
Indeed, it does seem to be something order dependent. I added some debug 
printouts, and looking in proc "rowranges" when the error occurs (for 
gitk f77a29e), I get:

$commitrow($curview,$id) =  8571
[lindex $rowrangelist $commitrow($curview,$id)] = 
29504118f8528f658fd0bfc02d8d78d4c01dc2cc 8571

In all previous cases, the lindex expression evalutates to two sha1's. 
So clearly, the order of processing is different. I did check that the 
input (from git-rev-list) is identical across the linux and Cygwin 
invocations. Shrug.

Mark
