From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] checkout: do not switch branch during a rebase unless -f
 is given
Date: Tue, 9 Nov 2010 08:38:16 -0600
Message-ID: <20101109143816.GC18960@burratino>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
 <1285649702-24773-1-git-send-email-pclouds@gmail.com>
 <AANLkTinUudOXmhKW-+rkcpzb-VNnSBLZwGZcjrS6UdMu@mail.gmail.com>
 <AANLkTin19PREB3B68s+ejsgtXwe3CBxZF-caCvRp4UXv@mail.gmail.com>
 <AANLkTinKNF6OEX=k1aepD-Zrm2_4GzHaB+SVHdfTMG-j@mail.gmail.com>
 <20101109140615.GA18960@burratino>
 <AANLkTi=VtP=T7PwY-PcZ9sHy0FjU8Nj=Fe1eWc44Q+OE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 15:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFpLL-0002qv-Tv
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 15:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605Ab0KIOif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 09:38:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56339 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab0KIOie (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 09:38:34 -0500
Received: by vws13 with SMTP id 13so3268825vws.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 06:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jf3WIgtM21M6jONdxaBJdGfLGCN0kz5qnngjMQPrb1U=;
        b=vuDyMq2Prwm8CvyGvbC3pNd4iQPoJF3z6Py8qwI85uqBiMnHpR6bgn2IlXCtXHE7LU
         1oXRzKo+zgq6m60RCFbe+AgS6ZM0nqC1okg1nBg1b3Mr+Am9GuPDRbT2AO0QJO4voYqx
         zYdNwCwDhoN4rkEz3/bclX3Ku+z0CnjM5pqA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E4igALVzbl8Am3NoioYBxuAld+lwptvycH6VukL9AhVZXXhlVTBgVOIuHMlxoYPsRK
         /BCsGGLn7nVkGeKr3RY3r1MKat+Qi7yJ4KKgOrM9nLDQqQVXNdnft3XEy3rnF3Ien1Kz
         jUpiGsgGlZx2GBLSVre8O4JO/hpZcCQe4jhPg=
Received: by 10.224.54.134 with SMTP id q6mr4906672qag.278.1289313513374;
        Tue, 09 Nov 2010 06:38:33 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm1021966qcb.27.2010.11.09.06.38.31
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 06:38:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=VtP=T7PwY-PcZ9sHy0FjU8Nj=Fe1eWc44Q+OE@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161052>

Nguyen Thai Ngoc Duy wrote:

> I don't know. If we can place the branch lock inside
> .git/rebase-merge, then yes removing that directory will also remove
> the lock. But how does git find the locks if they are everywhere in
> .git?

Could the lock signature say something to the effect that "this lock
is only valid against commands that don't declare this signature, and
only so long as .git/rebase-merge/ref has such-and-such content"?
