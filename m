From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-daemon wrapper to wait until daemon is ready
Date: Thu, 19 Apr 2012 08:00:04 -0700
Message-ID: <CAPc5daX7aQhuez+Q28s5jMcZzofxDvA-g1nnnEA_9tZFCJm-gw@mail.gmail.com>
References: <20120414182907.GA3915@ecki>
	<4F89D1C6.8090705@kdbg.org>
	<20120414220606.GA18137@ecki>
	<20120415115322.GA11786@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Apr 19 17:00:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKsqK-00033X-EQ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 17:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab2DSPAJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 11:00:09 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:50316 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab2DSPAG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 11:00:06 -0400
Received: by wejx9 with SMTP id x9so5457112wej.19
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xo3C6ZUJzDHshSFZAxrRziKyku0LUDb259fTcswleW0=;
        b=BUvZuP7q2MsJLpUV9Zc0htp0gCFOBnZTs0YdSO91Rh2dUol1YYKDG7JmpJxmyby8er
         LgJATHZxd0BhzZuVQzwDw2i1/9ZR6x06yjfJV5JkDXPcqMdnbOUvqIMsB95vG54Ki9sZ
         llt4fBMRSpGTO1h+8n6sawBSXkAv/sbcTlZ2sWO/L1KYUEsKWMTZlBSQC1ysxi6d/og3
         vWQLI0q/8ayJxgPav+bz6QwKBJlSuit4HETcP0xLSagYVirM5mdnwqjqYlwsbAsAUuxR
         Oucwvl3JkN2L+wOJS5ejdFcGHWuh7LaO2rj2wf7yJHvv6Bme0rtqWp+Czw6n7vzgM1xz
         fQBA==
Received: by 10.180.106.9 with SMTP id gq9mr6053222wib.17.1334847605228; Thu,
 19 Apr 2012 08:00:05 -0700 (PDT)
Received: by 10.216.216.16 with HTTP; Thu, 19 Apr 2012 08:00:04 -0700 (PDT)
In-Reply-To: <20120415115322.GA11786@ecki>
X-Google-Sender-Auth: eYt4AwFWLGrAUptxIbC_RalyG90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195948>

2012/4/15 Clemens Buchacher <drizzd@aon.at>
>
> The shell script which is currently used to parse git daemon output d=
oes
> not seem to work reliably. In order to work around such issues,
> re-implement the same procedure in C and write the daemon pid to a fi=
le.
> ...
> + =C2=A0 =C2=A0 =C2=A0 strbuf_getwholeline_fd(&line, proc.err, '\n');
> + =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, line.buf);

Just a note. I'll update this part with "fputs(line.buf, stderr)".
