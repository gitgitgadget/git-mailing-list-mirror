From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 12:12:47 -0600
Message-ID: <20100218181247.GA1052@progeny.tock>
References: <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100218013822.GB15870@coredump.intra.peff.net>
 <alpine.LFD.2.00.1002172350080.1946@xanadu.home>
 <7vocjnqf5c.fsf@alter.siamese.dyndns.org>
 <5DDD89A9-900F-40AD-8F3F-F756D6E0AD6C@wincent.com>
 <20100218161843.GB11733@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Zygo Blaxell <zblaxell@esightcorp.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:12:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiArv-0007Xa-Ew
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165Ab0BRSMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 13:12:49 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:37057 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab0BRSMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 13:12:48 -0500
Received: by ywh35 with SMTP id 35so1251901ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZSU7hUFvhZJjjhauPeqIXgCQzca3u3+Azg2WiVYPCC0=;
        b=ItdVGpBT+6zVjboRxp6NTNpUzQfpj3OCJCmdigcFGYRkZTwSYFlfo7g7hSsQQFM4hd
         GBGxUIHrYbctyWPCCWkNfCUklUQfmKXXzqOe3bBhKJrpgLZ7sjNYSNdCPJbSjiYTm6LX
         4M6weYZDDuW67js73yJq7G9EskY/pAnikyLdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Tjx0YdC23bqosgUcsiHUYACYHsboyeuobvKyhaQ8xRJiBz/Szj6GoEu018VhgdU3Zf
         /RR4fT1OJASUNMszm0qsO9xfsHHJze513pbkkan8sBPB/vW7aAvUQGjEE5X12SrH0CEY
         /4yZw0Yik23Ga5lBiZg+TFcGTevPaSpOpu4R0=
Received: by 10.90.18.27 with SMTP id 27mr4586669agr.20.1266516767832;
        Thu, 18 Feb 2010 10:12:47 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm1098095gxk.15.2010.02.18.10.12.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 10:12:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100218161843.GB11733@gibbs.hungrycats.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140354>

Zygo Blaxell wrote:
> On Thu, Feb 18, 2010 at 08:27:28AM +0100, Wincent Colaiuta wrote:
>> Shouldn't a switch that hurts performance and is only needed for
>> insane use cases default to off rather than on?
>
> While I don't disagree that default off might(*) be a good idea,
> I do object to the categorization of this use case as 'insane'.

=46WIW I think default off would not be a good idea.  This talk of
insane uses started from the idea that git is not so great for taking
automatic snapshots, but as you pointed out, other situations can
trigger this and the failure mode is pretty bad.

> (*) "might" be a good idea because there's been some evidence to sugg=
est
> that a paranoid implementation of git add might perform better than t=
he
> mmap-based one in all cases, if more work was done than anyone seems
> willing to do.

What you are saying here seems a bit handwavy.  If you have some
concrete ideas about what this paranoid implementation should look
like, I encourage you to write a rough patch.  The two patches so far
have indicated the relevant parts of sha1_file.c (index_fd at the
beginning and write_sha1_file at the end of the pipeline,
respectively).  Special cases include:

 - The blob being added to the repository is a special file (e.g.,
   pipe) specified on the 'git hash-object' command line: I think it=E2=
=80=99s
   fine if this is slow, but it should keep working.

 - The blob was generated in memory (e.g. 'git apply --cached').

 - autocrlf conversion is on.  This means scanning through the file to
   collect statistics on the dominant line ending, then scanning
   through again to convert the file.

 - some other filter is on.  This means sending the file as input to
   a command, then slurping it up somewhere until its length has been
   determined for the beginning of the blob header

 - The blob being added to the repository is already in the repository,
   so it would be a waste of time to compress and write it again.

Some of these already don=E2=80=99t have great performance for large fi=
les
(autocrlf and filters), and I suspect there is room for improvement
for many of them.

Jonathan
