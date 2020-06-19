Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BDAC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6299120C09
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbgFSThh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 19 Jun 2020 15:37:37 -0400
Received: from elephants.elehost.com ([216.66.27.132]:35602 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389200AbgFSThh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:37:37 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05JJbWld010202
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Jun 2020 15:37:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>, <git@vger.kernel.org>
References: <20200619150445.4380-1-randall.s.becker@rogers.com>        <20200619150445.4380-2-randall.s.becker@rogers.com>        <20200619163530.GB5027@danh.dev>        <02a501d6465d$80366680$80a33380$@nexbridge.com> <xmqqimfmhmzs.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimfmhmzs.fsf@gitster.c.googlers.com>
Subject: RE: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with write_in_full
Date:   Fri, 19 Jun 2020 15:37:27 -0400
Message-ID: <02c201d64671$13c9a840$3b5cf8c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKpTDE+t6IzuT5QyP1r/drrysHRPAImfDU6AorP7dACFQoNBAOIDLs0pufWH6A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 19, 2020 3:31 PM, Junio C Hamano wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Đoàn Trần Công Danh' <congdanhqx@gmail.com>;
> randall.s.becker@rogers.com; git@vger.kernel.org
> Subject: Re: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with
> write_in_full
> 
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> >> > +	if (write_in_full(report, buffer.buf, buffer.len) < 0) {
> >> > +		die(_("couldn't write report contents '%s' to file '%s'"),
> >> > +			buffer.buf, report_path.buf);
> >>
> >> Doesn't this dump the whole report to the stderr?
> >> If it's the case, the error would be very hard to grasp.
> >
> > Where else can we put the error? By this point, we're likely out of disk or
> virtual memory.
> >
> >> Nit: We wouldn't want the pair of {}.
> >>
> >> > +	}
> >> >  	close(report);
> >
> > I'm not sure what you mean in this nit? {} are balanced. You mean in the
> error message?
> 
> I think he means that a block that consists of a single statement (i.e. call to
> die()) does not have to be enclosed in {}.
> 
> (partial quote from Documentation/CodingGuidelines):
> 
>  - We avoid using braces unnecessarily.  I.e.
> 
> 	if (bla) {
> 		x = 1;
> 	}
> 
>    is frowned upon. But there are a few exceptions:

I get that. I was trying to maintain visual consistency with the rest of bugreport.c. Will redo it.

