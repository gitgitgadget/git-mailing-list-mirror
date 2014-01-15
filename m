From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the
 defaults
Date: Wed, 15 Jan 2014 13:50:24 -0800
Message-ID: <20140115215024.GM18964@google.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com>
 <xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com>
 <7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com>
 <xmqqob3d0w7g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ruben Kerkhof <ruben@rubenkerkhof.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Igor Gnatenko <i.gnatenko.brain@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 22:50:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3YM7-0000ca-2o
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 22:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbaAOVub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 16:50:31 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64071 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaAOVua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 16:50:30 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so1586762qcv.33
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 13:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=geRM+nKww4zGmFK5Ck2s6ZoqnljSrifuIACJCto5LhI=;
        b=EEFNEU6FuDjxcimGpftGE3vV/t8WSZc9AvY2GcFrphhlCspFnbzmBA3NmybpLsPU3j
         trQ6PPp8rKN3gvEpesGelOkc+DqJ6gie4yVsXy7dkO2wL2p04nuy2vkIcY/OI+QHgsKM
         ebo5PgONX7Ggi8kVK+vB+C4O46GNYs7REedFp8SwMRSdyQ7Lkmy4TiqOEZB+PEGMBOYE
         uklYdcN0YStV1CdSJw6r1NgQP3bD0zvVecAK0q4NLGSMcfaAC31DUjvug7YB3cNA5VW8
         Rws9sPPMyFUV49aLLZGBAk8NhShPouoiMmYA2K2IjbUwomL/gOX1h2HMphLbYBcCiXZK
         iZSg==
X-Received: by 10.140.31.75 with SMTP id e69mr1857263qge.76.1389822629298;
        Wed, 15 Jan 2014 13:50:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h12sm75748qge.0.2014.01.15.13.50.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 13:50:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqob3d0w7g.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240481>

Junio C Hamano wrote:
> Ruben Kerkhof <ruben@rubenkerkhof.com> writes:

>> As a last check, I set smtpsslcertpath = /etc/pki/tls/cert.pem in
>> ~/.gitconfig and git-send-email works fine now.
>
> Which would mean that the existing code, by blindly defaulting to
> /etc/ssl/certs/ and misdiagnosing that the directory is meant to be
> used as SSL_ca_path, breaks a set-up that otherwise _should_ work.
[...]
> Ram (who did 35035bbf), with the patch from Ruben in the thread, do
> you get either the warning or SSL failure?  Conceptually, the
> resulting code is much better, I think, without blindly defaulting
> /etc/ssl/certs and instead of relying on the underlying platform
> just working out of the box with its own default,

FWIW this should help on Mac OS X, too.  Folks using git on mac
at $DAYJOB have been using the workaround described at
http://mercurial.selenic.com/wiki/CACertificates#Mac_OS_X_10.6_and_higher
so I forgot to report it. :/

Thanks,
Jonathan
