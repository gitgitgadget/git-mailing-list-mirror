From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Fri, 19 Jul 2013 14:17:52 -0400
Message-ID: <51E982D0.5040505@gmail.com>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com> <1374245631-15955-1-git-send-email-mlevedahl@gmail.com> <7vtxjqwlj2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 20:18:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0FFg-0002my-FD
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 20:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760995Ab3GSSR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 14:17:56 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:32919 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760991Ab3GSSRz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 14:17:55 -0400
Received: by mail-qc0-f171.google.com with SMTP id n1so2480776qcw.2
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6zD172pIQPFJYy0OtaMD2mY6BL9qnHZxeL9f9VpRPzU=;
        b=GxLJ+goXFYWvCdAfojU2fcTico1mb31JlF7rY053JCN+OkobCCRpGMbs9GFtREuzQT
         fLRihuqA7xF6xCUoxB8VB+t7A/k2Ycb69ntYsS3Rn8TjZJzNFdHTWYmxr1G8KvOUNSXA
         gmAiJtw2Z3zFiYJEzmrQSm6t4O7FSh83hoZfrE0PAd3C3glup5zQAxg4zHQF221veZrx
         NEMZ4tMilCm1GH/EHa3sBDqXip/kwofNAV1Grv//akNawjzp33AO4UJRy4OGOg90bycs
         5eVRYwpIHahaYhEC9TFsnoiRkjqVAMFSjNEAtDTM/OfQMIEJpZ+tvZA8YX3FxW7uTRjy
         EzmQ==
X-Received: by 10.49.85.4 with SMTP id d4mr19215538qez.10.1374257874399;
        Fri, 19 Jul 2013 11:17:54 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id 2sm24086615qap.7.2013.07.19.11.17.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 11:17:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <7vtxjqwlj2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230835>

On 07/19/2013 12:40 PM, Junio C Hamano wrote:
> Thanks, will replace.
>
> What do we want to do with the compat/regex build-time switch?
>
> IIRC, this was only needed for 1.7 and not 1.5, and I also would
> expect (without anything to back-up, so this is more a faith than
> expectation) over time the "new library" would have a working regex
> library.
>

The situation is that Cygwin uses newlib rather than glibc, and does so 
for licesnsing reasons (redhat sells licenses to developers allowing 
closed source applications built using Cygwin). So, there must be a 
compelling need to fix the library - git has a simple work around, so 
isn't the case. Also, Cygwin has a perl regex library for those 
demanding more complete / correct regex solution. So, I make no 
prediction on when the newlib regex functions are fixed.

Related: Should we have separate settings for 1.5 and 1.7 for several 
variables? Conflicts I see not reflected in config.mak.uname on pu:
     trustable filemode   (1.7 has, 1.5 does not)
     MMAP/Pread (1.7 pread is thread safe, 1.5 I dont think was, MMAP 
utility is convolved in this)
     regex - 1.7 is broken, per Ramsay 1.5 works

If you think its worth it, I'll create a patch series with the above and 
justifications for the different settings that I know.

Mark
