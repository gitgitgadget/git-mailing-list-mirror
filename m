From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 1/2] commit: add parse_commit_repl() to replace
 commits at parsing time
Date: Tue, 17 Aug 2010 23:24:59 -0500
Message-ID: <20100818042459.GD21185@burratino>
References: <20100817015901.5592.25471.chriscool@tuxfamily.org>
 <7vbp91aqfk.fsf@alter.siamese.dyndns.org>
 <AANLkTimu0r_3L7_YJgfMVb6saFOyOK-mHLiKyTG_6Q5O@mail.gmail.com>
 <201008180607.54675.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Aug 18 06:26:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlaEd-0007aa-OG
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 06:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797Ab0HRE0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 00:26:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47137 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab0HRE0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 00:26:38 -0400
Received: by gyd8 with SMTP id 8so39979gyd.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dMLbpBlLPWf98EFkVFlu3OeYBE8Ued7TNsMqo4+thAk=;
        b=PRm9kxlJqAXTmBY0+nJZSQyOa/YA/rpvF1Ufq2Z7485AkOmM3Tkr/70FpntDiTLG9i
         zqWGr1LrcWgiiB/suAi2qlpN37kg3B40CxPAhLtI2seI88ZbJLoIL4l9IoMu6r3Kpmwi
         2LPVO2MEUj179RmFUl91aqfaCeFXvUiUN2f54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J+wpBzZR3FNDV+yZL/DvSQaK0NGnj7OkkMlpJxZNJzevV2fnl9QC7ETwrt6HNW/QEJ
         0RH8EGL54OYMIKbJ+brJrS1VmI53RdTBMXk6mYA/5atwK15KSgJIE9OU8S1tTZnxRC63
         P7hskAVm1t3QtAgIjHGOfWnfBDCfDWshtjWRA=
Received: by 10.151.9.8 with SMTP id m8mr8214373ybi.367.1282105596475;
        Tue, 17 Aug 2010 21:26:36 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q25sm845810ybk.18.2010.08.17.21.26.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 21:26:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008180607.54675.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153811>

Christian Couder wrote:

> The downside is that the sha1 will not be 
> consistent with the content anymore and that it will be more difficult to 
> realize that an object has been replaced as there will be no sha1 change to be 
> seen.

Maybe in the long run it would make sense to keep a "replaced" flag
and use it to mark the replace objects specially in some user-facing
commands (like log --format=medium).
