From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon, 17 Nov 2008 10:03:18 +0000
Message-ID: <e2b179460811170203v41e54ecclc3d6526bcc0fe928@mail.gmail.com>
References: <200811121029.34841.thomas@koch.ro>
	 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
	 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
	 <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org>
	 <7vtza95h01.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:04:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L20yB-0005Vu-Fk
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbYKQKDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbYKQKDU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:03:20 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:50356 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbYKQKDT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:03:19 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1154289qwe.37
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 02:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3tKepI4jzqmt0ZnHxyk+cU3mJykvhvtrEZfVIBZiixI=;
        b=Mk+Qj0nFDMEZXx+VaIX9q7Fis1DyTMKp0GVS4WoCtfLl2WpM2aLSXh3clxl7R5BsLD
         tm1COtr6mXWkbcqW5ShZcRRDku6PsoGnTAoNqxxydDtiUTSj0lWdzhk+xEbOoWrp4D2/
         LSsvQrDRT2Ja0sgNx5km7plGGclrVyouK+mXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=J0M4v6XZHB4lxo30UOs0DiqurgnFpeOPcKVsXMpH1PcRwaKoYJJWMI6XKc28JNuFgn
         4wFQa8f9RJ1TKNH0Yp1WjLRpxUqYPOe2MUO4svftuXU4RSpUHAAvZ7NZOU4Xp48jeYwD
         dKppq6iSuxIfY7pdozoLgXTyLGUqZ2/v348e8=
Received: by 10.214.242.17 with SMTP id p17mr2210664qah.367.1226916198282;
        Mon, 17 Nov 2008 02:03:18 -0800 (PST)
Received: by 10.214.81.4 with HTTP; Mon, 17 Nov 2008 02:03:18 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101204>

2008/11/15 Linus Torvalds <torvalds@linux-foundation.org>:
>
> On Sat, 15 Nov 2008, Junio C Hamano wrote:
>>
>> This introduces make variable NO_PTHREADS for platforms that lack the
>> support for pthreads library or people who do not want to use it for
>> whatever reason.  When defined, it makes the multi-threaded index
>> preloading into a no-op, and also disables threaded delta searching by
>> pack-objects.
>
> Ack. Makes sense.

I'd be minded to make this the default on AIX to keep the prerequisite
list as small as possible, then people can opt-in for the performance
benefits if required.

I'll wait a little while to see if anyone else reports the same for
other platforms and then submit a patch.

Mike
