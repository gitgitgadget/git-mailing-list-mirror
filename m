Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6029A20A40
	for <e@80x24.org>; Wed, 22 Nov 2017 03:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdKVDjg (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 22:39:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54720 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751434AbdKVDjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 22:39:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8136FB0F81;
        Tue, 21 Nov 2017 22:39:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KmB7+nDfMN3DyErPy9gvaBpsRtI=; b=P0asJu
        Pt7DbTPXIfAuV6agkfLVUACNhfhaVS3ZjlkNrDlZjt+9kLSR0Oy+rRpdh939sOvb
        O2U469Ow3dCWeZwzM7jeTvxQ5EvF+pHw+LKY7aE7f0cj+x2kM4c/tPedWZhKA5yo
        iw2G+qeBcgL3Gm2nH6864ttisZNPJn3dDD9lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d+Nz+5lHjgUc+O4u8dMUKulK6b8iZlU0
        VjTkBnrW8OgYPQ/DctrVu2uMnL8R1jF6ZaDxoOOTPGWQTHW5yxiX9Kzu8jnObdo+
        ua7/tMdiIzfuUn2FNWgQxtqDG6SFxqlMyuq0F2Ls4+wlG3YyqcGLpm8Ka3cVjUYs
        ziMo2dt220Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C8D8B0F80;
        Tue, 21 Nov 2017 22:39:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C17CCB0F7F;
        Tue, 21 Nov 2017 22:39:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] Git/Packet.pm: rename packet_required_key_val_read()
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
        <20171121191900.GD3429@aiede.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 12:39:32 +0900
In-Reply-To: <20171121191900.GD3429@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 21 Nov 2017 11:19:00 -0800")
Message-ID: <xmqq60a3vv63.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C171BEEC-CF36-11E7-B21D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> nit: please wrap lines to a consistent width, to make the message
> easier to read.  In the above, it looks like the line break is
> intentional --- is it meant to be two paragraphs (i.e. is it missing
> another newline)?

I'd think so; will add a missing LF while queuing..

> optional, just noticed while I'm nitpicking: the description 'rename
> packet_required_key_val_read' doesn't tell why the function is being
> renamed.  Maybe something like
>
> 	Git::Packet: clarify that packet_required_key_val_read allows EOF
>
> would do the trick.

Sounds good. 

>> +# Read a text line and check that it is in the form "key=value"
>> +sub packet_key_val_read {
>
> This comment doesn't tell me how to use the function.  How do I detect
> whether it successfully read a line?  What do the return values
> represent?  What happens if the line it read doesn't match the key?

Would this work for both of you?

# Read a text packet, expecting that it is in the form "key=value" for
# the given $key.  An EOF does not trigger any error and is reported
# back to the caller (like packet_txt_read() does).  Die if the "key"
# part of "key=value" does not match the given $key, or the value part
# is empty.
