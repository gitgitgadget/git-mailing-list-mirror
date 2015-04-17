From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Fri, 17 Apr 2015 14:49:40 -0400
Message-ID: <20150417184939.GA32578@peff.net>
References: <552E9816.6040502@gmail.com>
 <1429117143-4882-1-git-send-email-karthik.188@gmail.com>
 <xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
 <20150415221824.GB27566@peff.net>
 <20150417142310.GA12479@peff.net>
 <553154C8.5090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:49:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjBKm-0004Pm-V0
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 20:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbbDQSto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 14:49:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:46869 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754168AbbDQStn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 14:49:43 -0400
Received: (qmail 14541 invoked by uid 102); 17 Apr 2015 18:49:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 13:49:43 -0500
Received: (qmail 4899 invoked by uid 107); 17 Apr 2015 18:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 14:50:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 14:49:40 -0400
Content-Disposition: inline
In-Reply-To: <553154C8.5090001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267377>

On Sat, Apr 18, 2015 at 12:15:28AM +0530, karthik nayak wrote:

> >But now we use type_from_string_gently, which can accept a length[1]. So
> >we could just count the bytes to the first space and pass the original
> >buffer along with that length, no?
> 
> Yes, we could, that would eliminate  "struct strbuf typename =
> STRBUF_INIT".
> 
> Something like this perhaps :

Yeah, this is exactly what I had in mind.

>   {
> -       char type[10];
> -       int i;
> +       const char *buf = hdr;
>          unsigned long size;
> +       int type, len = 0;

Maybe switch the names of "buf" and "len" to "type_buf" and "type_len"
to make their purpose more clear?

-Peff
