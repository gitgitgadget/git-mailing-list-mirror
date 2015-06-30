From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 09:22:18 -0700
Message-ID: <xmqq381988ud.fsf@gitster.dls.corp.google.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165545.GC23503@peff.net> <20150629222247.GA31607@flurp.local>
	<20150630102055.GA11928@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:22:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9yIk-0002bI-9K
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 18:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbbF3QWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 12:22:21 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38756 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbF3QWU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 12:22:20 -0400
Received: by igrv9 with SMTP id v9so16108230igr.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PZnkC8kYSKNdInevRD6R0p5shDgF2qnx9sr4ZDecsI0=;
        b=pQfqEN+zGl5khTNncEm8hgkZHtiMv2jSLwya+F4YQf008O8VqJmlo2ISK+Xb97LgCc
         7a98bR7WWsWdh1uLFEXwsQmJFqa76JzqPRNv+piyLQMThZax9sgLTiEQ6q1y2nz/gB3Z
         iVZ6rruvSA+0kyBCJmVBceiPkRJQ4ZcIsCXOoo75NaGUf5SSClsm2PM0uHv5tk4tMR5x
         m+9w8u1cJRaVGDjp5VcVPwIjzwNz1ySf/XxWUMd5W2VYZXQ8ixC0dnKJ3cZvtYvS7p0n
         kKoA1ZBq1jWGTBqJPo673nlzLIlepSIv+6VLaYa3krHb9UXKAgbunREqY+O8sKcWrkH2
         G4TQ==
X-Received: by 10.50.2.3 with SMTP id 3mr25749270igq.34.1435681340068;
        Tue, 30 Jun 2015 09:22:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id d96sm23559929ioj.37.2015.06.30.09.22.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 09:22:19 -0700 (PDT)
In-Reply-To: <20150630102055.GA11928@peff.net> (Jeff King's message of "Tue,
	30 Jun 2015 06:20:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273079>

Jeff King <peff@peff.net> writes:

>> 	strbuf_addf(&f, "%s ", fmt);
>
> Basically I was trying to avoid making any assumptions about exactly how
> strftime works. But presumably "stick a space in the format" is a
> universally reasonable thing to do. It's a hack, but it's contained to
> the function.

Why can't I shake this feeling that (" %s", fmt), i.e. prepend not
append, is the safer thing to do than to append?
