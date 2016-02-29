From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 2/7] submodule: don't pass empty string arguments to
 submodule--helper clone
Date: Mon, 29 Feb 2016 15:14:45 -0800
Message-ID: <CAGZ79kZGzXHJ=oWfx8tsTEs=OU7c+KuV-G9sA7ABHQGQtXLOzQ@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
	<1456786715-24256-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:14:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaX1e-0005fS-WA
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbcB2XOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 18:14:47 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35196 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbcB2XOq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:14:46 -0500
Received: by mail-ig0-f169.google.com with SMTP id hb3so6278110igb.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 15:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=deThZbeyr+cUTXMT0ob7T9lwB5HK6qDe3mYtYmKUKkg=;
        b=N3kcP00WlE7UQNpzLYNNB3dSBarmjjyLc4VUTgG9iv8rrGDtEFiAV3wSWm+T8gCTLl
         HjGau/LJP1rMEMSalFFnXAwWXPIiiej5naGHe7GbxnV1AvUhTPr1BppmhzlQDMXwooPA
         gbY7TsdhI4E0uxGA/Hinyi21Lmb1xGSX3qsRazEIQ4/KknObvjc8Sq7JO4z3b4fouIGf
         A7k/tGN6hOQboAyeN4pvqDVyGel5eGRvUS0YL/YKlCExHHEKwCiHR1g7dEZmWwVjCQpH
         45M33v8GVYn7P5EPToK1U0vrXjnQ9x7if3zjaqtMxEy8NcPqnYq/Le2owGKuHuA007uo
         Z/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=deThZbeyr+cUTXMT0ob7T9lwB5HK6qDe3mYtYmKUKkg=;
        b=GAT/1Gf9mE/kkjUsMQZldWo8y0UBdECJ/yK4zDO13O2zZ/66L0bcDM4VmfHACXqByS
         HexKAT2cUh4XsN0mtyoVOiCN4n2hKoUsFBAbMUTccb1W55CVfgrMXfDVeqbeTtfkQD4M
         H5YouCK5MVYsg5jMCvYcpjCoGof1E+1Bu1hvbr/4ZRQiXRDE/ROeDpDcw8QkaFhQOq/T
         gxDXC0n+IUtoYk4dzspkunk5KXRIui71gdwFJ4wsG83c6EsI+++BsgHhEhDVMcvMCfCP
         RuYdzKlLWT4oK5TPwdpgy+asXRRcYa9xser9lu5cuOdoo+GDr17Ts0PdV8zO4XmASsgr
         an+Q==
X-Gm-Message-State: AD7BkJIdiXzAGTBn48M/BljTzAtC0HQUt+OistiCYHDLxJMWUbUqbEJV/qhn6A/OUMkVW7+mqYGGps9vmB73JTgG
X-Received: by 10.50.176.138 with SMTP id ci10mr425320igc.93.1456787685609;
 Mon, 29 Feb 2016 15:14:45 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 15:14:45 -0800 (PST)
In-Reply-To: <1456786715-24256-3-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287935>

On Mon, Feb 29, 2016 at 2:58 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> When --reference or --depth are unused, the current git-submodule.sh
> results in empty "" arguments appended to the end of the argv array
> inside git submodule--helper clone. This is not caught because the argc
> count is not checked today.
>
> Fix git-submodule.sh to only pass an argument when --reference or
> --depth are used, preventing the addition of two empty string arguments
> on the tail of the argv array.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
