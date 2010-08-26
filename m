From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Compiling git with makepp patch
Date: Wed, 25 Aug 2010 19:20:46 -0500
Message-ID: <20100826002045.GC2850@burratino>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de>
 <4C71A53F.2020108@t-online.de>
 <20100824043220.GA20037@burratino>
 <4C758016.8070104@t-online.de>
 <m262yyuzk4.fsf@igel.home>
 <7v8w3upan6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, occitan@esperanto.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 02:22:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoQEp-0004vb-QF
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 02:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab0HZAWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 20:22:35 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36599 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0HZAWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 20:22:33 -0400
Received: by qyk33 with SMTP id 33so1143262qyk.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tD7yfxiP6yB/gT6sDGClACow8CB0T0+MxeE4l+CoOn4=;
        b=VIMzHgh2kJTmvFE5/l6K3CE3qgih+ymN/S4fPx6/sVGJgcbj50hPkzGe6HgQ/4q7m3
         NupF+c05Qc28+Lcv1GOdjJSUQunwmBjS2I3niFkU+uo0+E8htArVaotRc3pyoOEVRg1L
         NmjAMt1UoKjE66Jo7ECBRfDS1bW/YtKoA1IPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Gc75xydpXrpmWlORotyohRN6QPMbvsAYuozS4TaAWQoxgKd/58CIgHJ8QSJRNyB3xp
         Khkv+cFS4UDglIQmOI0Zsxpcoy8gXRpc5VUDEcoqaUoYXabOBbCsfn1QvA9d2P+q6zEV
         M6q7iZnTn+He4Y20I0mqfYZ2GnZDOMC4DLzkA=
Received: by 10.229.186.211 with SMTP id ct19mr3950578qcb.55.1282782152609;
        Wed, 25 Aug 2010 17:22:32 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r38sm2257076qcs.38.2010.08.25.17.22.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 17:22:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8w3upan6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154499>

Junio C Hamano wrote:
>>> Jonathan Nieder wrote:

>>>> GNU make, unlike, say, pmake, reads all the rules before it runs
>>>> anything iirc.
[...]
> I am not sure about the "reread" part, but shouldn't all POSIX compliant
> make be topology driven (i.e. " reads all the rules before it runs
> anything")?

Yes, you are right.

I was thinking of something else, namely that

-- 8< --
#!/bin/sh

cat <<\EOF >Makefile &&
.foo.bar:
	cp $< $@

.SUFFIXES: .foo .bar
EOF

echo hello >test.foo &&
pmake test.bar
-- >8 --

fails while the corresponding script for GNU make succeeds.
