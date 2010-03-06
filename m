Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 19082 invoked by uid 107); 6 Mar 2010 12:58:05 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sat, 06 Mar 2010 07:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab0CFM5g (ORCPT <rfc822;peff@peff.net>);
	Sat, 6 Mar 2010 07:57:36 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:58572 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab0CFM5e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Mar 2010 07:57:34 -0500
Received: by fxm19 with SMTP id 19so4997740fxm.21
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 04:57:33 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OTnxYBy7zgweoillVrYi+/d7MDQ9VAnFCjsb2nAtxZE=;
        b=aVKn//JRfUw2sCwAOOxVI/C0wJUcVEtul6AUCAXqipVcyC/YFrwgfeifu7Pn9CxjXz
         k0E0SamEie6fjEnmWrXNF1736q5aXKHsV8NaRLmltUf46020vUMVqiL/0WWcsZg6LgEf
         CUCfP+gfWhuj5bT++fXGUe7af+ak8/dxHk7Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GJ8rjUM3pYMXaBi1g8HdILfjGLBKK32OCjQqZq26qr5I2BKkUYcuXa6cT5NnILNpMG
         Ayb2QNStp7dWLINLSfYLzp0h6+AzjvFGEtEiSXHhQIQ/1meW9XXv0bDz6bewNptiP4UZ
         0V++G5DRS5QuDTSELB15NceqPDFLdhsQeXFM8=
MIME-Version: 1.0
Received: by 10.223.143.82 with SMTP id t18mr2620492fau.52.1267880252950; Sat, 
	06 Mar 2010 04:57:32 -0800 (PST)
In-Reply-To: <7vpr3itn89.fsf@alter.siamese.dyndns.org>
References: <20100305215253.364.63583.reportbug@localhost>
	 <20100305221950.GB5083@progeny.tock>
	 <7vpr3itn89.fsf@alter.siamese.dyndns.org>
Date:	Sat, 6 Mar 2010 13:57:32 +0100
Message-ID: <36ca99e91003060457s6417f800uc7a3e126ee6b7d6f@mail.gmail.com>
Subject: Re: git-core: conflictstyle=diff3 doesn't actually use diff3 
	compatible format
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Monnier <monnier@iro.umontreal.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Mar 5, 2010 at 23:31, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> I can't live without conflictstyle=diff3m and I'm very happy it exists.
>>> But it has a little problem: it uses "|||||||\n" as a separator for the
>>> ancestor version of the text, whereas diff3 uses "||||||| <ancestorname>\n".
>>> The difference is harmless for a human (tho the <ancestorname> can sometimes
>>> be useful, assuming it's meaningful), but it makes some tools fail to
>>> recognize the conflict markers properly.
>>> So please add a " BASE" or " ANCESTOR" after the "|||||||".
>>
>> No opinion on this myself.  I’d be interested to hear from xdiff people
>> whether it should be easy to add the ancestor name to the output.
>
> I don't think there was any xdiff people involved in this area.
>
> I suspect that our tools actually rely on the common ancestor markers not
> having any extra cruft after them, so it would be introducing a bug if you
> change this output without changing the places that read them (I know
> about "rerere", but there may be others).

rerere needs an isspace() after the specified marker length. So I
assume it could live with extra cruft after the | marker and a space.

BTW: Am I right, that rerere would need to handle my new conflict style too?

Bert
