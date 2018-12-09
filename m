Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273E520A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 00:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLIAPl (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 19:15:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55226 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLIAPk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 19:15:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 579232DE10;
        Sat,  8 Dec 2018 19:15:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZXWvPSCMjYvgFZCtUlQoWGWE3Ws=; b=s+THrR
        RAwCxUvgiO+qwYQdzWMi5+rX7kOmjdeWDMcLgNxEanjzntYAVj8IG8ZaV9JYbUkg
        SE9+10C29DbO3hr6GWpCXhniMG92ouSyZq0AVwWwMfUUKMWrqiAgtTw6o260wLnZ
        hPOMz7RnFqZOd+INYFpPRlyyQTVoSsPoFYszE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lG7EokIl1IsQtuGfGKffR8q7DgHVxgOq
        SARrCmVczdinjPzPgkB8pxQH9yx6kNCd5QPdEM8PaKSalxiep9xN564wMJhD16a8
        ZNfuTZDt6i7/7iLED3DXkCBLIk7za2AbZtm4Y2xAuhP1BPtT2UiZmpJl0g4urcPs
        oF4zgUkl8V0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5058A2DE0F;
        Sat,  8 Dec 2018 19:15:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67CC72DE0D;
        Sat,  8 Dec 2018 19:15:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP RFC 1/5] Documentation: order protocol v2 sections
References: <xmqqin08d36k.fsf@gitster-ct.c.googlers.com>
        <20181206225431.135449-1-jonathantanmy@google.com>
Date:   Sun, 09 Dec 2018 09:15:35 +0900
In-Reply-To: <20181206225431.135449-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 6 Dec 2018 14:54:31 -0800")
Message-ID: <xmqqftv77dy0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DC2B964-FB47-11E8-8643-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > The git command line expects Git servers to follow a specific order of
>> 
>> "Command line"?  It sounds like you are talking about the order of
>> command line arguments and options, but apparently that is not what
>> you are doing.  Is it "The git over-the-wire protocol"?
>
> I meant to say the current Git implementation, as opposed to what is
> written in the specification. I'll replace it with "The current C Git
> implementation".

Yeah, that would avoid confusing future readers; sounds good.

>> Earlier, we said that shallow-info is not given when packfile is not
>> there.  That is captured in the updated EBNF above.  We don't have a
>> corresponding removal of a bullet point for wanted-refs section below
>> but probably that is because the original did not have corresponding
>> bullet point to begin with.
>
> That's because the corresponding bullet point had other information.
> Quoted in full below:
>
>> 	* This section is only included if the client has requested a
>> 	  ref using a 'want-ref' line and if a packfile section is also
>> 	  included in the response.
>
> I could reword it to "If a packfile section is included in the response,
> this section is only included if the client has requested a ref using a
> 'want-ref' line", but I don't think that is significantly clearer.

I don't either.  I didn't mean to suggest to change anything in this
part.  I was just giving an observation---two parallel things do not
get updates in tandem, and that is because they were not described
the same way to begin with, which was a good enough explanation.
