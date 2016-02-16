From: Stefan Beller <sbeller@google.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Tue, 16 Feb 2016 10:34:21 -0800
Message-ID: <CAGZ79kaDM+sATm73t1pkdc7PqYeZVDgZyYaL-0b8VS2HB9x93g@mail.gmail.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
	<CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
	<20160210214945.GA5853@sigill.intra.peff.net>
	<CAJo=hJv-GWZOsv31iekW+AdNazLGQ=XYD=UXMO+RuB15baTsow@mail.gmail.com>
	<20160214170525.GB10219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 19:34:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkSA-0007lI-WC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 19:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbcBPSeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 13:34:23 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:33038 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbcBPSeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 13:34:22 -0500
Received: by mail-io0-f172.google.com with SMTP id z135so132891696iof.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 10:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4gQw83EWZ/v66L7Hl8wY2bHGUMXGwxaL91cUJnID8fM=;
        b=SgIyJDlXOLi6EPz4iJtJYHEW/a6/QE7LXI4swfjawV6KdbV0OWsqyDlWKZYAbT+P9a
         uKYwQr6wS6xlg4h8FBvVhb0Ywj0eTqtl7n/AqKtgKH2jzXemXsuf0bZDVCjRV70P4nzi
         05tm/nKT2GvN+WSAP+kEbI8O76xxLLKLpbXxGlNlwsYPZlNosHIBDg8eF43vz8Dr2TsV
         T+xmWQrB54RcJXlqyh5FWqHvP5KMGBvffJprywKvUc1RV54WdNgiHrXhLkXSecCmcgWd
         duCI01gruR8TovcH6I4Z2wEy3OlTYtgXwid64QeOGLIF2XHvMKLSJTRy05O8u+THGNw8
         JEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4gQw83EWZ/v66L7Hl8wY2bHGUMXGwxaL91cUJnID8fM=;
        b=chy2mI1r8D93O90ELSzzSiwDtFoyLkY8py8hH72J7fjhwYOqKHCPtc/9VBK6qOfzNW
         paLTtMvifeo5jzoIK92F09fc8aTGW3f70AUfwyQ37+RpxSxV9MIJE7QwxqekJizPP18y
         WO/NQFeRMGusYryrPacmBXmRM+jsY8313sIZ719otA4uBXDf+0nbP+0uKEqpUE/HE4bd
         7S1iEjAMtN2zxqQKXvouYVzBbIght7UU470mIFvXd7Bdi0jR3j/EZhW2TaM/gJhknv4i
         jpjbhztPTaBEPNuML84G38BGcBNZt14FXQ3Bf4bjeUWdGEHN43S4ZPSoWXDeIPfjQL75
         9+Dw==
X-Gm-Message-State: AG10YOTeLTV6cQaA1pgFxAa7iMkAdZgTCy8KiAQ/A/3wcYzVp3rK/Hhc5bgYsO3VlQKB48iPGQ8gh77JiMYwwSA/
X-Received: by 10.107.158.81 with SMTP id h78mr23449126ioe.174.1455647661675;
 Tue, 16 Feb 2016 10:34:21 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 16 Feb 2016 10:34:21 -0800 (PST)
In-Reply-To: <20160214170525.GB10219@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286411>

On Sun, Feb 14, 2016 at 9:05 AM, Jeff King <peff@peff.net> wrote:
>
> I'm also not happy about having an HTTP-only feature in the protocol. I
> liked Stefan's proposal for the "v2" protocol that would let the two
> sides exchange capabilities before the ref advertisement. Then the
> client, having seen the server's resumable URL, knows whether or not
> to proceed with the advertisement.

I completely stalled that side project, so if anyone wants to pick it up,
feel free.

The server side was complete (and reviewed and people liked it).
The only missing part was the client side to be completed. (There were
some patches back and forth and it worked mostly, the design seemed to
be accepted and well). The code is at
https://github.com/stefanbeller/git/commits/protocol2-10

Thanks,
Stefan
