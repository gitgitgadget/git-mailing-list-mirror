From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: don't run rm without any files
Date: Wed, 13 Feb 2013 12:12:44 -0800
Message-ID: <20130213201244.GD3381@google.com>
References: <1360771068-505-1-git-send-email-kraai@ftbfs.org>
 <7vtxpg9mxq.fsf@alter.siamese.dyndns.org>
 <20130213170028.GA410@ftbfs.org>
 <7vehgk6l11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 21:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5ihf-0001Zt-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 21:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760302Ab3BMUMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2013 15:12:51 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55514 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab3BMUMv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 15:12:51 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so891247pad.2
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ommfaD3ulj2CdMk4OYfs1D2i3FKbsDBF3cMBMU0YWrc=;
        b=hOcNDHSBXuE0Q2Uv3D6TVCQuYQP0luhqbS/+fjMHOak4ItWl3PemHVbaVElGr+izR8
         6LXFwOFpf53gpzSLnmi2sBeHaMltEc2WNQoNA8ERz1OfTaTSbXP5D+/KynJNgOv86BtA
         ejUCGZPvQ0ZxWHfS0UyDC+rjUEk87T66se+l61FR6lxAV/a5EdbWHQHp5C/zN/kFr4Lp
         SJmOsuG2xHxl4cVlpNlAnKcE4D95Q4q0nqOzexQl/RR8q2UNqOYyVS4NikYibk7eQWhX
         hTg0dOvbRzlYlCojP4GIz0Yvr4FvG1UVTKMdSw+QMEPoTiCzW/+/rYCkgSGyJlS5Lt2I
         d3Xg==
X-Received: by 10.66.87.8 with SMTP id t8mr67360722paz.28.1360786369289;
        Wed, 13 Feb 2013 12:12:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id l5sm85961547pax.10.2013.02.13.12.12.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 12:12:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vehgk6l11.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216282>

Junio C Hamano wrote:

> I amended the log message like so:
>
> commit bd9df384b16077337fffe9836c9255976b0e7b91
> Author: Matt Kraai <matt.kraai@amo.abbott.com>
> Date:   Wed Feb 13 07:57:48 2013 -0800
>
>     Makefile: don't run rm without any files
>
>     When COMPUTE_HEADER_DEPENDENCIES is set to "auto" and the compile=
r
>     does not support it, $(dep_dirs) becomes empty.  "make clean" run=
s
>     "rm -rf $(dep_dirs)", which fails in such a case.

To pedantic, that only fails on some platforms.  The autoconf manual
explains:

	It is not portable to invoke rm without options or operands. On the
	other hand, Posix now requires rm -f to silently succeed when there ar=
e
	no operands (useful for constructs like rm -rf $filelist without first
	checking if =E2=80=98$filelist=E2=80=99 was empty). But this was not a=
lways portable; at
	least NetBSD rm built before 2008 would fail with a diagnostic.

Anyway, looks like a good fix.  Thanks.
