From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH] git-new-workdir: add windows compatibility
Date: Tue, 26 May 2015 08:20:35 -0400
Organization: I may be mad, but I am a professional!
Message-ID: <1432642835.17513.22.camel@mad-scientist.net>
References: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com>
	 <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com>
	 <cbfbf842705637b52cde9c6b61f89a75@www.dscho.org>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Smith <dansmith65@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Richard Hartmann <richih@net.in.tum.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 26 16:07:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxFW9-0004Af-MA
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 16:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbbEZOHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 10:07:34 -0400
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:41910 "HELO
	gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754418AbbEZOH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 10:07:28 -0400
X-Greylist: delayed 2797 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2015 10:07:28 EDT
Received: (qmail 20841 invoked by uid 0); 26 May 2015 12:20:48 -0000
Received: from unknown (HELO cmgw4) (10.0.90.85)
  by gproxy8.mail.unifiedlayer.com with SMTP; 26 May 2015 12:20:48 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw4 with 
	id YiDX1q00R2qhmhE01iDaQW; Tue, 26 May 2015 12:13:37 -0600
X-Authority-Analysis: v=2.1 cv=D8zUdJhj c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=xb9AoMtQs74A:10 a=h1PgugrvaO0A:10 a=8pif782wAAAA:8 a=sde-2SfQDcxyCX6T0F8A:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID; bh=58avJ27np4pP6CHMTaWVVd03zzTPGO8/eYFHPUZdANw=;
	b=KBz6ni+YXJEfk64tuysfItKqifDdNwhIJsWAG/K7jEvijS+Y7VyBerEilK7cd/pcXd+W5c9ex88jdKE2BZsks01WxlMqX6Bkt9LiB1yAcRVIyzbVi2KaxRN4EGW4TXIf;
Received: from [72.93.83.251] (port=54124 helo=homebase)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <paul@mad-scientist.net>)
	id 1YxDqc-0004Vs-8a; Tue, 26 May 2015 06:20:42 -0600
In-Reply-To: <cbfbf842705637b52cde9c6b61f89a75@www.dscho.org>
X-Mailer: Evolution 3.12.11-0ubuntu3 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 72.93.83.251 authed with paul+mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269939>

On Tue, 2015-05-26 at 11:53 +0200, Johannes Schindelin wrote:
> The biggest problem with `mklink` is that it is only supported on
> Windows Vista and later, while I really like to keep Windows XP
> support in Git for Windows.

No, the biggest problem with mklink is that you have to have
administrative privileges to use it... from wikipedia:

http://en.wikipedia.org/wiki/NTFS_symbolic_link

> The default security settings in Windows Vista/Windows 7 disallow
> non-elevated administrators and all non-administrators from creating
> symbolic links. This behavior can be changed running "secpol.msc" the
> Local Security Policy management console (under: Security Settings
> \Local Policies\User Rights Assignment\Create symbolic links). It can
> be worked around by starting cmd.exe with Run as administrator option
> or the runas command.

Except even that is not so simple, as various StackOverflow questions
and answers will show (I have to run so I can't look them up now).  I
did try to get this to work a year or so ago, and although I'm in no way
a Windows person (so maybe someone else would have better luck) I
couldn't get it to work.
