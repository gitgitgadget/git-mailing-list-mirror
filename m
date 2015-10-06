From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 18/43] refs-be-files.c: add a backend method
 structure with transaction functions
Date: Mon, 05 Oct 2015 20:20:29 -0400
Organization: Twitter
Message-ID: <1444090829.7739.4.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-19-git-send-email-dturner@twopensource.com>
	 <56122EB6.2020501@alum.mit.edu>
	 <xmqq8u7hz0qw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 02:27:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjFzg-0008CC-F9
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 02:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbbJFAUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 20:20:32 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35007 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbbJFAUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 20:20:31 -0400
Received: by qgt47 with SMTP id 47so164982075qgt.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 17:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=5TFlwWcrF+edwMC88JFzxoiqmIp6WjWXmiTM/EMwjmk=;
        b=jO6BjfD6OabaRscxc7DI/WQKv7Ooq4NqJLMuQS0NQrbGhyC2clNJWcuqHkenzIvuX1
         YmFJtjBPS8aqge6aKTtM7jIF73hOUz6lcyf3WcgJdV47UWO1jy0JskADnIqUvix4Spop
         EafV5BQG+/0CsqxxjEoEODmyn8dpk032IdVznNIENjsPuVE6R+hAdAIZeJycJafn07D1
         FIUOafqWk+ZIbEnEVyuoxMuhj7M7spS7RU7BI4t209SAkJxo0jHRtmvPKmST95UDYgWU
         2RVoU5K1gW+Q6XysIqOmaO4cQlAzuiGoAcYeYksuUeDXE2RdrGe8DUEp4sMlB3hyIBYx
         W30Q==
X-Gm-Message-State: ALoCoQkrG+xIUzV5P2GgTKPCCHOxITweKW66aHTdSLgqxPtH+vvfCNwQhL5GGqGSQLllC1CsMbb6
X-Received: by 10.140.93.53 with SMTP id c50mr42251475qge.59.1444090831307;
        Mon, 05 Oct 2015 17:20:31 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id o20sm12568083qge.28.2015.10.05.17.20.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 17:20:30 -0700 (PDT)
In-Reply-To: <xmqq8u7hz0qw.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279107>

On Mon, 2015-10-05 at 10:25 -0700, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> >> +/* refs backends */
> >> +typedef struct ref_transaction *(*ref_transaction_begin_fn)(struct strbuf *err);
> >
> > Hmmm, I thought our convention was to define typedefs for functions
> > themselves, not for the pointer-to-function; e.g.,
> >
> >     typedef struct ref_transaction *ref_transaction_begin_fn(struct
> > strbuf *err);
> >
> > (which would require `struct ref_be` to be changed to
> >
> >         ref_transaction_begin_fn *transaction_begin;
> >
> > etc.) But now as I grep through the code it looks like both conventions
> > are used. So never mind :-)
> 
> Well spotted.  My recollection is the same and we do prefer the
> latter (I think all early function typedefs by Linus were done that
> way).  It would be better to correct existing mistakes we added over
> time and certainly not add more of them in new code.

Will fix, thanks.
