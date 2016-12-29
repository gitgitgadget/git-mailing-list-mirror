Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85CCD1FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 21:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbcL2VmR (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 16:42:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60923 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750930AbcL2VmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 16:42:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C4AD5C641;
        Thu, 29 Dec 2016 16:42:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SQI4DgbWzTKhJlTWasbw6T+2ZjQ=; b=j/B+oV
        F8v8sN+8IK6nl3/uc0r3GW+O5KcRXbozgKxpEV3wMvgeTm9+5hRy2LvJhiHcb2Or
        vqA+w+uu5KcKMma4h5Ka4s/5kBdQjVwnCQvDCr625TJJvF87Xyum2v6gsOlrFvjV
        sjXSAb0LZH4ixHt+kuW0Xktx8dmuQH/59pF6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ViDUaW1sjTOAmFGZ4ZA+oMIljEK9d5OS
        3vohs16z81Edg4jUKajfhRtwyiDYKsRFxxNLs75hp8FToB0gWt2Mx5jA3BREml4a
        wZJjF4xg1blYMB1I0a8Ud6lRTgrZsltPgqNg2UsEytwCutoILuUSrNTYlE7rFlKF
        +uJw9yct97Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 544505C640;
        Thu, 29 Dec 2016 16:42:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB5085C63F;
        Thu, 29 Dec 2016 16:42:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Eduardo Habkost <ehabkost@redhat.com>, git@vger.kernel.org,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] am: add am.signoff add config variable
References: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
        <20161229084701.GA3643@starla>
Date:   Thu, 29 Dec 2016 13:42:13 -0800
In-Reply-To: <20161229084701.GA3643@starla> (Eric Wong's message of "Thu, 29
        Dec 2016 08:47:01 +0000")
Message-ID: <xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9AC09EE-CE0F-11E6-A242-E17F7A1B28F4-77302942!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com;
 h=from:to:cc:subject:references:date:in-reply-to:message-id:mime-version:content-type; s=2016-12.pbsmtp; bh=SQI4DgbWzTKhJlTWasbw6T+2ZjQ=; b=NJscyNlhyl4TCJPqCmQn5pyHU2LQXT+MdYq6VgmaEGSuaeIJLwcqOAe/vTciItxfZSuR6nNddGXiIotKyC5nwphPUCpcAy4vk7VIHCJd99L8zX8qIIKvfn8ZiapLRYcdQUPUyLAMZPTfG0ipQGkr+kPy6qE+lDAPfWs9jTUzGoU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Eduardo Habkost <ehabkost@redhat.com> wrote:
>> git-am has options to enable --message-id and --3way by default,
>> but no option to enable --signoff by default. Add a "am.signoff"
>> config option.
>
> I'm not sure this is a good idea.  IANAL, but a sign-off
> has some sort of legal meaning for this project (DCO)
> and that would be better decided on a patch-by-patch basis
> rather than a blanket statement.

IANAL either, but we have been striving to keep output of

   $ git grep '\.signoff' Documentation

empty to keep Sign-off meaningful. 

Adding more publicized ways to add SoB without thinking will make it
harder to argue against one who tells the court "that log message
ends with a SoB by person X but it is very plausible that it was
done by inertia without person X really intending to certify what
DCO says, and the SoB is meaningless".

> I don't add my SoB to patches (either my own or received) until
> I'm comfortable with it; and I'd rather err on the side of
> forgetting and being prodded to resubmit rather than putting
> an SoB on the wrong patch.

