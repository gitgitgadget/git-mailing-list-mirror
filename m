From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 33/67] read_branches_file: replace strcpy with xstrdup
Date: Thu, 17 Sep 2015 09:53:16 -0700
Message-ID: <xmqqa8slj8cj.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915154950.GG29753@sigill.intra.peff.net>
	<xmqqlhc6p2f9.fsf@gitster.mtv.corp.google.com>
	<20150916204226.GE3915@sigill.intra.peff.net>
	<xmqq7fnpkqdj.fsf@gitster.mtv.corp.google.com>
	<20150917162447.GA25837@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:53:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccR0-0005fn-S1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbbIQQxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:53:19 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34847 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbIQQxS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:53:18 -0400
Received: by pacfv12 with SMTP id fv12so24785965pac.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fxgVNmElJRbhGvhfx5VM11cLwgSoF46XMqMbUUBJ+gA=;
        b=QIjYEN6qbTCm21w5oeP8WFVNElIWnXG6Z6Qvmp5Nfs2WkcgXzVq/bJLbgVQnOMGQQK
         9EFpe9CL6F7d8pmpQBnkDr1g/BL0TF0F7nR7R9A4pQc04S6j9x+TyAQ5MiB96BB/NKae
         baqeD4F9tnxdr6XqNhoQLwMEYPhKbQO/CLxyaAkRRAm4wldmc7XFejPYTvNyce7OIlYa
         JaqKcvs/gkDsdohnZ7R3exLLl9C93V8h9fJQeyJl8L+oReHx9q9Nzw06Z0A6W+c0g2hF
         F1a1msQRfZCOvtxLlxwRGodtmR2MvMKQNWc003Y6DRxKsoFNTo/5/uNTvZO2X6fg0w4x
         FumQ==
X-Received: by 10.68.104.227 with SMTP id gh3mr266527pbb.108.1442508797887;
        Thu, 17 Sep 2015 09:53:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id xi1sm4397310pac.48.2015.09.17.09.53.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 09:53:17 -0700 (PDT)
In-Reply-To: <20150917162447.GA25837@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 17 Sep 2015 12:24:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278138>

Jeff King <peff@peff.net> writes:

> Yeah, that was my thinking. Since I _did_ end up doing the cleanup and
> posted it earlier, please feel free to review and express an opinion on
> the original versus the cleanup.
>
> I'm on the fence.  I do think the cleaned-up version is much nicer, but
> I always worry about the risk of touching little-used code.

True.

With s/strbuf_read_file()/strbuf_getline()/ on the first one I think
there is no regression (at least, that is the only deliberate
regression I saw).

I found all other parts of the cleaned-up version much nicer, too.
