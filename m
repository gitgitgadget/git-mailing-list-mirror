From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] "status --ignored"
Date: Sat, 10 Apr 2010 12:20:42 -0700 (PDT)
Message-ID: <m3fx33glob.fsf@localhost.localdomain>
References: <20100410040959.GA11977@coredump.intra.peff.net>
	<1270885256-31589-1-git-send-email-gitster@pobox.com>
	<20100410074430.GA12567@coredump.intra.peff.net>
	<7vd3y7ycgu.fsf@alter.siamese.dyndns.org>
	<20100410084007.GA16843@coredump.intra.peff.net>
	<7v633zxiw4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Eric Raymond <esr@snark.thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 21:20:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0gEd-0001Fs-MB
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177Ab0DJTUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 15:20:45 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47104 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab0DJTUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 15:20:44 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so26194bwz.21
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Vf7YF1NQD4hIPtg4Y2BQUZHqBh6bxKUTbP9oHQbXoPs=;
        b=MZH9f0FiCKVwbnVOSHrMolmZQ4vXeIFoXJ5ysyeg5WRvLeyGZKvyo4cPhRXd94oUFM
         hHdPQAnbOCCPFwmcd2p1r10GC1B0y+anIVJIq71OTiiQ7TEfnY2LA1Q08a28r8pvqOmA
         Wh942oyTAAUQlsxSfRtIJoTdT6paFaKjk0YU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=j5z5SEM2GiedNTmpSUHvVMudLaolkrmUa98eV9cj9S8LOdlm+ryVNvrtz8pDRDfEZq
         OLjoggZujMtGgWGsOTp2JOLuVh/DwzpZSkS36k5gCIcHZohl/pJVjWxqaennL7U7pyW8
         vilxobKrkgc4L/KbnxTBC9D9O4CBciCaHLZBw=
Received: by 10.204.80.99 with SMTP id s35mr1914962bkk.183.1270927242648;
        Sat, 10 Apr 2010 12:20:42 -0700 (PDT)
Received: from localhost.localdomain (abvp94.neoplus.adsl.tpnet.pl [83.8.213.94])
        by mx.google.com with ESMTPS id a11sm21414198bkc.21.2010.04.10.12.20.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 12:20:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3AJJxdG023985;
	Sat, 10 Apr 2010 21:20:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3AJJWWL023981;
	Sat, 10 Apr 2010 21:19:32 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v633zxiw4.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144580>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> 
> > ... But finding every file means
> > we have to traverse areas that git otherwise wouldn't look at, which
> > might mean going to disk to pull in all of the "foo/" directory
> > structure (which is less likely to be cached, since the rest of git
> > isn't touching it), even though it may not even be of interest to us.
> 
> Yes, that is why it is adequate for us use COLLECT_IGNORED in "git add"
> and give "foo/ is outside---you as an intelligent human should be able to
> infer that your foo/bar is also" without double traversal.
> 
> Eric's tool might want the same abbreviated information if it is just
> relaying our output to an intelligent human.  Or it might want to get all
> paths if it wants to operate on them itself.  Knowing VC I chose to
> illustrate how to do the latter, but in the real implementation, we may
> want --show-ignored=normal vs --show-ignored=expanded to support both
> uses.

Or rather -i / --ignored-files[=(no|normal|all)], default to 'normal' 
in the '--ignored-files' form (without optional <mode>), similarly
to currently existing -u / --untracked-files option to git-status.

Let's not introduce yet another CLI inconsistency^TM in Git... ;-)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
