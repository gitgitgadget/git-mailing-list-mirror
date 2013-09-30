From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: suppress false positive warnings of empty
 format string.
Date: Mon, 30 Sep 2013 14:26:36 -0700
Message-ID: <20130930212636.GY9464@google.com>
References: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org>
 <1380456534-7582-1-git-send-email-stefanbeller@googlemail.com>
 <20130929190017.GA2482@elie.Belkin>
 <20130930201429.GA14433@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 30 23:26:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQkzO-0007vm-FZ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 23:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab3I3V0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 17:26:42 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:38273 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab3I3V0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 17:26:41 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so6224412pdj.34
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QNfMQP2mJLt3gGKQUA+9vkkkxyvo7gbhviiJMn3oNOY=;
        b=KOiUD6Vfa4x+24Ps22I/0g4TslSx+KaV1I8PicOW2jcKELm1FWLK9//yf0I/905EMe
         jZMBPLrgH3AYq00AMQy7+zuJ53noAarJL3fNt9ySoWTZfTwjAOFSr912TkFFzC1wWdUC
         1tzM0oMRcp4/JJ/yG4BRiAEqBSFHNqKnUUpDv/CnxDLUcf5Lf12+EaaL8noHkEpExqkH
         SwfsKt6aoT8bJnzEpU4uWlx27dPjtH14HsS2/mhOz3LUJ9ut0xzbbXpTHmQCSv5r6VFO
         2P6QFB02n8p38ot+7HoE0gbyVNvuFzDmajjaCL7/k+3QbGsKH7/DNZYe+AOCQlAkG5XD
         8+7Q==
X-Received: by 10.66.25.205 with SMTP id e13mr4183867pag.180.1380576400403;
        Mon, 30 Sep 2013 14:26:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xv2sm2627735pbb.39.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 14:26:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130930201429.GA14433@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235628>

Jeff King wrote:

>                                            I think we'd be better off to
> simply mark up the few callsites. Workarounds are here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/230026

Yeah, that looks okay (ugly but tolerable).  It's tempting to do
something like

	-	status_printf_ln(s, GIT_COLOR_NORMAL, "");
	+	status_nl(s, GIT_COLOR_NORMAL);

and

	-	status_printf(s, color(WT_STATUS_HEADER, s), "");
	+	status_start_line(s, color(WT_STATUS_HEADER, s));

to make the intent clearer.  Sane?

Jonathan
