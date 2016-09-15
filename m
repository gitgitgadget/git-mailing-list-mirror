Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D44852070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbcIOU7x (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:59:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55189 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752097AbcIOU7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:59:51 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Sep 2016 16:59:51 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A2063D52D;
        Thu, 15 Sep 2016 16:51:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=vL8c
        n44xhjdY4Qy52eg/iO4zT+o=; b=XvaPbaRNnjQScrUxjMPAUcT9p9AxhZw0kXfa
        AB29r0p087I3tzLgujENkujCC/mKjfwPPhKPaJgC3uocvg3I+yAqCg2wRnrB+xm1
        SLjxDDA4V1ui09YRLhaiJl9+yOPdJ47lBl5Ys/myS+Of2g+tYQ+gXGOtV73NeBqH
        2KjaD0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=eutPcM
        Q2jZsIiPZcJCP4auC4skhhqoMtBcMCnnED1sNrAy3lE5ZEYNR1Ek7oQWlR/gNNso
        Jubl4AAjyF4Ma4I2lMwyb0JFYc7R9H//xXfXmnpvVmCJixMV1I/FO9ajZVEKsN41
        h/QS85wBAUnIi34TGa55BX2yeJloInlfTY+P4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11ECB3D52C;
        Thu, 15 Sep 2016 16:51:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F3833D523;
        Thu, 15 Sep 2016 16:51:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2] ls-files: adding support for submodules
Date:   Thu, 15 Sep 2016 13:51:07 -0700
Message-Id: <20160915205109.12240-1-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-458-g97b4043
In-Reply-To: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com>
References: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 2275649C-7B86-11E6-B5E8-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks, will queue with a minimum fix.

So here are two squashable patches, one is the "minimum" one, the
other is a bit more invasive one to use "a pointer to an optional
setting is set to NULL" convention.  I am undecided, and I'll stay
to be without further comments from others, on the latter one.

I understand that many internal changes in your work environment
titles their changes like "DOing X", but our convention around here
is to label them "DO X", as if you are giving an order to somebody
else, either telling the codebase "to be like so", or telling the
patch-monkey maintainer "to make it so".  So I'd retitle it

	ls-files: optionally recurse into submodules

or something like that.  It is an added advantage of being a lot
more descriptive than "adding support", which does not say what kind
of support it is adding.
