Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6328CC00523
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 21:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEFC21835
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 21:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jbT+0gO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgACVbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 16:31:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60929 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgACVbG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 16:31:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1025D96513;
        Fri,  3 Jan 2020 16:31:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=398UNSo5XQIbxRAClXirkkPJMVk=; b=jbT+0g
        O+Xv+OgPGJMNWshd2Ws6OV+qSeqY8yunuieck73tF3Dr7AS2bXTG+PYVacPRh4Gr
        rnmilnuuV60EroXVIb+oULk0UIAp+LaNgmugMacEKUITMf8Y7hbwbXHqXylMpPAn
        XM3Z7lTi9s01y5bXV9P83Km+4ugveIhGtcSeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F5jgFcYYfFRPjxdd7KR6+BGmUb/ps14H
        hBok9+WAMT/zXV3oNaBrvhY2pdMNDDWMb4UxaI9MQnawVAUrGelSTsi9HVG9R8M9
        4+XXiHclS/3fU2fMyPtyvMgzUgEAOyI3iqM7xNJbxc+pLubXkmSzkwO4RY++SeBF
        aRfNDVp+McU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 083A696512;
        Fri,  3 Jan 2020 16:31:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 324209650F;
        Fri,  3 Jan 2020 16:31:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, jonathantanmy@google.com,
        jrnieder@gmail.com, steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
References: <20191029003023.122196-1-matvore@google.com>
        <20191031003929.GA22855@google.com>
        <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet>
        <20200103201423.GA20975@comcast.net>
Date:   Fri, 03 Jan 2020 13:30:59 -0800
In-Reply-To: <20200103201423.GA20975@comcast.net> (Matthew DeVore's message of
        "Fri, 3 Jan 2020 12:14:23 -0800")
Message-ID: <xmqqk168cjn0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 569840AA-2E70-11EA-9968-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

> On Thu, Oct 31, 2019 at 09:26:48AM +0100, Johannes Schindelin wrote:
>> 
>> am stands for "apply mbox", and I think that the only reason it is not
>> called `git apply-mbox` is that the Linux maintainer uses it a lot and
>> wanted to save on keystrokes.

No need to give an incorrect speculation if you do not know the
history in this discussion.  Back then, the command to apply mbox
contents existed and was called "git applymbox".  "am" was invented
as a better replacement with more rational behaviour and set of
command line arguments.

>> Having said that, I do agree that `xl` is not a good name for this. It
>> is neither intuitive, nor is it particularly easy to type (on a
>> US-English keyboard, the `x` and the `l` key are far apart), and to add
>
> There is a subjective element to this, but I would consider it easy to type
> since it is using two different hands....

Give descriptive name to the command, define an alias of your choice
and use it privately.  Nobody would be able to guess what "git xl"
or "git extra-long" command would do ;-)
