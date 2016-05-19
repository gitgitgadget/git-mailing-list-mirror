From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack.c: use of parse-options API
Date: Thu, 19 May 2016 09:46:16 -0700
Message-ID: <xmqqa8jmknc7.fsf@gitster.mtv.corp.google.com>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<431335092.10912437.1463674220365.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 19 18:46:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3R5q-0007Er-Q4
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 18:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbcESQqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 12:46:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754437AbcESQqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 12:46:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C03E1BEF7;
	Thu, 19 May 2016 12:46:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HGJU9yDkFdjwvxCOCWrfIePDk0A=; b=AAqBDC
	ClTlsOf2DkkStGAn1FwkqsqNB9f4gpxyxwB7JmP8qMsP1o99492P0rhzUTEZOk/O
	rORsLAzkZkSi8OK8UwF7N5aSF4ymChpw2TOxLBry8Tj4NUINtpPy0mbY4nWKMdNB
	Nxj6mPmvv9kbkVPhUgkeVvCgS3NM2QM+yZ0Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QlFxz9oLJd0vv9feVQ4jUTu7b5IdbYGj
	3CWhBuJXih06l67cjSmfzjgfoka3mgqi2xXTP7rP/qs1mGFN7Eemwxn+hMaNG/X0
	ys6ouM8PTmDdJHLLjZChY46RklvK7D31S2NhnUR1qlyvTtaFChco4B96vkg4PtnS
	WZHOBKGKVF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 73FFD1BEF6;
	Thu, 19 May 2016 12:46:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C22E71BEF5;
	Thu, 19 May 2016 12:46:19 -0400 (EDT)
In-Reply-To: <431335092.10912437.1463674220365.JavaMail.zimbra@imag.fr>
	(Matthieu Moy's message of "Thu, 19 May 2016 18:10:20 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 366418CA-1DE1-11E6-9856-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295073>

Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:

> Antoine.Queru@ensimag.grenoble-inp.fr wrote:
>> Option parsing now uses the parser API instead of a local parser.
>> Code is now more compact.
>> Description for -stateless-rpc and --advertise-refs
>> come from the commit (gmane/131517)
>
> Please, use a real commit id instead of a Gmane link.
>
> We don't know how long Gmane will remain up, but a self
> reference from Git's history to itself will always remain valid.
>
> The following alias is handy for this:
>
> [alias]
>         whatis = show -s --pretty='tformat:%h (%s, %ad)' --date=short
>
> In your case it would allow writing: 
>
> Description for --stateless-rpc and --advertise-refs is taken
> from commit 42526b4 (Add stateless RPC options to upload-pack,
> receive-pack, 2009-10-30).

Good suggestion; a real question may be how you went from
$gmane/131517 to 42526b4 (I vaguely recall that you have and publish
a database of sort; this would be a good place to advertise it ;-).

>
>> diff v1 v2:
>
> We usually say "diff" to refer to an actual diff. I'd write "changes since v1" here.
>
>> +		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
>> +			 N_("may perform only a single read-write cycle with stdin and stdout")),
>
> It's weird to define what an option does with "may". It's a
> property of --stateless-rpc, but does not really define it.

If this "may" were to express "The program might or might not do
this, and we do not know what it would do until we try", then it
indeed would be weird.  But the way the word "may" was used in
42526b4 is "the program is ALLOWED to do only a single exchange".

I agree that the phrasing is bad, in the sense that it can be
misread as a non-definition; perhaps

    quit after a single request/response exchange

or something?
