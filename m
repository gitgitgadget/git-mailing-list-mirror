From: "Reid Woodbury Jr." <reidw@rawsound.com>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Thu, 2 Apr 2015 13:06:00 -0700
Message-ID: <5B043A67-E2FC-4F40-89C5-915B3D893459@rawsound.com>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com> <20150402180914.GA19081@peff.net> <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com> <20150402191452.GA20420@peff.net> <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com> <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com> <20150402193524.GA21555@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:06:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdlNS-0001dj-1K
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 22:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbbDBUGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 16:06:05 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35455 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbbDBUGD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 16:06:03 -0400
Received: by patj18 with SMTP id j18so94045438pat.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 13:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=n84fnlqzolDlUrYtWlaRdz/o00dP7Q5gcMI8nUXFhXc=;
        b=hwtDNjSI3pswbkURNwRoCGCAeP8ODWCT36V6TBR1Thywi7uPrbVJmn+KjxPCpC3wed
         yPyZAT7a+90tUewT+IgTtObvaQ8gkUEFn88/ksgyfpFilq//KOZQuNLcN7OQHaGTWzcT
         NTQ9f5ZiECuWIq3FtnLWerHduE70rwzmMu8Fl/lS3+kEvI5/RlKW5GQTpQRzaCEaHaHQ
         3Bk4iSHcBxtKEDrW8TRH766kFGvnpB/BScYMOj31CKTM5v++UJh585aSFDK2opwN3r3W
         L+1k4xjIM0Kw1BrtWgBYz11hz6pcO3kyaR5QONE4JQhbGdYmp+GEe2B9I5wO54nigNSt
         Laaw==
X-Gm-Message-State: ALoCoQnG9iSO1iRisTT0j7o/J+1Ts6dbEb0R/8BgODG1leU9MZVD8SF/NUREWDj0ucflBzyeJX/r
X-Received: by 10.68.109.197 with SMTP id hu5mr89625483pbb.126.1428005162447;
        Thu, 02 Apr 2015 13:06:02 -0700 (PDT)
Received: from [192.168.1.87] (107-128-47-25.lightspeed.irvnca.sbcglobal.net. [107.128.47.25])
        by mx.google.com with ESMTPSA id j1sm6038351pdj.94.2015.04.02.13.06.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 13:06:01 -0700 (PDT)
In-Reply-To: <20150402193524.GA21555@peff.net>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266665>

Yup, removing the colon works in both 2.3.3 and 2.3.4. And I see that the manual doesn't use the colon! (eg. $ git clone ssh://user@server/project.git). The usage of the colon looks normal to my eyes because, for instance, SFTP uses it to set the path on login so this wasn't something I would have even considered. I'm sure I've seen it other places but I can't remember right now.

Thanks all for your time.


> On Apr 2, 2015, at 12:35 PM, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Apr 02, 2015 at 12:31:14PM -0700, Reid Woodbury Jr. wrote:
> 
>> Ah, understand. Here's my project URL for 'remote "origin"' with a
>> more meaningful representation of their internal FQDN:
>> 
>> 	url = ssh://rwoodbury@systemname.groupname.online:/opt/git/inventory.git
>> 
>> The "online" is their literal internal TLD.
> 
> Thanks. The problem is the extra ":" after "online"; your URL is
> malformed. You can just drop that colon entirely.
> 
> I do not think we need to support this syntax going forward (the colon
> is meaningless here, and our documentation is clear that it should go
> with a port number), but on the other hand, it might be nice to be more
> liberal, as we were in v2.3.3 and prior. I'll leave it to Torsten to see
> whether supporting that would hurt some of the other cases, or whether
> it would make the code too awkward.
> 
> -Peff
