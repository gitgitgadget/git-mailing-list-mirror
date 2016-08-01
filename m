Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB0E1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 20:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171AbcHAUuZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 16:50:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755168AbcHAUuR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 16:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2047D3126E;
	Mon,  1 Aug 2016 15:54:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Qh/f8ZbTvAue
	O1Lne/gezbYpI1k=; b=bQ4xumSpA4r9AUj83/X335ng6h5yDTIxGLcnLJ7Mc9is
	9vvdxIP3ZdX078ZoH/bYWUQb0OVZRqgXRdGFMeg1lsKCaGUTnz+ew57FdvkYPp0J
	h4aGumt4WJ2h4Cj8kSmwDJc8dfCK5VxK7XdHvty11S4GqT7bu4Ahzl4YX/oRx/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SAufWW
	6NaQmDG7/o4hD6dYiNiejqV+sDKLB4rnGrKrt8qE1y99XokcM7rqOYzVm6Inugdz
	c+QPN8Iee1SI/BOxek/wxoy1crEHHhzbX53BCIR2fKNtfl8Gpkg4I5X93ozr/Rpi
	GsLo+TpV7TemOxfzUPoGiVYY20Z8I0HBsWscg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 17EE03126D;
	Mon,  1 Aug 2016 15:54:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 833A83126C;
	Mon,  1 Aug 2016 15:54:15 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Andreas Brauchli <a.brauchli@elementarea.net>, git@vger.kernel.org
Subject: Re: [PATCH] gitweb: escape link body in format_ref_marker
References: <CABnoAVcUbmvZbu7ZiEUWtq_2P6RQLVnJx1a-PiLW-r8uWQ+5vw@mail.gmail.com>
	<51785fbd-6858-c9b2-7f59-eaf7bd3ea394@gmail.com>
Date:	Mon, 01 Aug 2016 12:54:13 -0700
In-Reply-To: <51785fbd-6858-c9b2-7f59-eaf7bd3ea394@gmail.com> ("Jakub
	=?utf-8?Q?Nar=C4=99bski=22's?= message of "Sat, 30 Jul 2016 19:46:39
 +0200")
Message-ID: <xmqq37mojme2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B9C882E4-5821-11E6-A330-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> Good catch!
>
> Acked-by: Jakub Narębski <jnareb@gmail.com>

Sigh; the contents may be good but the patch is unusable as-is
because of heavy whitespace damage.

I'll fix it up.  Thanks, both.

>> ---
>>  gitweb/gitweb.perl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 2fddf75..33d701d 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2090,7 +2090,7 @@ sub format_ref_marker {
>>                                 -href => href(
>>                                         action=>$dest_action,
>>                                         hash=>$dest
>> -                               )}, $name);
>> +                               )}, esc_html($name));
>> 
>>                         $markers .= " <span
>> class=\"".esc_attr($class)."\" title=\"".esc_attr($ref)."\">" .
>>                                 $link . "</span>";
>> 
