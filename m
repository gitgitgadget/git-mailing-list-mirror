From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Thu, 14 Jan 2016 14:49:53 -0800
Message-ID: <CAGZ79kZ0ooOd+rCXwEiBWgpRbfy6fU+_AOjYbqHP_2qTKQG3Xg@mail.gmail.com>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
	<xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
	<56980BC8.90506@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <jens.lehmann@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 23:49:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJqiM-0001QZ-D1
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 23:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbcANWty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 17:49:54 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33482 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbcANWty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 17:49:54 -0500
Received: by mail-io0-f182.google.com with SMTP id q21so469141107iod.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 14:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bRJGhI6NCXJd6wjN24VEFNhKiT5B+/NP+F5sRzMz51Q=;
        b=ISbDUOxtsytOtDJhnyz3VQ57/YEYruoNVkB30NVC298NykbwHYcorlyBclknRz4sbM
         0gFCF/Vw6teWWnF/swlf2FJMajVyJ7ro7DxgG8KICnNGmkkhemxLZ+Oxrc1IXrxzSpq+
         SJMDgqnS+E4Ad3cktn6L7pWzm9mDOY1P2lfid1PCqRiB/Lb/q5O+SJlXVN7kCHzU9dgO
         NX7ES2Wx2c4ajaN220DO7tho9ANGSCTD9Gh22pz+fZJRjhXQxctZZPOIwJXxXtJknFCC
         s87D6ak6ijC/J/9nlLFvICz4NdkwCMz97XQd1tXbAG22gqPFSbfdwGf34lZkSkFw4LZB
         fe0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bRJGhI6NCXJd6wjN24VEFNhKiT5B+/NP+F5sRzMz51Q=;
        b=jg2BR5CBpYLWJdqipx5RyNfE0Up2vBeYq3jiO9qp6r+hOy124L+x0VYM2cXBIaO+a/
         3dLeWNkBosI769F6ZWirdD+rQrUKyi0tFN5MPq0ZhD+pX0xi74qZtfz5P7FMQKSiID4N
         2YynFKP7kBA5E0yk4GH6PpG0lwX3j2c5m/rB/G8kkbs3u4PpNpqIVEg4yb7VwpkWbZK+
         ybvWtjMtiD6PsGLC8NR/jyyYf3vJBvItO1yMOkmKTLT911QcQT5gEgf7kBM2ZZK15mKs
         j89+WAUpuk4ye7ch97CRsXrD7UK8weUTZ5Tko9aZmWNzZsgPFxpyPoi/6QrZzaz+2mGJ
         qSZw==
X-Gm-Message-State: ALoCoQkih40/8YfseNH/tRWLG8AanuAAOL9Soyg0clwtYKXTYNjDgyXE8uyVdfzhyeBaBs274czWgAcoVy0AWb4cqDKz1EpqCn/S98UjBLecYo7Q0D0DW90=
X-Received: by 10.107.168.203 with SMTP id e72mr7067992ioj.96.1452811793266;
 Thu, 14 Jan 2016 14:49:53 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 14 Jan 2016 14:49:53 -0800 (PST)
In-Reply-To: <56980BC8.90506@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284101>

> (at the cost of some additional ?: conditionals in the arguments).

I tried that once last year and I could not bring a version which was
easier to read.
I'll try again.
