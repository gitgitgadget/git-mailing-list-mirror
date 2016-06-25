Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557741FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 19:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbcFYTVI (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 15:21:08 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:52709 "EHLO
	homiemail-a19.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658AbcFYTVH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2016 15:21:07 -0400
Received: from homiemail-a19.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a19.g.dreamhost.com (Postfix) with ESMTP id 22B0E604079;
	Sat, 25 Jun 2016 12:21:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=subject:to
	:references:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=novalis.org; bh=iyamS
	eQJkQNsZjplkKRAD6042i8=; b=U/ruJ7F0+M8QZ+GcVRHSJkxEZcQQnUFgLwNlG
	oJSJuotJNvDdvZGnXCr+GRMGxdoZ1fq1lEuEJNNmaputdWpy+glGqUddMXOnr8kJ
	ydrPdFwjD208BVTEm433G/GyLVJCb4GM45+z9aqMGWJRVFaLibfkCGjJXt0q2R80
	IfYrJw=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a19.g.dreamhost.com (Postfix) with ESMTPSA id D4FFD604076;
	Sat, 25 Jun 2016 12:21:06 -0700 (PDT)
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
To:	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
 <1463694357-6503-5-git-send-email-dturner@twopensource.com>
 <CACsJy8CftPGmrKP8Yeok90T9=whzj69bfE3_X6wHyWOEp6vRzg@mail.gmail.com>
From:	David Turner <novalis@novalis.org>
Message-ID: <576ED9A2.8070202@novalis.org>
Date:	Sat, 25 Jun 2016 15:21:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CftPGmrKP8Yeok90T9=whzj69bfE3_X6wHyWOEp6vRzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/25/2016 10:33 AM, Duy Nguyen wrote:
>> +               /*
>> +                * Our connection to the client is blocking since a client
>> +                * can always be killed by SIGINT or similar.
>> +                */
>> +               set_socket_blocking_flag(client_fd, 0);
>
> Out of curiosity, do we really need this? I thought default behavior
> was always blocking (and checked linux kernel, it seemed to agree with
> me). Maybe for extra safety because other OSes may default to
> something else?

Yes -- see this bug report for details:
https://bugs.python.org/issue7995

