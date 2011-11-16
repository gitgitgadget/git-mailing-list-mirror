From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Wed, 16 Nov 2011 14:10:41 +0400
Message-ID: <CACf55T6rUiE8Pm3s16oFgJ1ueTAdOwOz_+XptE-tZM1z9fcq+w@mail.gmail.com>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
	<CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
	<7v1ut9uglb.fsf@alter.siamese.dyndns.org>
	<CACf55T6SRAfdOP1+qQdjeFv13B=G8w+DR-GCSEz=6swFhLJzcw@mail.gmail.com>
	<CALUzUxrM8o1uahQgSFUuvZ0mSPxG_zVQ9awOantRM2A8kkbbtA@mail.gmail.com>
	<CACf55T5cp1ko45DCufcRXm=EeZd1-x+aYasvbzjDXkQH31u5VA@mail.gmail.com>
	<alpine.DEB.2.00.1111161008430.19479@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Wed Nov 16 11:10:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQcS7-0001vv-Ix
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 11:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519Ab1KPKKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 05:10:43 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64926 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497Ab1KPKKm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 05:10:42 -0500
Received: by ywt32 with SMTP id 32so4573046ywt.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 02:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yJcSp01dx9wMUlt6y9FClG/pqWykVc7xtMAWp2nbrkA=;
        b=tkDXeEPwYApnho12wQSodSNT7ytOHVM1Nnp7D4SfQ4ab7EPltnmo9nOXliy3vNZO8v
         PonDC+k3piWDopno/a9Ejl1DpCK+RIeKOCNO4cY8zZ1aMMjwbyEnfME2i5uvNJM927UT
         kf7g3/xtmH6wgYfF2TQwdpafnA+wCe+VSr+Kg=
Received: by 10.68.74.40 with SMTP id q8mr68283638pbv.36.1321438241455; Wed,
 16 Nov 2011 02:10:41 -0800 (PST)
Received: by 10.68.66.230 with HTTP; Wed, 16 Nov 2011 02:10:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1111161008430.19479@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185533>

> I'd say that isn't very likely and you could easily snoop on the network to> figure that out for sure

In the very first message I wrote that there is strange tcpdump record:
21      3.815135        X.X.X.X Y.Y.Y.Y TLSv1   215     Ignored Unknown Record
In this record there is some binary dump followed by an uncripted text:
GET /pub/scm/git/git.git/info/refs?service=git-upload-pack HTTP/1.1
User-Agent: git/1.7.5.4 Host: git.kernel.org Accept: */* Pragma:
no-cache

This packet is recorded before negotiation complete, so I'm wondering
who is guilty: git or curl?
What Git is providing to libcurl? Can I log it?

> curl will send the HTTP request once the TLS negotiation has completed as
> told by the TLS library. I believe you said you're using GnuTLS, are you
> using a recent version?
I'm using the version that comes with Ubuntu 11.10.
