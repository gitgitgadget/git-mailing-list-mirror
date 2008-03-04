From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Tue, 04 Mar 2008 03:51:22 -0800 (PST)
Message-ID: <m3k5kiiu60.fsf@localhost.localdomain>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca>
	<alpine.LSU.1.00.0803041044120.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Bremner <bremner@unb.ca>,
	=?iso-8859-14?q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org, 469250@bugs.debian.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:52:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVgk-0008L4-Oj
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894AbYCDLva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756879AbYCDLva
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:51:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:43462 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844AbYCDLv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 06:51:29 -0500
Received: by nf-out-0910.google.com with SMTP id g13so428935nfb.21
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 03:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=KbPFwwZLH8QRd/BSHmj6exZhqkXxRAMYR+N9c/JumP0=;
        b=ADnJ0NVULjfNCEVivxfBzvzM26b5GaRhZGwEQIPg9vRNc3T0FMA7kCanoK2i7Ywo9Phpa7FDKEjYo5J568gk1/I0M7Eq5Exil90/kKxn2mgt2aw3hGbnV4VXiGIYid7v2QcWJkZe+8cmDJUjPcofS2RRgCU6tNWxxgeUl5E+Tck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ogxBXQ4VNuKaLma1peLW/J5u6M15XKSAXSfEfMoYxmjYW1cX509pIhnGKlDW1IIexB0p8kqH87C2vkainbOw7saHUAcTjyh1o9arQNUYRDwB8qOECE0rrUx5l5oYliELVc7Sg3iiGdz0dvHvGN2vbw+fIu1rPa89oK/V/YMyHpM=
Received: by 10.82.186.5 with SMTP id j5mr4201627buf.38.1204631483849;
        Tue, 04 Mar 2008 03:51:23 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.156])
        by mx.google.com with ESMTPS id q9sm1810819gve.10.2008.03.04.03.51.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 03:51:22 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m24Bpcf3011411;
	Tue, 4 Mar 2008 12:51:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m24Bpaf1011408;
	Tue, 4 Mar 2008 12:51:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LSU.1.00.0803041044120.22527@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76072>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Tue, 4 Mar 2008, David Bremner wrote:
> 
>> It looks like line 435 of builtin-commit.c disables stdin for hooks 
>> (with the disclaimer that I first looked at the git source ten minutes 
>> ago).
>> 
>> 	   hook.no_stdin = 1
>> 
>> I'm not sure if this was by design, but just so you know, this breaks 
>> people's hooks.  In particular the default metastore pre-commit hook no 
>> longer works.  I didn't find anything relevant in the docs [1].
> 
> Pardon my ignorance, but what business has metastore reading stdin?  There 
> should be nothing coming in, so the change you mentioned should be 
> correct, and your hook relies on something it should not rely on.

Never mind pre-commit. What about pre-receive and post-receive hooks,
both of which gets data on stdin?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
