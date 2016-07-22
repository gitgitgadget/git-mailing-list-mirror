Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF96203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbcGVTuQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:50:16 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33342 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbcGVTuO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:50:14 -0400
Received: by mail-io0-f179.google.com with SMTP id 38so114398838iol.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 12:50:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FdxUZB1yu4OgcItUKgsV5sxFZo0ZkPle0PjLB5YO3Gg=;
        b=Wfnjis7ssYR0AMCtIXwCMmWp/Hhjw8fiAQ2t9Ob0RXCYmtynHKsvTGM1bbmyHkPC45
         Crw/eK3goh9KWHJQ1nnz9fLprwmR80548oE9TfS/J7i9Rfv80uwUL18SeGSLcs+4cbNK
         oc3q1O319/usY0zlJbK96nYf1akHVmjPMZYxTj7kVpcnqNyteTNBRzfuk+kHrdWxqkB6
         EDGJJj05f/xt2BSrAzHKWnx4BpuulaYlDzwio3/II4UAGAp1yZNZZAJKSxzaYzVvw2mU
         T77lQrhzIJeeD0Fx/pnzshHTVOD1xaGPmfYEi7a0/OKd+IRG79SQhywKLdb7M06YBB4z
         Pp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FdxUZB1yu4OgcItUKgsV5sxFZo0ZkPle0PjLB5YO3Gg=;
        b=BSQKW4LUKK96MgkIui0OmIbD6OtcgEUKrKyknCkIv+Yz8lnqppkBam4NJB6Ll32HLn
         xstLuQ8+FhRlG5QejJDQSok3DzhfcenabqMmXzu9954MRXpobvBfTPsjIDL0pv1PCiJf
         EVyrS8sYzpZRpEjvVraYSXNysYtsxpZQ/lmqy7lfgKqMC2zedZvMx500JjCWsvS+dVXa
         R7t9s4fMB5NbW1Z1uu+EdIFhhouKvV2HvnyD8y/sE9ISQjvc7frHlnyTespI8ozTK1/k
         yV18O2jnGSD6xmxh6KF7jDgehKq3ZohB35WsfEdSLcE58Nx8v1vSVZvOlSEnuqkeMQx7
         Xk7g==
X-Gm-Message-State: AEkooutxqiXf+PZfxzz8gQkBpvaOy1gXb707vUeondD3Wmw5986l3TLjhbCgaXVUp/g6HjHt6cLnxu4AoE+F76JO
X-Received: by 10.107.144.10 with SMTP id s10mr6341750iod.165.1469217013440;
 Fri, 22 Jul 2016 12:50:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 22 Jul 2016 12:50:13 -0700 (PDT)
In-Reply-To: <xmqqeg6la2da.fsf@gitster.mtv.corp.google.com>
References: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
 <4d40da99-2f66-a380-840f-1828dc5b9324@kdbg.org> <xmqqeg6la2da.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 22 Jul 2016 12:50:13 -0700
Message-ID: <CAGZ79kZCt2iZNc7VkkcW1bTnwF9YrDi9zPi0p7=-7aDVe=0dzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule-helper: fix indexing in clone retry error
 reporting path
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 12:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> 'git submodule--helper update-clone' has logic to retry failed clones
>> a second time. For this purpose, there is a list of submodules to clone,
>> and a second list that is filled with the submodules to retry. Within
>> these lists, the submodules are identified by an index as if both lists
>> were just appended.
>>
>> This works nicely except when the second clone attempt fails as well. To
>> report an error, the identifying index must be adjusted by an offset so
>> that it can be used as an index into the second list. However, the
>> calculation uses the logical total length of the lists so that the result
>> always points one past the end of the second list.
>>
>> Pick the correct index.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>
> Looks very similar to
>
>   http://public-inbox.org/git/20160721013923.17435-1-sbeller%40google.com/
>
> but these two patch series looks more thorough.
>
> I expect I'd queue these two instead, after seeing Acks from Stefan.
>
> Thanks.

Sure. Please take these 2 patches instead of mine.

Thanks,
Stefan
