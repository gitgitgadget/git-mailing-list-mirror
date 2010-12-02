From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Git.pm: discourage casual use
Date: Thu, 02 Dec 2010 11:30:10 -0800
Message-ID: <7veia0q8fx.fsf@alter.siamese.dyndns.org>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
 <7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
 <AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
 <20101202181425.GG3962@burratino>
 <AANLkTimKKssBbtuLKCqG9WGbOe+-CH4pc5PDaNxCH_PS@mail.gmail.com>
 <20101202190546.GI3962@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:30:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POErT-0005iv-4Z
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864Ab0LBTa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:30:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699Ab0LBTa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:30:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6DB82AB6;
	Thu,  2 Dec 2010 14:30:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S/c8G35cbuYBiFAJcopuhNEIVXw=; b=LzE/X5
	aCN3RsRo214B2iijjc/wT+BThzdSce1ajfWAAgTeF5cK4up3KuJsEkoDIMhQqQQ9
	LfMump4Mwg5us61jKvi1R1cfYSCUcMZoL6+Dh41TqB4f/7G1Vn68VuTFfO8OWB00
	ZRLcI4TAJ3fGDhh+DXTtamgUaGqCOUoSwxyOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gy2FBsoI1HZgZZRCkBoUkDvHhS6q0P5U
	CJOcWdpu5BkeRO8woj/c17vMH+Gr0XEPgFvC9hStQS5+qlIYie2ZXfWwo83OryD1
	07SD5jY1PvB1mSKCUkPpUYhi0LoR+p3mGxutG90JSNqc7vTSOqqKlM0onVl8vajC
	zfXFsdDK5Hs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 66D7A2AB5;
	Thu,  2 Dec 2010 14:30:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 850362AAE; Thu,  2 Dec 2010
 14:30:32 -0500 (EST)
In-Reply-To: <20101202190546.GI3962@burratino> (Jonathan Nieder's message of
 "Thu\, 2 Dec 2010 13\:05\:46 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A599ADC0-FE4A-11DF-8242-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162740>

Jonathan Nieder <jrnieder@gmail.com> writes:

> So how about something like this patch, to start?

Ok.  We may probably want to reduce the repetition of "easy", though.

> diff --git a/perl/Git.pm b/perl/Git.pm
> index 6cb0dd1..7f6c500 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -63,12 +63,16 @@ require Exporter;
>  
>  =head1 DESCRIPTION
>  
> -This module provides Perl scripts easy way to interface the Git version control
> -system. The modules have an easy and well-tested way to call arbitrary Git
> +This module provides an easy way to interact with the Git version control
> +system for Git's internal perl scripts.
> +The modules have an easy and well-tested way to call arbitrary Git
>  commands; in the future, the interface will also provide specialized methods
>  for doing easily operations which are not totally trivial to do over
>  the generic command interface.
>  
> +Note: this module should not be used by code outside the Git package itself,
> +since the API is not stable yet.
> +
>  While some commands can be executed outside of any context (e.g. 'version'
>  or 'init'), most operations require a repository context, which in practice
>  means getting an instance of the Git object using the repository() constructor.
